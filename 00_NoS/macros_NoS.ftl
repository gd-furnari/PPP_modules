<#--common macros/functions for NoS reports (PDF and CSV)-->

<#-- addNosStudyAsUnique appends a reference and a study into a pre-defined hashMap.
    Inputs:
    - reference: LITERATURE entity
    - document: IUCLID document e.g. ENDPOINT STUDY RECORD
    - section: string containing the section where the document is found e.g. 2.1 Appearance
    - hash: hash to add studies to
        - Keys correspond to reference uuids
        - Values correspond to another hash containing the keys "reference", "section", and "doc", each
        one containing a list of literature references, section names and studies, respectively

        Hash structure:
        { ref uuid 1 : {'reference': [reference1, reference2, ...],
                           'section': [section1, section2, ...],
                           'doc': [study1, study1, ...]},
            ref uuid 2: {..}
        }
    Outputs:
    - a HASH with structure as above, containing the additional study
-->
<#function addNosStudyAsUnique reference document section hash>

    <#local uuid = reference.documentKey.uuid/>

    <#-- if reference exists, add new document to its hash entry; else create a new entry-->
    <#if hash?keys?seq_contains(uuid)>

        <#local hashEntry = hash[uuid]/>
        <#local docs = hashEntry['doc']/>
        <#local sects = hashEntry['section']/>

        <#-- avoid duplicates! only add document if it's not already present-->
        <#local dup=false/>
        <#list docs as doc>
            <#if doc.documentKey==document.documentKey>
                <#local dup=true>
                <#break>
            </#if>
        </#list>
        <#if !dup>
            <#local sects = sects + [section]/>
            <#local docs = docs + [document]/>
        </#if>

    <#else>

        <#local docs=[document]/>
        <#local sects=[section]/>

    </#if>

    <#local hashEntry = { uuid : {'reference': reference, 'section': sects, 'doc': docs}}/>
    <#local hash = hash + hashEntry/>

    <#return hash/>

</#function>

<#-- getNoSid extracts an NoS ID from a literature reference entity.
    A NoS id is identified if entries under Other study identifiers have type "Notification of Studies (NoS) ID"
    and id matches or contains the format for EFSA NoS id.
    Inputs:
    - reference: LITERATURE entity
    - exactMatch: if true, it requires EFSA's NoS id format contained in the text, otherwise it retrieves the content
    of the field Study ID as it is.
    Outputs:
    - a STRING containing unique NoS IDs separated by "; "
-->
<#function getNoSid reference exactMatch=true>

    <#local NoSIds=[]/>

    <#if reference.GeneralInfo.StudyIdentifiers?has_content>
        <#list reference.GeneralInfo.StudyIdentifiers as studyId>
            <#local idType><@com.picklist studyId.StudyIDType/></#local>
            <#local idValue><@com.text studyId.StudyID/></#local>

            <#if idValue?has_content>
				<#if idType=="Notification of Studies (NoS) ID">
				    <#if exactMatch>
                        <#if idValue?matches(".*EFSA-[0-9]{4}-[0-9]{8}.*", "s")>
                            <#-- NOTE: needs the 's' flag in order to also cope with multi-line!-->
                            <#if !NoSIds?seq_contains(idValue)>
                                <#local NoSIds = NoSIds + [idValue]/>
                            </#if>
                        </#if>
	                <#else>
	                	<#if !NoSIds?seq_contains(idValue)>
	                        <#local NoSIds = NoSIds + [idValue]/>
	                    </#if>
	                </#if>
                </#if>
            </#if>
        </#list>
    </#if>

    <#if NoSIds?has_content>
        <#return NoSIds?join("; ")/>
    <#else>
        <#return ""/>
    </#if>
</#function>

<#-- getNoSidRemarks extracts the remarks corresponding to Notification of Studies from a literature reference entity.
    A NoS remark is identified if entries under Other study identifiers have type "Notification of Studies (NoS) ID"
    and the remarks field has content.
    Inputs:
    - reference: LITERATURE entity
    Outputs:
    - a STRING containing unique remarks separated by "; "
-->
<#function getNoSidRemarks reference>

    <#local remarks=[]/>

    <#if reference.GeneralInfo.StudyIdentifiers?has_content>
        <#list reference.GeneralInfo.StudyIdentifiers as studyId>
            <#local idType><@com.picklist studyId.StudyIDType/></#local>
            
			<#if idType=="Notification of Studies (NoS) ID">
                <#local remark><@com.text studyId.Remarks/></#local>

                <#if remark?has_content>
                    <#if !remarks?seq_contains(remark)>
                        <#local remarks = remarks + [remark]/>
                    </#if>
                </#if>
            </#if>
        </#list>
    </#if>

    <#if remarks?has_content>
        <#return remarks?join("; ")/>
    <#else>
        <#return ""/>
    </#if>

</#function>


<#-- getSynonyms extracts a list of all synonyms of a reference substance.
    Inputs:
    - referenceSubstanceID: REFERENCE_SUBSTANCE entity
    Outputs:
    - a LIST containing all synonyms found
-->
<#function getSynonyms referenceSubstanceID>
    <#local synonymsList=[]>
    <#if referenceSubstanceID?has_content && referenceSubstanceID.Synonyms.Synonyms?has_content>
        <#list referenceSubstanceID.Synonyms.Synonyms as synonyms>
            <#if synonyms?has_content>
                <#local syn>
                    <#compress>
                        <#-- NOTE: if "other:" the synonym name is empty-->
                        <#if synonyms.Identifier?has_content><@com.picklist synonyms.Identifier/>: </#if>
                        <#if synonyms.Name?has_content><@com.text synonyms.Name/></#if>
<#--                        <#if synonyms.Remarks?has_content> (<@com.text synonyms.Remarks/>)</#if>-->
                    </#compress>
                </#local>
                <#local synonymsList=synonymsList+[syn]/>
            </#if>
        </#list>
    </#if>
    <#return synonymsList/>
</#function>

<#-- sanitizeUUID sanitises the UUID in order to keep just the second part after the '/',
     which corresponds to the dossier (first part is dataset).
     Input:
     - uuidPath: path to the uuid to be sanitised.
     Output:
     - a STRING with the sanitised uuid

     NOTE: to be moved to macros_common_general.ftl!
-->
<#function sanitizeUUID uuidPath>
	
	<#local uuid><@com.text uuidPath/></#local>
	<#if uuid?matches(".{2,50}/.{2,50}", "r")>
		<#local uuid=uuid?replace(".*/", '', 'r')/>
	</#if>
	<#return uuid/>
</#function>

<#-- getRefYear extracts the year from a LITERATURE entity as an integer, if possible, else
    it returns an empty string
     Input:
     - reference: LITERATURE entity
     Outut:
     - an INTEGER (number) containg the literature entity year or an empty STRING

     NOTE: for future, maybe return 0 if there is no year or year is not convertible to number??
-->
<#function getRefYear reference>

	<#local refYear><@com.number reference.GeneralInfo.ReferenceYear/></#local>
    	 
    <#if refYear?has_content>
		<#attempt>
			<#local refYear=refYear?number/>
		<#recover>
			<#local refYear=""/>
		</#attempt>
    </#if> 
    
    <#return refYear/>
</#function>

<#-- getNosInfo returns the path to the section in the dossier header where notification of studies information is
    present, depending on the dossier context.
     Input:
     - dossier: _dossierHeader variable, obtained by the default initializeMainVariables macro.
     Outut:
     - a PATH to the section in the dossier header for NoS or an empty STRING if not found.
-->
<#function getNosInfo dossier>

    <#--get context and paths-->
    <#if dossier.documentSubType=="EU_PPP_MAXIMUM_RESIDUE_LEVELS">
        <#return dossier.NotificationOfStudies/>
    <#elseif dossier.documentSubType=="EU_PPP_MICROORGANISMS_FOR_MIXTURES" ||
            dossier.documentSubType=="EU_PPP_ACTIVE_SUBSTANCE_FOR_MIXTURES">
        <#return dossier.NotificationOfStudies/>
    <#elseif dossier.documentSubType=="EU_PPP_BASIC_SUBSTANCE">
        <#return dossier.PreApplicationInformation/>
    <#else>
        <#return ""/>
    </#if>
</#function>

<#-------------------------------------------------
    OLD approach macros and functions
    (to be deleted once report is changed to traversal)
-------------------------------------------------->

<#--
    populateNoSstudyHashes parses the table of contents of a _subject document (MIXTURE, SUBSTANCE) and performs
    the actions defined in the "section_tree_node" macro below for each node.
    In case of MIXTUREs, it also parses recursively parses the tocs of all their SUBSTANCE or MIXTURE
    components as defined in the mixture composition documents and metabolites as defined in the metabolites document, and performs the same actions
-->
<#macro populateNoSstudyHashes subject>

    <#local products=[subject] + com.getOtherRepresentativeProducts(subject)/>
    <#local components=[]/>
    <#list products as prod>
        <#local components=components + com.getComponents(prod)/>
    </#list>
    <#local metabolites=com.getMetabolites(subject)/>

    <#--Remove duplicates-->
    <#local allEntities = products/>
    <#list components+metabolites as sub>
        <#local allEntities=com.addDocumentToSequenceAsUnique(sub, allEntities)/>
    </#list>

    <#--Parse-->
    <#list allEntities as entity>
        <#local toc=iuclid.localizeTreeFor(entity.documentType, entity.submissionType, entity.documentKey)/>
        <#recurse toc/>
    </#list>

</#macro>

<#--
    This macro is automatically applied by the #recurse function.

    It loops through the documents on a node, and for each ENDPOINT_STUDY_RECORD
    or any other documents specified in the variable 'otherDocs' (e.g. FLEXIBLE_RECORD.IntermediateEffects) it:
    - extracts all the literature references
    - appends each reference and the study where it is used into two different hashMaps depending on
    the existence of a NoS ID
    The path for the reference in the document is either the standard for ENDPOINT_STUDY_RECORDs, or must be
    hardcoded in the "otherDocs" variable.
-->
<#macro "section_tree_node">

    <#--NOTE: these other docs have all literature references, but most likely the only relevant is Intermediate Effects-->
    <#local otherDocs = {"FLEXIBLE_RECORD.IntermediateEffects":["DataSource.Reference"],
    						"ENDPOINT_SUMMARY.AnalyticalProfileOfBatches":["AdministrativeDataSummary.BatchAnalysis"], <#-- this is a list! -->
	                        "FLEXIBLE_RECORD.ProtectionMeasures":["AdditionalInformation.Reference"],
                        	"FLEXIBLE_SUMMARY.SummaryEvaluation_EU_PPP":["OtherReferencesIncludingSDS.References"],
                        	"FLEXIBLE_RECORD.LiteratureSearch":["RelevantStudies.LiteratureReference"] <#--  also in EvaluationOfTheReview.ExcludedPublications as rep block, but should never be a study-->,
                        	"FLEXIBLE_RECORD.BioPropertiesMicro":
                        		["BiologicalPropertiesOfTheMicroorganism.GeneralInformationOnTheMicroorganism.Reference",
                        		"BiologicalPropertiesOfTheMicroorganism.GeneralInformationOnTheMicroorganism.HistoricalBackground.Reference",
                        		"BiologicalPropertiesOfTheMicroorganism.GeneralInformationOnTheMicroorganism.HistoricalUses.Reference",
                        		"BiologicalPropertiesOfTheMicroorganism.GeneralInformationOnTheMicroorganism.OriginNaturalOccurrenceAndGeographicalDistribution.Reference",
                        		"BiologicalPropertiesOfTheMicroorganism.DevelopmentStagesLifeCycleOfTheMicroorganism.Reference",
                        		"BiologicalPropertiesOfTheMicroorganism.RelationshipsToKnownPlantOrAnimalOrHumanPathogens.Reference",
                        		"BiologicalPropertiesOfTheMicroorganism.GeneticStabilityAndFactorsAffectingIt.Reference",
                        		"BiologicalPropertiesOfTheMicroorganism.InformationOnTheProductionOfMetabolitesEspeciallyToxins.Reference",
                        		"BiologicalPropertiesOfTheMicroorganism.ProductionAndResistanceToAntibioticsAndOtherAntimicrobialAgents.Reference",
                        		"BiologicalPropertiesOfTheMicroorganism.RobustnessToEnvironmentalFactors.Reference",
                        		"BiologicalPropertiesOfTheMicroorganism.FurtherInformationOnTheMicroorganism.Reference",
                        		"EffectivenessAgainstTargetOrganisms.InfectivenessDispersalAndColonisationAbility.Reference",
                        		"EffectivenessAgainstTargetOrganisms.MethodsToPreventLossOfVirulenceOfSeedStockOfTheMicroorganism.Reference",
                        		"MeasuresNecessaryToProtectHumansAnimalsAndTheEnvironment.MonitoringPlan.Reference",
                        		"BiologicalPropertiesOfTheMicroorganismInTheBiocidalProduct.Reference"]
    }/>

    <#local contents=(.node.content)!/>

    <#if contents?has_content>
        <#list contents as doc>
            <#local docTypeSubtype>${doc.documentType}.${doc.documentSubType}</#local>

            <#if (doc.documentType=="ENDPOINT_STUDY_RECORD" || otherDocs?keys?seq_contains(docTypeSubtype)) && doc?has_content>

                <#--get path-->
                <#local refPaths=[]/>
                <#if otherDocs?keys?seq_contains(docTypeSubtype)>
                	<#if docTypeSubtype=="ENDPOINT_SUMMARY.AnalyticalProfileOfBatches">
                		<#if doc.AdministrativeDataSummary.BatchAnalysis?has_content>
                			<#list doc.AdministrativeDataSummary.BatchAnalysis as item>
                				<#if item.Reference?has_content>
                					<#local refPaths = refPaths + [item.Reference]/>
                				</#if>
                			</#list>
                		</#if>
                	<#else>
	                	<#local refPathList = otherDocs[docTypeSubtype]>
	                    <#list refPathList as refPathEntry>
	                    	<#local refPath = "doc." + refPathEntry/>
	                    	<#local refPaths = refPaths + [refPath?eval]/>
	                    </#list>
                	</#if>
                <#else>
                    <#local refPaths=[doc.DataSource.Reference]/>
                </#if>

                <#--check if document has a valid reference for NoS id, and retrieve it-->
                <#list refPaths as refPath>
	                <#local reference=getStudyReference(refPath)/>

	                <#if reference?has_content>
	                    <#list reference as ref>
	                       <#--check for NoSid based on specific criteria defined in macro-->
	                        <#local NoSid=getNoSid(ref)/>

							<#-- if NoS ID exists, append to list  -->
	                        <#if NoSid?has_content>
	                            <#assign NoSstudyHash=addNosStudyAsUnique(ref, doc, "" NoSstudyHash)/>
	                        <#-- if it does not exist, then append the study to the list without NoS ID if:
	                        - type is study report
	                        - year >= 2021 (or empty)
	                        -->
	                        <#else>
	                            <#local refType><@com.picklist ref.GeneralInfo.LiteratureType/></#local>
	                            <#local refYear=getRefYear(ref)/>

	                            <#if refType=="study report" && ((!refYear?has_content) || refYear>=2021)>
	                                <#assign missingNoSstudyHash=addNosStudyAsUnique(ref, doc, "" missingNoSstudyHash)/>
	                            </#if>
	                        </#if>
	                    </#list>
	                </#if>
	             </#list>
            </#if>

        </#list>
    </#if>

    <#recurse/>
</#macro>


<#--
    This function extracts a list of all the literature references from a study,
    provided a path to find the references.
    No other criteria (type of lit ref, etc) are used for filtering at the moment.
-->
<#function getStudyReference referencePath>

    <#local reference=[]/>

    <#if referencePath?has_content>
        <#list referencePath as referenceLink>
            <#local referenceEntry = iuclid.getDocumentForKey(referenceLink)/>
            <#local reference= reference + [referenceEntry]/>

        </#list>
    </#if>

    <#return reference>
</#function>
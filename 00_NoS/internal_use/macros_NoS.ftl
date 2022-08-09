<#--common macros/functions for NoS reports (PDF and CSV) - for internal use -->

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
                        	"FLEXIBLE_RECORD.LiteratureSearch":["RelevantStudies.LiteratureReference"] <#--  also in EvaluationOfTheReview.ExcludedPublications as rep block-->,
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

                <#--check if document has a valid reference for NoS id (year limit can be included, currently 0), and retrieve it-->
                <#list refPaths as refPath>
	                <#local reference=getStudyReference(refPath, 0)/>
	
	                <#if reference?has_content>
	                    <#list reference as ref>
	                        <#--check for NoSid based on specific criteria defined in macro-->
	                        <#local NoSid=getNoSid(ref)/>
							
							<#-- if NoS ID exists, append to list  -->
	                        <#if NoSid?has_content>
	                            <#assign NoSstudyHash=addNosStudyAsUnique(ref, doc, NoSstudyHash)/>
	                        <#-- if it does not exist, then append the study to the list without NoS ID if:
	                        - type is study report
	                        - year >= 2021 (or empty)
	                        -->
	                        <#else>
	                            <#local refType><@com.picklist ref.GeneralInfo.LiteratureType/></#local>
	                            <#local refYear=getRefYear(ref)/>

	                            <#if refType=="study report" && ((!refYear?has_content) || refYear>=2021)>
	                                <#assign missingNoSstudyHash=addNosStudyAsUnique(ref, doc, missingNoSstudyHash)/>
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
    This macro appends a reference and a study into a pre-defined hashMap
-->
<#function addNosStudyAsUnique reference document hash>

    <#local uuid = reference.documentKey.uuid/>

    <#-- get section: to do, if needed-->
    <#local section = "section"/>

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

<#--
    This macro extracts an NoS ID from a literature reference entity
    A NoS id is identified if: 
    	- Entries under Other study identifiers have value CONTAINING the format "EFSA-YYYY-NNNNNNNN" OR
    	- Year is >= 2021 (if exists) AND 
	    	- entries under Other study identifiers have type "Notification of Studies (NoS) ID" OR have remarks like "NoS ID" and value is not empty AND
	    	- the id contains some 8 digits
	    	
-->
<#function getNoSid reference exactMatch=true>

    <#local NoSIds=[]/>

    <#if reference.GeneralInfo.StudyIdentifiers?has_content>
    
    	<#-- get Literature year -->
    	<#local litYear=getRefYear(reference)/>
    
        <#-- iterate through identifiers and get NoS ID if present -->
        <#list reference.GeneralInfo.StudyIdentifiers as studyId>
            <#local idType><@com.picklist studyId.StudyIDType/></#local>
            <#local idValue><@com.text studyId.StudyID/></#local>
            <#local remark><@com.text studyId.Remarks/></#local>

            <#if idValue?has_content>
            	<#if exactMatch>
	            	<#if idValue?matches(".*EFSA-[0-9]{4}-[0-9]{8}.*", "s") || <#-- needs the 's' flag in order to also cope with multi-line!-->
	            	
		            	(	((!litYear?has_content) || (litYear >= 2021)) && 
							
							(idType=="Notification of Studies (NoS) ID" || remark?matches(".*NOTIF.*STUD.*", "i") || remark?matches(".*NOS.*ID", "i")) &&
							
							idValue?matches(".*[0-9]{8}.*", "s")
						)>
						
	                    <#if !NoSIds?seq_contains(idValue)>
	                        <#local NoSIds = NoSIds + [idValue]/>
	                    </#if>
	                 </#if>
                <#else>    
                    <#if idType=="Notification of Studies (NoS) ID" || remark?matches(".*NOTIF.*STUD.*", "i") || remark?matches(".*NOS.*ID", "i")>
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

<#--
    This macro extracts relevant remarks for Notification of Studies from a literature reference entity
    A remark is identified at least one of the following is true:
	    	- entries under Other study identifiers have type "Notification of Studies (NoS) ID"
	    	- entries under Other study identifiers have value CONTAINING the format "EFSA-YYYY-NNNNNNNN" OR
	    	- entries under Other study identifiers have remarks like "NoS ID" and value is not empty.
-->
<#function getNoSidRemarks reference >

    <#local remarks=[]/>

    <#if reference.GeneralInfo.StudyIdentifiers?has_content>
        
        <#list reference.GeneralInfo.StudyIdentifiers as studyId>
            <#local idType><@com.picklist studyId.StudyIDType/></#local>
            <#local idValue><@com.text studyId.StudyID/></#local>
			<#local remark><@com.text studyId.Remarks/></#local>
			<#if remark?has_content>
			
				<#if (idType=="Notification of Studies (NoS) ID" || 
						idValue?matches(".*EFSA-[0-9]{4}-[0-9]{8}.*", 'r') ||
						remark?matches(".*NOTIF.*STUD.*", "i") || 
						remark?matches(".*NOS.*ID", "i")
				)>
		
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

<#--
    This macro extracts a list of all the literature references from a study,
    provided a path to find the references.
    A year filter can be included e.g. 2021
-->
<#function getStudyReference referencePath year=2021>

    <#local reference=[]/>

    <#if referencePath?has_content>
        <#list referencePath as referenceLink>
            <#local referenceEntry = iuclid.getDocumentForKey(referenceLink)/>
            
            <#if referenceEntry?has_content>
            	<#local litYear=getRefYear(referenceEntry)/>
            	<#if (!litYear?has_content) || (litYear >= year)> 
            		<#local reference= reference + [referenceEntry]/>
            	</#if>
            </#if>
        </#list>
    </#if>

    <#return reference>
</#function>

<#--
    This macro extracts a list of all synonyms of a reference substance
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

<#function sanitizeUUID uuidPath>
	
	<#local uuid><@com.text uuidPath/></#local>
	<#if uuid?matches(".{2,50}/.{2,50}", "r")>
		<#local uuid=uuid?replace(".*/", '', 'r')/>
	</#if>
	<#return uuid/>
</#function>

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
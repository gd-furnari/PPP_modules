<#--common macros/functions for NoS reports (PDF and CSV)-->

<#--
    populateNoSstudyLists parses the table of contents of a _subject document (MIXTURE, SUBSTANCE) and performs
    the actions defined in the "section_tree_node" macro below for each node.
    In case of MIXTUREs, it also parses recursively parses the tocs of all their SUBSTANCE or MIXTURE
    components as defined in the mixture composition documents and metabolites as defined in the metabolites document, and performs the same actions
-->
<#macro populateNoSstudyLists subject>

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
    <#local otherDocs = {"FLEXIBLE_RECORD.IntermediateEffects":"DataSource.Reference"
<#--                        ,-->
<#--                        "FLEXIBLE_RECORD.ProtectionMeasures":"AdditionalInformation.Reference",-->
<#--                        "FLEXIBLE_SUMMARY.SummaryEvaluation_EU_PPP":"OtherReferencesIncludingSDS.References",-->
<#--                        "FLEXIBLE_RECORD.LiteratureSearch":"RelevantStudies.LiteratureReference"-->
    }/>

    <#local contents=(.node.content)!/>

    <#if contents?has_content>
        <#list contents as doc>
            <#local docTypeSubtype>${doc.documentType}.${doc.documentSubType}</#local>

            <#if (doc.documentType=="ENDPOINT_STUDY_RECORD" || otherDocs?keys?seq_contains(docTypeSubtype)) && doc?has_content>

                <#--get path-->
                <#if otherDocs?keys?seq_contains(docTypeSubtype)>
                    <#local refPath= "doc." + otherDocs[docTypeSubtype]>
                    <#local refPath=refPath?eval/>
                <#else>
                    <#local refPath=doc.DataSource.Reference/>
                </#if>

                <#--check if document has a valid reference for NoS id, and retrieve it-->
                <#local reference=getStudyReference(refPath)/>

                <#if reference?has_content>
                    <#list reference as ref>
                        <#--check for NoSid-->
                        <#local NoSid=getNoSid(ref)/>

                        <#if NoSid?has_content>
                            <#assign NoSstudyList=addNosStudyAsUnique(ref, doc, NoSstudyList)/>
                        <#else>
                            <#-- only if type is study report-->
                            <#local refType><@com.picklist ref.GeneralInfo.LiteratureType/></#local>
                            <#if refType=="study report">
                                <#assign missingNoSstudyList=addNosStudyAsUnique(ref, doc, missingNoSstudyList)/>
                            </#if>
                        </#if>
                    </#list>
                </#if>
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
    Currently,an NoS id is identified in one of the following situations:
    - there is an id provided under Other study identifiers and the id follows EFSA's format for NoS IDs
    - there is an id provided under Other study identifiers and the remarks section indicates "NoS" (or similar)
    This will change in the October 2021 release when a type of identifier is introduced in the lit ref.
-->
<#function getNoSid reference>

    <#local NoSIds=[]/>
<#--    <#if reference.GeneralInfo.StudyIdentifiers?has_content>-->
<#--        <#list reference.GeneralInfo.StudyIdentifiers as studyId>-->
<#--            <#if studyId.Remarks?matches(".*NOTIF.*STUD.*", "i") || studyId.Remarks?matches(".*NOS.*", "i") ||-->
<#--                    studyId.StudyID?matches("EFSA-[0-9]{4}-[0-9]{8}")>-->
<#--                <#local NoSId = studyId.StudyID/>-->
<#--                <#if NoSId?has_content>-->
<#--                    <#return NoSId>-->
<#--                </#if>-->
<#--            </#if>-->
<#--        </#list>-->
<#--    </#if>-->
    <#if reference.GeneralInfo.StudyIdentifiers?has_content>
        <#list reference.GeneralInfo.StudyIdentifiers as studyId>
            <#local idType><@com.picklist studyId.StudyIDType/></#local>
			<#if idType=="Notification of Studies (NoS) ID">
                <#local NoSId = studyId.StudyID/>
                <#if NoSId?has_content>
                    <#if !NoSIds?seq_contains(NoSId)>
                        <#local NoSIds = NoSIds + [NoSId]/>
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

<#function getNoSidRemarks reference>

    <#local remarks=[]/>

    <#if reference.GeneralInfo.StudyIdentifiers?has_content>
        <#list reference.GeneralInfo.StudyIdentifiers as studyId>
            <#local idType><@com.picklist studyId.StudyIDType/></#local>
			<#if idType=="Notification of Studies (NoS) ID">
                <#local  remark><@com.text studyId.Remarks/></#local>
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

<#--
    This macro extracts a list of all the literature references from a study,
    provided a path to find the references.
    No other criteria (type of lit ref, etc) are used for filtering at the moment.
-->
<#function getStudyReference referencePath>

    <#local reference=[]/>

    <#--    <#local referencePath=study.DataSource.Reference/>&ndash;&gt;-->

    <#if referencePath?has_content>
        <#list referencePath as referenceLink>
            <#local referenceEntry = iuclid.getDocumentForKey(referenceLink)/>
            <#local litType><@com.picklist referenceEntry.GeneralInfo.LiteratureType/></#local>
            <#--            <#if litType=="study report">-->
            <#local reference= reference + [referenceEntry]/>
            <#--                <#break>-->
            <#--            </#if>-->
        </#list>
    <#--        <#local reference = referenceList[0]/>-->
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
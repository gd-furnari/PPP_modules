<#--common macros/functions for NoS reports (PDF and CSV)-->
<#macro endpointStudyRecords _subject>
    <#--get docs for the main toc (substance or mixture)-->
    <#local toc=iuclid.localizeTreeFor(_subject.documentType, _subject.submissionType, _subject.documentKey)/>
    <#recurse toc/>

    <#--if it's a mixture, iterate over the components/metabolites-->
    <#if _subject.documentType=="MIXTURE">
        <#--components-->
        <#local comps=getComponents(_subject)/>
        <#if comps?has_content>
            <#list comps as comp>
                <#local toc=iuclid.localizeTreeFor(comp.documentType, comp.submissionType, comp.documentKey)/>
                <#recurse toc/>
            </#list>
        </#if>

        <#--metabolites datasets-->
        <#local metabs=getMetabolites(_subject)/>
        <#if metabs?has_content>
            <#list metabs as metab>
                <#local toc=iuclid.localizeTreeFor(metab.documentType, metab.submissionType, metab.documentKey)/>
                <#recurse toc/>
            </#list>
        </#if>
    </#if>
</#macro>

<#macro "section_tree_node">

    <#local contents=(.node.content)!/>

    <#if contents?has_content>
        <#list contents as doc>
            <#if doc.documentType=="ENDPOINT_STUDY_RECORD" && doc?has_content>

                <#--option 1: just add row-->
                <#--<@NoStableRow doc/>-->

                <#--option 2: check for NOS id and append to separate lists-->
                <#local reference=getStudyReference(doc)/>

                <#if reference?has_content>
                    <#local NoSid=getNoSid(reference)/>

                    <#if NoSid?has_content>
                        <#assign NoSstudyList=com.addDocumentToSequenceAsUnique(doc, NoSstudyList)/>
                    <#else>
                        <#assign missingNoSstudyList=com.addDocumentToSequenceAsUnique(doc, missingNoSstudyList)/>
                    </#if>
                </#if>
            </#if>
        </#list>
    </#if>

    <#recurse/>
</#macro>

<#function getNoSid reference>

    <#local NoSId=""/>
    <#if reference.GeneralInfo.StudyIdentifiers?has_content>
        <#list reference.GeneralInfo.StudyIdentifiers as studyId>
            <#if studyId.Remarks?matches(".*NOTIF.*STUD.*", "i") || studyId.Remarks?matches(".*NOS.*", "i")>
                <#local NoSId = studyId.StudyID/>
                <#if NoSId?has_content>
                    <#return NoSId>
                </#if>
            </#if>
        </#list>
    </#if>

    <#return "">
</#function>

<#function getStudyReference study>

    <#local reference=""/>

    <#local referenceLinksList=study.DataSource.Reference/>

    <#if referenceLinksList?has_content>
    <#--        <#local referenceList = []/>-->
        <#list referenceLinksList as referenceLink>
            <#local referenceEntry = iuclid.getDocumentForKey(referenceLink)/>
            <#local litType><@com.picklist referenceEntry.GeneralInfo.LiteratureType/></#local>
            <#if litType=="study report">
                <#local reference=referenceEntry/>
                <#break>
            </#if>
        <#--            <#local referenceList = referenceList + [reference] />-->
        </#list>
    <#--        <#local referenceList = iuclid.sortByField(referenceList, "GeneralInfo.LiteratureType", ["study report", "other company data", "publication", "review article or handbook", "other:"]) />-->
    <#--        <#local reference = referenceList[0]/>-->
    </#if>

    <#return reference>
</#function>

<#function getComponents mixture type="">

    <#local componentsList = [] />

    <#local compositionList = iuclid.getSectionDocumentsForParentKey(mixture.documentKey, "FLEXIBLE_RECORD", "MixtureComposition") />

    <#list compositionList as composition>
        <#local componentList = composition.Components.Components />
        <#list componentList as component>
            <#if component.Reference?has_content>
                <#if type=="" || isComponentType(component, type)>
                    <#local substance = iuclid.getDocumentForKey(component.Reference)/>
                    <#if substance?has_content && substance.documentType=="SUBSTANCE">
                        <#local componentsList = com.addDocumentToSequenceAsUnique(substance, componentsList)/>
                    </#if>
                </#if>
            </#if>
        </#list>
    </#list>

    <#return componentsList />
</#function>

<#function isComponentType component type>
    <#return component.Function?has_content && com.picklistValueMatchesPhrases(component.Function, [type]) />
</#function>

<#function getMetabolites mixture>

    <#local metabolitesList = [] />

    <#local compositionList = iuclid.getSectionDocumentsForParentKey(mixture.documentKey, "FLEXIBLE_SUMMARY", "Metabolites") />

    <#list compositionList as composition>
        <#local metaboliteList = composition.ListMetabolites.Metabolites />
        <#list metaboliteList as metabolite>
            <#if metabolite.LinkMetaboliteDataset?has_content>
                <#local substance = iuclid.getDocumentForKey(metabolite.LinkMetaboliteDataset)/>
                <#if substance?has_content && substance.documentType=="SUBSTANCE">
                    <#local metabolitesList = com.addDocumentToSequenceAsUnique(substance, metabolitesList)/>
                </#if>
            </#if>
        </#list>
    </#list>

    <#return metabolitesList />
</#function>

<#function getSynonyms referenceSubstanceID>
    <#local synonymsList=[]>
    <#if referenceSubstanceID?has_content && referenceSubstanceID.Synonyms.Synonyms?has_content>
        <#list referenceSubstanceID.Synonyms.Synonyms as synonyms>
            <#if synonyms?has_content>
                <#local syn>
                    <#compress>
                        <#if synonyms.Identifier?has_content><@com.picklist synonyms.Identifier/>:</#if>
                        <#if synonyms.Name?has_content><@com.text synonyms.Name/></#if>
                        <#if synonyms.Remarks?has_content> (<@com.text synonyms.Remarks/>)</#if>
                    </#compress>
                </#local>
                <#local synonymsList=synonymsList+[syn]/>
            </#if>
        </#list>
    </#if>
    <#return synonymsList/>
</#function>
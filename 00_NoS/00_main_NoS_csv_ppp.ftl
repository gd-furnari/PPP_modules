<#-- Import common macros and functions -->
<#import "macros_common_general.ftl" as com>
<#import "macros_common_studies_and_summaries.ftl" as studyandsummaryCom>
<#include "macros_NoS.ftl">
<#assign locale = "en" />
<#assign sysDateTime = .now>
<#-- Initialize the following variables:
	* _dossierHeader (:DossierHashModel) //The header document of a proper or 'raw' dossier, can be empty
	* _subject (:DocumentHashModel) //The dossier subject document or, if not in a dossier context, the root document, never empty
	-->
<@com.initializeMainVariables/>
<#if _dossierHeader??>
<#assign dossier = _dossierHeader />
<#--get context and paths-->
<#if dossier.documentSubType=="EU_PPP_MAXIMUM_RESIDUE_LEVELS">
    <#assign app=dossier.MRLApplication.DossierSpecificInformation/>
    <#assign nosinfo=dossier.NotificationOfStudies/>
<#elseif dossier.documentSubType=="EU_PPP_MICROORGANISMS_FOR_MIXTURES" || dossier.documentSubType=="EU_PPP_ACTIVE_SUBSTANCE_FOR_MIXTURES">
    <#assign app=dossier.ActiveSubstanceApproval/>
    <#assign nosinfo=dossier.NotificationOfStudies/>
<#elseif dossier.documentSubType=="EU_PPP_BASIC_SUBSTANCE">
    <#assign app=dossier.BasicSubstanceApproval/>
    <#assign nosinfo=dossier.PreApplicationInformation/>
</#if>
<#assign legalEntityName = ""/>
<#assign ownerLegalEntity = iuclid.getDocumentForKey(_subject.OwnerLegalEntity) />
<#if ownerLegalEntity?has_content><#assign legalEntityName=ownerLegalEntity.GeneralInfo.LegalEntityName/></#if>
<#-- Print the headears for each column -->
<@printHeader app/>

<#-- Print the content-->
<#assign content>
    <@printJustNoS _subject dossier nosinfo app legalEntityName/>
    <@printNoS _subject dossier nosinfo app legalEntityName/>
</#assign>
<#assign content=content?replace('", "', '","')/>
${content}
<#else>
Please run Report Generator from a dossier.
</#if>
<#--macros-->
<#macro printHeader app>
    <@compress single_line=true>
    NoS ID,Study NoS classification,Remarks/Justification,
    Reference Type,Title,Author,Year,Bibliographic source,Testing facility,Report no.,Study sponsor,Study no.,Report date,Remarks,Reference uuid,
    Study period,Endpoint,Guideline,GLP,Adequacy,Study uuid,
    <@printChildren path=app header=true/>
    Subject,Subject ids,Active Substance(s),Pre-application identification,
    Dossier name,Dossier UUID,Dossier submission remarks,Dossier creation date and time,Submission type,
    Submitting legal entity
    </@compress>
</#macro>

<#macro printJustNoS _subject dossier nosinfo app legalEntityName>
    <#if nosinfo.StudiesReqJustification?has_content>
        <#list nosinfo.StudiesReqJustification as nos>
            <@compress single_line=true>
            <#local nosId><#compress>
                <#if nos.hasElement("NosId")>
                    <@com.text nos.NosId/>
                <#elseif  nos.hasElement("NoSID")>
                    <@com.text nos.NoSID/>
                <#elseif nos.hasElement("EFSAStudyIdentification")>
                    <@com.text nos.EFSAStudyIdentification/>
                </#if>
            </#compress></#local>
            "${nosId}",
            "justified study",
            "<@com.text nos.Justification/>",
            "","","","","","","","","","","","",
            "","","","","","",
            <@printChildren path=app header=false/>
            <@printSubject _subject/>
            <@printPreapp nosinfo/>
            <@printDossierInfo dossier/>
            "${legalEntityName}"
            </@compress>

        </#list>
    </#if>
</#macro>

<#macro printNoS _subject dossier nosinfo app ownerLegalEntity>
    <#compress>

        <#assign NoSstudyList=[]/>
        <#assign missingNoSstudyList=[]/>
        <@endpointStudyRecords _subject/>

        <#assign fullList=NoSstudyList+missingNoSstudyList/>
        <#list fullList as study>
            <#local reference=getStudyReference(study)/>
            <#if reference?has_content>
                <@compress single_line=true>
                <#local NoSid=getNoSid(reference)/>
                "${NoSid}",
                <#if NoSid?has_content>"notified study"<#else>"study lacking notification"</#if>,
                <#local remarksList=[]>
                <#if !(NoSid?has_content)>
                    <#list reference.GeneralInfo.StudyIdentifiers as studyId>
                        <#if studyId.Remarks?has_content>
                            <#local remark><#compress>
                                <@com.text studyId.Remarks/>
                                <#if studyId.StudyID?has_content>
                                    : <@com.text studyId.StudyID/>
                                </#if>
                            </#compress></#local>
                            <#local remarksList = remarksList + [remark]/>
                        </#if>
                    </#list>
                </#if>
                <#if remarksList?has_content>"${remarksList?join(" | ")}"<#else>""</#if>,
                <@printChildren path=reference.GeneralInfo header=false exclude=["AttachedDocuments", "AttachedSanitisedDocsForPublication", "StudyIdentifiers_list"]/>
                "<@com.text reference.documentKey.uuid/>",
                "<@com.text study.AdministrativeData.StudyPeriod/>",
                "<@com.picklist study.AdministrativeData.Endpoint/>",
                <#local guideline><#compress>
                    <#if study.hasElement("MaterialsAndMethods")>
                        <@studyandsummaryCom.guidelineList study.MaterialsAndMethods.Guideline/>
                        <#if study.MaterialsAndMethods.MethodNoGuideline?has_content>
                            - other method: <@com.text study.MaterialsAndMethods.MethodNoGuideline/>
                        </#if>
                    </#if>
                </#compress></#local>
                "${guideline}",
                <#local glp><#compress>
                    <#if study.hasElement("MaterialsAndMethods")>
                        <@com.picklist study.MaterialsAndMethods.GLPComplianceStatement/>
                        <#if study.hasElement("MaterialsAndMethods.OtherQualityAssurance") && study.MaterialsAndMethods.OtherQualityAssurance?has_content>
                            ; other quality assurance: <@com.picklist study.MaterialsAndMethods.OtherQualityAssurance/>
                        </#if>
                    </#if>
                </#compress></#local>
                "${glp}",
                "<@com.picklist study.AdministrativeData.PurposeFlag/>",
                "<@com.text study.documentKey.uuid/>",
                <@printChildren path=app header=false/>
                <@printSubject _subject/>
                <@printPreapp nosinfo/>
                <@printDossierInfo dossier/>
                "${legalEntityName}"
                </@compress>

            </#if>
        </#list>
    </#compress>
</#macro>

<#macro printDossierInfo dossier>
    "<@com.text dossier.name/>",
    "<@com.text dossier.subjectKey/>",
    "<@com.text dossier.remarks />",
    "<@com.text dossier.creationDate />",
    "<@com.text dossier.submissionType />",
</#macro>

<#macro printPreapp nosinfo>
    <#local preApp><#compress>
        <#if nosinfo.PreApplicationId?has_content>
            <#list nosinfo.PreApplicationId as paid>
                <@com.text paid.PreApplicationId/>
                <#if paid_has_next>; </#if>
            </#list>
        </#if>
    </#compress></#local>
    "${preApp}",
</#macro>

<#macro printSubject _subject>
    <#compress>
    <#if _subject.documentType=="MIXTURE">
        <#local actSubs=getComponents(_subject, "active substance")/>
<#--        <#local actSubName><#if actSubs?has_content></#if><@com.text actSubs[0].ChemicalName/></#local>-->
        <#local actSubIds><#if actSubs?has_content><@substanceIds actSubs[0]/></#if></#local>
        "<@com.text _subject.MixtureName/>","<@mixtureIds _subject/>","${actSubIds}",
    <#elseif _subject.documentType=="SUBSTANCE">
        "<@substanceIds _subject/>"
    </#if>
    </#compress>
</#macro>

<#macro printChildren path header=false exclude=[]>
    <#list path?children as child>
        <#if !exclude?seq_contains(child?node_name)>
            <#if header>
                ${child?node_name?replace("([A-Z]{1})", " $1", "r")?lower_case?cap_first},
            <#else>
                "<@printNode child/>",
            </#if>
        </#if>
    </#list>
</#macro>

<#macro printNode node>
    <#compress>
        <#assign nodeVal=""/>

        <#if node?has_content>
            <#assign nodeType=node?node_type/>

            <#assign nodeVal><#compress>
                <#if nodeType=="range">
                    <@com.range  node/>
                <#elseif nodeType=="picklist_single">
                    <@com.picklist  node/>
                <#elseif nodeType=="picklist_multi">
                    <@com.picklistMultiple node/>
                <#elseif nodeType=="quantity">
                    <@com.quantity node/>
                <#elseif nodeType=="decimal">
                    <@com.number node/>
                <#elseif nodeType=="multilingual_text_html">
                    <@com.richText node/>
                <#else>
                    <@com.text node/>
                </#if>
            </#compress></#assign>

            <#-- remove escaping...-->
            <#assign nodeVal=nodeVal?replace("&gt;", ">")?replace("&lt;", "<")?replace("&amp;", "&")/>
            ${nodeVal}
        </#if>

    </#compress>
</#macro>

<#macro mixtureIds mixture>
    <#compress>
        <@compress single_line=true>
        <#if mixture.PublicName?has_content>public name: <@com.text mixture.PublicName/>;</#if>
        <#if mixture.OtherNames?has_content>
            <#list mixture.OtherNames as name>
                <@com.picklist name.NameType/>: <@com.text name.Name/>
                    <#if name.Country?has_content>
                        in <@com.picklistMultiple name.Country/>
                    </#if>
                <#if name.Remarks?has_content>(<@com.text name.Remaks/>)</#if>
                <#if name_has_next>; </#if>
            </#list>
        </#if>
        </@compress>

    </#compress>
</#macro>

<#macro substanceIds substance>
    <#compress>
        <@compress single_line=true>
        <@com.text substance.ChemicalName/>.
        <@mixtureIds substance/>

        <#assign referenceSubstance = iuclid.getDocumentForKey(substance.ReferenceSubstance.ReferenceSubstance) />
            <#if referenceSubstance?has_content>
            <#--                Reference substance: <@com.text referenceSubstance.ReferenceSubstanceName/>-->
                <#if referenceSubstance.Inventory?? && referenceSubstance.Inventory.InventoryEntry?has_content>
                    EC number : <@com.inventoryECNumber com.getReferenceSubstanceKey(substance.ReferenceSubstance.ReferenceSubstance)/>;
                </#if>
                <#if referenceSubstance.Inventory?? && referenceSubstance.Inventory.InventoryEntry?has_content>
                    EC name: <@com.inventoryECName com.getReferenceSubstanceKey(substance.ReferenceSubstance.ReferenceSubstance) />;
                </#if>
                <#if referenceSubstance.Inventory?? && referenceSubstance.Inventory.InventoryEntry?has_content>
                    CAS number (EC inventory): <@com.inventoryECCasNumber com.getReferenceSubstanceKey(substance.ReferenceSubstance.ReferenceSubstance) />;
                </#if>
                <#if referenceSubstance?? && referenceSubstance.Inventory.CASNumber?has_content>
                    CAS number:<@com.casNumber com.getReferenceSubstanceKey(substance.ReferenceSubstance.ReferenceSubstance) />;
                </#if>
                <#if referenceSubstance?? && referenceSubstance.Inventory.CASName?has_content>
                    CAS name: <@com.casName com.getReferenceSubstanceKey(substance.ReferenceSubstance.ReferenceSubstance)/>;
                </#if>
                <#if referenceSubstance?? && referenceSubstance.IupacName?has_content>
                    IUPAC name: <@com.iupacName com.getReferenceSubstanceKey(substance.ReferenceSubstance.ReferenceSubstance)/>;
                </#if>
                <#if referenceSubstance?? && referenceSubstance.Synonyms.Synonyms?has_content>
                    <#assign synonyms=getSynonyms(referenceSubstance)?join(" | ")/>
                    <#if synonyms?has_content>
                        Synonyms:${synonyms}
                    </#if>
                </#if>
            </#if>
        </@compress>

    </#compress>
</#macro>
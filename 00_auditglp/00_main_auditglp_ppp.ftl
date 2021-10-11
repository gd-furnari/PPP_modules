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
<#--get context and paths for NoS-->
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
    NoS ID,Study NoS classification,NoS remarks/justification,
    Reference Type,Title,Author,Year,Testing facility,Report no.,Study no.,Report date,Reference uuid,
    Study period,Endpoint,Reliability,Guideline,Guideline deviations,GLP,GLP remarks,Adequacy,Study uuid,
<#--    <@printChildren path=app header=true/>-->
    Application purpose,Competent authority,
    Subject,Active Substance,
    Dossier uuid,Dossier creation date and time,Submission type
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
            "","","","","","","","","",
            "","","","","","","","","",
<#--            <@printChildren path=app header=false/>-->
            <#local purpose><#compress>
                <#if app.hasElement("ScopeApp")>
                    <@picklistSimple app.ApplicationPurpose/>
                <#elseif app.hasElement("ApplicationPurpose")>
                    <@picklistSimple app.ApplicationPurpose/>
                <#elseif app.hasElement("Purpose")>
                    <@picklistSimple app.Purpose/>
                </#if>
            </#compress></#local>
            "${purpose}",
            <#local compAuth><#compress>
                <#if app.hasElement("CompetentAuthority")>
                    <@com.text app.CompetentAuthority/>
                </#if>
            </#compress></#local>
            "${compAuth}",
            <@printSubject _subject/>
<#--            <@printPreapp nosinfo/>-->
            <@printDossierInfo dossier/>
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
                <@printChildren path=reference.GeneralInfo header=false
                    exclude=["AttachedDocuments", "AttachedSanitisedDocsForPublication", "StudyIdentifiers_list", "Source", "CompanyOwner", "Remarks"]/>
                "<@com.text reference.documentKey.uuid/>",
                "<@com.text study.AdministrativeData.StudyPeriod/>",
                "<@picklistSimple study.AdministrativeData.Endpoint/>",
                "<@picklistSimple study.AdministrativeData.Reliability/>",
                <#local guideline><#compress>
                    <#if study.hasElement("MaterialsAndMethods")>
                        <@studyandsummaryCom.guidelineList study.MaterialsAndMethods.Guideline/>
<#--                        <#if study.MaterialsAndMethods.MethodNoGuideline?has_content>-->
<#--                            - other method: <@com.text study.MaterialsAndMethods.MethodNoGuideline/>-->
<#--                        </#if>-->
                    </#if>
                </#compress></#local>
                "${guideline}",
                <#local devs=getGuidelineDevs(study)/>
                "${devs}",
                <#local glp><#compress>
                    <#if study.hasElement("MaterialsAndMethods")>
                        <@picklistSimple study.MaterialsAndMethods.GLPComplianceStatement/>
                    </#if>
                </#compress></#local>
                "${glp}",
                <#local glpRemarks><#compress>
                    <#if study.hasElement("MaterialsAndMethods") && study.MaterialsAndMethods.GLPComplianceStatement?has_content>
                        ${study.MaterialsAndMethods.GLPComplianceStatement.remarks}
                    </#if>
                </#compress></#local>
                "${glpRemarks}",
                "<@picklistSimple study.AdministrativeData.PurposeFlag/>",
                "<@com.text study.documentKey.uuid/>",
                <#local purpose><#compress>
                    <#if app.hasElement("ScopeApp")>
                        <@picklistSimple app.ScopeApp/>
                    <#elseif app.hasElement("ApplicationPurpose")>
                        <@picklistSimple app.ApplicationPurpose/>
                    <#elseif app.hasElement("Purpose")>
                        <@picklistSimple app.Purpose/>
                    </#if>
                </#compress></#local>
                "${purpose}",
                <#local compAuth><#compress>
                    <#if app.hasElement("CompetentAuthority")>
                        <@com.text app.CompetentAuthority/>
                    </#if>
                </#compress></#local>
                "${compAuth}",
                <#--                <@printChildren path=app header=false/>-->
                <@printSubject _subject/>
<#--                <@printPreapp nosinfo/>-->
                <@printDossierInfo dossier/>
<#--                "${legalEntityName}"-->
                </@compress>

            </#if>
        </#list>
    </#compress>
</#macro>

<#macro printDossierInfo dossier>
<#--    "<@com.text dossier.name/>",-->
    "<@com.text dossier.subjectKey/>",
<#--    "<@com.text dossier.remarks />",-->
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
        "<@com.text _subject.MixtureName/>","${actSubIds}",
<#--        "<@mixtureIds _subject/>",-->
    <#elseif _subject.documentType=="SUBSTANCE">
        "<@substanceIds _subject/>",
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
                <#if name.hasElement("Remarks") && name.Remarks?has_content>(<@com.text name.Remarks/>) </#if>
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

<#function getGuidelineDevs study>
    <#if study.hasElement("MaterialsAndMethods") && study.MaterialsAndMethods.Guideline?has_content>
        <#list study.MaterialsAndMethods.Guideline as guideline>
            <#local dev><@com.picklist guideline.Deviation/></#local>
            <#if dev?contains("yes")>
                <#return "yes"/>
            </#if>
        </#list>
        <#return "no"/>
    </#if>
    <#return ""/>
</#function>

<#macro picklistSimple picklistValue printOtherText=true>
    <#compress>
        <#escape x as x?html>
            <#local localizedPhrase = iuclid.localizedPhraseDefinitionFor(picklistValue.code, locale) />
            <#if localizedPhrase?has_content>
                <#if !localizedPhrase.open || !(localizedPhrase.text?matches("other:")) || !(printOtherText)>
                    ${localizedPhrase.text} <#t>
                <#elseif localizedPhrase.open && picklistValue.otherText?has_content>
                    ${picklistValue.otherText}<#t>
                </#if>
            </#if>
            <#lt>
        </#escape>
    </#compress>
</#macro>
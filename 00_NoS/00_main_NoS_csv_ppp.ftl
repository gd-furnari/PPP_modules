<#-- Import common macros and functions. -->
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
<#if ownerLegalEntity?has_content><#assign legalEntityName=ownerLegalEntity.GeneralInfo.LegalEntityName/><#else><#assign legalEntityName=""></#if>
<#assign thirdParty = iuclid.getDocumentForKey(_subject.ThirdParty)/>
<#if thirdParty?has_content><#assign thirdPartyName=thirdParty.GeneralInfo.LegalEntityName/><#else><#assign thirdPartyName=""></#if>
<#assign submittingLegalEntity = iuclid.getDocumentForKey(dossier.submittingLegalEntityKey) />
<#if submittingLegalEntity?has_content><#assign submittingLegalEntityName=submittingLegalEntity.GeneralInfo.LegalEntityName/><#else><#assign submittingLegalEntityName=""/></#if>
<#-- Print the headears for each column -->
<@printHeader app/>

<#-- Print the content-->
<#assign content>
    <@printJustNoS _subject dossier nosinfo app legalEntityName submittingLegalEntityName/>
    <@printNoS _subject dossier nosinfo app legalEntityName submittingLegalEntityName/>
</#assign>
<#assign content=content?replace('", "', '","')/>
${content}
<#else>
Please run Report Generator from a dossier.
</#if>
<#--macros-->
<#macro printHeader app>
    <@compress single_line=true>
    NoS ID,Remarks/Justification,Study NoS classification,
    Reference Type,Title,Author,Year,Bibliographic source,Testing facility,Report date, Report no.,Study sponsor,Study no.,Remarks,Reference uuid,
    No records,
    Study period,Endpoint,Guideline,GLP,Adequacy,Study uuid,
    <@printChildren path=app header=true/>
    Subject,Subject ids,Active Substance(s),Pre-application identification,
    Dossier name,Dossier UUID,Dossier submission remarks,Dossier creation date and time,Submission type,
    Owner legal entity,Third party,Submitting legal entity
    </@compress>
</#macro>

<#macro printJustNoS _subject dossier nosinfo app legalEntityName submittingLegalEntityName>
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
            "<@com.text nos.Justification/>",
            "justified study",
            "","","","","","","","","","","","",
            "","","","","","","",
            <@printChildren path=app header=false/>
            <@printSubject _subject/>
            <@printPreapp nosinfo/>
            <@printDossierInfo dossier/>
            "${legalEntityName}",
            "${thirdPartyName}",
            "${submittingLegalEntityName}"
            </@compress>

        </#list>
    </#if>
</#macro>

<#macro printNoS _subject dossier nosinfo app ownerLegalEntity submittingLegalEntityName>
    <#compress>

        <#assign NoSstudyHash={}/>
        <#assign missingNoSstudyHash={}/>
        <@populateNoSstudyHashes _subject/>

        <#assign fullList=NoSstudyHash+missingNoSstudyHash/>
		<#list fullList as key,value>

            <#local reference=value['reference']/>
            <#local studies=value['doc']/>

            <#list studies as study>

                <@compress single_line=true>
                <#if NoSstudyHash?keys?seq_contains(reference.documentKey.uuid)><#local NoSid=getNoSid(reference, true)/><#else><#local NoSid=getNoSid(reference, false)/></#if>
                "${NoSid}",
                <#local NoSremarks=getNoSidRemarks(reference)/>
                <#if NoSremarks?has_content>"${NoSremarks}"<#else>""</#if>,
                <#if NoSstudyHash?keys?seq_contains(reference.documentKey.uuid)>"notified study"<#else>"study lacking notification"</#if>,
                <@printChildren path=reference.GeneralInfo header=false exclude=["Attachments_list", "StudyIdentifiers_list"]/>
                "<@com.text reference.documentKey.uuid/>",
                "${studies?size}",
                <#if study.hasElement("AdministrativeData.StudyPeriod")>"<@com.text study.AdministrativeData.StudyPeriod/>"<#else>""</#if>,
                 <#local endpoint>
                    <#compress>
                        <#if study.hasElement("AdministrativeData.Endpoint")>
                            <@com.picklist study.AdministrativeData.Endpoint/>
                        <#else>
                            <#if study.documentSubType=="IntermediateEffects">
                                intermediate effects: <@com.picklist study.AdministrativeData.StudyResultType/>
                            <#elseif study.documentSubType=="AnalyticalProfileOfBatches">
                            	5-batch analysis
                        	<#elseif study.documentSubType=="BioPropertiesMicro">
                            	biological properties of the microorganism<#-- It's not very specific at the moment-->
                            </#if>
                        </#if>
                    </#compress>
                 </#local>
                 "${endpoint}",
<#--                "<@com.picklist study.AdministrativeData.Endpoint/>",-->
                <#local guideline><#compress>
                    <#if study.hasElement("MaterialsAndMethods.Guideline")>
                        <@studyandsummaryCom.guidelineList study.MaterialsAndMethods.Guideline/>
                        <#if study.MaterialsAndMethods.MethodNoGuideline?has_content>
                            - other method: <@com.text study.MaterialsAndMethods.MethodNoGuideline/>
                        </#if>
                    <#elseif study.hasElement("MaterialsAndMethods.MethodUsed")>
                        <#if study.hasElement("MaterialsAndMethods.MethodUsed.Qualifier")>
                            <@com.picklist study.MaterialsAndMethods.MethodUsed.Qualifier/>
                        </#if>
                        <#if study.hasElement("MaterialsAndMethods.MethodUsed.MethodUsed")>
                            method <@com.picklist study.MaterialsAndMethods.MethodUsed.MethodUsed/>
                        </#if>
                    </#if>
                </#compress></#local>
                "${guideline}",
                <#local glp><#compress>
                    <#if study.hasElement("MaterialsAndMethods")>
                            <#if study.hasElement("MaterialsAndMethods.GLPComplianceStatement")>
                                <@com.picklist study.MaterialsAndMethods.GLPComplianceStatement/>
                            <#elseif study.hasElement("MaterialsAndMethods.MethodUsed.GLPCompliance")>
                                <@com.picklist study.MaterialsAndMethods.MethodUsed.GLPCompliance/>
                            </#if>

                            <#if study.hasElement("MaterialsAndMethods.OtherQualityAssurance") && study.MaterialsAndMethods.OtherQualityAssurance?has_content>
                                ; other quality assurance: <@com.picklist study.MaterialsAndMethods.OtherQualityAssurance/>
                            <#elseif study.hasElement("MaterialsAndMethods.MethodUsed.OtherQualityFollowed") && study.MaterialsAndMethods.MethodUsed.OtherQualityFollowed?has_content>
                                ; other quality assurance: <@com.picklist study.MaterialsAndMethods.MethodUsed.OtherQualityFollowed/>
                            </#if>
                    </#if>
                </#compress></#local>
                "${glp}",
                <#if study.hasElement("AdministrativeData.PurposeFlag")>"<@com.picklist study.AdministrativeData.PurposeFlag/>"<#else>""</#if>,
<#--                "<@com.picklist study.AdministrativeData.PurposeFlag/>",-->
                "<@com.text study.documentKey.uuid/>",
                <@printChildren path=app header=false/>
                <@printSubject _subject/>
                <@printPreapp nosinfo/>
                <@printDossierInfo dossier/>
                "${legalEntityName}",
                "${thirdPartyName}",
                "${submittingLegalEntityName}"
                </@compress>

            </#list>
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
        <#local actSubs=com.getComponents(_subject, "active substance")/>
        <#local actSubIds>
            <#if actSubs?has_content>
                <#list actSubs as actSub>
                    <@substanceIds actSub/>
                    <#if actSub_has_next>; </#if>
                </#list>
            </#if>
        </#local>

        <#local otherProd = com.getOtherRepresentativeProducts(_subject)/>
        <#local products = [_subject] + otherProd />
        <#local prodsNames><#compress>
            <#list products as prod>
                <@com.text prod.MixtureName/>
                <#if prod?has_next>; </#if>
            </#list>
        </#compress></#local>
        "${prodsNames}","<@mixtureIds products/>","${actSubIds}",
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
                <#elseif nodeType=="decimal" || nodeType=="integer">
                    <@com.number node/>
                <#elseif nodeType=="multilingual_text_html">
                    <@com.richText node/>
                <#elseif nodeType?contains("text")>
                    <@com.text node/>
                <#elseif nodeType=="date">
                    <@com.text node/>
                <#elseif nodeType=="boolean">
                    <#if node>Y<#else>N</#if>
                </#if>
            </#compress></#assign>

            <#-- remove escaping...-->
            <#assign nodeVal=nodeVal?replace("&gt;", ">")?replace("&lt;", "<")?replace("&amp;", "&")/>
            ${nodeVal}
        </#if>

    </#compress>
</#macro>

<#macro mixtureIds mixtures>
    <#compress>
        <@compress single_line=true>
        <#list mixtures as mixture>
            <#if mixture.PublicName?has_content>public name: <@com.text mixture.PublicName/><#if mixture.OtherNames?has_content>;</#if></#if>
            <#if mixture.OtherNames?has_content>
                <#list mixture.OtherNames as nameEntry>
                    <#--Substitute : by - in name type and in name-->
                    <#local nameType><@com.picklist nameEntry.NameType/></#local>
                    <#local nameType=nameType?replace(":", "-")/>

                    <#local name><@com.text nameEntry.Name/></#local>
                    <#local name=name?replace(":", "-")/>

    <#--                <@com.picklist name.NameType/>: <@com.text name.Name/>-->
                    <#if name?has_content>${nameType}: ${name}</#if>
    <#--                    <#if nameEntry.Country?has_content>-->
    <#--                        in <@com.picklistMultiple nameEntry.Country/>-->
    <#--                    </#if>-->
    <#--                <#if nameEntry.hasElement("Remarks") && nameEntry.Remarks?has_content>(<@com.text nameEntry.Remarks/>)</#if>-->
                    <#if nameEntry_has_next>; </#if>
                </#list>
            </#if>
            <#local compositions = iuclid.getSectionDocumentsForParentKey(mixture.documentKey, "FLEXIBLE_RECORD", "MixtureComposition")/>
            <#if compositions?has_content>
                <#list compositions as composition>
                    ; composition: <@com.text composition.GeneralInformation.Name/>
                    <#list composition.GeneralInformation.TradeNames as tradeName>
                        ; <@com.text tradeName.TradeName/>
                    <#--                    <#if tradeName.Country?has_content>-->
                    <#--                        (<@com.picklistMultiple tradeName.Country/>)-->
                    <#--                    </#if>-->
                    </#list>
                </#list>
            </#if>

            <#if mixture?has_next>; </#if>
        </#list>
        </@compress>

    </#compress>
</#macro>

<#macro substanceIds substance>
    <#compress>
        <@compress single_line=true>
        Name: <@com.text substance.ChemicalName/>;
        <#local mixIds><@mixtureIds [substance]/></#local>
        <#if mixIds?has_content>${mixIds};</#if>

        <#local referenceSubstance = iuclid.getDocumentForKey(substance.ReferenceSubstance.ReferenceSubstance) />
            <#if referenceSubstance?has_content>
                Reference substance: <@com.text referenceSubstance.ReferenceSubstanceName/>;
                <#if referenceSubstance.Inventory?? && referenceSubstance.Inventory.InventoryEntry?has_content>
                    EC number: <@com.inventoryECNumber com.getReferenceSubstanceKey(substance.ReferenceSubstance.ReferenceSubstance)/>;
                </#if>
                <#if referenceSubstance.Inventory?? && referenceSubstance.Inventory.InventoryEntry?has_content>
                    EC name: <@com.inventoryECName com.getReferenceSubstanceKey(substance.ReferenceSubstance.ReferenceSubstance) />;
                </#if>
                <#if referenceSubstance.Inventory?? && referenceSubstance.Inventory.InventoryEntry?has_content>
                    CAS number (EC inventory): <@com.inventoryECCasNumber com.getReferenceSubstanceKey(substance.ReferenceSubstance.ReferenceSubstance) />;
                </#if>
                <#if referenceSubstance?? && referenceSubstance.Inventory.CASNumber?has_content>
                    CAS number: <@com.casNumber com.getReferenceSubstanceKey(substance.ReferenceSubstance.ReferenceSubstance) />;
                </#if>
                <#if referenceSubstance?? && referenceSubstance.Inventory.CASName?has_content>
                    CAS name: <@com.casName com.getReferenceSubstanceKey(substance.ReferenceSubstance.ReferenceSubstance)/>;
                </#if>
                <#if referenceSubstance?? && referenceSubstance.IupacName?has_content>
                    IUPAC name: <@com.iupacName com.getReferenceSubstanceKey(substance.ReferenceSubstance.ReferenceSubstance)/>;
                </#if>
                <#if referenceSubstance?? && referenceSubstance.Synonyms.Synonyms?has_content>
                    <#local synonyms=getSynonyms(referenceSubstance)?join("; ")/>
                    <#if synonyms?has_content>
<#--                        Synonyms:-->
                        ${synonyms}
                    </#if>
                </#if>
            </#if>
        </@compress>

    </#compress>
</#macro>
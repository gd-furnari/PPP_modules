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
<#if ownerLegalEntity?has_content><#assign legalEntityName=ownerLegalEntity.GeneralInfo.LegalEntityName/><#else><#assign legalEntityName=""></#if>
<#assign submittingLegalEntity = iuclid.getDocumentForKey(dossier.submittingLegalEntityKey) />
<#if submittingLegalEntity?has_content><#assign submittingLegalEntityName=submittingLegalEntity.GeneralInfo.LegalEntityName/><#else><#assign submittingLegalEntityName=""/></#if>
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
    Reference Type,Title,Author,Year,Testing facility,Report date,Report no.,Study no.,Reference uuid,
    Study period,Endpoint,Reliability,Guideline,Guideline deviations,GLP,GLP remarks,Adequacy,
    Test material,Test material composition,Test material characteristics,Additional test material,Details on test material,Details on test material (confidential),
    Study uuid,
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
            "","","","","","","","",
            "","","","","","",
            "",
<#--            <@printChildren path=app header=false/>-->
            <#local purpose><#compress>
                <#if app.hasElement("ScopeApp")>
                    <@com.picklist app.ScopeApp/>
                <#elseif app.hasElement("ApplicationPurpose")>
                    <@com.picklist app.ApplicationPurpose/>
                <#elseif app.hasElement("Purpose")>
                    <@com.picklistMultiple app.Purpose/>
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

        <#assign NoSstudyList={}/>
        <#assign missingNoSstudyList={}/>
        <@populateNoSstudyLists _subject/>

        <#assign fullList=NoSstudyList+missingNoSstudyList/>
        <#list fullList as key,value>

            <#local reference=value['reference']/>
            <#local studies=value['doc']/>

            <#list studies as study>

                <@compress single_line=true>
                <#local studyUrl=getDocumentUrl(study) />
                <#local refUrl=getDocumentUrl(reference) />
                <#local NoSid=getNoSid(reference)/>
                "${NoSid}",
                <#if NoSid?has_content>"notified study"<#else>"study lacking notification"</#if>,
                <#local NoSremarks=getNoSidRemarks(reference)/>
                <#if NoSremarks?has_content>"${NoSremarks}"<#else>""</#if>,
                <@printChildren path=reference.GeneralInfo header=false exclude=["Attachments_list", "StudyIdentifiers_list", "Source", "CompanyOwner", "Remarks"]/>
                "=HYPERLINK(""${refUrl}"",""${reference.documentKey.uuid}"")",
                "<@com.text study.AdministrativeData.StudyPeriod/>",
                "<#if study.hasElement("AdministrativeData.Endpoint")><@com.picklist study.AdministrativeData.Endpoint "en" false false false/></#if>",
                "<@com.picklist study.AdministrativeData.Reliability "en" false false false/>",
                <#local guideline><#compress>
                    <#if study.hasElement("MaterialsAndMethods.Guideline")>
                        <@studyandsummaryCom.guidelineList study.MaterialsAndMethods.Guideline/>
<#--                        <#if study.MaterialsAndMethods.MethodNoGuideline?has_content>-->
<#--                            - other method: <@com.text study.MaterialsAndMethods.MethodNoGuideline/>-->
<#--                        </#if>-->
<#--                    <#elseif study.hasElement("MaterialsAndMethods.MethodUsed")>-->
<#--                        <#if study.hasElement("MaterialsAndMethods.MethodUsed.Qualifier")>-->
<#--                            <@com.picklist study.MaterialsAndMethods.MethodUsed.Qualifier/>-->
<#--                        </#if>-->
<#--                        <#if study.hasElement("MaterialsAndMethods.MethodUsed.MethodUsed")>-->
<#--                            method <@com.picklist study.MaterialsAndMethods.MethodUsed.MethodUsed/>-->
<#--                        </#if>-->
                    </#if>
                </#compress></#local>
                "${guideline}",
                <#local devs=getGuidelineDevs(study)/>
                "${devs}",
                <#local glp><#compress>
                    <#if study.hasElement("MaterialsAndMethods")>
                        <#if study.hasElement("MaterialsAndMethods.GLPComplianceStatement")>
                            <@com.picklist study.MaterialsAndMethods.GLPComplianceStatement "en" false false false/>
                        <#elseif study.hasElement("MaterialsAndMethods.MethodUsed.GLPCompliance")>
                            <@com.picklist study.MaterialsAndMethods.MethodUsed.GLPCompliance "en" false false false/>
                        </#if>
<#--                        <#if study.hasElement("MaterialsAndMethods.OtherQualityAssurance") && study.MaterialsAndMethods.OtherQualityAssurance?has_content>-->
<#--                            ; other quality assurance: <@com.picklist study.MaterialsAndMethods.OtherQualityAssurance/>-->
<#--                        <#elseif study.hasElement("MaterialsAndMethods.MethodUsed.OtherQualityFollowed") && study.MaterialsAndMethods.MethodUsed.OtherQualityFollowed?has_content>-->
<#--                            ; other quality assurance: <@com.picklist study.MaterialsAndMethods.MethodUsed.OtherQualityFollowed/>-->
<#--                        </#if>-->
                    </#if>
                </#compress></#local>
                "${glp}",
                <#local glpRemarks><#compress>
                    <#if study.hasElement("MaterialsAndMethods.GLPComplianceStatement") && study.MaterialsAndMethods.GLPComplianceStatement?has_content>
                        ${study.MaterialsAndMethods.GLPComplianceStatement.remarks}
                    <#elseif study.hasElement("MaterialsAndMethods.MethodUsed.GLPCompliance") && study.MaterialsAndMethods.MethodUsed.GLPCompliance?has_content>
                        ${study.MaterialsAndMethods.MethodUsed.GLPCompliance.remarks}
                    </#if>
                </#compress></#local>
                "${glpRemarks}",
                "<#if study.hasElement("AdministrativeData.PurposeFlag")><@com.picklist study.AdministrativeData.PurposeFlag "en" false false false/></#if>",
                "<#if study.hasElement("MaterialsAndMethods.TestMaterials.TestMaterialInformation")><@testMaterial study.MaterialsAndMethods.TestMaterials.TestMaterialInformation/></#if>",
                "<#if study.hasElement("MaterialsAndMethods.TestMaterials.TestMaterialInformation")><@testMaterialComp study.MaterialsAndMethods.TestMaterials.TestMaterialInformation/></#if>",
                "<#if study.hasElement("MaterialsAndMethods.TestMaterials.TestMaterialInformation")><@testMaterialChar study.MaterialsAndMethods.TestMaterials.TestMaterialInformation/></#if>",
				"<#if study.hasElement("MaterialsAndMethods.TestMaterials.AdditionalTestMaterialInformation")><@additionalTestMaterial study.MaterialsAndMethods.TestMaterials.AdditionalTestMaterialInformation/></#if>",
				"<#if study.hasElement("MaterialsAndMethods.TestMaterials.SpecificDetailsOnTestMaterialUsedForTheStudy")><@com.text study.MaterialsAndMethods.TestMaterials.SpecificDetailsOnTestMaterialUsedForTheStudy/></#if>",
				"<#if study.hasElement("MaterialsAndMethods.TestMaterials.SpecificDetailsOnTestMaterialUsedForTheStudyConfidential")><@com.text study.MaterialsAndMethods.TestMaterials.SpecificDetailsOnTestMaterialUsedForTheStudyConfidential/></#if>",
                "=HYPERLINK(""${studyUrl}"",""${study.documentKey.uuid}"")",
                <#local purpose><#compress>
                    <#if app.hasElement("ScopeApp")>
                        <@com.picklist app.ScopeApp/>
                    <#elseif app.hasElement("ApplicationPurpose")>
                        <@com.picklist app.ApplicationPurpose/>
                    <#elseif app.hasElement("Purpose")>
                        <@com.picklistMultiple app.Purpose/>
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
            </#list>
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
            <#local actSubs=com.getComponents(_subject, "active substance")/>
            <#local actSubIds>
                <#if actSubs?has_content>
                    <#list actSubs as actSub>
                        <@substanceIds actSub/>
                        <#if actSub_has_next>; </#if>
                    </#list>
                </#if>
            </#local>
            "<@com.text _subject.MixtureName/>","${actSubIds}",
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

<#macro mixtureIds mixture>
    <#compress>
        <@compress single_line=true>
            <#if mixture.PublicName?has_content>public name: <@com.text mixture.PublicName/><#if mixture.OtherNames?has_content>;</#if></#if>
            <#if mixture.OtherNames?has_content>
                <#list mixture.OtherNames as nameEntry>
                <#--Substitute : by - in name type and in name-->
                    <#local nameType><@com.picklist nameEntry.NameType/></#local>
                    <#local nameType=nameType?replace(":", "-")/>

                    <#local name><@com.text nameEntry.Name/></#local>
                    <#local name=name?replace(":", "-")/>

                    <#if name?has_content>${nameType}: ${name}</#if>
                    <#if nameEntry_has_next>; </#if>
                </#list>
            </#if>
            <#local compositions = iuclid.getSectionDocumentsForParentKey(mixture.documentKey, "FLEXIBLE_RECORD", "MixtureComposition")/>
            <#if compositions?has_content>
                <#list compositions as composition>
                    ; composition: <@com.text composition.GeneralInformation.Name/>
                    <#list composition.GeneralInformation.TradeNames as tradeName>
                        ; <@com.text tradeName.TradeName/>
                    </#list>
                </#list>
            </#if>
        </@compress>

    </#compress>
</#macro>

<#macro substanceIds substance>
    <#compress>
        <@compress single_line=true>
            Name: <@com.text substance.ChemicalName/>;
            <#local mixIds><@mixtureIds substance/></#local>
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

<#function getGuidelineDevs study>
    <#if study.hasElement("MaterialsAndMethods.Guideline") && study.MaterialsAndMethods.Guideline?has_content>
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

<#macro additionalTestMaterial path>

	<#if path?has_content>
		<#list path as addTestMatPath>
			<@testMaterialName addTestMatPath/>.
		</#list>
	</#if>
	
</#macro>

<#macro testMaterial path>
	<#local testMat = iuclid.getDocumentForKey(path) />
	<#if testMat?has_content><@com.text testMat.Name/></#if>
</#macro>

<#macro testMaterialComp path>
	<#local testMat = iuclid.getDocumentForKey(path) />
	
	<#if testMat?has_content>
		<#if testMat.Composition.CompositionList?has_content>
			<#list testMat.Composition.CompositionList as comp>
				<#local ref = iuclid.getDocumentForKey(comp.ReferenceSubstance)/>
				
				<@com.text ref.ReferenceSubstanceName/>
				
				<#if comp.Type?has_content>(<@com.picklist comp.Type/>)</#if>
				<#if comp.Concentration?has_content>: <@com.range comp.Concentration/></#if>
				<#if comp.Remarks?has_content> - <@com.text comp.Remarks/></#if>
				
				<#if comp?has_next> | </#if>
			</#list>
		</#if>
	</#if>
</#macro>

<#macro testMaterialChar path>
	<#local testMat = iuclid.getDocumentForKey(path) />
	
	<#if testMat?has_content>
		<#if testMat.Composition.CompositionPurityOtherInformation?has_content>
			Purity: <@com.picklist testMat.Composition.CompositionPurityOtherInformation/>.
		</#if>
		
		<#if testMat.Composition.OtherCharacteristics.TestMaterialForm?has_content>
			Form: <@com.picklist testMat.Composition.OtherCharacteristics.TestMaterialForm/>.
		</#if>
		
		<#if testMat.Composition.OtherCharacteristics.DetailsOnTestMaterial?has_content>
			Details: <@com.text testMat.Composition.OtherCharacteristics.DetailsOnTestMaterial/>.
		</#if>
		
		<#if testMat.Composition.OtherCharacteristics.ConfidentialDetailsOnTestMaterial?has_content>
			Conf. details: <@com.text testMat.Composition.OtherCharacteristics.ConfidentialDetailsOnTestMaterial/>.
		</#if>
	</#if>
</#macro>

<#function getDocumentUrl document>
  <#local generatedUrl = iuclid.webUrl.entityView(document.documentKey) />
  <#if generatedUrl?has_content>
    <#-- Get the base URL part -->
    <#local generatedUrl = generatedUrl?keep_before("/iuclid6-web") />
  </#if>
  <#return generatedUrl + "/iuclid6-web/?key=" + document.documentKey>
</#function>
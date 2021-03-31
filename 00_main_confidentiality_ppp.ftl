<?xml version="1.0" encoding="UTF-8"?>

<#-- Import common macros and functions -->
<#import "macros_common_general.ftl" as com>

<!-- Example template file -->
<#assign locale = "en" />
<#assign sysDateTime = .now>


<#assign confFlagIdentifierList = {
"MIXTURE":[{"path":"", "field":"OwnerLegalEntityProtection", "type":"val", "name":"Legal entity", "info":""},
            {"path":"", "field":"ThirdPartyProtection", "type":"val", "name":"Third party", "info":""},
            {"path":"", "field":"RoleInSupplyChain.RoleProtection", "type":"val", "name":"Role in supply chain", "info":""},
            {"path":"ContactPersons", "field":"DataProtection", "type":"rep_block", "name":"Contact person", "info":""},
            {"path":"OtherNames", "field":"Protection", "type":"rep_block", "name":"Other names", "info":""}],
"SUBSTANCE":[{"path":"", "field":"OwnerLegalEntityProtection", "type":"val", "name":"Legal entity", "info":""},
            {"path":"", "field":"ThirdPartyProtection", "type":"val", "name":"Third party", "info":""},
            {"path":"", "field":"RoleInSupplyChain.RoleProtection", "type":"val", "name":"Role in supply chain", "info":""},
            {"path":"ContactPersons", "field":"DataProtection", "type":"rep_block", "name":"Contact person", "info":""},
            {"path":"", "field":"ReferenceSubstance.Protection", "type":"val", "name":"Reference substance", "info":""},
            {"path":"OtherNames", "field":"DataProtection", "type":"rep_block", "name":"Other names", "info":""}],
"FLEXIBLE_RECORD.MixtureComposition":[{"path":"Components.Components", "field":"DataProtection", "type":"rep_block", "name":"Component", "info":""}],
"FLEXIBLE_SUMMARY.Metabolites": [{"path":"ListMetabolites.Metabolites", "field":"DataProtection", "type":"rep_block", "name":"Metabolite", "info":""}],
"FLEXIBLE_RECORD.Identifiers":[{"path":"RegulatoryProgrammeIdentifiers.RegulatoryProgrammeIdentifiers", "field":"DataProtection", "type":"rep_block", "name":"Regulatory Programme identifier", "info":""},
        {"path":"ExternalSystemIdentifiers.ExternalSystemIdentifiers", "field":"DataProtection", "type":"rep_block", "name":"External System identifier", "info":""}],
"FLEXIBLE_RECORD.ChangeLog":[{"path":"", "field":"GeneralInformation.field7767", "type":"val", "name":"Full document", "info":""}],
"FLEXIBLE_RECORD.SubstanceComposition":[{"path":"", "field":"DegreeOfPurity.DataProtection", "type":"val", "name":"Degree of purity", "info":""},
        {"path":"Constituents.Constituents", "field":"DataProtection", "type":"rep_block", "name":"Constituent", "info":""},
        {"path":"Impurities.Impurities", "field":"DataProtection", "type":"rep_block", "name":"Impurity", "info":""},
        {"path":"Additives.Additives", "field":"DataProtection", "type":"rep_block", "name":"Additive", "info":""},
        {"path":"", "field":"CharacterisationOfNanoforms.NameDataProtection", "type":"val", "name":"Nanoform name", "info":""},
        {"path":"", "field":"CharacterisationOfNanoforms.SetDataProtection", "type":"val", "name":"Nanoform set", "info":""},
        {"path":"", "field":"CharacterisationOfNanoforms.Shape.ShapeFlags", "type":"val", "name":"Nanoform shape", "info":""},
        {"path":"", "field":"CharacterisationOfNanoforms.ParticleSizeDistributionAndRange.ParticleSizeDistributionRangeFlags", "type":"val", "name":"Nanoform particle size distribution and range", "info":""},
        {"path":"", "field":"CharacterisationOfNanoforms.Crystallinity.CrystallinityFlags", "type":"val", "name":"Nanoform crystallinity", "info":""},
        {"path":"", "field":"CharacterisationOfNanoforms.SpecificSurfaceArea.SpecificSurfaceAreaFlags", "type":"val", "name":"Nanoform specific surface area", "info":""},
        {"path":"", "field":"CharacterisationOfNanoforms.SurfaceFunctionalisationTreatment.DataProtection", "type":"val", "name":"Nanoform surface functionalisation / treatment", "info":""},
        {"path":"", "field":"CharacterisationOfPolymers.PolymerMolecularWeight.DataProtection", "type":"val", "name":"Polymer molecular weight", "info":""},
        {"path":"", "field":"CharacterisationOfPolymers.ReactiveFunctionalGroups.DataProtection", "type":"val", "name":"Reactive functional groups", "info":""}],
"FLEXIBLE_RECORD.AnalyticalInformation":[{"path":"", "field":"AnalyticalInformation.DataProtection", "type":"val", "name":"Full document", "info":""}]
}/>

<#-- Initialize the following variables:
	* _dossierHeader (:DossierHashModel) //The header document of a proper or 'raw' dossier, can be empty
	* _subject (:DocumentHashModel) //The dossier subject document or, if not in a dossier context, the root document, never empty
	-->
<@com.initializeMainVariables/>

<#--<#assign ownerLegalEntity = iuclid.getDocumentForKey(_subject.OwnerLegalEntity) />-->
<#--<#assign docUrl=iuclid.webUrl.entityView(_subject.documentKey)/>-->

<book version="5.0" xmlns="http://docbook.org/ns/docbook" xmlns:xi="http://www.w3.org/2001/XInclude">

<#--    <#assign mixture = com.getReportSubject(rootDocument) />-->

<#--    &lt;#&ndash; Stop if the root document is not mixture &ndash;&gt;-->
<#--	<#if false>-->
<#--		<#stop "BPR Confidentiality Claims template expects a mixture/product as root document. The root document is not a mixture/product!" />-->
<#--	</#if>-->

<#--    <#assign left_header_text = ''/>-->
<#--    <#assign central_header_text = com.getReportSubject(rootDocument).name?html />-->
<#--    <#assign right_header_text = ''/>-->

<#--    <#assign left_footer_text = sysDateTime?string["dd/MM/yyyy"] + " - IUCLID 6 " + iuclid6Version!/>-->
<#--    <#assign central_footer_text = 'Confidentiality report' />-->
<#--    <#assign right_footer_text = ''/>-->

    <info>
        <title>
<#--            <para role="i6header5_nobold"><#if ownerLegalEntity?has_content><@com.text ownerLegalEntity.GeneralInfo.LegalEntityName/></#if></para>-->
<#--            <@com.emptyLine/>-->

<#--            <para role="rule">-->

<#--            &lt;#&ndash;                <#assign prodDocUrl=iuclid.webUrl.entityView(mixture.documentKey)/>&ndash;&gt;-->

<#--            <@com.emptyLine/>-->
<#--            &lt;#&ndash;                <ulink url="${prodDocUrl}">&ndash;&gt;-->
<#--            <ulink url="${docUrl}"><@com.text _subject.MixtureName/></ulink>-->
<#--            &lt;#&ndash;                </ulink>&ndash;&gt;-->
<#--            </para>-->
        </title>

        <subtitle>
            <para role="align-center">
            </para>
            <@com.emptyLine/>
            <para role="rule"/>
        </subtitle>

        <subtitle>
            <para role="align-right">
                <para>Confidentiality report</para>
                <para></para>
            </para>
            <@com.emptyLine/>

            <para role="align-right">
<#--                <para role="cover.i6subtext">-->
<#--                    ${left_footer_text}-->
<#--                </para>-->
            </para>
        </subtitle>

    </info>

    <chapter>
        <title role="HEAD-4">Confidentiality requests</title>

        <table border="1">
            <title>Confidentiality requests</title>
<#--            <col width="10%" />-->
<#--            <col width="8%" />-->
<#--            <col width="11.5%" />-->
<#--            <col width="11.5%" />-->
<#--            <col width="11.5%" />-->
<#--            <col width="17.5%" />-->
<#--            <col width="10%" />-->
<#--            <col width="10%" />-->
<#--            <col width="10%" />-->
            <tbody>
            <tr>
                <th><?dbfo bgcolor="#33B7FF" ?><emphasis role="bold">Doc. type</emphasis></th>
                <th><?dbfo bgcolor="#33B7FF" ?><emphasis role="bold">Doc. name</emphasis></th>
                <th><?dbfo bgcolor="#33B7FF" ?><emphasis role="bold">Doc. UUID</emphasis></th>
                <th><?dbfo bgcolor="#33B7FF" ?><emphasis role="bold">Doc. section</emphasis></th>
                <th><?dbfo bgcolor="#33B7FF" ?><emphasis role="bold">Justification</emphasis></th>

                <th><?dbfo bgcolor="#FFD17D" ?><emphasis role="bold">Accept/Do Not Accept confidentiality claim</emphasis></th>
<#--                <th><?dbfo bgcolor="#FFD17D" ?><emphasis role="bold">Is the decision based on dossier assessment or additional information, or both of these two sources</emphasis></th>-->
<#--                <th><?dbfo bgcolor="#FFD17D" ?><emphasis role="bold">ECHA's assessment remarks</emphasis></th>-->
            </tr>

            <#global entity=_subject.documentType/>
            <#assign toc=iuclid.localizeTreeFor(_subject.documentType, _subject.submissionType, _subject.documentKey)/>
            <#recurse toc/>

            <#assign components=getComponentsList(_subject)/>
            <#list components as comp>
                <#global entity=comp.documentType/>
                <#assign toc=iuclid.localizeTreeFor(comp.documentType, comp.submissionType, comp.documentKey)/>
                <#recurse toc/>
            </#list>

            </tbody>
        </table>

    </chapter>

</book>


<#macro "section_tree_node">

    <#local contents=(.node.content)!/>

    <#if contents?has_content>
        <#list contents as doc>

            <#-- if it has the basic confidentiality flag, check and add-->
            <#local flagPath="">
            <#if doc.hasElement("AdministrativeData.DataProtection")>
                <#--in ENDPOINT_STUDY_RECORD (at least)-->
                <#local flagPath="AdministrativeData.DataProtection"/>
            <#elseif doc.hasElement("AdministrativeDataSummary.DataProtection")>
                <#--in SUMMARY_RECORD (at least)-->
                <#local flagPath="AdministrativeDataSummary.DataProtection"/>>
            <#elseif doc.hasElement("DataProtection")>
                 <#--in some FLEXIBLE RECORDS: Supplieres, Sites, GhS-->
                 <#local flagPath="DataProtection"/>>
            </#if>

            <#if flagPath?has_content && isDataProtectionAvailable(doc, flagPath)>
                <@tableRowForConfidentialityFlag doc doc flagPath entity/>
            </#if>

            <#--if it's a specific doc type, then check in hashMap and add-->
            <#if doc.documentType=="SUBSTANCE" || doc.documentType=="MIXTURE">
                <#assign docTypeSubtype=doc.documentType/>
            <#else>
                <#assign docTypeSubtype="${doc.documentType}.${doc.documentSubType}"/>
            </#if>

            <#if confFlagIdentifierList?keys?seq_contains(docTypeSubtype)>
                <#assign flagIds=confFlagIdentifierList[docTypeSubtype]/>
                <#list flagIds as flagId>
                    <#if flagId.type=="val">
                        <@tableRowForConfidentialityFlag doc doc flagId.field entity flagId.name/>
                    <#elseif flagId.type="rep_block">
                        <#local blockPath = "doc." + flagId.path />
                        <#list blockPath?eval as path>
                            <#assign secName=flagId.name+"#${path_index+1}"/>
                            <@tableRowForConfidentialityFlag doc path flagId.field entity secName/>
    <#--                        #add code for info on reference (name)-->
                        </#list>
                    </#if>
                </#list>
            </#if>
        </#list>
    </#if>

    <#recurse/>
</#macro>

<#macro tableRowForConfidentialityFlag document section flagPath entityName="" fieldName="Full document">
    <#compress>
        <#if isDataProtectionAvailable(section, flagPath)>

    <#--         <#local reference=getStudyReference(doc)/>-->

    <#--                <#if reference?has_content>-->
            <tr><?dbfo bgcolor="#97DAFF"?>

            <#-- Type-->
            <td>
                ${entityName}: <@com.text document.documentType/> : <@com.text document.documentSubType/>
            </td>

            <#-- Document Name -->
            <td>
                <@com.text document.name />
            </td>

            <#-- UUID -->
            <td>
                <#assign docUrl=iuclid.webUrl.documentView(documentKey) />
                <#if docUrl?has_content>
                    <ulink url="${docUrl}"><@com.text document.documentKey.uuid/></ulink>
                <#else>
                    <@com.text document.documentKey.uuid/>
                </#if>
            </td>
    <#--            document.documentKey.snapshotUuid-->

            <#-- Field Name -->
            <td>
                ${fieldName}
            </td>

            <#-- Justification -->
            <td>
                <#local confidentialityFlagPath = "section." + flagPath + ".confidentiality" />
                <#local confidentialityFlag = confidentialityFlagPath?eval />
                <#if !(confidentialityFlag)?has_content>
                    <emphasis role="bold">
                        <para>Note that no confidentiality claim has been made using the following three reasons: "Confidential business information", "intellectual property", "not publicly available"
                        </para>
                    </emphasis>
                <@com.emptyLine/>
                </#if>

                <#local justificationPath = "section." + flagPath + ".justification" />
                <#local justification = justificationPath?eval />
                <#if justification?has_content>
                    <@com.text justification />
                    <@com.emptyLine/>
                <#else>
                    <emphasis role="bold">No Justification Provided</emphasis>
                    <@com.emptyLine/>
                </#if>

<#--                <#local regulatoryPath = "section." + flagPath + ".legislations" />-->
<#--                <#local regulation = regulatoryPath?eval />-->
<#--                <#if regulation?has_content>-->
<#--                    <para>Regulatory programme(s) which the claim is restricted to:</para>-->
<#--                    <@com.picklistMultiple regulation />-->
<#--                <#else>-->
<#--                    <emphasis role="bold">The claim is not restricted to any Regulatory programme</emphasis>-->
<#--                </#if>-->
            </td>

            <!-- Accept/Do Not Accept confidentiality claim -->
            <td><?dbfo bgcolor="#FFFFFF" ?>

            </td>

    <#--        <!-- Decision based on dossier assessment or additional information, or both of these two sources &ndash;&gt;-->
    <#--        <td><?dbfo bgcolor="#FFFFFF" ?>-->

    <#--        </td>-->

    <#--        <!-- ECHA's assessment remarks &ndash;&gt;-->
    <#--        <td><?dbfo bgcolor="#FFFFFF" ?>-->

    <#--        </td>-->
            </tr>
        </#if>
    </#compress>
</#macro>


<#function isDataProtectionAvailable document flagPath>
    <#assign dataProtection="document." + flagPath/>
    <#assign dataProtection=dataProtection?eval/>
<#--    -->
<#--		<#assign confidentialityFlagPath = "document." + flagPath + ".confidentiality" />-->
<#--		<#local confidentiality = confidentialityFlagPath?eval />-->

<#--		<#assign justificationPath = "document." + flagPath + ".justification" />-->
<#--		<#local justification = justificationPath?eval />-->

<#--		<#assign regulatoryPath = "document." + flagPath + ".legislations" />-->
<#--		<#local regulatory = regulatoryPath?eval />-->

		<#if dataProtection.confidentiality?has_content || dataProtection.justification?has_content>
		    <#return true />
		<#else>
<#--			<#if !(confidentiality)?has_content || !(justification)?has_content || regulatory?has_content>-->
			    <#return false />
<#--			</#if>-->
		</#if>
</#function>

<#function getComponentsList mixture>
    <#local substanceList = []/>

    <#local compositionList = iuclid.getSectionDocumentsForParentKey(mixture.documentKey, "FLEXIBLE_RECORD", "MixtureComposition") />

    <#list compositionList as composition>
        <#local componentList = composition.Components.Components/>

        <#list componentList as component>
            <#if component.Reference?has_content>
                <#local substance = iuclid.getDocumentForKey(component.Reference)/>
                <#if substance.documentType=="SUBSTANCE" || substance.documentType=="MIXTURE">
                    <#local substanceList = com.addDocumentToSequenceAsUnique(substance, substanceList)/>
                </#if>
            </#if>
        </#list>
    </#list>

    <#return substanceList />
</#function>


<#--ASSESSMENT_ENTITY.RegisteredSubstanceAsSuch.AssessmentEntityConfidentialityClaim-->
<#--ASSESSMENT_ENTITY.SpecificCompositionOfTheRegisteredSubstance.AssessmentEntityConfidentialityClaim-->
<#--ASSESSMENT_ENTITY.GroupOfConstituentInTheRegisteredSubstance.AssessmentEntityConfidentialityClaim-->
<#--ASSESSMENT_ENTITY.TransformationProductOfTheRegisteredSubstance.AssessmentEntityConfidentialityClaim-->



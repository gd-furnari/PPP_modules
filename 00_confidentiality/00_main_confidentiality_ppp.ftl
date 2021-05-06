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
<#assign ownerLegalEntity = iuclid.getDocumentForKey(_subject.OwnerLegalEntity) />

<#if _dossierHeader?has_content>

    <#assign dossier = _dossierHeader />

    <#--get context and paths-->
    <#if dossier.documentSubType=="EU_PPP_MAXIMUM_RESIDUE_LEVELS">
        <#assign app=dossier.MRLApplication.DossierSpecificInformation/>
    <#elseif dossier.documentSubType=="EU_PPP_MICROORGANISMS_FOR_MIXTURES" || dossier.documentSubType=="EU_PPP_ACTIVE_SUBSTANCE_FOR_MIXTURES">
        <#assign app=dossier.ActiveSubstanceApproval/>
    <#elseif dossier.documentSubType=="EU_PPP_BASIC_SUBSTANCE">
        <#assign app=dossier.BasicSubstanceApproval/>
    <#elseif dossier.documentSubType=="EU_PPP_PESTICIDE_PRODUCT">
        <#assign app=dossier.ApplicationForOrAmendmentToPlantProtectionProductAuthorisation/>
        <#--NOTE: not considered for the moment. Fields:-->
        <#--ApplicationForOrAmendmentToPlantProtectionProductAuthorisation.ApplicationIsMadeThroughARepresentativeOfTheApplicant (picklist)-->
        <#--ApplicationForOrAmendmentToPlantProtectionProductAuthorisation.AuthorisationPreviouslyGrantedForPlantProtectionProduct (picklist)-->
        <#--ApplicationForOrAmendmentToPlantProtectionProductAuthorisation.ConclusionSOfTheMemberStateAssessingEquivalence (picklist)-->
    </#if>

    <#--<#assign docUrl=iuclid.webUrl.entityView(_subject.documentKey)/>-->

    <book version="5.0" xmlns="http://docbook.org/ns/docbook" xmlns:xi="http://www.w3.org/2001/XInclude">

        <#assign left_header_text = ''/>
        <#assign central_header_text = com.getReportSubject(rootDocument).name?html />
        <#assign right_header_text = ''/>

        <#assign left_footer_text = sysDateTime?string["dd/MM/yyyy"] + " - IUCLID 6 " + iuclid6Version!/>
        <#assign central_footer_text = 'Confidentiality report' />
        <#assign right_footer_text = ''/>

        <info>
            <title>
                <para role="i6header5_nobold"><#if ownerLegalEntity?has_content><@com.text ownerLegalEntity.GeneralInfo.LegalEntityName/></#if></para>
                <@com.emptyLine/>

                <para role="rule">

                <#assign dossierUrl=iuclid.webUrl.entityView(dossier.documentKey)/>

                <@com.emptyLine/>
                <ulink url="${dossierUrl}">
                Dossier: <@com.text dossier.name />
                </ulink>
                </para>
            </title>

            <subtitle>
                <para role="align-center">
                    <#if _subject.documentType=="MIXTURE">for mixture <@com.text _subject.MixtureName/>
                    <#elseif _subject.documentType=="SUBSTANCE">for substance <@com.text _subject.ChemicalName/></#if>
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
                    <para role="cover.i6subtext">
                        ${left_footer_text}
                    </para>
                </para>
            </subtitle>

        </info>

        <chapter>
            <title role="HEAD-4">Administrative information</title>

             Dossier details
            <para><emphasis role="bold">Application dossier details:</emphasis>
                <para role="indent"><itemizedlist>
                    <listitem>Dossier name: <@com.text dossier.name /></listitem>
                    <listitem>Dossier UUID: <@com.text dossier.subjectKey /></listitem>
                    <listitem>Dossier submission remarks: <@com.text dossier.remarks /></listitem>
                    <listitem>Dossier creation date and time: <@com.text dossier.creationDate /></listitem>
                    <listitem>Submission type: <@com.text dossier.submissionType /></listitem>
                    <listitem>Submitting legal entity:
                        <#if ownerLegalEntity?has_content><@com.text ownerLegalEntity.GeneralInfo.LegalEntityName/></#if>
                    </listitem>
                </itemizedlist></para>
            </para>

            <#-- EU reference nb-->
            <para><emphasis role="bold">European reference number:</emphasis>
                <#--for mixtures-->
                <#if app.hasElement("EuropeanReferenceNumber")>
                    <@com.text app.EuropeanReferenceNumber/>
                <#--for basic and MRL-->
                <#elseif app.hasElement("EUReferenceNumber")>
                    <@com.text app.EUReferenceNumber/>
                <#--for authorisations-->
                <#elseif app.hasElement("ReferenceNumber")>
                    <@com.text app.ReferenceNumber/>
                </#if>
            </para>

            <#-- Purpose-->
            <para><emphasis role="bold">Purpose of the application:</emphasis>
                <#--for basic-->
                <#if app.hasElement("ScopeApp")>
                    <@com.picklist app.ScopeApp/>
                    <#if app.ApplicationPurpose?has_content>
                        - <@com.text app.ApplicationPurpose/>
                    </#if>
                <#--for mixtures-->
                <#elseif app.hasElement("ApplicationPurpose")>
                    <@com.picklist app.ApplicationPurpose/>
                <#--MRL-->
                <#elseif app.hasElement("Purpose")>
                    <@com.picklist app.Purpose/>
                <#--for authorisations-->
                <#elseif app.hasElement("ReferenceNumber")>
                    <@com.text app.ReferenceNumber/>
                </#if>
            </para>

            <#-- RMs/EMs-->
            <#--for mixtures-->
            <#if app.hasElement("RapporteurMemberState")>
                <para><emphasis role="bold">Rapporteur Member State (RMS):</emphasis>
                    <@com.picklist app.RapporteurMemberState/>
                    <#if app.hasElement("CoRms") && app.CoRms?has_content>
                        (Co-RMS: <@com.picklistMultiple app.CoRms/>)
                    </#if>
                    <#if app.hasElement("CompetentAuthority") && app.CompetentAuthority?has_content>
                        <para role="indent">- Competent Authority: <@com.text app.CompetentAuthority/></para>
                    </#if>
                    <#--NOTE: missing JointApplication (picklist)-->
                </para>
            <#--MRL-->
            <#elseif app.hasElement("EMS")>
                <para><emphasis role="bold">Evaluating Member State (EMS):</emphasis>
                    <@com.picklist app.EMS/>
                </para>
            <#--Basic-->
            <#elseif app.hasElement("Contributors")>
                <para><emphasis role="bold">Contributors:</emphasis>
                    <@com.text app.Contributors/>
                </para>
            </#if>

            <#--Only for MRL-->
            <#if dossier.documentSubType=="EU_PPP_MAXIMUM_RESIDUE_LEVELS">
                <para><emphasis role="bold">Applicant:</emphasis><@com.picklistMultiple app.Applicant/></para>
                <para><emphasis role="bold">Data requirements:</emphasis><@com.picklist app.DataRequirements/></para>
            </#if>

        </chapter>

        <chapter>
            <title role="HEAD-4">Confidentiality requests</title>

            <para role="small">
            <table border="1">
                <title>Confidentiality requests</title>
                <col width="15%" />
                <col width="15%" />
                <col width="15%" />
                <col width="10%" />
                <col width="10%" />
                <col width="25%" />
                <col width="10%" />

                <tbody valign="middle">
                <tr  align="center">
                    <th><?dbfo bgcolor="#33B7FF" ?><emphasis role="bold">IUCLID section</emphasis></th>
                    <th><?dbfo bgcolor="#33B7FF" ?><emphasis role="bold">Doc. type</emphasis></th>
                    <th><?dbfo bgcolor="#33B7FF" ?><emphasis role="bold">Doc. name</emphasis></th>
                    <th><?dbfo bgcolor="#33B7FF" ?><emphasis role="bold">Doc. UUID</emphasis></th>
                    <th><?dbfo bgcolor="#33B7FF" ?><emphasis role="bold">Doc. section</emphasis></th>
                    <th><?dbfo bgcolor="#33B7FF" ?><emphasis role="bold">Justification</emphasis></th>
                    <th><?dbfo bgcolor="#FFD17D" ?><emphasis role="bold">Accept / Do Not Accept</emphasis></th>
                </tr>

                <#global entity=_subject.documentType/>
                <#global toc=iuclid.localizeTreeFor(_subject.documentType, _subject.submissionType, _subject.documentKey)/>
                <#recurse toc/>

                <#assign components=getComponentsList(_subject)/>
                <#list components as comp>
                    <#global entity=comp.documentType/>
                    <#global toc=iuclid.localizeTreeFor(comp.documentType, comp.submissionType, comp.documentKey)/>
                    <#recurse toc/>
                </#list>

                </tbody>
            </table>
            </para>
        </chapter>

    </book>
<#else>
    <book version="5.0" xmlns="http://docbook.org/ns/docbook" xmlns:xi="http://www.w3.org/2001/XInclude">
        <info>
            <title>Confidentiality report expects a dossier as root document. The root document is not a dossier!
                    Please, create a dossier from your mixture/substance dataset and try again.
            </title>
        </info>
        <part></part>
    </book>
</#if>


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
                <@tableRowForConfidentialityFlag doc doc flagPath entity "Full document"/>
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

            <tr><?dbfo bgcolor="#97DAFF"?>

            <#-- IUCLID section -->
            <td>
                <#assign docTypeSubtype>
                    <#compress>
                        ${document.documentType}<#if document.documentSubType?has_content>.${document.documentSubType}</#if>
                    </#compress>
                </#assign>
                <#if docTypeSubtype?has_content>
                    <#if docTypeSubtype=="MIXTURE">
                        1.1 Identity of the plant protection product, trade name or proposed trade name, and applicant
                    <#elseif docTypeSubtype=="SUBSTANCE">
                        <#if subType?contains("MICRO")>
                            1.3 Name, species description, strain characterisation and applicant
                        <#else>
                            1.1 Identity of the active substance and applicant
                        </#if>
                    <#else>
                        <#assign numberToC = toc.nodeFor[docTypeSubtype].number />
                        ${numberToC}

                        <#assign titleToC = toc.nodeFor[docTypeSubtype].title />
                        ${titleToC}
                    </#if>
                </#if>
            </td>

            <#-- Type -->
            <td>
                ${entityName?replace("_", " ")?capitalize}: ${document.documentType?replace("_", " ")?capitalize}<#if document.documentSubType?has_content>: <@com.text document.documentSubType/></#if>
            </td>

            <#-- Document Name -->
            <td>
                <@com.text document.name />

                <#-- reference if exists -->
                <#if document.hasElement("DataSource.Reference")>
                    <#assign reference=getStudyReference(document)/>
                    <#if reference?has_content>
                        <para>(ref: <@com.text reference.GeneralInfo.Name/>, <@com.text reference.GeneralInfo.ReferenceYear/>)</para>
                    </#if>
                </#if>
            </td>

            <#-- UUID (note: it's too long and doesn't show properly)-->
            <td>
                <#--<#assign uuid=document.documentKey.uuid?replace("-", "-<?linebreak?>")/>-->
<#--                <#assign uuid=document.documentKey.uuid/>-->
                <#assign uuid><#compress>
                    <#list document.documentKey.uuid?matches('.{1,14}', 's') as chunk>
                        ${chunk}<#if chunk_has_next><?linebreak?></#if>
                    </#list>
                </#compress></#assign>
                <#assign docUrl=iuclid.webUrl.documentView(documentKey)/>
                <#if docUrl?has_content>
                    <ulink url="${docUrl}">${uuid}</ulink>
                <#else>
                    ${uuid}
                </#if>
            </td>

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

                    <#-- if mixture, call function again-->
                    <#if substance.documentType=="MIXTURE">
                        <#local substanceList = substanceList + getComponentsList(substance)/>
                    </#if>
                </#if>
            </#if>
        </#list>
    </#list>

    <#return substanceList />
</#function>

<#function getStudyReference study>

    <#local reference=""/>

    <#local referenceLinksList=study.DataSource.Reference/>

    <#if referenceLinksList?has_content>
        <#list referenceLinksList as referenceLink>
            <#local referenceEntry = iuclid.getDocumentForKey(referenceLink)/>
            <#local litType><@com.picklist referenceEntry.GeneralInfo.LiteratureType/></#local>
            <#if litType=="study report">
                <#local reference=referenceEntry/>
                <#break>
            </#if>
        </#list>
    </#if>

    <#return reference>
</#function>


<#--ASSESSMENT_ENTITY.RegisteredSubstanceAsSuch.AssessmentEntityConfidentialityClaim-->
<#--ASSESSMENT_ENTITY.SpecificCompositionOfTheRegisteredSubstance.AssessmentEntityConfidentialityClaim-->
<#--ASSESSMENT_ENTITY.GroupOfConstituentInTheRegisteredSubstance.AssessmentEntityConfidentialityClaim-->
<#--ASSESSMENT_ENTITY.TransformationProductOfTheRegisteredSubstance.AssessmentEntityConfidentialityClaim-->



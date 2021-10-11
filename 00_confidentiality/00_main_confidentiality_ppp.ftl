<?xml version="1.0" encoding="UTF-8"?>

<#-- Import common macros and functions -->
<#import "macros_common_general.ftl" as com>

<#assign locale = "en" />
<#assign sysDateTime = .now>

<#--Map all paths to confidentiality flags-->
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
"FLEXIBLE_RECORD.AnalyticalInformation":[{"path":"", "field":"AnalyticalInformation.DataProtection", "type":"val", "name":"Full document", "info":""}],
"REFERENCE_SUBSTANCE":[{"path":"", "field":"MolecularStructuralInfo.DataProtection", "type":"val", "name":"Molecular and structural information", "info":""},
                        {"path":"Synonyms.Synonyms", "field":"DataProtection", "type":"rep_block", "name":"Synonyms", "info":""}]
}/>

<#-- Initialize the following variables:
	* _dossierHeader (:DossierHashModel) //The header document of a proper or 'raw' dossier, can be empty
	* _subject (:DocumentHashModel) //The dossier subject document or, if not in a dossier context, the root document, never empty
	-->
<@com.initializeMainVariables/>
<#assign ownerLegalEntity = iuclid.getDocumentForKey(_subject.OwnerLegalEntity) />

<#if _dossierHeader?has_content>

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

                <#assign dossierUrl=iuclid.webUrl.entityView(_dossierHeader.documentKey)/>

                <@com.emptyLine/>
                <ulink url="${dossierUrl}">
                Dossier: <@com.text _dossierHeader.name />
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
            <@dossierHeaderInfo _dossierHeader/>
        </chapter>

        <chapter>
            <title role="HEAD-4">Confidentiality requests</title>

            <para role="small">
            <table border="1">
                <title>Confidentiality requests</title>
                <col width="3%" />
                <col width="10%" />
                <col width="15%" />
                <col width="17%" />
<#--                <col width="10%" />-->
                <col width="10%" />
                <col width="40%" />
                <col width="5%" />

                <tbody valign="middle">
                <tr  align="center">
                    <th><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">#</emphasis></th>
                    <th><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">Entity</emphasis></th>
                    <th><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">IUCLID section</emphasis></th>
                    <th><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">Document</emphasis></th>
<#--                    <th><?dbfo bgcolor="#33B7FF" ?><emphasis role="bold">Doc. UUID</emphasis></th>-->
                    <th><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">Doc. section</emphasis></th>
                    <th><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">Justification</emphasis></th>
                    <th><?dbfo bgcolor="#FFD17D" ?><emphasis role="bold">Accept Y/N</emphasis></th>
                </tr>

                <#--Get all components (for all products) and metabolites-->
                <#assign products=[_subject] + getOtherRepresentativeProducts(_subject)/>
                <#assign components=[]/>
                <#list products as prod>
                    <#assign components=components + com.getComponents(prod, "", true, true, true)/>
                </#list>
                <#assign metabolites=com.getMetabolites(_subject)/>

                <#--Remove duplicates and separate reference substances so that they are parsed at the end-->
                <#assign allEntities = products/>
                <#assign refSubs=[]/>

                <#list components+metabolites as sub>
                    <#if sub.documentType=="REFERENCE_SUBSTANCE">
                        <#assign refSubs=com.addDocumentToSequenceAsUnique(sub, refSubs)/>
                    <#else>
                        <#assign allEntities=com.addDocumentToSequenceAsUnique(sub, allEntities)/>
                    </#if>
                </#list>

                <#--Parse first substances/mixtures and then ref substances-->
                <#global nRow=0/>

                <#list allEntities as entity>
                    <#global entity=entity>
                    <#global toc=iuclid.localizeTreeFor(entity.documentType, entity.submissionType, entity.documentKey)/>
                    <#recurse toc/>
                </#list>

                <#list refSubs as ref>
                    <#global entity=ref/>
                    <@docConfInfo ref/>
<#--                    <@tableRowForConfidentialityFlag ref ref "DataProtection" "Full document"/>-->
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
            <@docConfInfo doc/>
        </#list>
    </#if>

    <#recurse/>
</#macro>

<#macro docConfInfo doc>
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
         <#local flagPath="DataProtection"/>
    </#if>

    <#if flagPath?has_content>
        <@tableRowForConfidentialityFlag doc doc flagPath "Full document"/>
    </#if>

    <#--if it's a specific doc type, then check in hashMap and add-->
    <#if doc.documentType=="SUBSTANCE" || doc.documentType=="MIXTURE" || doc.documentType=="REFERENCE_SUBSTANCE">
        <#local docTypeSubtype=doc.documentType/>
    <#else>
        <#local docTypeSubtype="${doc.documentType}.${doc.documentSubType}"/>
    </#if>

    <#if confFlagIdentifierList?keys?seq_contains(docTypeSubtype)>
        <#local flagIds=confFlagIdentifierList[docTypeSubtype]/>
        <#list flagIds as flagId>
            <#if flagId.type=="val">
                <@tableRowForConfidentialityFlag doc doc flagId.field flagId.name/>
            <#elseif flagId.type="rep_block">
                <#local blockPath = "doc." + flagId.path />
                <#list blockPath?eval as path>
                    <#local secName=flagId.name+"#${path_index+1}"/>
                    <@tableRowForConfidentialityFlag doc path flagId.field secName/>
                </#list>
            </#if>
        </#list>
    </#if>
</#macro>

<#macro dossierHeaderInfo dossier>

    <#--get context and paths-->
    <#if dossier.documentSubType=="EU_PPP_MAXIMUM_RESIDUE_LEVELS">
        <#local app=dossier.MRLApplication.DossierSpecificInformation/>
    <#elseif dossier.documentSubType=="EU_PPP_MICROORGANISMS_FOR_MIXTURES" || dossier.documentSubType=="EU_PPP_ACTIVE_SUBSTANCE_FOR_MIXTURES">
        <#local app=dossier.ActiveSubstanceApproval/>
    <#elseif dossier.documentSubType=="EU_PPP_BASIC_SUBSTANCE">
        <#local app=dossier.BasicSubstanceApproval/>
    <#elseif dossier.documentSubType=="EU_PPP_PESTICIDE_PRODUCT">
        <#local app=dossier.ApplicationForOrAmendmentToPlantProtectionProductAuthorisation/>
    <#--NOTE: not considered for the moment. Fields:-->
    <#--ApplicationForOrAmendmentToPlantProtectionProductAuthorisation.ApplicationIsMadeThroughARepresentativeOfTheApplicant (picklist)-->
    <#--ApplicationForOrAmendmentToPlantProtectionProductAuthorisation.AuthorisationPreviouslyGrantedForPlantProtectionProduct (picklist)-->
    <#--ApplicationForOrAmendmentToPlantProtectionProductAuthorisation.ConclusionSOfTheMemberStateAssessingEquivalence (picklist)-->
    </#if>

    <#if app??>
        <#-- Dossier details-->
        <para><emphasis role="bold">Application dossier details:</emphasis>
            <para role="indent"><itemizedlist>
                    <listitem>Dossier name: <@com.text dossier.name /></listitem>
                    <listitem>Dossier UUID: <@com.text dossier.subjectKey /></listitem>
                    <listitem>Dossier submission remarks: <@com.text dossier.remarks /></listitem>
                    <listitem>Dossier creation date and time: <@com.text dossier.creationDate /></listitem>
                    <listitem>Submission type: <@com.text dossier.submissionType /></listitem>
                    <listitem>Owner legal entity:
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
                <@com.picklistMultiple app.Purpose/>
            <#--for authorisations-->
            <#elseif app.hasElement("ReferenceNumber")>
                <@com.text app.ReferenceNumber/>
            </#if>
        </para>

        <#-- Joint application-->
        <#if app.hasElement("JointApplication")>
            <#assign joint><@com.picklist app.JointApplication/></#assign>
            <para><emphasis role="bold">Joint application:</emphasis>
                <#if joint?has_content>${joint}<#else>NA</#if>
            </para>
        </#if>

        <#-- RMs/EMs-->
        <#--for mixtures-->
        <#if app.hasElement("RapporteurMemberState")>
            <para><emphasis role="bold">Rapporteur Member State (RMS):</emphasis>
                <@com.picklist app.RapporteurMemberState/>
                <#if app.hasElement("CompetentAuthority") && app.CompetentAuthority?has_content>
                    <para role="indent">- Competent Authority: <@com.text app.CompetentAuthority/></para>
                </#if>
                <#if app.hasElement("CoRms") && app.CoRms?has_content>
                    <para role="indent">- Co-RMS: <@com.picklistMultiple app.CoRms/></para>
                </#if>

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
            <para><emphasis role="bold">Applicant:</emphasis> <@com.picklistMultiple app.Applicant/></para>
            <para><emphasis role="bold">Data requirements:</emphasis> <@com.picklist app.DataRequirements/></para>
        </#if>

        <#--MRL application linked (TO BE TESTED)-->
        <#if dossier.hasElement("OtherSubmissionRelatedInformation")>
            <#if dossier.OtherSubmissionRelatedInformation.hasElement("PartOfMRLAppl") && dossier.OtherSubmissionRelatedInformation.PartOfMRLAppl>
                <para><emphasis role="bold">MRL application dossier submitted:</emphasis>
                    yes
                    <#if dossier.OtherSubmissionRelatedInformation.SubmissionNumber?has_content>
                        - <@com.text dossier.OtherSubmissionRelatedInformation.SubmissionNumber/>
                    </#if>
                </para>
            <#elseif dossier.OtherSubmissionRelatedInformation.hasElement("PartOfActiveSubstanceAppl")&& dossier.OtherSubmissionRelatedInformation.PartOfActiveSubstanceAppl>
                <para><emphasis role="bold">MRL application dossier submitted:</emphasis>
                    yes
                    <#if dossier.OtherSubmissionRelatedInformation.SubmissionNumber?has_content>
                        - <@com.text dossier.OtherSubmissionRelatedInformation.SubmissionNumber/>
                    </#if>
                </para>
            </#if>
        </#if>
    </#if>

</#macro>

<#macro tableRowForConfidentialityFlag document section flagPath fieldName="Full document">
    <#compress>

        <#if isDataProtectionAvailable(section, flagPath)>

            <#local docUrl=iuclid.webUrl.documentView(document.documentKey)/>

            <#if entity.documentType=="MIXTURE">
                <#local entityName><@com.text entity.MixtureName/></#local>
            <#elseif entity.documentType=="SUBSTANCE">
                <#local entityName><@com.text entity.ChemicalName/></#local>
            <#elseif entity.documentType=="REFERENCE_SUBSTANCE">
                <#local entityName><@com.text entity.ReferenceSubstanceName/></#local>
            <#else>
                <#local entityName="">
            </#if>

            <#global nRow=nRow+1/>
            <tr>
<#--                <?dbfo bgcolor="#97DAFF"?>-->
                <td>${nRow}</td>
                <#-- Type of entity -->
                <td>
                    ${entity.documentType?replace("_", " ")} ${entityName}
                    <#--                Name?replace("_", " ")?capitalize}: -->
                    <#--                ${document.documentType?replace("_", " ")?capitalize}<#if document.documentSubType?has_content>: <@com.text document.documentSubType/></#if>-->
                </td>

                <#-- IUCLID section -->
                <td>
                    <#local docTypeSubtype>
                        <#compress>
                            ${document.documentType}<#if document.documentSubType?has_content>.${document.documentSubType}</#if>
                        </#compress>
                    </#local>

                    <#-- manually add the corresponding section for SUBSTANCE/MITURE entities: however this will not correspond always 100%-->
                    <#if docTypeSubtype?has_content>
                        <#if docTypeSubtype=="MIXTURE">
                            <#if document.submissionType?contains("MAXIMUM")>
                                1.1 Identity of the product
                            <#elseif document.submissionType?contains("BASIC")>
                                1 Identity and applicant
                            <#else>
                                1.1 Identity of the plant protection product, trade name or proposed trade name, and applicant
                            </#if>
                        <#elseif docTypeSubtype=="SUBSTANCE">
                            <#if document.submissionType?contains("MICRO")>
                                1.3 Name, species description, strain characterisation and applicant
                            <#elseif document.submissionType?contains("BASIC")>
                                2.0 Substance and applicant
                            <#else>
                                1.1 Identity of the (active) substance and applicant
                            </#if>
                        <#elseif docTypeSubtype=="REFERENCE_SUBSTANCE">

                        <#else>
                            <#local numberToC = toc.nodeFor[docTypeSubtype].number />
                            ${numberToC}

                            <#local titleToC = toc.nodeFor[docTypeSubtype].title />
                            ${titleToC}
                        </#if>
                    </#if>
                </td>

                <#-- Document Name -->
                <td>
                    <ulink url="${docUrl}"><@com.text document.name /></ulink>
                    <#--                &lt;#&ndash; reference if exists &ndash;&gt;-->
                    <#--                <#if document.hasElement("DataSource.Reference")>-->
                    <#--                    <#assign reference=getStudyReference(document)/>-->
                    <#--                    <#if reference?has_content>-->
                    <#--                        <para>(ref: <@com.text reference.GeneralInfo.Name/>, <@com.text reference.GeneralInfo.ReferenceYear/>)</para>-->
                    <#--                    </#if>-->
                    <#--                </#if>-->
                </td>

                <#-- UUID (note: it's too long and doesn't show properly)-->
                <#--            <td>-->
                <#--                &lt;#&ndash;<#assign uuid=document.documentKey.uuid?replace("-", "-<?linebreak?>")/>&ndash;&gt;-->
                <#--&lt;#&ndash;                <#assign uuid=document.documentKey.uuid/>&ndash;&gt;-->
                <#--                <#assign uuid><#compress>-->
                <#--                    <#list document.documentKey.uuid?matches('.{1,14}', 's') as chunk>-->
                <#--                        ${chunk}<#if chunk_has_next><?linebreak?></#if>-->
                <#--                    </#list>-->
                <#--                </#compress></#assign>-->
                <#--                <#assign docUrl=iuclid.webUrl.documentView(documentKey)/>-->
                <#--                <#if docUrl?has_content>-->
                <#--                    <ulink url="${docUrl}">${uuid}</ulink>-->
                <#--                <#else>-->
                <#--                    ${uuid}-->
                <#--                </#if>-->
                <#--            </td>-->

                <#-- Field Name -->
                <td>
                    ${fieldName}
                </td>

                <#-- Justification-->
                <td>
                    <#local justificationPath = "section." + flagPath + ".justification" />
                    <#local justification=justificationPath?eval />

                    <#if justification?has_content>
                        <@com.text justification/>
                        <#--If maximum char required:-->
<#--                        <@com.text justification[0..*300] />-->
                    <#else>
                        <emphasis role="bold">No justification provided</emphasis>
                    </#if>
                </td>

                <!-- Accept/Do Not Accept confidentiality claim -->
                <td><?dbfo bgcolor="#FFFFFF" ?></td>

            </tr>
        </#if>
    </#compress>
</#macro>


<#function isDataProtectionAvailable document flagPath>
    <#local dataProtection="document." + flagPath/>
    <#local dataProtection=dataProtection?eval/>

    <#--		<#assign confidentialityFlagPath = "document." + flagPath + ".confidentiality" />-->
    <#--		<#local confidentiality = confidentialityFlagPath?eval />-->

    <#--		<#assign justificationPath = "document." + flagPath + ".justification" />-->
    <#--		<#local justification = justificationPath?eval />-->

    <#--		<#assign regulatoryPath = "document." + flagPath + ".legislations" />-->
    <#--		<#local regulatory = regulatoryPath?eval />-->

		<#if dataProtection.confidentiality?has_content >
            <#--            || dataProtection.justification?has_content-->
		    <#return true />
		<#else>
            <#return false />
		</#if>
</#function>

<#--ASSESSMENT_ENTITY.RegisteredSubstanceAsSuch.AssessmentEntityConfidentialityClaim-->
<#--ASSESSMENT_ENTITY.SpecificCompositionOfTheRegisteredSubstance.AssessmentEntityConfidentialityClaim-->
<#--ASSESSMENT_ENTITY.GroupOfConstituentInTheRegisteredSubstance.AssessmentEntityConfidentialityClaim-->
<#--ASSESSMENT_ENTITY.TransformationProductOfTheRegisteredSubstance.AssessmentEntityConfidentialityClaim-->

<#function getOtherRepresentativeProducts mixture>

    <#local otherProdsSummaries=iuclid.getSectionDocumentsForParentKey(mixture.documentKey, "FLEXIBLE_SUMMARY", "OtherRepresentativeProducts") />
    <#local otherProds=[]/>

    <#list otherProdsSummaries as otherProdSummary>
        <#if otherProdSummary.OtherRepresentativeProductS?has_content>
            <#list otherProdSummary.OtherRepresentativeProductS as prodLink>
                <#local prod=iuclid.getDocumentForKey(prodLink)/>
                <#if prod?has_content>
                    <#local otherProds = com.addDocumentToSequenceAsUnique(prod, otherProds)/>
                </#if>
            </#list>
        </#if>
    </#list>
    <#return otherProds/>
</#function>

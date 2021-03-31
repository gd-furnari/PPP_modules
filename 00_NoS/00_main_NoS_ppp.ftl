<?xml version="1.0" encoding="UTF-8"?>

<#-- Import common macros and functions -->
<#import "macros_common_general.ftl" as com>
<#import "macros_common_studies_and_summaries.ftl" as studyandsummaryCom>
<#include "macros_NoS.ftl">

<!-- Example template file -->
<#assign locale = "en" />
<#assign sysDateTime = .now>

<#-- Initialize the following variables:
	* _dossierHeader (:DossierHashModel) //The header document of a proper or 'raw' dossier, can be empty
	* _subject (:DocumentHashModel) //The dossier subject document or, if not in a dossier context, the root document, never empty
	-->
<@com.initializeMainVariables/>

<#assign ownerLegalEntity = iuclid.getDocumentForKey(_subject.OwnerLegalEntity) />

<#--<#assign testMaterialInformations = [] />-->

<#if _dossierHeader?has_content>

    <#assign dossier = _dossierHeader />

    <#--get context and paths-->
    <#if dossier.documentSubType=="EU_PPP_MAXIMUM_RESIDUE_LEVELS">
        <#assign app=dossier.MRLApplication.DossierSpecificInformation/>
        <#assign nosinfo=dossier.NotificationOfStudies/>
    <#elseif dossier.documentSubType=="EU_PPP_MICROORGANISMS_FOR_MIXTURES" ||
                dossier.documentSubType=="EU_PPP_ACTIVE_SUBSTANCE_FOR_MIXTURES">
        <#assign app=dossier.ActiveSubstanceApproval/>
        <#assign nosinfo=dossier.NotificationOfStudies/>
    <#elseif dossier.documentSubType=="EU_PPP_BASIC_SUBSTANCE">
        <#assign app=dossier.BasicSubstanceApproval/>
        <#assign nosinfo=dossier.PreApplicationInformation/>
    <#elseif dossier.documentSubType=="EU_PPP_PESTICIDE_PRODUCT">
        <#assign app=dossier.ApplicationForOrAmendmentToPlantProtectionProductAuthorisation/>
        <#assign nosinfo=""/>
        <#--NOTE: not considered for the moment. Fields:-->
        <#--ApplicationForOrAmendmentToPlantProtectionProductAuthorisation.ApplicationIsMadeThroughARepresentativeOfTheApplicant (picklist)-->
        <#--ApplicationForOrAmendmentToPlantProtectionProductAuthorisation.AuthorisationPreviouslyGrantedForPlantProtectionProduct (picklist)-->
        <#--ApplicationForOrAmendmentToPlantProtectionProductAuthorisation.ConclusionSOfTheMemberStateAssessingEquivalence (picklist)-->
    </#if>

    <#--populate lists of studies-->
    <#assign NoSstudyList=[]/>
    <#assign missingNoSstudyList=[]/>
    <@endpointStudyRecords _subject/>

    <book version="5.0" xmlns="http://docbook.org/ns/docbook" xmlns:xi="http://www.w3.org/2001/XInclude">
        <#assign left_header_text = ''/>
        <#assign central_header_text = com.getReportSubject(rootDocument).name?html />
        <#assign right_header_text = ''/>

        <#assign left_footer_text = sysDateTime?string["dd/MM/yyyy"] + " - IUCLID 6 " + iuclid6Version!/>
        <#assign central_footer_text = 'NoS report' />
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
                    <para>Notification of Studies (NoS) Extraction Request</para>
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
            <title role="HEAD-4">General details of the application</title>

                <#-- Dossier details-->
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
                        <@com.picklist app.ApplicationPurpose/>
                        <#if app.ApplicationPurpouse?has_content>
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

                <#-- Subject-->
                <para><emphasis role="bold">Subject of the application:</emphasis>
                    <#if _subject.documentType=="MIXTURE">
                        <@com.emptyLine/>
                        <para role="indent"><emphasis role="underline">Product/Mixture:</emphasis> <@mixtureIdentity _subject/></para>

                        <#assign actSubs=getComponents(_subject, "active substance")/>
                        <#if actSubs?has_content>
                            <#assign actSub=actSubs[0]/>
                            <para role="indent"><emphasis role="underline">Active substance:</emphasis>
                                    <@substanceIdentity actSub/>
                            </para>
                        </#if>
                    <#elseif _subject.documentType=="SUBSTANCE">
                        <para role="indent"><@substanceIdentity actSub/></para>
                    </#if>
                </para>

                <#-- Preapp id-->
                <para><emphasis role="bold">Pre-application identification:</emphasis>
                     <#if nosinfo.PreApplicationId?has_content>
                        <#list nosinfo.PreApplicationId as paid>
                            <@com.text paid.PreApplicationId/>
                            <#if paid_has_next>; </#if>
                        </#list>
                     </#if>
                </para>

                <#-- NoS id justification-->
                <para>
                    <command linkend="justNoSlist"><emphasis role="bold">Studies requiring NoS justification:</emphasis></command> ${nosinfo.StudiesReqJustification?size}
                </para>

                <#-- NoS ids-->
                <para>
                    <command linkend="NoSlist"><emphasis role="bold">Studies with NoS identification:</emphasis></command> ${NoSstudyList?size}
                </para>

                <#-- missing NoS ids-->
                <para>
                    <command linkend="noNoSlist"><emphasis role="bold">Studies lacking NoS identification:</emphasis></command> ${missingNoSstudyList?size}
                </para>

        </chapter>

        <chapter xml:id="justNoSlist">
            <title>List of justified studies in the application</title>
            <#if nosinfo.StudiesReqJustification?has_content>
                <table border="1">
                    <col width="25%"/>
                    <col width="75%"/>

                    <tbody>
                        <tr>
                            <th><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">NoS ID</emphasis></th>
                            <th><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">Justification</emphasis></th>
                        </tr>

                        <#list nosinfo.StudiesReqJustification as nos>
                            <tr>
                                <td>
                                    <#if nos.hasElement("NosId")>
                                        <@com.text nos.NosId/>
                                    <#elseif  nos.hasElement("NoSID")>
                                        <@com.text nos.NoSID/>
                                    <#--basic-->
                                    <#elseif nos.hasElement("EFSAStudyIdentification")>
                                        <@com.text nos.EFSAStudyIdentification/>
                                    </#if>
                                </td>
                                <td><@com.text nos.Justification/></td>
                            </tr>
                        </#list>
                    </tbody>
                </table>
            </#if>
        </chapter>

        <chapter xml:id="NoSlist">
            <title>List of notified studies in the application</title>

            <para role="small">
                <@studyTable NoSstudyList/>
            </para>
        </chapter>

        <chapter xml:id="noNoSlist">
            <title>List of studies without notification in the application</title>

            <para role="small">
                <@studyTable missingNoSstudyList/>
            </para>
        </chapter>

    <#-- Annex for materials&ndash (not needed)-->
<#--        <chapter label="Annex">-->
<#--            <title role="HEAD-1">Information on Test Material</title>-->
<#--            <#include "Annex2_test_materials.ftl" encoding="UTF-8" />-->
<#--            <@printTestMaterials testMaterialInformations/>-->
<#--        </chapter>-->

    </book>
<#else>
    <book version="5.0" xmlns="http://docbook.org/ns/docbook" xmlns:xi="http://www.w3.org/2001/XInclude">
        <info>
            <title>NoS Extraction Request expects a dossier as root document. The root document is not a dossier!
                    Please, create a dossier from your mixture/substance dataset and try again.
            </title>
        </info>
        <part></part>
    </book>
</#if>

<#macro studyTable studyList title="">
    <#compress>

    <table border="1">
        <title>${title}</title>

        <col width="6%"/>
        <col width="15%"/>
        <col width="20%" />
        <col width="10%" />
        <col width="12%" />
        <col width="12%" />
        <col width="12%" />
        <col width="6%" />
        <col width="7%" />

        <tbody>
        <tr>
            <th><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">NoS ID</emphasis></th>
            <th><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">Remarks</emphasis></th>
            <th><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">Study name</emphasis></th>
            <#-- <th><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">Study uuid</emphasis></th>-->
            <th><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">Study period</emphasis></th>
            <#--  <th><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">Subject</emphasis></th>-->
            <#--  <th><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">Doc uuid</emphasis></th>-->
            <th><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">Endpoint</emphasis></th>
            <th><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">Testing facility</emphasis></th>
            <th><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">Guideline</emphasis></th>
            <th><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">GLP</emphasis></th>
            <th><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">Adequacy</emphasis></th>
            <#-- <th><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">Reliability</emphasis></th>-->

        </tr>

        <#list studyList as study>
            <#local reference=getStudyReference(study)/>

            <tr>
                <#-- NoS ID -->
                <td>
                    <#local NoSid=getNoSid(reference)/>
                    <#if NoSid?has_content>
                        ${NoSid}
                    <#else >
                        NA
                    </#if>
                </td>

                <#--Remarks: print all ids/remarks if empty-->
                <td>
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
                    <#if remarksList?has_content>${remarksList?join(" | ")}</#if>
                </td>

                <#-- Study name / reference (author, year, No) -->
                <#assign refUrl=getDocUrl(reference, _subject)/>
                <td><ulink url="${refUrl}"><@com.text reference.GeneralInfo.Name/></ulink><?linebreak?>
                    (<@com.text reference.GeneralInfo.Author/>, <@com.number reference.GeneralInfo.ReferenceYear/>, No: <@com.text reference.GeneralInfo.ReportNo/>)
                </td>

                <#-- Study uuid&ndash -->
                <#-- <td><@com.text reference.documentKey.uuid/></td>-->

                <#-- Period -->
                <td><@com.text study.AdministrativeData.StudyPeriod/></td>

                <#-- Test material -->
                <#-- <td>-->
                <#--    <#if study.hasElement("MaterialsAndMethods")><@testMatInfo study.MaterialsAndMethods.TestMaterials.TestMaterialInformation/></#if>-->
                <#-- </td>-->

                <#-- IUCLID endpoint study record uuid -->
                <#-- <td><@com.text study.documentKey.uuid/></td>-->

                <#-- Endpoint -->
                <#assign stUrl=getDocUrl(study, _subject)/>
                <td><ulink url="${refUrl}"><@com.picklist study.AdministrativeData.Endpoint/></ulink></td>

                <#-- Testing facility-->
                <td><@com.text reference.GeneralInfo.TestLab/></td>

                <#-- Guideline -->
                <td><#if study.hasElement("MaterialsAndMethods")>
                        <@studyandsummaryCom.guidelineList study.MaterialsAndMethods.Guideline/>
                    <#--                        <#if study.MaterialsAndMethods.MethodNoGuideline?has_content>-->
                    <#--                            <?linebreak?>other method: <@com.text study.MaterialsAndMethods.MethodNoGuideline/>-->
                    <#--                        </#if>-->
                    </#if>
                </td>

                <#-- GLP -->
                <td><#if study.hasElement("MaterialsAndMethods")>
                        <@com.picklist study.MaterialsAndMethods.GLPComplianceStatement/>
                        <#if study.hasElement("MaterialsAndMethods.OtherQualityAssurance") && study.MaterialsAndMethods.OtherQualityAssurance?has_content>
                            <?linebreak?>other quality assurance: <@com.picklist study.MaterialsAndMethods.OtherQualityAssurance/>
                        </#if>
                    </#if>
                </td>

                <#-- Adequacy -->
                <td><@com.picklist study.AdministrativeData.PurposeFlag/></td>

                <#-- Reliability (not needed)-->
                <#--            <td><@com.picklist study.AdministrativeData.Reliability/>-->
                <#--                <#if study.AdministrativeData.RationalReliability?has_content>-->
                <#--                    : <@com.picklist study.AdministrativeData.RationalReliability/>-->
                <#--                </#if>-->
                <#--            </td>-->
            </tr>

        </#list>

        </tbody>
    </table>

    </#compress>
</#macro>

<#macro mixtureIdentity mixture>
    <#compress>

        ${mixture.MixtureName}

        <#if mixture.PublicName?has_content>(<@com.text mixture.PublicName/>)</#if>
        <#if mixture.OtherNames?has_content>
            <para role="indent2">
                <itemizedlist>
                    <#list mixture.OtherNames as name>
                        <listitem><@com.picklist name.NameType/>: <@com.text name.Name/>
                            <#if name.Country?has_content>
                                in <@com.picklistMultiple name.Country/>
                            </#if>
                            <#if name.Remarks?has_content><@com.text name.Remaks/></#if>
                        </listitem>
                    </#list>
                </itemizedlist>
            </para>
        </#if>

    </#compress>
</#macro>

<#macro substanceIdentity substance>
    <#compress>

        ${substance.ChemicalName}

        <#if substance.PublicName?has_content>(<@com.text substance.PublicName/>)</#if>
        <#--        <#if substance.TypeOfSubstance.Composition?has_content || substance.TypeOfSubstance.Origin?has_content>-->
        <#--            <span role="indent">-->
        <#--                Type: <@com.picklist substance.TypeOfSubstance.Composition/> (<@com.picklist substance.TypeOfSubstance.Origin/>)-->
        <#--            </span>-->
        <#--        </#if>-->
        <para role="indent2">
            <itemizedlist>
                <#if substance.OtherNames?has_content>
                    <#list substance.OtherNames as name>
                        <listitem><@com.picklist name.NameType/>: <@com.text name.Name/>
                            <#if name.Country?has_content>
                                in <@com.picklistMultiple name.Country/>
                            </#if>
                            <#--                        <#if name.Remarks?has_content><@com.text name.Remaks/></#if>-->
                        </listitem>
                    </#list>
                </#if>

                <#assign referenceSubstance = iuclid.getDocumentForKey(substance.ReferenceSubstance.ReferenceSubstance) />
                <#if referenceSubstance?has_content>
                    <#--                Reference substance: <@com.text referenceSubstance.ReferenceSubstanceName/>-->
                    <#if referenceSubstance.Inventory?? && referenceSubstance.Inventory.InventoryEntry?has_content>
                        <listitem>EC number : <@com.inventoryECNumber com.getReferenceSubstanceKey(substance.ReferenceSubstance.ReferenceSubstance)/></listitem>
                    </#if>
                    <#if referenceSubstance.Inventory?? && referenceSubstance.Inventory.InventoryEntry?has_content>
                        <listitem>EC name: <@com.inventoryECName com.getReferenceSubstanceKey(substance.ReferenceSubstance.ReferenceSubstance) /></listitem>
                    </#if>
                    <#if referenceSubstance.Inventory?? && referenceSubstance.Inventory.InventoryEntry?has_content>
                        <listitem>CAS number (EC inventory): <@com.inventoryECCasNumber com.getReferenceSubstanceKey(substance.ReferenceSubstance.ReferenceSubstance) /></listitem>
                    </#if>
                    <#if referenceSubstance?? && referenceSubstance.Inventory.CASNumber?has_content>
                        <listitem>CAS number:<@com.casNumber com.getReferenceSubstanceKey(substance.ReferenceSubstance.ReferenceSubstance) /></listitem>
                    </#if>
                    <#if referenceSubstance?? && referenceSubstance.Inventory.CASName?has_content>
                        <listitem>CAS name: <@com.casName com.getReferenceSubstanceKey(substance.ReferenceSubstance.ReferenceSubstance)/></listitem>
                    </#if>
                    <#if referenceSubstance?? && referenceSubstance.IupacName?has_content>
                        <listitem>IUPAC name: <@com.iupacName com.getReferenceSubstanceKey(substance.ReferenceSubstance.ReferenceSubstance)/></listitem>
                    </#if>
                    <#--                <#if referenceSubstance?? && referenceSubstance.Description?has_content>-->
                    <#--                    <listitem>Description: <@com.description com.getReferenceSubstanceKey(_subject.ReferenceSubstance.ReferenceSubstance)/></listitem>-->
                    <#--                </#if>-->
                    <#if referenceSubstance?? && referenceSubstance.Synonyms.Synonyms?has_content>
                        <#assign synonyms=getSynonyms(referenceSubstance)?join(" | ")/>
                        <#if synonyms?has_content>
                            <listitem>Synonyms: ${synonyms}
                                <#--                    <@com.synonyms com.getReferenceSubstanceKey(substance.ReferenceSubstance.ReferenceSubstance)/>-->
                            </listitem>
                        </#if>
                    </#if>
                    <#--                <#if referenceSubstance.MolecularStructuralInfo?? && referenceSubstance.MolecularStructuralInfo.MolecularFormula?has_content>-->
                    <#--                   <listitem>Molecular formula: <@com.molecularFormula com.getReferenceSubstanceKey(substance.ReferenceSubstance.ReferenceSubstance)/></listitem>-->
                    <#--                </#if>-->
                    <#--                <#if referenceSubstance.MolecularStructuralInfo?? && referenceSubstance.MolecularStructuralInfo.MolecularWeightRange?has_content>-->
                    <#--                    <listitem>Molecular weight range: <@com.molecularWeight com.getReferenceSubstanceKey(substance.ReferenceSubstance.ReferenceSubstance)/></listitem>-->
                    <#--                </#if>-->
                </#if>
            </itemizedlist>
        </para>
    </#compress>
</#macro>

<#function getDocUrl study _subject>
    <#local docUrl=iuclid.webUrl.documentView(study.documentKey) />

    <#local datasetId = _subject.documentKey?replace("\\/.*$", "", "r")/>
	<#local datasetEntity = _subject.documentType/>
	<#local docUrl = docUrl?replace("\\?goto", "\\/raw\\/${datasetEntity}\\/${datasetId}\\?content_uri", "r")/>

    <#local docUrl = docUrl?replace("\\%3A", "\\:", "r")/>

    <#return docUrl>
</#function>

<#--Unused macros for test materials-->
<#--<#macro testMatInfo documentKey>-->
<#--    <#compress>-->
<#--        <#if documentKey?has_content>-->
<#--            <#local testMaterial = iuclid.getDocumentForKey(documentKey) />-->
<#--            <#if testMaterial?has_content>-->
<#--                <#assign testMaterialInformations = com.addDocumentToSequenceAsUnique(testMaterial, testMaterialInformations) />-->
<#--            </#if>-->
<#--            <command linkend="${testMaterial.documentKey.uuid!}"><@com.text testMaterial.Name/></command>-->
<#--        </#if>-->
<#--    </#compress>-->
<#--</#macro>-->

<#--<#macro printTestMaterials testMaterialsInformations >-->
<#--    <#list testMaterialInformations as testMaterial>-->
<#--        <para xml:id="${testMaterial.documentKey.uuid!}">-->
<#--            Test material: <emphasis role="bold"><@com.text testMaterial.Name/></emphasis>-->
<#--            <?linebreak?>-->
<#--            Form: <emphasis role="bold"><@com.picklist testMaterial.Composition.OtherCharacteristics.TestMaterialForm/></emphasis>-->
<#--        </para>-->

<#--        <#if testMaterial.Composition.CompositionList?has_content>-->
<#--            <informaltable border="1">-->
<#--                <col width="25%" />-->
<#--                <col width="35%" />-->
<#--                <col width="40%" />-->
<#--                <tbody>-->
<#--                <#list testMaterial.Composition.CompositionList as blockItem>-->
<#--                    <tr>-->
<#--                        <td>-->
<#--                            <emphasis role="bold">Composition type:</emphasis> <@com.picklist blockItem.Type/>-->
<#--                        </td>-->
<#--                        <td>-->
<#--                            <emphasis role="bold">Reference substance:</emphasis>-->
<#--                            <#assign refSubst = iuclid.getDocumentForKey(blockItem.ReferenceSubstance) />-->
<#--                            <#if refSubst?has_content>-->
<#--                                <@com.text refSubst.ReferenceSubstanceName/>-->
<#--                                <?linebreak?>-->
<#--                                EC no.: <@com.inventoryECNumber refSubst.Inventory.InventoryEntry/>-->
<#--                                <?linebreak?>-->
<#--                                CAS no: <@com.text refSubst.Inventory.CASNumber/>-->
<#--                                <?linebreak?>-->
<#--                                IUPAC name: <@com.text refSubst.IupacName/>-->
<#--                            </#if>-->
<#--                        </td>-->
<#--                        <td>-->
<#--                            <emphasis role="bold">Concentration range:</emphasis> <@com.range blockItem.Concentration/>-->
<#--                            <para>-->
<#--                                <#if blockItem.Remarks?has_content>-->
<#--                                    Additional information:-->
<#--                                    <@com.text blockItem.Remarks/>-->
<#--                                </#if>-->
<#--                            </para>-->
<#--                        </td>-->
<#--                    </tr>-->
<#--                </#list>-->
<#--                </tbody>-->
<#--            </informaltable>-->
<#--        </#if>-->

<#--        <#if testMaterial.Composition.CompositionPurityOtherInformation?has_content>-->
<#--            <para>-->
<#--                Composition / purity: <@com.picklist testMaterial.Composition.CompositionPurityOtherInformation/>-->
<#--            </para>-->
<#--        </#if>-->

<#--        <#if testMaterial.Composition.OtherCharacteristics.DetailsOnTestMaterial?has_content>-->
<#--            <para>-->
<#--                Details on test material:-->
<#--                <@com.text testMaterial.Composition.OtherCharacteristics.DetailsOnTestMaterial/>-->
<#--                <?linebreak?>-->
<#--            </para>-->
<#--        </#if>-->

<#--        <@com.emptyLine/>-->
<#--    </#list>-->
<#--</#macro>-->
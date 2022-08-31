<#--Main ftl for the NoS report.
    This version uses the "traversal" approach.
-->
<?xml version="1.0" encoding="UTF-8"?>

<#-- Import common macros and functions -->
<#import "macros_common_general.ftl" as com>
<#import "macros_common_studies_and_summaries.ftl" as studyandsummaryCom>
<#import "traversal_utils.ftl" as utils>
<#--An alternative to making global variables is to include traversal.ftl
    <#include "traversal_utils.ftl"/>
-->
<#import "macros_NoS.ftl" as nos>
<#import "front_page_list_reports.ftl" as fp>

<#-- Initialize common variables -->
<@com.initializeMainVariables/>
<#assign locale = "en" />
<#assign sysDateTime = .now>

<#-- Root entity -->
<#assign rootEntity = entity.root>

<#-- Define the main macro and the arguments to be used to get output using the traversal approach -->
<#assign mainMacroName = "getLitRefWithNoSFromDoc"/>
<#assign mainMacroArgs = ['sectionDoc', 'docElementNode', 'sectionNode', 'level']/>

<#-- Make global all the macros used in the mainMacroCall -->
<#global getLitRefWithNoSFromDoc = getLitRefWithNoSFromDoc/>
<#global checkAndAddNoS = checkAndAddNoS/>

<#-- Create the main macro call -->
<#global mainMacroCall="<@" + mainMacroName + " " + mainMacroArgs?join(" ") + "/>"/>

<#-- Initialize hashes to store NoS id information (input to table) -->
<#assign NoSstudyHash={}/>
<#assign missingNoSstudyHash={}/>

<#-- Create report only for dossiers -->
<#if _dossierHeader?has_content>

    <#-- Get path for nos information in dossier header depeding on context -->
    <#assign nosinfo = nos.getNosInfo(_dossierHeader)/>

    <#-- Do the traverse -->
    <@utils.traversal rootEntity 8/>

    <#-- Docbook output -->
    <book version="5.0" xmlns="http://docbook.org/ns/docbook" xmlns:xi="http://www.w3.org/2001/XInclude">

        <#-- Get front page -->
        <@fp.getFrontPage _subject _dossierHeader "Notification of Studies (NoS) Extraction Request" "" "NoS report"/>

        <#-- Chapters -->

        <chapter>
            <title role="HEAD-4">General details of the application</title>
            <@dossierHeaderInfo _dossierHeader/>
        </chapter>

        <chapter xml:id="justNoSlist">

            <title>List of justified studies in the application</title>

            <para>
				The following table lists Notification of Studies (NoS) IDs that have been notified in the database but are not included in this dossier.
				<?linebreak?>A justification for non inclusion is provided next to each NoS ID.
				<?linebreak?>This information is retrieved from the <emphasis role='bold'>dossier header</emphasis>.
			</para>

            <@justifiedStudiesTable nosinfo/>
        </chapter>

        <chapter xml:id="NoSlist">

            <title>List of notified studies in the application</title>

        	<para>
				The following table lists all studies for which a NoS ID has been provided in the corresponding <emphasis role='bold'>literature reference</emphasis>
				(under <emphasis>Other study identifier(s)</emphasis> of <emphasis>Study ID Type</emphasis> = "Notification of Studies (NoS) ID").
			</para>

            <para role="small">
                <@studyTable NoSstudyHash "" "notified"/>
            </para>
        </chapter>

        <chapter xml:id="noNoSlist">
            <title>List of studies without notification in the application</title>

			<para>
				The following table lists all <emphasis role='bold'>study reports</emphasis> performed <emphasis role='bold'>in or later than 2021</emphasis> for
				which a NoS ID <emphasis role='underline'>has not</emphasis> been provided in the corresponding <emphasis role='bold'>literature reference</emphasis>
				(under <emphasis>Other study identifier(s)</emphasis> of <emphasis>Study ID Type</emphasis> = "Notification of Studies (NoS) ID").
				<?linebreak?>The remarks of each study should provide a justification for the lack of notification.
			</para>

            <para role="small">
                <@studyTable missingNoSstudyHash "" "not notified"/>
            </para>
        </chapter>

    </book>

</#if>

<#----------------------------------------------->
<#-- Macro and function definitions            -->
<#----------------------------------------------->

<#-- getLitRefWithNoSFromDoc retrieves all the literature references for a document and classifies into two different predefined
    hashes depending whether they have NoS ids or not.

     General description: If level is 0 (meaning: the doc node corresponds to the root of the entire doc),
     then it recursively iterates through the different elements in the document to find linked LITERATURE reference
     entities. For each LITERATURE found, the macro checkAndAddNoS is called.

     Inputs:
     - doc: DOCUMENT being traversed
     - docElementNode: NODE (element) of the document being traversed (initialy root = the document itself, then all the children)
     - sectionNode: NODE of the table of contents where the document being traversed is found
     - level: NUMBER (index) indicating the document element level being traversed (initially 0 = root)
-->
<#macro getLitRefWithNoSFromDoc doc docElementNode sectionNode level>

    <#if level==0>
        <#if docElementNode?node_type == "document_reference">
            <@checkAndAddNoS docElementNode doc sectionNode/>
        </#if>

        <#if docElementNode?node_type == "document_references">
            <#list docElementNode as item>
                    <@checkAndAddNoS item  doc sectionNode/>
            </#list>
        </#if>

        <#if docElementNode?children?has_content>
            <#list docElementNode?children as child>
                    <@getLitRefWithNoSFromDoc doc  child sectionNode level/>
            </#list>
        </#if>
    </#if>
</#macro>

<#-- checkAndAddNoS looks for NoS Ids in a LITERATURE reference entity and fills in one of two predefined hashes
    depending on the outcome of the search. It makes use of additional macros which identify NoS IDs based on some
    conditions and add studies to a hash. In general:
    - if a NoS id is found, the LITERATURE reference, the DOCUMENT where it is linked and the SECTION of the ToC where
    the document is present are appended to the hash NoSstudyHash
    - if a NoS id is NOT found, then those elements are added to the hash missingNoSstudyHash

     Inputs:
     - refKey: key for a LITERATURE entity
     - doc: DOCUMENT where the LITERATURE entity is linked to
     - sectionNode: NODE of the table of contents where the document is found
-->
<#macro checkAndAddNoS refKey doc sectionNode>
    <#if refKey?has_content && doc?has_content>
        <#local ref = iuclid.getDocumentForKey(refKey) />
        <#if ref?has_content && ref.documentType == "LITERATURE">

            <#-- get section -->
            <#local sect = "" />
            <#if sectionNode?has_content>
                <#if sectionNode.number?has_content>
                    <#local sect = sectionNode.number + " ">
                </#if>
                <#local sect = sect + sectionNode.title>
            </#if>

            <#-- look for NoS IDs -->
            <#local NoSid=nos.getNoSid(ref)/>

            <#-- if NoS ID exists, append to list  -->
            <#if NoSid?has_content>
                <#assign NoSstudyHash=nos.addNosStudyAsUnique(ref, doc, sect, NoSstudyHash)/>
            <#-- if it does not exist, then append the study to the list without NoS ID if:
            - type is study report
            - year >= 2021 (or empty)
            -->
            <#else>
                <#local refType><@com.picklist ref.GeneralInfo.LiteratureType/></#local>
                <#local refYear=nos.getRefYear(ref)/>

                    <#if refType=="study report" && ((!refYear?has_content) || refYear>=2021)>
                        <#assign missingNoSstudyHash=nos.addNosStudyAsUnique(ref, doc, sect, missingNoSstudyHash)/>
                    </#if>
            </#if>
        </#if>
    </#if>
</#macro>


<#----------------------------------------------->
<#-- TABLES AND INFORMATION SUMMARIES -->
<#----------------------------------------------->

<#-- studyTable prints a table containing a list of studies, either notified or lacking notification, and
     some details about them.

     Inputs:
        - studyHash: hash obtained using function addNosStudyAsUnique
        - title: table title
        - type: "notified" for list of NoS studies, and
                "not notified" for table of studies lacking NoS notification
-->
<#macro studyTable studyHash title="" type="notified">
    <#compress>

        <table border="1">
            <title>${title}</title>

            <col width="3%"/>
            <col width="15%"/>
            <col width="18%" />
            <col width="10%" />
            <col width="8%" />
            <col width="15%" />
            <col width="15%" />
            <col width="8%" />
            <col width="8%" />

            <tbody>
            <tr>
                <th><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">#</emphasis></th>
                <th><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">NoS ID / remarks</emphasis></th>
                <th><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">Study name</emphasis></th>
                <th><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">Testing facility</emphasis></th>
                <th><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">Study period</emphasis></th>
                <th><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">Section and endpoint</emphasis></th>
                <th><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">Guideline</emphasis></th>
                <th><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">GLP</emphasis></th>
                <th><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">Adequacy</emphasis></th>
            </tr>

            <#list studyHash as key,value>

                <#local reference=value['reference']/>
                <#local studies=value['doc']/>
                <#local sections=value['section']/>

                <#local usespan = true />

                <#list studies as study>
                    <tr>
                        <#if usespan>

                            <td rowspan="${studies?size}">
                                ${key_index+1}
                            </td>

                            <#-- NoS ID and remarks-->
                            <td rowspan="${studies?size}">

                                <#local NosRemarks=nos.getNoSidRemarks(reference)/>
                                <#if type=="notified">
                                    <#local NoSid=nos.getNoSid(reference, true)/>
                                    ${NoSid}<#if NosRemarks?has_content><?linebreak?>(${NosRemarks})</#if>
                                <#elseif type=="not notified">
                                    <#local NoSid=nos.getNoSid(reference, false)/>
                                    <#if NoSid?has_content>${NoSid}: </#if>${NosRemarks}
                                </#if>

                            </td>

                            <#-- Study name / reference (author, year, No) -->
                            <#local refUrl=iuclid.webUrl.documentView(reference.documentKey)/>
                            <td rowspan="${studies?size}"><ulink url="${refUrl}"><@com.text reference.GeneralInfo.Name/></ulink><?linebreak?>
                                (<@com.text reference.GeneralInfo.Author/>, <@com.number reference.GeneralInfo.ReferenceYear/>, No: <@com.text reference.GeneralInfo.ReportNo/>)
                            </td>

                            <#-- Study uuid&ndash -->
                            <#-- <td><@com.text reference.documentKey.uuid/></td>-->

                            <#-- Testing facility-->
                            <td rowspan="${studies?size}"><@com.text reference.GeneralInfo.TestLab/></td>

                            <#local usespan = false />
                        </#if>

                        <#-- Period -->
                        <td>
                            <#if study.hasElement("AdministrativeData.StudyPeriod")><@com.text study.AdministrativeData.StudyPeriod/></#if>
                        </td>

                        <#-- IUCLID endpoint study record name -->
<#--                         <td><@com.text study.documentKey.name/></td>-->

                        <#-- Section and endpoint-->
                        <#local section = sections[study?index]/>

                        <#local stUrl=iuclid.webUrl.documentView(study.documentKey)/>
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
                                        biological properties of the microorganism
<#--                                    <#else>-->
<#--                                        ------>
                                    </#if>
                                </#if>
                            </#compress>
                        </#local>
<#--                        <#if !endpoint?has_content><#local endpoint="NA"/></#if>-->
                        <td>
                            <ulink url="${stUrl}">
                                <@com.text section/><#if endpoint?has_content>:<?linebreak?>${endpoint}</#if>
                            </ulink>
                        </td>

                        <#-- Guideline -->
                        <td>
                            <#if study.hasElement("MaterialsAndMethods.Guideline")>
                                <@studyandsummaryCom.guidelineList study.MaterialsAndMethods.Guideline/>
                            <#elseif study.hasElement("MaterialsAndMethods.MethodUsed")>
                                <#if study.hasElement("MaterialsAndMethods.MethodUsed.Qualifier")>
                                    <@com.picklist study.MaterialsAndMethods.MethodUsed.Qualifier/>
                                </#if>
                                <#if study.hasElement("MaterialsAndMethods.MethodUsed.MethodUsed")>
                                    method <@com.picklist study.MaterialsAndMethods.MethodUsed.MethodUsed/>
                                </#if>
                            <#else>
                                ----
                            </#if>
                        </td>

                        <#-- GLP -->
                        <td>
                            <#if study.hasElement("MaterialsAndMethods")>
                                <#if study.hasElement("MaterialsAndMethods.GLPComplianceStatement")>
                                    <@com.picklist study.MaterialsAndMethods.GLPComplianceStatement/>
                                <#elseif study.hasElement("MaterialsAndMethods.MethodUsed.GLPCompliance")>
                                    <@com.picklist study.MaterialsAndMethods.MethodUsed.GLPCompliance/>
                                </#if>

                                <#if study.hasElement("MaterialsAndMethods.OtherQualityAssurance") && study.MaterialsAndMethods.OtherQualityAssurance?has_content>
                                    <?linebreak?>other quality assurance: <@com.picklist study.MaterialsAndMethods.OtherQualityAssurance/>
                                <#elseif study.hasElement("MaterialsAndMethods.MethodUsed.OtherQualityFollowed") && study.MaterialsAndMethods.MethodUsed.OtherQualityFollowed?has_content>
                                    <?linebreak?>other quality assurance: <@com.picklist study.MaterialsAndMethods.MethodUsed.OtherQualityFollowed/>
                                </#if>
                            <#else>
                                ----
                            </#if>
                        </td>

                        <#-- Adequacy -->
                        <td>
                            <#if study.hasElement("AdministrativeData.PurposeFlag")><@com.picklist study.AdministrativeData.PurposeFlag/><#else>----</#if>
                        </td>

                        <#-- Reliability (not needed)-->
                        <#--            <td><@com.picklist study.AdministrativeData.Reliability/>-->
                        <#--                <#if study.AdministrativeData.RationalReliability?has_content>-->
                        <#--                    : <@com.picklist study.AdministrativeData.RationalReliability/>-->
                        <#--                </#if>-->
                        <#--            </td>-->
                    </tr>
                </#list>
            </#list>

            </tbody>
        </table>

    </#compress>
</#macro>


<#-- dossierHeaderInfo prints information related to the dossier application, extracted from the dossier header,
    as well as details on the subject (mixture, substance) and numbers of justified, notified and not notified
    studies.

    Inputs:
    - dossier: _dossierHeader variable, obtained by the default initializeMainVariables macro.
-->
<#macro dossierHeaderInfo dossier>
    <#compress>

        <#--get context and paths-->
        <#if dossier.documentSubType=="EU_PPP_MAXIMUM_RESIDUE_LEVELS">
            <#local app=dossier.MRLApplication.DossierSpecificInformation/>
            <#local nosinfo=dossier.NotificationOfStudies/>
        <#elseif dossier.documentSubType=="EU_PPP_MICROORGANISMS_FOR_MIXTURES" ||
        dossier.documentSubType=="EU_PPP_ACTIVE_SUBSTANCE_FOR_MIXTURES">
            <#local app=dossier.ActiveSubstanceApproval/>
            <#local nosinfo=dossier.NotificationOfStudies/>
        <#elseif dossier.documentSubType=="EU_PPP_BASIC_SUBSTANCE">
            <#local app=dossier.BasicSubstanceApproval/>
            <#local nosinfo=dossier.PreApplicationInformation/>
        <#elseif dossier.documentSubType=="EU_PPP_PESTICIDE_PRODUCT">
            <#local app=dossier.ApplicationForOrAmendmentToPlantProtectionProductAuthorisation/>
            <#local nosinfo=""/>
        <#--NOTE: nosinfo would raise error if run with this context (not possible at moment)-->
        <#--NOTE: not considered for the moment. Fields:-->
        <#--ApplicationForOrAmendmentToPlantProtectionProductAuthorisation.ApplicationIsMadeThroughARepresentativeOfTheApplicant (picklist)-->
        <#--ApplicationForOrAmendmentToPlantProtectionProductAuthorisation.AuthorisationPreviouslyGrantedForPlantProtectionProduct (picklist)-->
        <#--ApplicationForOrAmendmentToPlantProtectionProductAuthorisation.ConclusionSOfTheMemberStateAssessingEquivalence (picklist)-->
        </#if>

        <#if app?? && nosinfo??>

            <#-- Dossier details-->
            <para><emphasis role="bold">Application dossier details:</emphasis>
                <para role="indent">
                    <itemizedlist>
                        <listitem>Dossier name: <@com.text dossier.name /></listitem>
                        <listitem>Dossier UUID: ${com.sanitizeUUID(dossier.subjectKey)}</listitem>
                        <listitem>Dossier submission remarks: <@com.text dossier.remarks /></listitem>
                        <listitem>Dossier creation date and time: <@com.text dossier.creationDate /></listitem>
                        <listitem>Submission type: <@com.text dossier.submissionType /></listitem>
                        <listitem>Submitting legal entity:
                            <#local submittingLegalEntity = iuclid.getDocumentForKey(dossier.submittingLegalEntityKey) />
                            <#if submittingLegalEntity?has_content>
                                <@com.text submittingLegalEntity.GeneralInfo.LegalEntityName/>
                            </#if>
                        </listitem>
                        <#if ownerLegalEntity?has_content>
                            <listitem>Owner legal entity: <@com.text ownerLegalEntity.GeneralInfo.LegalEntityName/></listitem>
                        </#if>
                        <#if thirdParty?has_content>
                            <listitem>Third party: <@com.text thirdParty.GeneralInfo.LegalEntityName/></listitem>
                        </#if>
                    </itemizedlist>
                </para>
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
            <#local printJA=true/>
            <#if app.hasElement("JointApplication")>
                <#local joint><@com.picklist app.JointApplication/></#local>
                <para><emphasis role="bold">Joint application:</emphasis>
                    <#if joint?has_content>${joint}
                        <#if joint?matches("^yes.*") && app.hasElement("EuJsNumber") && app.EuJsNumber?has_content>
                            <para role="indent">European joint submission number: <@com.text app.EuJsNumber/></para>
                            <#local printJA=false/>
                        </#if>
                    <#else>
                        NA
                    </#if>
                </para>
            </#if>
            <#if app.hasElement("EuJsNumber") && printJA && app.EuJsNumber?has_content>
                <para><emphasis role="bold">European joint submission number: </emphasis><@com.text app.EuJsNumber/></para>
            </#if>

            <#-- Lead applicant-->
            <#if app.hasElement("LeadApplicant")>
                <para><emphasis role="bold">Lead applicant: </emphasis><@com.picklist app.LeadApplicant/></para>
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
                <para><emphasis role="bold">Applicant:</emphasis><@com.picklistMultiple app.Applicant/></para>
                <para><emphasis role="bold">Data requirements:</emphasis><@com.picklist app.DataRequirements/></para>
            </#if>

            <#--Other application linked (TO BE TESTED)-->
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

            <#-- Subject-->
            <para><emphasis role="bold">Subject of the application:</emphasis>
                <#if _subject.documentType=="MIXTURE">
                    <#assign otherProd = com.getOtherRepresentativeProducts(_subject)/>
                    <#assign products = [_subject] + otherProd />

                    <#list products as prod>
                        <@com.emptyLine/>
                        <para role="indent"><emphasis role="underline">Representative Product<#if (products?size>1)> #${prod?index + 1}</#if>:</emphasis>  <@mixtureIdentity prod/></para>
                    </#list>
                    <@com.emptyLine/>
                    <#local actSubs=com.getComponents(_subject, "active substance", false)/>
                    <#if actSubs?has_content>
                        <#local actSub=actSubs[0]/>
                        <para role="indent"><emphasis role="underline">Active substance:</emphasis>
                            <@substanceIdentity actSub/>
                        </para>
                        <@com.emptyLine/>
                    </#if>

                <#elseif _subject.documentType=="SUBSTANCE">
                    <para role="indent"><@substanceIdentity actSub/></para>
                </#if>
            </para>

            <#-- Preapp id-->
            <para><emphasis role="bold">Pre-application identification:</emphasis>
                <#if nosinfo?has_content && nosinfo.PreApplicationId?has_content>
                    <#list nosinfo.PreApplicationId as paid>
                        <@com.text paid.PreApplicationId/>
                        <#if paid_has_next>; </#if>
                    </#list>
                <#else>
                    NA
                </#if>
            </para>

            <#-- NoS id justification-->
            <para>
                <command linkend="justNoSlist"><emphasis role="bold">Studies requiring NoS justification:</emphasis></command>
                <#if nosinfo?has_content>
                    ${nosinfo.StudiesReqJustification?size}
                <#else>
                    0
                </#if>
            </para>

            <#-- NoS ids-->
            <para>
                <command linkend="NoSlist"><emphasis role="bold">Studies with NoS identification:</emphasis></command> ${NoSstudyHash?keys?size}
            </para>

            <#-- missing NoS ids-->
            <para>
                <command linkend="noNoSlist"><emphasis role="bold">Studies lacking NoS identification:</emphasis></command> ${missingNoSstudyHash?keys?size}
            </para>

        </#if>

    </#compress>
</#macro>

<#--justifiedStudiesTable prints information relating to justified studies as present in the dossier header

    Inputs:
        - nosinfo: path to section containing NoS information in the dossier header e.g. dossier.NotificationOfStudies
            The path depends on the context.
-->
<#macro justifiedStudiesTable nosinfo>

    <#compress>

        <table border="1">
            <col width="3%"/>
            <col width="15%"/>
            <col width="82%"/>

            <tbody>
            <tr>
                <th><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">#</emphasis></th>
                <th><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">NoS ID</emphasis></th>
                <th><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">Justification</emphasis></th>
            </tr>

            <#if nosinfo?has_content && nosinfo.StudiesReqJustification?has_content>
                <#list nosinfo.StudiesReqJustification as nos>
                    <tr>
                        <td>${nos_index + 1}</td>
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
            </#if>
            </tbody>
        </table>
    </#compress>
</#macro>

<#-- mixtureIdentity prints general information about a mixture.
    Inputs:
    - mixture: MIXTURE entity
-->
<#macro mixtureIdentity mixture>
    <#compress>

        <@com.text mixture.MixtureName/>

        <#if mixture.PublicName?has_content>(<@com.text mixture.PublicName/>)</#if>
        <#if mixture.OtherNames?has_content>
            <para role="indent2">
                <itemizedlist>
                    <#list mixture.OtherNames as name>
                        <listitem><@com.picklist name.NameType/>: <@com.text name.Name/>
                            <#if name.Country?has_content>
                                in <@com.picklistMultiple name.Country/>
                            </#if>
                            <#if name.Remarks?has_content><@com.text name.Remarks/></#if>
                        </listitem>
                    </#list>
                </itemizedlist>
            </para>
        </#if>

        <#-- Compositions-->
        <#local compositions = iuclid.getSectionDocumentsForParentKey(mixture.documentKey, "FLEXIBLE_RECORD", "MixtureComposition")/>
        <#if compositions?has_content>
            <#list compositions as composition>
                <para role="indent2">
                    <emphasis role="underline">Composition<#if (compositions?size>1)> #${composition_index+1}</#if></emphasis>:
                    <@com.text composition.GeneralInformation.Name/>

                    <#if composition.GeneralInformation.TradeNames?has_content>
                        <para role="indent3">
                            - trade name(s):
                            <#list composition.GeneralInformation.TradeNames as tradeName>
                                <@com.text tradeName.TradeName/>
                                <#if tradeName.Country?has_content>
                                    (<@com.picklistMultiple tradeName.Country/>)
                                </#if>
                                <#if tradeName_has_next>|</#if>
                            </#list>
                        </para>
                    </#if>
                </para>
            </#list>
        </#if>

    </#compress>
</#macro>

<#--substanceIdentity prints general information about a substance.

    Inputs:
    - substance: SUBSTANCE entity
-->
<#macro substanceIdentity substance>
    <#compress>

        <@com.text substance.ChemicalName/>

        <#if substance.PublicName?has_content>(<@com.text substance.PublicName/>)</#if>
    <#--        <#if substance.TypeOfSubstance.Composition?has_content || substance.TypeOfSubstance.Origin?has_content>-->
    <#--            <span role="indent">-->
    <#--                Type: <@com.picklist substance.TypeOfSubstance.Composition/> (<@com.picklist substance.TypeOfSubstance.Origin/>)-->
    <#--            </span>-->
    <#--        </#if>-->
        <#local referenceSubstance = iuclid.getDocumentForKey(substance.ReferenceSubstance.ReferenceSubstance) />

        <#if substance.OtherNames?has_content || referenceSubstance?has_content>
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

                    <#if referenceSubstance?has_content>
                        <listitem>Ref. substance: <@com.text referenceSubstance.ReferenceSubstanceName/></listitem>
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
                            <#local synonyms=nos.getSynonyms(referenceSubstance)?join(" | ")/>
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
        </#if>
    </#compress>
</#macro>


<!-- Macros and functions for EU PPP reports, including appendix E format (subset for tox only)-->

<!-- Appendix E structure -->
<#macro appendixEstudies _subject docSubTypes context="" name="">
    <#compress>

    <#--Get all documents, from same or different type-->
        <#if !docSubTypes?is_sequence>
            <#local docSubTypes=[docSubTypes]/>
        </#if>

        <#local allStudyList=[]/>
        <#list docSubTypes as docSubType>
            <#local studyList = iuclid.getSectionDocumentsForParentKey(_subject.documentKey, "ENDPOINT_STUDY_RECORD", docSubType) />
            <#local allStudyList = allStudyList + studyList/>
        </#list>

        <#-- Filter all documents (including data waiving)n by context-->
        <@filterStudyListbyContext allStudyList context/>

        <#-- Populate resultStudyList, dataWaivingStudyList, testingProposalStudyList -->
        <@populateResultAndDataWaivingAndTestingProposalStudyLists filtStudyList/>

        <#-- Data waiving-->
        <#if dataWaivingStudyList?has_content>
            <para><@com.emptyLine/><emphasis role="HEAD-WoutNo">Data waiving</emphasis></para>
            <@studyandsummaryCom.dataWaiving dataWaivingStudyList name false/>
            <@com.emptyLine/>
        </#if>

        <#-- Testing proposal
			NOTE: Removed for the moment-->
        <#--		<#if testingProposalStudyList?has_content>-->
        <#--			<para><@com.emptyLine/><emphasis role="HEAD-WoutNo">Testing proposal</emphasis></para>-->
        <#--			<@studyandsummaryCom.testingProposal testingProposalStudyList name false/>-->
        <#--			<@com.emptyLine/>-->
        <#--		</#if>-->

        <#-- Study results-->
        <#if !dataWaivingStudyList?has_content || resultStudyList?has_content >
            <para><@com.emptyLine/><emphasis role="HEAD-WoutNo">Studies</emphasis></para>
        </#if>
        <@com.emptyLine/>

        <#if !resultStudyList?has_content>
            <#if !dataWaivingStudyList?has_content>No relevant individual studies available.</#if>

        <#else>

            <#--Get requirement name to display-->
            <#if name==""><#local name>${docSubTypes[0]?replace("([A-Z]{1})", " $1", "r")?lower_case}</#local></#if>

            ${resultStudyList?size} individual <#if resultStudyList?size==1>study<#else>studies</#if> for ${name} <#if resultStudyList?size==1>is<#else>are</#if> summarised below:

            <#list resultStudyList as study>

                <sect4 xml:id="${study.documentKey.uuid!}" label="/${study_index+1}" role="NotInToc"><title  role="HEAD-5" >${study.name}</title>

                    <#--appendixE header-->
                    <para><emphasis role="HEAD-WoutNo">1. Information on the study</emphasis></para>
                    <@appendixEheader _subject study/>

                    <@com.emptyLine/>

                    <#--appendixE m&m and results-->
                    <para><emphasis role="HEAD-WoutNo"> 2. Full summary of the study according to OECD format </emphasis></para>

                    <#if study.hasElement("MaterialsAndMethods")>
                        <@appendixEmethods _subject study/>
                    <#elseif study.hasElement("GeneralInformation") && study.documentSubType=="EffectivenessAgainstTargetOrganisms">
                        <@keyBioPropMicro.generalInfo_effectivenessTargetOrg study/>
                    </#if>

                    <@com.emptyLine/>

                    <@appendixEresults _subject study/>

                    <@com.emptyLine/>

                    <#--appendixE Assessment and Conclusion-->
                    <@appendixEconclusion _subject study/>

                </sect4>
            </#list>
        </#if>

        <@com.emptyLine/>

    </#compress>
</#macro>

<#macro appendixEheader _subject study>
    <#compress>

    <#--Get first study report literature reference, if references exist (if more than one reference, sort and take first study report);
        else create an empty reference hash (another option is to make an if statement in each section)-->
        <#local reference=getStudyReference(study)/>
        <#if !reference?has_content>
            <#local reference = {'GeneralInfo': {'Author':"", 'ReferenceYear':"", 'Name':"", 'ReportNo':"", 'StudyIdentifiers':""}}/>
        </#if>

        <table border="1">
            <title> </title>
            <col width="35%" />
            <col width="65%" />
            <tbody>
            <tr>
                <th><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">Data point:</emphasis></th>
                <td><@com.picklist study.AdministrativeData.Endpoint/></td>
            </tr>
            <tr>
                <th><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">Report author: </emphasis></th>
                <td>
                    <@com.text reference.GeneralInfo.Author/>
                </td>
            </tr>
            <tr>
                <th><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">Report year: </emphasis></th>
                <td><@com.number reference.GeneralInfo.ReferenceYear/></td>
            </tr>
            <tr>
                <th><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">Report title: </emphasis></th>
                <td><@com.text reference.GeneralInfo.Name/></td>
            </tr>
            <tr>
                <th><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">Report No: </emphasis></th>
                <td><@com.text reference.GeneralInfo.ReportNo/></td>
            </tr>
            <tr>
                <th><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">NoS Id: </emphasis></th>
                <td>
                    <#local NoSId=getNoSid(reference)/>
                    ${NoSId}
                    <#-- NOTE: Remarks should contain the justification of no NoS_ID, but not safe to report automatically since it could contain other info-->
                    <#--<#elseif reference.GeneralInfo.Remarks?has_content>-->
                    <#--<@com.text reference.GeneralInfo.Remarks/>-->
                </td>
            </tr>
            <tr>
                <th><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">Document No: </emphasis></th>
                <td>
                    <#local docUrl=getDocUrl(study, _subject) />
                    <ulink url="${docUrl}"><@com.text study.documentKey.uuid/></ulink>
                </td>
            </tr>
            <tr>
                <th><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">Guidelines followed in study: </emphasis></th>
                <td>
                    <#if study.hasElement("MaterialsAndMethods")>
                        <@studyandsummaryCom.guidelineList study.MaterialsAndMethods.Guideline/>
                        <#if study.MaterialsAndMethods.MethodNoGuideline?has_content>
                            other method: <@com.text study.MaterialsAndMethods.MethodNoGuideline/>
                        </#if>
                    </#if>
                </td>
            </tr>
            <tr>
                <th><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">Deviations from current test guideline: </emphasis></th>
                <td>
                    <#--Display guideline deviations only if yes, referring to which guideline it applies (if several)-->
                    <#if study.hasElement("MaterialsAndMethods")>
                        <#list study.MaterialsAndMethods.Guideline as guidelineKey>
                            <#local deviation><@com.picklist guidelineKey.Deviation/></#local>
                            <#if deviation?starts_with('yes')>
                                <#if guidelineKey_has_next || guidelineKey_index!=0>for <@com.picklist guidelineKey.Guideline/>: </#if>
                                ${deviation}
                            </#if>
                        </#list>
                    </#if>
                </td>
            </tr>
            <tr>
                <th><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">Previous evaluation: </emphasis></th>
                <td>
                    <#--Check in change log: if uuid found, then "Yes:" and append status (concatenated); else "No"
                        (NOTE: probably part of this can go to a macro/function elsewhere)-->
                    <#local changeLogStatus=getChangeLogStatus(study, _subject)/>
                    ${changeLogStatus}
                </td>
            </tr>
            <tr>
                <th><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">GLP/Officially recognised testing facilities: </emphasis></th>
                <td><#if study.hasElement("MaterialsAndMethods")>
                        <@com.picklist study.MaterialsAndMethods.GLPComplianceStatement/>
                    <#--NOTE: not always present-->
                        <#if study.hasElement("MaterialsAndMethods.OtherQualityAssurance") && study.MaterialsAndMethods.OtherQualityAssurance?has_content>
                            <?linebreak?>other quality assurance: <@com.picklist study.MaterialsAndMethods.OtherQualityAssurance/>
                        </#if>
                    </#if>
                </td>
            </tr>
            <tr>
                <th><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">Adequacy of study: </emphasis></th>
                <td><@com.picklist study.AdministrativeData.PurposeFlag/>
                </td>
            </tr>
            <tr>
                <th><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">Acceptability/Reliability: </emphasis></th>
                <td><@com.picklist study.AdministrativeData.Reliability/>
                    <#if study.AdministrativeData.RationalReliability?has_content>
                        : <@com.picklist study.AdministrativeData.RationalReliability/>
                    </#if>
                </td>
            </tr>
            </tbody>
        </table>
    </#compress>
</#macro>

<#macro appendixEconclusion _subject study>
    <#compress>
        <para><emphasis role="HEAD-WoutNo">3. Assessment and conclusion </emphasis> </para>
<#--        <@com.emptyLine/>-->

    <#--		<para><emphasis role="bold">a) Assessment and conclusion by applicant:</emphasis></para>-->

        <#--NOTE: Interpretation of results does not exists for all documents-->
        <#if study.hasElement("ApplicantSummaryAndConclusion.InterpretationOfResults") && study.ApplicantSummaryAndConclusion.InterpretationOfResults?has_content>
            <@com.emptyLine/>
            <para>
                <emphasis role="bold">Interpretation of results: </emphasis><@com.picklist study.ApplicantSummaryAndConclusion.InterpretationOfResults/>
            </para>
        </#if>

        <#if study.hasElement("ApplicantSummaryAndConclusion.ValidityCriteriaFulfilled") && study.ApplicantSummaryAndConclusion.ValidityCriteriaFulfilled?has_content>
            <@com.emptyLine/>
            <para>
                <emphasis role="bold">Validity criteria fulfilled: </emphasis><@com.picklist study.ApplicantSummaryAndConclusion.ValidityCriteriaFulfilled/>
            </para>
        </#if>

        <#if study.ApplicantSummaryAndConclusion.ExecutiveSummary?has_content>
            <@com.emptyLine/>
            <para>
                <emphasis role="bold">Executive summary:</emphasis>
                <@com.richText study.ApplicantSummaryAndConclusion.ExecutiveSummary/>
            </para>
        </#if>

        <#if study.ApplicantSummaryAndConclusion.Conclusions?has_content>
            <@com.emptyLine/>
            <para>
                <emphasis role="bold">Conclusion:</emphasis>
                <@com.text study.ApplicantSummaryAndConclusion.Conclusions/>
            </para>
        </#if>

<#--        <@com.emptyLine/>-->
    <#--		<para><emphasis role="bold">b) Assessment and conclusion by RMS:</emphasis></para>-->
    <#--		<itemizedlist><listitem>- Outcome and conclusion of the study: RMS should indicate if they agree to the results and conclusions of the APPL.</listitem></itemizedlist>-->
    </#compress>
</#macro>

<#macro appendixEmethods _subject study>

    <para><emphasis role="bold">a) Materials and methods</emphasis></para>

    <!-- Test material-->
    <para>
        <emphasis role="bold">Test material:</emphasis>
        <#assign testMat=study.MaterialsAndMethods.TestMaterials/>
        <span role="indent"><@studyandsummaryCom.testMaterialInformation testMat.TestMaterialInformation/></span>

        <#if testMat.SpecificDetailsOnTestMaterialUsedForTheStudy?has_content>
            <span role="indent">
			Specific details:
                <?linebreak?><@com.text study.MaterialsAndMethods.TestMaterials.SpecificDetailsOnTestMaterialUsedForTheStudy/>
			</span>
        </#if>

        <@com.children path=testMat exclude=["TestMaterialInformation", "SpecificDetailsOnTestMaterialUsedForTheStudy",
                        "SpecificDetailsOnTestMaterialUsedForTheStudyConfidential"]/>

    </para>

    <!-- Specific methods -->
    <#if study.documentSubType=="ExposureRelatedObservationsOther" || study.documentSubType=="SensitisationData" || study.documentSubType=="DirectObservationsClinicalCases"
            || study.documentSubType=="EpidemiologicalData" || study.documentSubType=="HealthSurveillanceData">
        <@keyTox.humanStudyMethod study/>
    <#else>
        <@keyTox.nonHumanStudyMethod study/>
    </#if>

    <#--Any other information-->
    <#if study.MaterialsAndMethods.hasElement("AnyOtherInformationOnMaterialsAndMethodsInclTables") && study.MaterialsAndMethods.AnyOtherInformationOnMaterialsAndMethodsInclTables.OtherInformation?has_content>
        <para>
            <emphasis role="bold">Other information:</emphasis><?linebreak?>
            <@com.richText study.MaterialsAndMethods.AnyOtherInformationOnMaterialsAndMethodsInclTables.OtherInformation/>
        </para>
    </#if>

</#macro>

<#macro appendixEresults _subject study>
    <#compress>
        <para><emphasis role="bold">b) Results</emphasis></para>

        <#--1. Section-dependent specific result lists -->
        <#if study.documentSubType=="BasicToxicokinetics">
            <@keyTox.results_basicToxicokinetics study/>

        <#elseif study.documentSubType=="AcuteToxicityOral" || study.documentSubType=="AcuteToxicityDermal" ||  study.documentSubType=="AcuteToxicityInhalation" || study.documentSubType=="AcuteToxicityOtherRoutes" >
            <@keyTox.results_acuteToxicity study/>

        <#elseif study.documentSubType=="SkinIrritationCorrosion" || study.documentSubType=="EyeIrritation">
            <@keyTox.results_skinEyeIrritation study/>

        <#elseif study.documentSubType=="SkinSensitisation">
            <@keyTox.results_skinSensitisation study />

        <#elseif study.documentSubType=="PhototoxicityVitro">
            <@keyTox.results_phototoxicity study/>

        <#elseif study.documentSubType=="RepeatedDoseToxicityOral" || study.documentSubType=="RepeatedDoseToxicityInhalation" || study.documentSubType=="RepeatedDoseToxicityDermal" ||
        study.documentSubType=="RepeatedDoseToxicityOther" || study.documentSubType=="Carcinogenicity" || study.documentSubType=="Neurotoxicity" || study.documentSubType=="Immunotoxicity">
            <@keyTox.results_repDoseCarciNeuroImmuno study/>

        <#elseif study.documentSubType=="GeneticToxicityVitro" || study.documentSubType=="GeneticToxicityVivo">
            <@keyTox.results_geneticToxicity study/>
        <#-- NOTE: changed from existing macros-->

        <#elseif study.documentSubType=="ToxicityReproduction">
            <@keyTox.results_toxicityReproduction study/>

        <#elseif study.documentSubType=="ToxicityReproductionOther">
            <@keyTox.results_toxicityReproductionOther study/>

        <#elseif study.documentSubType=="DevelopmentalToxicityTeratogenicity">
            <@keyTox.results_developmentalToxicity study/>

        <#elseif study.documentSubType=="ToxicEffectsLivestock" || study.documentSubType=="SpecificInvestigations">
            <@keyTox.results_effectsLivestock study/>

        <#elseif study.documentSubType=="EndocrineDisrupterMammalianScreening">
            <@keyTox.results_endocrineDisrupterMammalianScreening study/>

        <#elseif study.documentSubType=="DermalAbsorption">
            <@keyTox.results_dermalAbsorption study/>

        <#elseif study.documentSubType=="HealthSurveillanceData" ||  study.documentSubType=="ExposureRelatedObservationsOther" || study.documentSubType=="EpidemiologicalData" >
            <@keyTox.results_healthSurvExposureEpidemiological study/>

        <#elseif study.documentSubType=="DirectObservationsClinicalCases" || study.documentSubType="SensitisationData">
            <@keyTox.results_directObs study/>

        </#if>

        <#--2. Other information including tables
			 NOTE: in some cases ("technical characteristics" at least) the path of results is different (probably by error)-->
        <#if study.hasElement("ResultsAndDiscussion")><#local resultsPath=study.ResultsAndDiscussion/>
        <#elseif study.hasElement("ResultsAndDiscussions")><#local resultsPath=study.ResultsAndDiscussions/>
        </#if>
        <#if resultsPath.AnyOtherInformationOnResultsInclTables.OtherInformation?has_content>
            <para>
                Remarks: <@com.richText resultsPath.AnyOtherInformationOnResultsInclTables.OtherInformation/>
            </para>
        </#if>

        <#--3. Remarks on results-->
        <#if study.OverallRemarksAttachments.RemarksOnResults?has_content>
            <para>Overall remarks: <@com.richText study.OverallRemarksAttachments.RemarksOnResults/></para>
        </#if>

    </#compress>
</#macro>

<#--general functions and macros -->
<#macro filterStudyListbyContext myStudyList context>

    <#if myStudyList?has_content && context?has_content>

        <#assign filtStudyList = [] />

        <#--Loop over studies-->
        <#list myStudyList as study>

            <#-- Flag to set number of conditions met-->
            <#local nbCondMet=0/>

            <#--Loop over conditions-->
            <#list context as ctxt>

                <#local contextPath = "study." + ctxt["path"] />
                <#local contextVal = contextPath?eval/>

<#--                <#if contextVal?has_content>-->

                <#-- Convert value depending on type -->
                    <#if ctxt["type"]=="picklist">
                        <#local contextVal2><@com.picklist contextVal/></#local>
                    <#elseif ctxt["type"]=="text">
                        <#local contextVal2><@com.text contextVal/></#local>
                    </#if>

                <#-- Evaluate condition and change flag -->
                    <#if ctxt["qual"]=="eq">
                        <#if ctxt["val"]?seq_contains(contextVal2)>
                            <#local nbCondMet=nbCondMet+1/>
                        </#if>

                    <#elseif ctxt["qual"]=="ne">
                        <#if !ctxt["val"]?seq_contains(contextVal2)>
                            <#local nbCondMet=nbCondMet+1/>
                        </#if>

                    <#elseif ctxt["qual"] == "lk">
                        <#list ctxt["val"] as val>
                            <#if contextVal2?contains(val)>
                                <#local nbCondMet=nbCondMet+1/>
                                <#break>
                            </#if>
                        </#list>

                    <#elseif ctxt["qual"] == "nl">
                        <#local notfound=true/>
                        <#list ctxt["val"] as val>
                            <#if contextVal2?contains(val)>
                                <#local notfound=false/>
                            </#if>
                        </#list>
                        <#if notfound><#local nbCondMet=nbCondMet+1/></#if>

                    </#if>
<#--                </#if>-->
            </#list>

        <#--Check if all conditions met and add study-->
            <#if nbCondMet==context?size>
                <#assign filtStudyList = filtStudyList + [study] />
            </#if>
        </#list>
    <#else>
        <#assign filtStudyList = myStudyList/>
    </#if>
</#macro>

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

<#function getNoSid reference>

    <#local NoSId=""/>
    <#if reference.GeneralInfo.StudyIdentifiers?has_content>
        <#list reference.GeneralInfo.StudyIdentifiers as studyId>
            <#if studyId.Remarks?matches(".*NOTIF.*STUD.*", "i") || studyId.Remarks?matches(".*NOS.*", "i")>
                <#local NoSId = studyId.StudyID/>
                <#return NoSId>
            </#if>
        </#list>
    </#if>

    <#return "">

</#function>

<#function getDocUrl study _subject>
    <#local docUrl=iuclid.webUrl.documentView(study.documentKey) />

    <#local datasetId = _subject.documentKey?replace("\\/.*$", "", "r")/>
    <#local datasetEntity = _subject.documentType/>
    <#local docUrl = docUrl?replace("\\?goto", "\\/raw\\/${datasetEntity}\\/${datasetId}\\?content_uri", "r")/>

    <#local docUrl = docUrl?replace("\\%3A", "\\:", "r")/>

    <#return docUrl>
</#function>

<#function getChangeLogStatus study _subject>
    <#local changeLogFlag=false/>

    <#local changeLogStatusList=[]/>

    <#local changeLogs = iuclid.getSectionDocumentsForParentKey(_subject.documentKey, "FLEXIBLE_RECORD", "ChangeLog") />
    <#list changeLogs as changeLog>
        <#list changeLog.ChangeLog.ChangeLogEntries as changeLogEntry>
            <#local changeLogDoc=iuclid.getDocumentForKey(changeLogEntry.LinkToDocument)/>

            <#if changeLogDoc?has_content>
                <#if study.documentKey.uuid==changeLogDoc.documentKey.uuid>
                    <#local changeLogFlag=true/>
                    <#local changeLogStatus><@com.picklist changeLogEntry.Status/></#local>
                    <#if changeLogStatus?has_content>
                        <#local changeLogStatusList = changeLogStatusList + [changeLogStatus]/>
                    </#if>
                </#if>
            </#if>
        </#list>
    </#list>

    <#if changeLogFlag==true>
        <#local changeLogStatusMessage>yes<#if changeLogStatusList?has_content>- ${changeLogStatusList?join(", ")}</#if></#local>
    <#else>
        <#local changeLogStatusMessage="no"/>
    </#if>

    <#return changeLogStatusMessage>
</#function>


<#function sortByEndpoint myStudyList>

<#--	create a hashmap to sort by endpoint (same endpoints together)-->
    <#local studyHashMap={}/>
    <#list myStudyList as study>
        <#local endpoint><@com.picklist study.AdministrativeData.Endpoint/></#local>
    <#--		<#if studyHashMap?keys?seq_contains(endpoint)>-->
        <#if studyHashMap[endpoint]??>
        <#--			endpointsHash[seqEntry["name"]]??-->
            <#local entry = studyHashMap[endpoint] + [study]/>
            <#local studyHashMap = studyHashMap + {endpoint : entry}/>
        <#else>
            <#local studyHashMap = studyHashMap + {endpoint:[study]}/>
        </#if>
    </#list>

<#--	read hashmap and get ordered list-->
    <#local sortedStudies=[]/>
    <#list studyHashMap?keys as key>
        <#local sortedStudies = sortedStudies + studyHashMap[key]/>
    </#list>

    <#return sortedStudies/>
</#function>

<#-- Copied macros from common_module_human_health_hazard_assessment_of_physicochemical_properties: Macros to separate documents into three lists: 'study results', 'data waiving', 'testing proposal'-->

<#macro populateResultAndDataWaivingAndTestingProposalStudyLists studyList>
    <#assign resultStudyList = [] />
    <#assign dataWaivingStudyList = [] />
    <#assign testingProposalStudyList = [] />
    <#if studyList?has_content>
        <#list studyList as study>
            <#if isTestingProposalStudy(study)>
                <#assign testingProposalStudyList = testingProposalStudyList + [study] />
            <#elseif isDataWaivingStudy(study)>
                <#assign dataWaivingStudyList = dataWaivingStudyList + [study] />
            <#elseif isRelevantAdequacyOfStudy(study)>
                <#assign resultStudyList = resultStudyList + [study] />
            </#if>
        </#list>
    </#if>

<#-- sort resultStudyList according to PurposeFlag -->
    <#assign resultStudyList = iuclid.sortByField(resultStudyList, "AdministrativeData.PurposeFlag", ["key study","supporting study","weight of evidence","disregarded due to major methodological deficiencies","other information"]) />

<#-- sort resultStudyList by Endpoint (is there a function to do this?) -->
    <#assign resultStudyList = sortByEndpoint(resultStudyList)/>
</#macro>

<#function isRelevantAdequacyOfStudy study>
    <#if !(study?has_content)>
        <#return false>
    </#if>
    <#local PurposeFlag = study.AdministrativeData.PurposeFlag />
    <#return PurposeFlag?has_content && !com.picklistValueMatchesPhrases(PurposeFlag, ["other information"]) />
</#function>

<#function isDataWaivingStudy study>
    <#if !(study?has_content)>
        <#return false>
    </#if>
    <#local PurposeFlag = study.AdministrativeData.PurposeFlag />
    <#local DataWaiving = study.AdministrativeData.DataWaiving />
    <#return !(PurposeFlag?has_content) && DataWaiving?has_content />
</#function>

<#function isTestingProposalStudy study>
    <#if !(study?has_content)>
        <#return false>
    </#if>
    <#return !(PurposeFlag?has_content) && com.picklistValueMatchesPhrases(study.AdministrativeData.StudyResultType, ["experimental study planned.*"]) />
</#function>





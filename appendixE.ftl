<!-- Macros and functions for EU PPP reports, including appendix E format -->

<!-- Appendix E structure -->
<#macro appendixEstudies subject docSubTypes context="" name="" section="" includeMetabolites=true>
	<#compress>

		<#-- Convert elements to lists-->
		<#if !docSubTypes?is_sequence>
			<#local docSubTypes=[docSubTypes]/>
		</#if>

		<#if !subject?is_sequence>
			<#local entities=[subject]/>
		<#else>
			<#local entities=subject/>
		</#if>

		<#--Get name of subject, if only one -->
		<#local subjectName><#if !subject?is_sequence>${getEntityName(subject)}</#if></#local>

		<#--Get requirement name to display-->
		<#local name = getRequirementName(name, docSubTypes)>

		<#--Add metabolites to the list of entities to loop for studies, if required -->
		<#if includeMetabolites && _metabolites?? && _metabolites?has_content>
<#--			_subject.documentType=="SUBSTANCE" &&-->
			<#local entities = entities + _metabolites/>
		</#if>

		<#--Get a hash of studies for results and data waivers for all entities-->
		<#local studyHash = createStudyHash(entities, docSubTypes, context, section)/>

		<#-- Data waiving-->
		<#if studyHash['dw']?has_content>
			<#--			NOTE: need to output name-->
			<@com.emptyLine/>
			<para><emphasis role="HEAD-WoutNo">Data waiving</emphasis></para>
<#--			<#list studyHash['dw'] as entityName, dataWaivingData>-->
		<#--			NOTE: looping hashes by key, value only from Freemarker 2.3.25-->
			<#list studyHash['dw']?keys as entityName>
				<#local dataWaivingData=studyHash['dw'][entityName]/>

				<#local dataWaivingStudyList=dataWaivingData['records']/>
				<#if (entityName!=subjectName)>
					<@com.emptyLine/>- for ${entityName}:<?linebreak?>
				</#if>
				<@studyandsummaryCom.dataWaiving dataWaivingStudyList name false/>
			</#list>
		</#if>

		<#-- Testing proposal
        NOTE: Removed for the moment-->
		<#--		<#if testingProposalStudyList?has_content>-->
		<#--			<para><@com.emptyLine/><emphasis role="HEAD-WoutNo">Testing proposal</emphasis></para>-->
		<#--			<@studyandsummaryCom.testingProposal testingProposalStudyList name false/>-->
		<#--			<@com.emptyLine/>-->
		<#--		</#if>-->


		<#-- Study results-->
		<#if !(studyHash['dw']?has_content) || studyHash['st']?has_content >
			<@com.emptyLine/>
			<para><emphasis role="HEAD-WoutNo">Studies</emphasis></para>
		</#if>
		<#--<@com.emptyLine/>-->

		<#if !studyHash['st']?has_content>
			<#if !studyHash['dw']?has_content><para>No relevant individual studies for ${name} available.</para></#if>

		<#else>

			<para><@resultStudyHashSummaryText studyHash['st'] subjectName name/></para>
			<@com.emptyLine/>

			<#local studyIndex=0/>
<#--			<#list studyHash['st'] as entityName, resultData>-->
			<#list studyHash['st']?keys as entityName>
				<#local resultData=studyHash['st'][entityName]/>
			<#--			NOTE: looping hashes by key, value only from Freemarker 2.3.25-->

				<#local resultStudyList=resultData['records']/>
				<#local entity=resultData['entity']/>

				<#if entityName!=subjectName>
					<para><emphasis role="underline">----- Metabolite <emphasis role="bold">${entityName}</emphasis> -----</emphasis></para>
				</#if>

				<#list resultStudyList as study>

					<#local studyIndex=studyIndex+1/>

<#--					<sect4 xml:id="${study.documentKey.uuid!}" label="/${study_index+1}" role="NotInToc">-->
					<sect4 xml:id="${study.documentKey.uuid!}" label="/${studyIndex}" role="NotInToc">

						<title  role="HEAD-5"><@com.text study.name/></title>

						<#--appendixE header-->
						<para><emphasis role="HEAD-WoutNo">1. Information on the study</emphasis></para>
						<@appendixEheader study entity/>

						<@com.emptyLine/>

						<#--appendixE m&m and results-->
						<para><emphasis role="HEAD-WoutNo"> 2. Full summary of the study according to OECD format </emphasis></para>

						<#if study.hasElement("MaterialsAndMethods")>
							<@appendixEmethods study/>
						<#elseif study.hasElement("GeneralInformation") && study.documentSubType=="EffectivenessAgainstTargetOrganisms">
							<@keyBioPropMicro.generalInfo_effectivenessTargetOrg study/>
						<#elseif study.hasElement("Background") && study.documentSubType=="EfficacyData">
							<@keyEfficacy.basicInfo study/>
						<#elseif study.hasElement("Background") && study.Background.BackgroundInformation?has_content>
							<para><emphasis role="bold">Background information:</emphasis></para>
							<para role="indent"><@com.text study.Background.BackgroundInformation/></para>
						</#if>
						<#--for intermediate effects-->
						<#if study.hasElement("EffectIdentification")>
							<@keyTox.intermediateEffectIdentification study/>
						</#if>

						<#--<@com.emptyLine/>-->

						<@appendixEresults study/>

						<@com.emptyLine/>

						<#--appendixE Assessment and Conclusion-->
						<@appendixEconclusion study/>

					</sect4>

					<@com.emptyLine/>

				</#list>
			</#list>
		</#if>
		<@com.emptyLine/>

	</#compress>
</#macro>

<#macro resultStudyHashSummaryText studyHash subjectName name>
	<#compress>
		<#local text=''/>
		<#local size=0/>
<#--		<#list studyHash as entityName, resultData> -->
			<#--			NOTE: looping hashes by key, value only from Freemarker 2.3.25-->
		<#list studyHash?keys as entityName>

			<#local resultData=studyHash[entityName]/>

			<#local resultStudyList=resultData['records']/>

			<#local size = size + resultStudyList?size/>
			<#if (studyHash?keys?size>1)>
				<#local textEntity>
					<para role="indent">-
						${resultStudyList?size} for
						<#if entityName!=subjectName>metabolite ${entityName}<#else>active substance</#if>
					</para>
				</#local>

				<#local text = text + textEntity/>
			</#if>
		</#list>

		${size} individual <#if size==1>study<#else>studies</#if> for ${name} <#if size==1>is<#else>are</#if> summarised below: ${text}

	</#compress>
</#macro>

<#macro appendixEheader study entity>
	<#compress>

		<#--Get first study report literature reference, if references exist (if more than one reference, sort and take first study report);
        	else create an empty reference hash (another option is to make an if statement in each section)-->
		<#local reference=getStudyReference(study)/>
<#--		<#if !reference?has_content>-->
<#--			<#local reference = {'GeneralInfo': {'Author':"", 'ReferenceYear':"", 'Name':"", 'ReportNo':"", 'StudyIdentifiers':""}}/>-->
<#--		</#if>-->

		<table border="1">
			<title> </title>
			<col width="35%" />
			<col width="65%" />
			<tbody valign="middle">
			<tr>
				<th><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">Data point:</emphasis></th>
				<td>
					<#if study.documentSubType=="IntermediateEffects">
						intermediate effects: <@com.picklist study.AdministrativeData.StudyResultType/>
					<#else>
						<@com.picklist study.AdministrativeData.Endpoint/>
					</#if>
				</td>
			</tr>
			<tr>
				<th><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">Report type: </emphasis></th>
				<td>
					${getReferenceElement(reference, "GeneralInfo.LiteratureType", "picklist")}
				</td>
			</tr>
			<tr>
				<th><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">Report author: </emphasis></th>
				<td>
					${getReferenceElement(reference, "GeneralInfo.Author")}
<#--					<@com.text reference.GeneralInfo.Author/>-->
				</td>
			</tr>
			<tr>
				<th><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">Report year: </emphasis></th>
				<td>
					${getReferenceElement(reference, "GeneralInfo.ReferenceYear")}
<#--					<@com.number reference.GeneralInfo.ReferenceYear/>-->
				</td>
			</tr>
			<tr>
				<th><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">Report title: </emphasis></th>
				<td>
					${getReferenceElement(reference, "GeneralInfo.Name")}
<#--					<@com.text reference.GeneralInfo.Name/>-->
				</td>
			</tr>
			<tr>
				<th><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">Report No: </emphasis></th>
				<td>
					${getReferenceElement(reference, "GeneralInfo.ReportNo")}
<#--					<@com.text reference.GeneralInfo.ReportNo/>-->
				</td>
			</tr>
			<tr>
				<th><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">NoS Id: </emphasis></th>
				<td>
					<#local NoSId=getNoSid(reference)/>
					${NoSId}
				</td>
			</tr>
			<tr>
				<th><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">Document No: </emphasis></th>
				<td>
					<#local docUrl=iuclid.webUrl.documentView(study.documentKey) />
					<ulink url="${docUrl}"><@com.text study.documentKey.uuid/></ulink>
				</td>
			</tr>
			<tr>
				<th><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">Guidelines followed in study: </emphasis></th>
				<td>
					<#if study.hasElement("MaterialsAndMethods") && study.documentSubType!="IntermediateEffects">
						<@studyandsummaryCom.guidelineList study.MaterialsAndMethods.Guideline/>
						<#if study.MaterialsAndMethods.MethodNoGuideline?has_content>
							other method: <@com.text study.MaterialsAndMethods.MethodNoGuideline/>
						</#if>
					<#elseif study.documentSubType=="IntermediateEffects">
						<@com.picklist study.MaterialsAndMethods.MethodUsed.Qualifier/> <@com.picklist study.MaterialsAndMethods.MethodUsed.MethodUsed/>
						<?linebreak?><@com.text study.MaterialsAndMethods.MethodUsed.PrincipleOfTheMethod/>
					</#if>
				</td>
			</tr>
			<tr>
				<th><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">Deviations from current test guideline: </emphasis></th>
				<td>
					<#--Display guideline deviations only if yes, referring to which guideline it applies (if several)-->
					<#if study.hasElement("MaterialsAndMethods") && study.documentSubType!="IntermediateEffects">
						<#list study.MaterialsAndMethods.Guideline as guidelineKey>
							<#local deviation><@com.picklist guidelineKey.Deviation/></#local>
							<#if deviation?starts_with('yes')>
								<#if guidelineKey_has_next || guidelineKey_index!=0>for <@com.picklist guidelineKey.Guideline/>: </#if>
								${deviation}
							</#if>
						</#list>
					<#elseif study.documentSubType=="IntermediateEffects">
						<#local deviations><@com.picklist study.MaterialsAndMethods.MethodUsed.Deviations/></#local>
						<#if deviations?starts_with('yes')>${deviations}</#if>
					</#if>
				</td>
			</tr>
			<tr>
				<th><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">Previous evaluation: </emphasis></th>
				<td>
					<#--Check in change log: if uuid found, then "Yes:" and append status (concatenated); else "No"
                        (NOTE: probably part of this can go to a macro/function elsewhere)-->
					<#local changeLogStatus=getChangeLogStatus(study, entity)/>
					${changeLogStatus}
				</td>
			</tr>
			<tr>
				<th><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">GLP/Officially recognised testing facilities: </emphasis></th>
				<td><#if study.hasElement("MaterialsAndMethods") && study.documentSubType!="IntermediateEffects">
						<@com.picklist study.MaterialsAndMethods.GLPComplianceStatement/>
						<#--NOTE: not always present-->
						<#if study.hasElement("MaterialsAndMethods.OtherQualityAssurance") && study.MaterialsAndMethods.OtherQualityAssurance?has_content>
							<?linebreak?>other quality assurance: <@com.picklist study.MaterialsAndMethods.OtherQualityAssurance/>
						<#elseif study.hasElement("MaterialsAndMethods.ComplianceWithQualityStandards") && study.MaterialsAndMethods.ComplianceWithQualityStandards?has_content>
							<?linebreak?>compliance with quality standards: <@com.picklist study.MaterialsAndMethods.ComplianceWithQualityStandards/>
						</#if>
					<#elseif study.documentSubType=="IntermediateEffects">
						<@com.picklist study.MaterialsAndMethods.MethodUsed.GLPCompliance/>
						<?linebreak?>
						<#if study.MaterialsAndMethods.MethodUsed.OtherQualityFollowed?has_content>
							other quality assurance: <@com.picklist study.MaterialsAndMethods.MethodUsed.OtherQualityFollowed/>
						</#if>
					</#if>
				</td>
			</tr>
			<tr>
				<th><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">Adequacy of study: </emphasis></th>
				<td><#if study.hasElement("AdministrativeData.PurposeFlag")><@com.picklist study.AdministrativeData.PurposeFlag/></#if>
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

<#macro appendixEconclusion study>
	<#compress>
		<para><emphasis role="HEAD-WoutNo">3. Assessment and conclusion </emphasis> </para>

		<#--		<para><emphasis role="bold">a) Assessment and conclusion by applicant:</emphasis></para>-->

		<#--NOTE: Interpretation of results does not exist for all documents-->
		<#if study.hasElement("ApplicantSummaryAndConclusion.InterpretationOfResults") && study.ApplicantSummaryAndConclusion.InterpretationOfResults?has_content>
			<para>
				<emphasis role="bold">Interpretation of results: </emphasis><@com.picklist study.ApplicantSummaryAndConclusion.InterpretationOfResults/>
			</para>
		</#if>

		<#if study.hasElement("ApplicantSummaryAndConclusion.ValidityCriteriaFulfilled") && study.ApplicantSummaryAndConclusion.ValidityCriteriaFulfilled?has_content>
			<para>
				<emphasis role="bold">Validity criteria fulfilled: </emphasis><@com.picklist study.ApplicantSummaryAndConclusion.ValidityCriteriaFulfilled/>
			</para>
		</#if>

		<#if study.hasElement("ApplicantSummaryAndConclusion.ExecutiveSummary") && study.ApplicantSummaryAndConclusion.ExecutiveSummary?has_content>
			<para><emphasis role="bold">Executive summary:</emphasis></para>
			<para role="indent"><@com.richText study.ApplicantSummaryAndConclusion.ExecutiveSummary/></para>
		<#elseif study.hasElement("ApplicantSSummaryAndConclusion.ExecutiveSummary.ExecutiveSummary") && study.ApplicantSSummaryAndConclusion.ExecutiveSummary.ExecutiveSummary?has_content>
			<#--for intermediate effects-->
			<para><emphasis role="bold">Executive summary:</emphasis></para>
			<para role="indent"><@com.richText study.ApplicantSSummaryAndConclusion.ExecutiveSummary.ExecutiveSummary/></para>
		</#if>

		<#if study.hasElement("ApplicantSummaryAndConclusion.Conclusions") && study.ApplicantSummaryAndConclusion.Conclusions?has_content>
			<para>
				<emphasis role="bold">Conclusion:</emphasis>
				<para role="indent"><@com.text study.ApplicantSummaryAndConclusion.Conclusions/></para>
			</para>
		</#if>

		<#--for intermediate effects-->
		<#if study.hasElement("ApplicantSSummaryAndConclusion.InterpretationOfResultsObservations") && study.ApplicantSSummaryAndConclusion.InterpretationOfResultsObservations?has_content>
			<para><emphasis role="bold">Interpretation of results:</emphasis></para>
			<#local int=study.ApplicantSSummaryAndConclusion.InterpretationOfResultsObservations/>
			<#if int.TypeOfResult?has_content>
				<para role="indent">Type of result: <@com.picklist int.TypeOfResult/></para>
			</#if>
			<#if int.EffectConcentrationChoice?has_content>
				<para role="indent">Effect concentration: <@com.picklist int.EffectConcentrationChoice/>
					<#if int.Concentration?has_content>
						= <@com.range int.Concentration/>
					</#if>
				</para>
			</#if>
			<#if int.Remarks?has_content>
				<para role="indent">Remarks: <@com.text int.Remarks/></para>
			</#if>

			<#if int.OverallResults?has_content>
				<para>
					<emphasis role="bold">Conclusion:</emphasis>
					<@com.text  int.OverallResults/>
				</para>
			</#if>
		</#if>

		<#--		<para><emphasis role="bold">b) Assessment and conclusion by RMS:</emphasis></para>-->
		<#--		<itemizedlist><listitem>- Outcome and conclusion of the study: RMS should indicate if they agree to the results and conclusions of the APPL.</listitem></itemizedlist>-->
	</#compress>
</#macro>

<#macro appendixEmethods study>

	<#--	Map type of document to document name, so that it's possible to select which methods macro to use-->
   	<#assign docCategoryMap={"tox_nonhuman":["BasicToxicokinetics", "AcuteToxicityOral", "AcuteToxicityDermal", "AcuteToxicityInhalation","SkinIrritationCorrosion","EyeIrritation","SkinSensitisation","PhototoxicityVitro",
								"AcuteToxicityOtherRoutes", "RepeatedDoseToxicityOral", "RepeatedDoseToxicityInhalation", "RepeatedDoseToxicityDermal", "RepeatedDoseToxicityOther", "GeneticToxicityVitro", "GeneticToxicityVivo",
								"Carcinogenicity", "ToxicityReproduction", "ToxicityReproductionOther", "DevelopmentalToxicityTeratogenicity", "Neurotoxicity", "Immunotoxicity", "ToxicEffectsLivestock","EndocrineDisrupterMammalianScreening",
								"AdditionalToxicologicalInformation", "DermalAbsorption", "CellCultureStudy"],
							"tox_human":["ExposureRelatedObservationsOther","SensitisationData","DirectObservationsClinicalCases","EpidemiologicalData","HealthSurveillanceData"],
							"physchem":["Melting", "BoilingPoint", "Vapour", "HenrysLawConstant", "GeneralInformation", "WaterSolubility", "SolubilityOrganic", "Partition", "DissociationConstant",
											"Flammability", "AutoFlammability", "FlashPoint", "Explosiveness", "SurfaceTension", "OxidisingProperties", "AdditionalPhysicoChemical", "Ph", "Viscosity",
											"Density", "StorageStability", "StabilityThermal", "TechnicalCharacteristics", "DegreeOfDissolutionAndDilutionStability", "PhysicalChemicalCompatibility",
											"ToxicityToOtherAboveGroundOrganisms"],
							"ecotox":["ToxicityToBirds", "ToxicityToOtherAboveGroundOrganisms", "ShortTermToxicityToFish", "LongTermToxToFish", "BioaccumulationAquaticSediment",
										"EndocrineDisrupterTestingInAqua", "ShortTermToxicityToAquaInv", "LongTermToxicityToAquaInv", "SedimentToxicity", "ToxicityToAquaticAlgae",
										"ToxicityToAquaticPlant", "AdditionalEcotoxicologicalInformation", "ToxicityToTerrestrialArthropods", "ToxicityToSoilMacroorganismsExceptArthropods",
										"BioaccumulationTerrestrial", "ToxicityToSoilMicroorganisms", "ToxicityToTerrestrialPlants", "ToxicityToMicroorganisms", "BiologicalEffectsMonitoring"],
							"res":["StabilityOfResiduesInStoredCommod", "MetabolismInCrops", "MetabolismInLivestock", "ResiduesInLivestock",
									"NatureResiduesInProcessedCommod", "MagnitudeResidInProcessedComm", "ResiduesInRotationalCrops",
									"ExpectedExposureAndProposedAcceptableResidues", "AdditionalInfoOnResiduesInFood", "ResiduesProcessedCommodities", "MigrationOfResidues"],
							"anmeth":["AnalyticalMethods"],
							"fate":["BiodegradationInSoil", "PhotoTransformationInSoil", "FieldStudies", "AdsorptionDesorption", "AgedSorption", "OtherDistributionData",
									"Hydrolysis", "Phototransformation", "BiodegradationInWaterScreeningTests", "BiodegradationInWaterAndSedimentSimulationTests",
									"PhototransformationInAir", "TransportViaAir", "AdditionalInformationOnEnvironmentalFateAndBehaviour", "MonitoringData"],
							"efficacy" : ["EfficacyData"]
	}/>


	<para><emphasis role="bold">a) Materials and methods</emphasis></para>

	<!-- Test material-->
	<para><emphasis role="bold">Test material:</emphasis></para>
	<#assign testMat=study.MaterialsAndMethods.TestMaterials/>
	<para role="indent"><@studyandsummaryCom.testMaterialInformation testMat.TestMaterialInformation/></para>

	<#if testMat.SpecificDetailsOnTestMaterialUsedForTheStudy?has_content>
		<para role="indent">Specific details:</para>
		<para role="indent2"><@com.text study.MaterialsAndMethods.TestMaterials.SpecificDetailsOnTestMaterialUsedForTheStudy/></para>
	</#if>

	<@com.children path=testMat exclude=["TestMaterialInformation", "SpecificDetailsOnTestMaterialUsedForTheStudy",
											"SpecificDetailsOnTestMaterialUsedForTheStudyConfidential"] role1="indent" role2="indent2"/>

	<!-- Specific methods -->
	<#list docCategoryMap?keys as methodkey>
		<#list docCategoryMap[methodkey] as methodDocSubType>
			<#if methodDocSubType==study.documentSubType>
				<#if methodkey=="tox_human">
					<@keyTox.humanStudyMethod study/>
				<#elseif methodkey=="tox_nonhuman">
					<@keyTox.nonHumanStudyMethod study/>
				<#elseif methodkey=="ecotox" && keyEcotox??>
					<@keyEcotox.ecotoxMethod study/>
				<#elseif methodkey=="physchem" && keyPhyschem??>
					<@keyPhyschem.physchemMethod study/>
				<#elseif methodkey=="res">
					<@keyRes.residuesMethod study/>
				<#elseif methodkey=="anmeth">
					<@keyAnMeth.analyticalMethodsMethod study/>
				<#elseif methodkey=="fate">
					<@keyFate.fateMethod study/>
				<#elseif methodkey=="efficacy">
					<@keyEfficacy.efficacyMethod study/>
				</#if>
			</#if>
		</#list>
	</#list>
	<#if study.documentSubType=="IntermediateEffects">
		<@keyTox.methods_intermediateEffects study/>
	</#if>

	<#--Any other information-->
	<#if study.MaterialsAndMethods.hasElement("AnyOtherInformationOnMaterialsAndMethodsInclTables") && study.MaterialsAndMethods.AnyOtherInformationOnMaterialsAndMethodsInclTables.OtherInformation?has_content>
		<para><emphasis role="bold">Other information:</emphasis></para>
		<para role="indent"><@com.richText study.MaterialsAndMethods.AnyOtherInformationOnMaterialsAndMethodsInclTables.OtherInformation/></para>
	</#if>

</#macro>

<#macro appendixEresults study>
	<#compress>
		<para><emphasis role="bold">b) Results</emphasis></para>

			<#--1. Section-dependent specific result lists -->
			<#--NOTE: it seems in some cases ("TechnicalCharacteristics") this section has a different path-->

			<#--2. Physchem-->
			<#if study.documentSubType=='Melting'>
				<#if study.ResultsAndDiscussion.MeltingPoint?has_content>
					<para><emphasis role="bold">Melting point:</emphasis></para>
					<@keyPhyschem.meltingPointList studyandsummaryCom.orderByKeyResult(study.ResultsAndDiscussion.MeltingPoint)/>
				</#if>
			<#elseif study.documentSubType=='BoilingPoint'>
				<#if study.ResultsAndDiscussion.BoilingPoint?has_content>
					<para><emphasis role="bold">Boiling point:</emphasis></para>
					<@keyPhyschem.boilingPointList studyandsummaryCom.orderByKeyResult(study.ResultsAndDiscussion.BoilingPoint)/>
				</#if>
			<#elseif study.documentSubType=='Vapour'>
				<#if study.ResultsAndDiscussion.Vapourpr?has_content>
					<para><emphasis role="bold">Vapour pressure:</emphasis></para>
					<@keyPhyschem.vapourprList studyandsummaryCom.orderByKeyResult(study.ResultsAndDiscussion.Vapourpr)/>
				</#if>
				<#if study.ResultsAndDiscussion.VapourPressureAt50CIfRelevantForClassificationOfGasUnderPressure?has_content>
					<para><emphasis role="bold">Vapour pressure at 50°C:</emphasis></para>
					<@keyPhyschem.vapourprAt50List studyandsummaryCom.orderByKeyResult(study.ResultsAndDiscussion.VapourPressureAt50CIfRelevantForClassificationOfGasUnderPressure)/>
				</#if>
				<#if study.ResultsAndDiscussion.Transition?has_content>
					<para><emphasis role="bold">Transition / decomposition:</emphasis></para>
					<@keyPhyschem.vapourTransitionList studyandsummaryCom.orderByKeyResult(study.ResultsAndDiscussion.Transition)/>
				</#if>
			<#elseif study.documentSubType=="HenrysLawConstant">
				<#if study.ResultsAndDiscussion.HenrysLawConstantH?has_content>
					<para><emphasis role="bold">Henry's Law Constant H:</emphasis></para>
					<@keyPhyschem.henrysLawConstantHList studyandsummaryCom.orderByKeyResult(study.ResultsAndDiscussion.HenrysLawConstantH)/>
				</#if>
			<#elseif study.documentSubType=="GeneralInformation">
				<#if study.ResultsAndDiscussion.SubstancePhysicalState?has_content>
					<para><emphasis role="bold">Physical state at 20°C and 1013 hPa:</emphasis></para>
					<para role="indent"><@com.picklist study.ResultsAndDiscussion.SubstancePhysicalState/></para>
				</#if>
				<#if study.ResultsAndDiscussion.SubstanceType?has_content>
					<para><emphasis role="bold">Substance type:</emphasis></para>
					<para role="indent"><@com.picklist study.ResultsAndDiscussion.SubstanceType/></para>
				</#if>
				<#if study.ResultsAndDiscussion.FormBlock?has_content>
					<para><emphasis role="bold">Form / colour/ odour:</emphasis></para>
					<@keyPhyschem.appearanceList studyandsummaryCom.orderByKeyResult(study.ResultsAndDiscussion.FormBlock)/>
				</#if>
			<#elseif study.documentSubType=="WaterSolubility">
				<#if study.ResultsAndDiscussion.WaterSolubility?has_content>
					<para><emphasis role="bold">Water solubility:</emphasis></para>
					<@keyPhyschem.waterSolubilityList studyandsummaryCom.orderByKeyResult(study.ResultsAndDiscussion.WaterSolubility)/>
				</#if>
				<#if study.ResultsAndDiscussion.SolubilityOfMetalIonsInAqueousMedia?has_content>
					<para><emphasis role="bold">Solubility of metal ions in aqueous media:</emphasis></para>
					<@keyPhyschem.solubilityMetalList studyandsummaryCom.orderByKeyResult(study.ResultsAndDiscussion.SolubilityOfMetalIonsInAqueousMedia)/>
				</#if>
				<#if study.ResultsAndDiscussion.DetailsOnResults?has_content>
					<para><emphasis role="bold">Details on results:</emphasis></para>
					<para role="indent"><@com.text study.ResultsAndDiscussion.DetailsOnResults/></para>
				</#if>
			<#elseif study.documentSubType=="SolubilityOrganic">
				<#if study.ResultsAndDiscussion.SolubilityOrganic?has_content>
					<para><emphasis role="bold">Solubility in organic solvents / fat solubility:</emphasis></para>
					<@keyPhyschem.solubilityOrganicList studyandsummaryCom.orderByKeyResult(study.ResultsAndDiscussion.SolubilityOrganic)/>
				</#if>
				<#if study.ResultsAndDiscussion.TestSubstanceTable?has_content>
					<para><emphasis role="bold">Test substance stable:</emphasis></para>
					<para role="indent"><@com.picklist study.ResultsAndDiscussion.TestSubstanceTable/></para>
				</#if>
				<#if study.ResultsAndDiscussion.DetailsOnResults?has_content>
					<para><emphasis role="bold">Details on results:</emphasis></para>
					<para role="indent"><@com.text study.ResultsAndDiscussion.DetailsOnResults/></para>
				</#if>
			<#elseif study.documentSubType=="Partition">
				<#if study.ResultsAndDiscussion.Partcoeff?has_content>
					<para><emphasis role="bold">Partition coefficient:</emphasis></para>
					<@keyPhyschem.partcoeffList studyandsummaryCom.orderByKeyResult(study.ResultsAndDiscussion.Partcoeff)/>
				</#if>
				<#if study.ResultsAndDiscussion.DetailsOnResults?has_content>
					<para><emphasis role="bold">Details on results:</emphasis></para>
					<para role="indent"><@com.text study.ResultsAndDiscussion.DetailsOnResults/></para>
				</#if>
			<#elseif study.documentSubType=="DissociationConstant">
				<#if study.ResultsAndDiscussion.DissociatingProperties?has_content>
					<para><emphasis role="bold">Dissociating properties:</emphasis></para>
					<para role="indent"><@com.picklist study.ResultsAndDiscussion.DissociatingProperties/></para>
				</#if>
				<#if study.ResultsAndDiscussion.DissociationConstant?has_content>
					<para><emphasis role="bold">Dissociation constant:</emphasis></para>
					<@keyPhyschem.dissociationConstantList studyandsummaryCom.orderByKeyResult(study.ResultsAndDiscussion.DissociationConstant)/>
				</#if>
			<#elseif study.documentSubType=="Flammability">
				<#if study.ResultsAndDiscussion.FlammableGasesLowerAndUpperExplosionLimit?has_content>
					<para><emphasis role="bold">Flammable gasses (lower and upper explosion limits):</emphasis></para>
					<@keyPhyschem.flammableGasesList studyandsummaryCom.orderByKeyResult(study.ResultsAndDiscussion.FlammableGasesLowerAndUpperExplosionLimit)/>
				</#if>
				<#if study.ResultsAndDiscussion.Aerosols?has_content>
					<para><emphasis role="bold">Aerosols:</emphasis></para>
					<@keyPhyschem.aerosolsList studyandsummaryCom.orderByKeyResult(study.ResultsAndDiscussion.Aerosols)/>
				</#if>
				<#if study.ResultsAndDiscussion.FlammableSolids?has_content>
					<para><emphasis role="bold">Flammable solids:</emphasis></para>
					<@keyPhyschem.flammableSolidsList studyandsummaryCom.orderByKeyResult(study.ResultsAndDiscussion.FlammableSolids)/>
				</#if>
				<#if study.ResultsAndDiscussion.PyrophoricSolids?has_content>
					<para><emphasis role="bold">Pyrophoric solids:</emphasis></para>
					<@keyPhyschem.pyrophoricSolidsList studyandsummaryCom.orderByKeyResult(study.ResultsAndDiscussion.PyrophoricSolids)/>
				</#if>
				<#if study.ResultsAndDiscussion.PyrophoricLiquids?has_content>
					<para><emphasis role="bold">Pyrophoric liquid:</emphasis></para>
					<@keyPhyschem.pyrophoricLiquidList studyandsummaryCom.orderByKeyResult(study.ResultsAndDiscussion.PyrophoricLiquids)/>
				</#if>
				<#if study.ResultsAndDiscussion.SelfHeatingSubstancesMixtures?has_content>
					<para><emphasis role="bold">Self-heating substances/mixtures:</emphasis></para>
					<@keyPhyschem.selfHeatingSubstancesMixturesList studyandsummaryCom.orderByKeyResult(study.ResultsAndDiscussion.SelfHeatingSubstancesMixtures)/>
				</#if>
				<#if study.ResultsAndDiscussion.SubstancesMixturesWhichInContactWithWaterEmitFlammableGases?has_content>
					<para><emphasis role="bold">Substances/ mixture which in contact with water emit flammable gases:</emphasis></para>
					<@keyPhyschem.substancesMixturesWithWaterEmitFlammableGasesList studyandsummaryCom.orderByKeyResult(study.ResultsAndDiscussion.SubstancesMixturesWhichInContactWithWaterEmitFlammableGases)/>
				</#if>
			<#elseif study.documentSubType=="AutoFlammability">
				<#if study.ResultsAndDiscussion.AutoFlammability?has_content>
					<para><emphasis role="bold">Auto-ignition temperature (liquids / gases):</emphasis></para>
					<@keyPhyschem.autoFlammabilityList studyandsummaryCom.orderByKeyResult(study.ResultsAndDiscussion.AutoFlammability)/>
				</#if>
				<#if study.ResultsAndDiscussion.RelativeSelfIgnitionTemperatureSolids?has_content>
					<para><emphasis role="bold">Relative self-ignition temperature (solids):</emphasis></para>
					<@keyPhyschem.relativeSelfIgnitionTemperatureSolidsList studyandsummaryCom.orderByKeyResult(study.ResultsAndDiscussion.RelativeSelfIgnitionTemperatureSolids)/>
				</#if>
				<#if study.ResultsAndDiscussion.SelfIgnitionTemperatureOfDustAccumulation?has_content>
					<para><emphasis role="bold">Self-ignition temperature of dust accumulation:</emphasis></para>
					<@keyPhyschem.selfIgnitionTemperatureOfDustAccumulationList studyandsummaryCom.orderByKeyResult(study.ResultsAndDiscussion.SelfIgnitionTemperatureOfDustAccumulation)/>
				</#if>
			<#elseif study.documentSubType=="FlashPoint">
				<#if study.ResultsAndDiscussion.FlashPoint?has_content>
					<para><emphasis role="bold">Flash point:</emphasis></para>
					<@keyPhyschem.flashPointList studyandsummaryCom.orderByKeyResult(study.ResultsAndDiscussion.FlashPoint)/>
				</#if>
				<#if study.ResultsAndDiscussion.SustainingCombustibility?has_content>
					<para><emphasis role="bold">Sustaining combustibility:</emphasis></para>
					<@keyPhyschem.sustainingCombustabilityList studyandsummaryCom.orderByKeyResult(study.ResultsAndDiscussion.SustainingCombustibility)/>
				</#if>
			<#elseif study.documentSubType=='Explosiveness'>
				<#if study.ResultsAndDiscussion.SmallScalePreliminaryTests?has_content>
					<para><emphasis role="bold">Small-scale preliminary tests:</emphasis></para>
					<@keyPhyschem.smallScalePrelimTestsList studyandsummaryCom.orderByKeyResult(study.ResultsAndDiscussion.SmallScalePreliminaryTests)/>
				</#if>
				<#if study.ResultsAndDiscussion.ResultsOfTestSeriesForExplosives?has_content>
					<para><emphasis role="bold">All Test series for explosives:</emphasis></para>
					<#-- NOTE: i would change the way data display e.g. changing Test series for explosives by the actual test series-->
					<@keyPhyschem.resultsOfTestSeriesExplosivesList studyandsummaryCom.orderByKeyResult(study.ResultsAndDiscussion.ResultsOfTestSeriesForExplosives)/>
				</#if>
			<#elseif study.documentSubType=='SurfaceTension'>
				<#if study.ResultsAndDiscussion.SurfaceTension?has_content>
					<para><emphasis role="bold">SurfaceTension:</emphasis></para>
					<@keyPhyschem.surfaceTensionList studyandsummaryCom.orderByKeyResult(study.ResultsAndDiscussion.SurfaceTension)/>
				</#if>
			<#elseif study.documentSubType=="OxidisingProperties">
				<#if study.ResultsAndDiscussion.TestResultOxidisingGases?has_content>
					<para><emphasis role="bold">Oxidising gases:</emphasis></para>
					<@keyPhyschem.oxidisingGasesList studyandsummaryCom.orderByKeyResult(study.ResultsAndDiscussion.TestResultOxidisingGases)/>
				</#if>
				<#if study.ResultsAndDiscussion.TestResultsOxidisingLiquids?has_content>
					<para><emphasis role="bold">Oxidising liquids:</emphasis></para>
					<@keyPhyschem.oxidisingLiquidsList studyandsummaryCom.orderByKeyResult(study.ResultsAndDiscussion.TestResultsOxidisingLiquids)/>
				</#if>
				<#if study.ResultsAndDiscussion.TestResultsOxidisingSolids?has_content>
					<para><emphasis role="bold">Oxidising solids:</emphasis></para>
					<@keyPhyschem.oxidisingSolidsList studyandsummaryCom.orderByKeyResult(study.ResultsAndDiscussion.TestResultsOxidisingSolids)/>
				</#if>
			<#elseif study.documentSubType=="Ph">
				<#if study.ResultsAndDiscussion.phValue?has_content>
					<para><emphasis role="bold">pH:</emphasis></para>
					<@keyPhyschem.phList studyandsummaryCom.orderByKeyResult(study.ResultsAndDiscussion.phValue)/>
				</#if>
				<#if study.ResultsAndDiscussion.AcidityOrAlkalinity?has_content>
					<para><emphasis role="bold">Acidity / alkalinity:</emphasis></para>
					<@keyPhyschem.acidityList studyandsummaryCom.orderByKeyResult(study.ResultsAndDiscussion.AcidityOrAlkalinity)/>
				</#if>
			<#elseif study.documentSubType=="Density">
				<#if study.ResultsAndDiscussion.Density?has_content>
					<para><emphasis role="bold">Density:</emphasis></para>
					<@keyPhyschem.densityList studyandsummaryCom.orderByKeyResult(study.ResultsAndDiscussion.Density)/>
				</#if>
			<#elseif study.documentSubType=="StorageStability">
				<#if study.ResultsAndDiscussion.Results?has_content>
					<para><@com.text study.ResultsAndDiscussion.Results/></para>
				</#if>
				<#if study.ResultsAndDiscussion.TransformationProducts?has_content || study.ResultsAndDiscussion.IdentityTransformation?has_content>
					<para><emphasis role="bold">Transformation products: </emphasis><@com.picklist study.ResultsAndDiscussion.TransformationProducts/><?linebreak?>
						<@keyPhyschem.transformationList studyandsummaryCom.orderByKeyResult(study.ResultsAndDiscussion.IdentityTransformation)/>
					</para>
				</#if>
				<#if study.ResultsAndDiscussion.ContainerMaterial?has_content>
					<para><emphasis role="bold">Reactivity towards container material:</emphasis></para>
					<@com.picklistMultiple study.ResultsAndDiscussion.ContainerMaterial/>
				</#if>

			<#elseif study.documentSubType=="StabilityThermal">
				<#if study.ResultsAndDiscussion.ThermalStability.TestSubstanceThermallyStable?has_content || study.ResultsAndDiscussion.ThermalStability.OperatingTemperature?has_content ||
						study.ResultsAndDiscussion.ThermalStability.Sublimation?has_content || study.ResultsAndDiscussion.ThermalStability.TransformationProducts?has_content || study.ResultsAndDiscussion.ThermalStability.IdentityTransformation?has_content >
					<para><emphasis role="HEAD-WoutNo">Thermal stability:</emphasis></para>
					<#if study.ResultsAndDiscussion.ThermalStability.TestSubstanceThermallyStable?has_content>
						<para>Test substance thermally stable: <@com.picklist study.ResultsAndDiscussion.ThermalStability.TestSubstanceThermallyStable/></para>
					</#if>
					<#if study.ResultsAndDiscussion.ThermalStability.OperatingTemperature?has_content>
						<para><emphasis role="bold">Operating temperature: </emphasis>
							<@keyPhyschem.operatingTempList studyandsummaryCom.orderByKeyResult(study.ResultsAndDiscussion.ThermalStability.OperatingTemperature)/>
						</para>
					</#if>
					<#if study.ResultsAndDiscussion.ThermalStability.Sublimation?has_content>
						<para>Sublimation:<@com.picklist study.ResultsAndDiscussion.ThermalStability.Sublimation/></para>
					</#if>
					<#if study.ResultsAndDiscussion.ThermalStability.TransformationProducts?has_content || study.ResultsAndDiscussion.ThermalStability.IdentityTransformation?has_content>
						<para><emphasis role="bold">Transformation products: </emphasis><@com.picklist study.ResultsAndDiscussion.ThermalStability.TransformationProducts/><?linebreak?>
							<@keyPhyschem.transformationList studyandsummaryCom.orderByKeyResult(study.ResultsAndDiscussion.ThermalStability.IdentityTransformation)/>
						</para>
					</#if>
				</#if>
				<#if study.ResultsAndDiscussion.StudyOnStability.StableToSunlight?has_content>
					<para><emphasis role="HEAD-WoutNo">Stability to sunlight</emphasis></para>
					<para>Test substance stable to sunlight: <@com.picklist study.ResultsAndDiscussion.StudyOnStability.StableToSunlight/></para>
				</#if>
				<#if study.ResultsAndDiscussion.StabilityToMetals.StableToMetals?has_content>
					<para><emphasis role="HEAD-WoutNo">Stability to metals</emphasis></para>
					<para>Test substance stable to metals / metal ions: <@com.picklist study.ResultsAndDiscussion.StabilityToMetals.StableToMetals/></para>
				</#if>
			<#elseif study.documentSubType=="DegreeOfDissolutionAndDilutionStability">
				<#if study.ResultsAndDiscussion.DegreeOfDissolution?has_content>
					<para><emphasis role="bold">Degree of dissolution: </emphasis>
						<@keyPhyschem.degreeDissolutionList studyandsummaryCom.orderByKeyResult(study.ResultsAndDiscussion.DegreeOfDissolution)/>
					</para>
				</#if>
				<#if study.ResultsAndDiscussion.DilutionStability?has_content || study.ResultsAndDiscussion.DilutionStabilityMT41?has_content>
					<para><emphasis role="bold">Dilution stability: </emphasis>
						<@keyPhyschem.dilutionStabilityList studyandsummaryCom.orderByKeyResult(study.ResultsAndDiscussion.DilutionStabilityMT41)/>
						<@keyPhyschem.dilutionStability2List studyandsummaryCom.orderByKeyResult(study.ResultsAndDiscussion.DilutionStability)/>
					</para>
				</#if>
				<#if study.ResultsAndDiscussion.DetailsOnResults?has_content>
					<para>Details:
						<@com.text study.ResultsAndDiscussion.DetailsOnResults/>
					</para>
				</#if>
			<#elseif study.documentSubType=="AdditionalPhysicoChemical">
				<#if study.ResultsAndDiscussion.Results?has_content>
					<para><@com.text study.ResultsAndDiscussion.Results/></para>
				</#if>

			<#elseif study.documentSubType=="EffectivenessAgainstTargetOrganisms">
				<#if study.ResultsAndDiscussion.DetailsOnResults?has_content>
					<para>Details:</para>
					<para role="indent"><@com.text study.ResultsAndDiscussion.DetailsOnResults/></para>
				</#if>

			<#--NOTE: this is for microorg, but at least in chemicals, it's used in ecotox-->
			<#elseif study.documentSubType=="ToxicityToOtherAboveGroundOrganisms" && keyBioPropMicro??>
				<#if study.ResultsAndDiscussion.EffectConcentrations?has_content>
					<para>Effect concentrations:
						<@keyBioPropMicro.effectList study.ResultsAndDiscussion.EffectConcentrations study/>
					</para>
				</#if>
				<#if study.ResultsAndDiscussion.ResultsDetails?has_content>
					<para>Details:
						<@com.text study.ResultsAndDiscussion.ResultsDetails/>
					</para>
				</#if>
				<#if study.ResultsAndDiscussion.ResultsRefSubstance?has_content>
					<para>Results with reference substance:
						<@com.text study.ResultsAndDiscussion.ResultsRefSubstance/>
					</para>
				</#if>
				<#if study.ResultsAndDiscussion.Statistics?has_content>
					<para>Statistics:
						<@com.text study.ResultsAndDiscussion.Statistics/>
					</para>
				</#if>

			<#--5. Tox-->
			<#elseif study.documentSubType=="BasicToxicokinetics">
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

			<#elseif study.documentSubType=="CellCultureStudy">
				<@keyTox.results_cellCulture study/>

			<#elseif study.documentSubType=="IntermediateEffects">
				<@keyTox.results_intermediateEffects study/>

			<#--8. Ecotox-->
			<#elseif study.documentSubType=="ToxicityToBirds">
				<#--NOTE: probably could be merged with next-->
				<@keyEcotox.results_toxicityToBirds study/>

			<#elseif study.documentSubType=="ToxicityToOtherAboveGroundOrganisms" || study.documentSubType=="ShortTermToxicityToFish" ||
						study.documentSubType=="LongTermToxToFish" || study.documentSubType=="EndocrineDisrupterTestingInAqua" ||
						study.documentSubType=="ShortTermToxicityToAquaInv" || study.documentSubType=="LongTermToxicityToAquaInv"||
						study.documentSubType=="SedimentToxicity" || study.documentSubType=="ToxicityToAquaticAlgae" ||
						study.documentSubType=="ToxicityToAquaticPlant" || study.documentSubType=="ToxicityToTerrestrialArthropods" ||
						study.documentSubType=="ToxicityToSoilMacroorganismsExceptArthropods" ||
						study.documentSubType=="ToxicityToSoilMicroorganisms" || study.documentSubType=="ToxicityToTerrestrialPlants" ||
						study.documentSubType=="ToxicityToMicroorganisms">
				<@keyEcotox.results_envToxicity study/>

			<#elseif study.documentSubType=="BioaccumulationAquaticSediment" || study.documentSubType=="BioaccumulationTerrestrial">
				<@keyEcotox.results_bioaccumulation study/>

			<#-- 6. Residues-->

			<#elseif study.documentSubType=="StabilityOfResiduesInStoredCommod">
				<@keyRes.results_stabilityOfResiduesInStoredCommod study/>

			<#elseif study.documentSubType=="ResiduesInLivestock">
				<@keyRes.results_residuesInLivestock study/>

			<#elseif study.documentSubType=="NatureResiduesInProcessedCommod">
				<@keyRes.results_natureResiduesInProcessedCommod study/>

			<#elseif study.documentSubType=="MigrationOfResidues">
				<@keyRes.results_migrationOfResidues study/>

			<#elseif study.documentSubType=="AdditionalInfoOnResiduesInFood" || study.documentSubType=="ExpectedExposureAndProposedAcceptableResidues">
				<#if study.ResultsAndDiscussion.DetailsOnResults?has_content>
					<para>Details:</para>
					<para role="indent"><@com.text study.ResultsAndDiscussion.DetailsOnResults/></para>
				</#if>

			<#elseif study.documentSubType=="ResiduesInRotationalCrops">
				<@keyRes.results_residuesInRotationalCrops study/>
			<#--				<para role="indent">[Excel]</para>-->

			<#elseif study.documentSubType=="MagnitudeResidInProcessedComm">
				<@keyRes.results_magnitudeResidInProcessedComm study/>
			<#--				<para role="indent">[Excel]</para>-->

			<#elseif study.documentSubType=="MetabolismInCrops" || study.documentSubType=="MetabolismInLivestock">
				<@com.emptyLine/>
				<para role="indent">[Add here the result tables obtained with the render tool of MSS Composer]</para>

			<#-- NOTE: "ResiduesProcessedCommodities" no specific results	-->

			<#--Analytical methods-->
			<#elseif study.documentSubType=="AnalyticalMethods">
				<@keyAnMeth.results_analyticalMethods study/>

			<#--FATE-->
			<#elseif study.documentSubType=="BiodegradationInSoil">
				<@keyFate.results_biodegradationInSoil study/>
<#--				NOTE: maybe could be combined with the other biodegradations-->

			<#elseif study.documentSubType=="PhotoTransformationInSoil" || study.documentSubType=="Phototransformation" ||
						study.documentSubType=="PhototransformationInAir">
				<@keyFate.results_phototransformation study/>

			<#elseif study.documentSubType=="AdsorptionDesorption">
				<@keyFate.results_adsorptionDesorption study/>

			<#elseif study.documentSubType=="Hydrolysis">
				<@keyFate.results_hydrolysis study/>

			<#elseif study.documentSubType=="BiodegradationInWaterScreeningTests">
				<@keyFate.results_biodegradationWaterScreening study/>

			<#elseif study.documentSubType=="BiodegradationInWaterAndSedimentSimulationTests">
				<@keyFate.results_biodegradationWaterSedimentSimulation study/>

			<#elseif study.documentSubType=="MonitoringData">
				<@keyFate.results_monitoring study/>

			<#--Efficacy-->
			<#elseif study.documentSubType=="EfficacyData">
				<@keyEfficacy.results_efficacyData study/>
			</#if>

<#--			Without specific results: "FieldStudies", "AgedSorption", "OtherDistributionData", "TransportViaAir",
				"AdditionalInformationOnEnvironmentalFateAndBehaviour"-->

			<#--2. Other information including tables
			 NOTE: in some cases ("technical characteristics" at least) the path of results is different (probably by error)-->
			<#if study.hasElement("ResultsAndDiscussion")><#local resultsPath=study.ResultsAndDiscussion/>
			<#elseif study.hasElement("ResultsAndDiscussions")><#local resultsPath=study.ResultsAndDiscussions/>
			</#if>

			<#-- OtherInformation is the most common field but there might be others -->
			<#if resultsPath.hasElement("AnyOtherInformationOnResultsInclTables")>
				<#assign excludeResultsOtherInfo=["MetabolismInCrops","MetabolismInLivestock"]/>
				<#if resultsPath.AnyOtherInformationOnResultsInclTables.hasElement("OtherInformation") &&
						resultsPath.AnyOtherInformationOnResultsInclTables.OtherInformation?has_content &&
						!(excludeResultsOtherInfo?seq_contains(study.documentSubType))>
					<para><emphasis role="bold">Other information</emphasis></para>
					<para role="indent"><@com.richText resultsPath.AnyOtherInformationOnResultsInclTables.OtherInformation/></para>
				<#--Special case for acute fish toxicity-->
				<#elseif resultsPath.AnyOtherInformationOnResultsInclTables.hasElement("SublethalObservationsClinicalSigns") &&
						resultsPath.AnyOtherInformationOnResultsInclTables.SublethalObservationsClinicalSigns?has_content>
					<para><emphasis role="bold">Other information</emphasis></para>
					<para role="indent"><@com.richText resultsPath.AnyOtherInformationOnResultsInclTables.SublethalObservationsClinicalSigns/></para>
				</#if>
			</#if>

			<#-- Iterate over all other HTML fields if any -->
			<#list resultsPath?children as child>
				<#if child?node_type?contains("html") && child?node_name!="OtherInformation" && child?has_content>
					<#assign childName=child?node_name?replace("([A-Z]{1})", " $1", "r")?lower_case?cap_first/>
					<para>${childName}:</para>
					<para role="indent"><@com.richText child/></para>
				</#if>
			</#list>

			<#--3. Remarks on results-->
			<#if study.OverallRemarksAttachments.RemarksOnResults?has_content>
				<para><emphasis role="bold">Overall remarks:</emphasis></para>
				<para role="indent"><@com.richText study.OverallRemarksAttachments.RemarksOnResults/></para>
			</#if>

	</#compress>
</#macro>

<#--Functions-->
<#function filterStudyListbyContext myStudyList context>

	<#if myStudyList?has_content && context?has_content>

		<#local filtStudyList = [] />

		<#--Loop over studies-->
		<#list myStudyList as study>

			<#-- Flag to set number of conditions met-->
			<#local nbCondMet=0/>

			<#--Loop over conditions-->
			<#list context as ctxt>

				<#local contextPath = "study." + ctxt["path"] />
				<#local contextVal = contextPath?eval/>

			<#--				<#if contextVal?has_content>-->


				<#-- Convert value depending on type -->
				<#if ctxt["type"]=="picklistMultiple">

					<#local contextVal2>
						<#compress>
							<#list contextVal as ctxtVal>
<#--								<@picklistNoRemarks ctxtVal/><#if ctxt_has_next>;</#if>-->
								<@com.picklist picklistValue=ctxtVal locale="en" printOtherPhrase=false printDescription=false printRemarks=false /><#if ctxt_has_next>;</#if>

							</#list>
						</#compress>
					<#--                            <@com.picklistMultiple contextVal/>-->
					</#local>

				<#elseif ctxt["type"]=="picklist">

					<#-- get the value of the picklist without remarks!!-->
					<#local contextVal2>
<#--						<@picklistNoRemarks contextVal/>-->
						<@com.picklist picklistValue=contextVal locale="en" printOtherPhrase=false printDescription=false printRemarks=false />
					</#local>
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
			<#--				</#if>-->
			</#list>

		<#--Check if all conditions met and add study-->
			<#if nbCondMet==context?size>
				<#local filtStudyList = filtStudyList + [study] />
			</#if>
		</#list>
		<#return filtStudyList/>
	<#else>
<#--		<#local filtStudyList = myStudyList/>-->
		<#return myStudyList/>
	</#if>
</#function>

<!--
	Function to filter a study list by specific section numbers, provided a global variable being a hashmap mapping
	documents to sections.
	- studyList: list of study objects
	- section: string or list of strings indicating selected section numbers e.g. "5.1.1".
		NOTE: retrieval of the section is based on strict string matching at the beginning of a section numbering
			e.g. "5.1" would be matched by "5.1", "5.1.1", "5.1.2.1"..., but not by "4.5.1")
	- doc2sect: nested hashmap with document uuids as keys e.g.
		{'uuid1':{'name': X, 'endpoint': Y, 'section': [{'name': a, 'nb': b}, {'name': a2, 'nb': b2}, ..] }}
		NOTE: now it's by default the one used for analytical methods - not even passed as argument
-->
<#function filterStudyListbySection studyList section doc2sect>

	<#if studyList?has_content && section?has_content>

		<#local secStudyList = [] />

		<#if !(section?is_sequence)>
			<#local section=[section]/>
		</#if>

		<#list studyList as study>
			<#if _doc2SectHashMap?keys?seq_contains(study.documentKey.uuid)>
				<#local doc = _doc2SectHashMap[study.documentKey.uuid]/>
				<#local docSection = doc["section"]/>
			<#--				<#if docSection?has_content>-->

				<#local docMainSection = docSection?sort_by("nb")[0]/>
				<#local docMainSectionNb = docMainSection["nb"]/>

				<#list section as sect>
					<#if docMainSectionNb?starts_with(sect)>
						<#local secStudyList  = secStudyList + [study]/>
						<#break>
					</#if>
				</#list>
			<#else>
				<#if section?seq_contains("NA")>
					<#local secStudyList  = secStudyList + [study]/>
				</#if>
			</#if>
		</#list>

		<#return secStudyList/>
	<#else>
		<#return studyList/>
	</#if>
</#function>

<#macro metabolitesStudies metabList=[] mixture="" activeSubstance="" studySubTypes=[] studyContext="" studyName="" summarySubTypes=[] summaryMacroCall="keyTox.summarySingle">
	<#compress>

		<#if (!metabList?has_content) && mixture?has_content>
			<#if activeSubstance?has_content>
				<#local metabList=com.getMetabolites(mixture, activeSubstance, true)/>
			<#else>
				<#local metabList=com.getMetabolites(mixture)/>
			</#if>
		</#if>

		<#-- iterate over the list of metabolites and get all  studies-->
		<#if metabList?has_content>
			<@com.emptyLine/>
			<para>${metabList?size} metabolite dataset<#if metabList?size gt 1>s are<#else> is</#if> present <#if activeSubstance?has_content>for ${activeSubstance.ChemicalName}</#if>:
				<#if metabList?size gt 1>
					<#list metabList as metab>
						<para role="indent">
							- <command linkend="${metab.documentKey.uuid!}">${metab.ChemicalName}</command>
						</para>
					</#list>
				<#else>
					<command linkend="${metabList[0].documentKey.uuid!}">${metabList[0].ChemicalName}</command>
				</#if>
			</para>

			<@com.emptyLine/>

			<#list metabList as metab>

			<sect3 xml:id="${metab.documentKey.uuid!}" label="-${metab_index+1}">
				<title role="HEAD-3">Metabolite ${metab.ChemicalName}</title>
<#--				<para xml:id="${metab.documentKey.uuid!}" role="HEAD-5">-->
<#--					<para><emphasis role="underline">----- Metabolite <emphasis role="bold">${metab.ChemicalName}</emphasis> -----</emphasis></para>-->
<#--				</para>-->

				<#--Get all summaries-->
				<#if summaryMacroCall?has_content>
					<#local summaryFirst=true/>
					<#list summarySubTypes as summarySubType>

						<#local summaryCallString = "<@" + summaryMacroCall + " metab  summarySubType 'table' false/>"/>
						<#local summaryCall=summaryCallString?interpret/>
						<#local summary><@summaryCall/></#local>

						<#if summary?has_content>
							<#if summaryFirst>
								<#local summaryFirst=false/>
								<@com.emptyLine/>
								<para><emphasis role="HEAD-WoutNo">Summaries</emphasis></para>
								<para>Summaries for studies on metabolite ${metab.ChemicalName} are provided below:</para>
							</#if>
							<#local summaryDocFullName=summarySubType?replace("_EU_PPP", "")?replace("([A-Z]{1})", " $1", "r")?lower_case?cap_first/>
							<#if (summarySubTypes?size > 1)>
								${summary?replace('<para><emphasis role="HEAD-WoutNo">Summary</emphasis></para>',
								'<para>-- for <emphasis role="HEAD-WoutNo">${summaryDocFullName}</emphasis>:</para>')}
							<#else>
								${summary?replace('<para><emphasis role="HEAD-WoutNo">Summary</emphasis></para>', '')}
							</#if>
						</#if>
						<#if !summaryFirst && summarySubType_index==(summarySubTypes?size-1)>
							<@com.emptyLine/>
						</#if>
					</#list>
				</#if>

				<#--Get all studies-->
				<@com.emptyLine/>
				<@keyAppendixE.appendixEstudies subject=metab
					docSubTypes=studySubTypes context=studyContext name="Toxicity studies of metabolite ${metab.ChemicalName}"
					includeMetabolites=false/>
			</sect3>
			</#list>
		</#if>
	</#compress>
</#macro>

<#-- Function to create a hash of studies for results and data waivers for all entities
		Structure of the hash:
		hash= {'st':{'name_of_entity1':[list of studies], 'name_of_entity2':[list of studies]..},
				'dw': {'name_of_entity1':[list of data waivers], 'name_of_entity2':[list of data waivers]..}
-->
<#function createStudyHash entities docSubTypes="" context="" section="">

	<#local studyHash_st={}/>
	<#local studyHash_dw={}/>

	<#list entities as entity>

		<#local entityName=getEntityName(entity)/>

		<#-- filter by type, context and section (only for analytical methods)-->
		<#local studyList = getStudyListByType(entity, docSubTypes)/>
		<#local studyList = filterStudyListbyContext(studyList, context)/>
        <#if _doc2SectHashMap??>
		    <#local studyList = filterStudyListbySection(studyList, section, _doc2SectHashMap)/>
        </#if>
		<#local resultStudyList=getResultStudies(studyList)/>
		<#if resultStudyList?has_content>
<#--			<#local studyHash_st = studyHash_st + {entityName:resultStudyList}/>-->
			<#local studyHash_st = studyHash_st + {entityName:{'entity':entity, 'records': resultStudyList}}/>
		</#if>

		<#local dataWaivingStudyList=getDataWaivings(studyList)/>
		<#if dataWaivingStudyList?has_content>
<#--			<#local studyHash_dw = studyHash_dw + {entityName:dataWaivingStudyList}/>-->
			<#local studyHash_dw = studyHash_dw + {entityName:{'entity':entity, 'records': dataWaivingStudyList}}/>
		</#if>

	</#list>

	<#local studyHash = {'st':studyHash_st, 'dw':studyHash_dw}/>

	<#return studyHash/>
</#function>

<#function getStudyListByType entity docSubTypes="">

	<#local allStudyList=[]/>

	<#local allStudyList=[]/>
	<#list docSubTypes as docSubType>
		<#if docSubType=="IntermediateEffects">
			<#local studyList = iuclid.getSectionDocumentsForParentKey(entity.documentKey, "FLEXIBLE_RECORD", "IntermediateEffects") />
		<#else>
			<#local studyList = iuclid.getSectionDocumentsForParentKey(entity.documentKey, "ENDPOINT_STUDY_RECORD", docSubType) />
		</#if>
		<#local allStudyList = allStudyList + studyList/>
	</#list>

	<#return allStudyList/>
</#function>

<#function getEntityName entity>
	<#local entityName>
		<#compress>
			<#if entity.hasElement("ChemicalName")>
				<@com.text entity.ChemicalName/>
			<#elseif entity.hasElement("MixtureName")>
				<@com.text entity.MixtureName/>
			</#if>
		</#compress>
	</#local>
	<#return entityName>
</#function>

<#function getRequirementName name docSubTypes>

	<#if name=="">
		<#local name>
			<#compress>
				<#list docSubTypes as docSubType>
					${docSubType?replace("([A-Z]{1})", " $1", "r")?lower_case}<#if docSubType_has_next>, </#if>
				</#list>
			</#compress>
		</#local>
	</#if>

	<#return name>
</#function>

<#function getStudyReference study>

<#--	<#local reference=""/>-->
	<#local referenceList=[]/>
	<#local referenceLinksList=study.DataSource.Reference/>
	<#if referenceLinksList?has_content>
		<#list referenceLinksList as referenceLink>
			<#local referenceEntry = iuclid.getDocumentForKey(referenceLink)/>
			<#local referenceList = referenceList + [referenceEntry]/>
		</#list>
	</#if>

	<#if referenceList?has_content && (referenceList?size > 1)>
			<#local referenceList = iuclid.sortByField(referenceList,
				"GeneralInfo.LiteratureType", ["study report", "publication","review article or handbook", "other company data", "other:"]) />
	</#if>
<#--		<#local reference=referenceList[0]/>-->
<#--	<#if referenceLinksList?has_content>-->
<#--		<#list referenceLinksList as referenceLink>-->
<#--			<#local referenceEntry = iuclid.getDocumentForKey(referenceLink)/>-->
<#--			<#local litType><@com.picklist referenceEntry.GeneralInfo.LiteratureType/></#local>-->
<#--			<#if litType=="study report">-->
<#--				<#local reference=referenceEntry/>-->
<#--				<#break>-->
<#--			</#if>-->
<#--		</#list>-->
<#--	</#if>-->

	<#return referenceList>
</#function>

<#--Function to extract elements for a reference list-->
<#function getReferenceElement referenceList element type='text'>
	<#local referenceElement="">

	<#if referenceList?has_content>
		<#list referenceList as reference>
			<#local refElementPath = "reference." + element/>
			<#local refElement = refElementPath?eval/>
			<#local refElement><#if (referenceList?size>1)>(${reference_index+1})</#if>
				<#if type=="text"><#if element?contains("ReferenceYear")><@com.number refElement/><#else><@com.text refElement/></#if> <#elseif type=="picklist"><@com.picklist refElement/> </#if>
			</#local>
			<#local referenceElement = referenceElement + refElement/>
		</#list>
	</#if>
	<#return referenceElement/>
</#function>

<#function getNoSid referenceList>

	<#local NoSIds=[]/>
	<#-- Before IUCLID 6.6:-->
<#--	<#if reference?has_content>-->
<#--		-->
<#--		<#if reference?is_sequence>-->
<#--			<#local reference=reference[0]/>-->
<#--		</#if>-->

<#--		<#if reference.GeneralInfo.StudyIdentifiers?has_content>-->
<#--			<#list reference.GeneralInfo.StudyIdentifiers as studyId>-->
<#--				<#if studyId.Remarks?matches(".*NOTIF.*STUD.*", "i") || studyId.Remarks?matches(".*NOS.*", "i")>-->
<#--					<#if studyId.StudyID?has_content>-->
<#--						<#local NoSId = studyId.StudyID/>-->
<#--					<#else>-->
<#--						<#local NoSId>NA - justification: <@com.text studyId.Remarks/></#local>-->
<#--					</#if>-->

<#--					<#return NoSId>-->
<#--				</#if>-->
<#--			</#list>-->
<#--		</#if>-->
<#--	</#if>-->

	<#if !referenceList?is_sequence>
		<#local referenceList = [referenceList]/>
	</#if>

	<#list referenceList as reference>

		<#if reference.GeneralInfo.StudyIdentifiers?has_content>

			<#list reference.GeneralInfo.StudyIdentifiers as studyId>

				<#local idType><@com.picklist studyId.StudyIDType/></#local>

				<#if idType=="Notification of Studies (NoS) ID">

					<#local remark><@com.text studyId.Remarks/></#local>
					<#local NoSId><@com.text studyId.StudyID/></#local>
<#--					<#if studyId.StudyID?has_content>-->
					<#if NoSId?has_content>
<#--						<#local NoSId><@com.text studyId.StudyID/></#local>-->
						<#if remark?has_content>
							<#local NoSId = NoSId + ' (' + remark + ')'/>
						</#if>
						<#if !NoSIds?seq_contains(NoSId)>
							<#local NoSIds = NoSIds + [NoSId]/>
						</#if>
					<#elseif remark?has_content>
						<#local NoSIds = NoSIds + [remark]/>
					</#if>
				</#if>
			</#list>
		</#if>
	</#list>

	<#if NoSIds?has_content>
		<#return NoSIds?join("; ")/>
	<#else>
		<#return "">
	</#if>

</#function>

<#--Function deprecated: used as a workaround to correct URLs in previous versions-->
<#function getDocUrl study entity>
	<#local docUrl=iuclid.webUrl.documentView(study.documentKey) />
	<#local datasetId = entity.documentKey?replace("\\/.*$", "", "r")/>
	<#local datasetEntity = entity.documentType/>
	<#local docUrl = docUrl?replace("\\?goto", "\\/raw\\/${datasetEntity}\\/${datasetId}\\?content_uri", "r")/>

	<#local docUrl = docUrl?replace("\\%3A\\%2F[a-z0-9\\-]*\\%2F", "\\:\\%2F0%2F", "r")/>
	<#return docUrl>
</#function>

<#function getChangeLogStatus study entity>
	<#local changeLogFlag="no"/>

	<#local changeLogStatusList=[]/>

	<#local changeLogs = iuclid.getSectionDocumentsForParentKey(entity.documentKey, "FLEXIBLE_RECORD", "ChangeLog") />
	<#list changeLogs as changeLog>
		<#list changeLog.ChangeLog.ChangeLogEntries as changeLogEntry>
			<#local changeLogDoc=iuclid.getDocumentForKey(changeLogEntry.LinkToDocument)/>

			<#if changeLogDoc?has_content>
				<#if study.documentKey.uuid==changeLogDoc.documentKey.uuid>
					<#local changeLogStatus><@com.picklist changeLogEntry.Status/></#local>
					<#if changeLogStatus?has_content>
						<#if !(changeLogStatus?starts_with("new"))>
							<#local changeLogFlag="yes"/>
						</#if>
						<#local changeLogStatusList = changeLogStatusList + [changeLogStatus]/>
					</#if>
				</#if>
			</#if>
		</#list>
	</#list>

	<#local changeLogStatusMessage>${changeLogFlag}<#if changeLogStatusList?has_content> (${changeLogStatusList?join(", ")})</#if></#local>

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

<#-- Copied macro from common_modules: to separate documents into three lists: 'study results', 'data waiving', 'testing proposal'-->
<#-- DEPRECATED -->
<#macro populateResultAndDataWaivingAndTestingProposalStudyLists studyList>
	<#assign resultStudyList = [] />
	<#assign dataWaivingStudyList = [] />
	<#assign testingProposalStudyList = [] />
	<#if studyList?has_content>
		<#list studyList as study>
<#--			<#if isTestingProposalStudy(study)>-->
<#--				<#assign testingProposalStudyList = testingProposalStudyList + [study] />-->
			<#if isDataWaivingStudy(study)>
				<#assign dataWaivingStudyList = dataWaivingStudyList + [study] />
<#--			<#elseif isRelevantAdequacyOfStudy(study)>-->
            <#else>
				<#assign resultStudyList = resultStudyList + [study] />
			</#if>
		</#list>
	</#if>

	<#-- sort resultStudyList according to PurposeFlag -->
	<#assign resultStudyList = iuclid.sortByField(resultStudyList, "AdministrativeData.PurposeFlag", ["key study","supporting study","weight of evidence","disregarded due to major methodological deficiencies","other information"]) />

	<#-- sort resultStudyList by Endpoint (is there a function to do this?) -->
	<#assign resultStudyList = sortByEndpoint(resultStudyList)/>
</#macro>

<#function getResultStudies studyList>
	<#local resultStudyList=[]/>
	<#if studyList?has_content>
		<#list studyList as study>
			<#if !isDataWaivingStudy(study)>
				<#local resultStudyList = resultStudyList + [study] />
			</#if>
		</#list>
	</#if>
	<#return resultStudyList/>
</#function>

<#function getDataWaivings studyList>
	<#local dataWaivingStudyList=[]/>
	<#if studyList?has_content>
		<#list studyList as study>
			<#if isDataWaivingStudy(study)>
				<#local dataWaivingStudyList = dataWaivingStudyList + [study] />
			</#if>
	</#list>
	</#if>
	<#return dataWaivingStudyList/>
</#function>

<#function isRelevantAdequacyOfStudy study>
	<#if !(study?has_content)>
		<#return false>
	</#if>
	<#local PurposeFlag = study.AdministrativeData.PurposeFlag />
    <#return PurposeFlag?has_content && !com.picklistValueMatchesPhrases(PurposeFlag, ["other information"]) />
</#function>

<#function isDataWaivingStudy study>
	<#if !(study?has_content) || !(study.hasElement("AdministrativeData.DataWaiving"))>
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
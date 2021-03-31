<!-- Macros and functions for EU PPP reports, including appendix E format -->

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
<#--		<@com.emptyLine/>-->

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

		<@com.emptyLine/>
	<#--		<para><emphasis role="bold">b) Assessment and conclusion by RMS:</emphasis></para>-->
	<#--		<itemizedlist><listitem>- Outcome and conclusion of the study: RMS should indicate if they agree to the results and conclusions of the APPL.</listitem></itemizedlist>-->
	</#compress>
</#macro>

<#macro appendixEmethods _subject study>

	<#--	Map type of document to document name, so that it's possible to select which methods macro to use-->
   	<#assign docCategoryMap={"tox_nonhuman":["BasicToxicokinetics", "AcuteToxicityOral", "AcuteToxicityDermal", "AcuteToxicityInhalation","SkinIrritationCorrosion","EyeIrritation","SkinSensitisation","PhototoxicityVitro",
								"AcuteToxicityOtherRoutes", "RepeatedDoseToxicityOral", "RepeatedDoseToxicityInhalation", "RepeatedDoseToxicityDermal", "RepeatedDoseToxicityOther", "GeneticToxicityVitro", "GeneticToxicityVivo",
								"Carcinogenicity", "ToxicityReproduction", "ToxicityReproductionOther", "DevelopmentalToxicityTeratogenicity", "Neurotoxicity", "Immunotoxicity", "ToxicEffectsLivestock","EndocrineDisrupterMammalianScreening",
								"AdditionalToxicologicalInformation", "DermalAbsorption"],
							"tox_human":["ExposureRelatedObservationsOther","SensitisationData","DirectObservationsClinicalCases","EpidemiologicalData","HealthSurveillanceData"],
							"physchem":["Melting", "BoilingPoint", "Vapour", "HenrysLawConstant", "GeneralInformation", "WaterSolubility", "SolubilityOrganic", "Partition", "DissociationConstant",
											"Flammability", "AutoFlammability", "FlashPoint", "Explosiveness", "SurfaceTension", "OxidisingProperties", "AdditionalPhysicoChemical", "Ph", "Viscosity",
											"Density", "StorageStability", "StabilityThermal", "TechnicalCharacteristics", "DegreeOfDissolutionAndDilutionStability", "PhysicalChemicalCompatibility"],
							"ecotox":["ToxicityToBirds", "ToxicityToOtherAboveGroundOrganisms", "ShortTermToxicityToFish", "LongTermToxToFish", "BioaccumulationAquaticSediment",
										"EndocrineDisrupterTestingInAqua", "ShortTermToxicityToAquaInv", "LongTermToxicityToAquaInv", "SedimentToxicity", "ToxicityToAquaticAlgae",
										"ToxicityToAquaticPlant", "AdditionalEcotoxicologicalInformation", "ToxicityToTerrestrialArthropods", "ToxicityToSoilMacroorganismsExceptArthropods",
										"BioaccumulationTerrestrial", "ToxicityToSoilMicroorganisms", "ToxicityToTerrestrialPlants", "ToxicityToMicroorganisms", "BiologicalEffectsMonitoring"]
	}/>


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
	<#list docCategoryMap?keys as methodkey>
		<#list docCategoryMap[methodkey] as methodDocSubType>
			<#if methodDocSubType==study.documentSubType>
				<#if methodkey=="tox_human">
					<@keyTox.humanStudyMethod study/>
				<#elseif methodkey=="tox_nonhuman">
					<@keyTox.nonHumanStudyMethod study/>
				<#elseif methodkey="ecotox">
					<@keyEcotox.ecotoxMethod study/>
				<#elseif methodkey=="physchem">
					<@physchemMethod study/>
				</#if>
			</#if>
		</#list>
	</#list>

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
					<para>Details:
						<@com.text study.ResultsAndDiscussion.DetailsOnResults/>
					</para>
				</#if>

			<#--NOTE: this is for microorg, but at least in chemicals, it's used in ecotox-->
<#--			<#elseif study.documentSubType=="ToxicityToOtherAboveGroundOrganisms" && keyBioPropMicro??>-->
<#--				<#if study.ResultsAndDiscussion.EffectConcentrations?has_content>-->
<#--					<para>Effect concentrations:-->
<#--						<@keyBioPropMicro.effectList study.ResultsAndDiscussion.EffectConcentrations study/>-->
<#--					</para>-->
<#--				</#if>-->
<#--				<#if study.ResultsAndDiscussion.ResultsDetails?has_content>-->
<#--					<para>Details:-->
<#--						<@com.text study.ResultsAndDiscussion.ResultsDetails/>-->
<#--					</para>-->
<#--				</#if>-->
<#--				<#if study.ResultsAndDiscussion.ResultsRefSubstance?has_content>-->
<#--					<para>Results with reference substance:-->
<#--						<@com.text study.ResultsAndDiscussion.ResultsRefSubstance/>-->
<#--					</para>-->
<#--				</#if>-->
<#--				<#if study.ResultsAndDiscussion.Statistics?has_content>-->
<#--					<para>Statistics:-->
<#--						<@com.text study.ResultsAndDiscussion.Statistics/>-->
<#--					</para>-->
<#--				</#if>-->

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
			</#if>

			<#--2. Other information including tables
			 NOTE: in some cases ("technical characteristics" at least) the path of results is different (probably by error)-->
			<#if study.hasElement("ResultsAndDiscussion")><#local resultsPath=study.ResultsAndDiscussion/>
			<#elseif study.hasElement("ResultsAndDiscussions")><#local resultsPath=study.ResultsAndDiscussions/>
			</#if>

			<#-- OtherInformation is the most common field but there might be others-->
			<#if resultsPath.AnyOtherInformationOnResultsInclTables.hasElement("OtherInformation") &&
					resultsPath.AnyOtherInformationOnResultsInclTables.OtherInformation?has_content>
				<para>
					Remarks: <@com.richText resultsPath.AnyOtherInformationOnResultsInclTables.OtherInformation/>
				</para>
			</#if>

			<#-- Iterate over all other fields if any -->
			<#list resultsPath?children as child>
				<#if child?node_type?contains("html") && child?node_name!="OtherInformation">
					<#assign childName=child?node_name?replace("([A-Z]{1})", " $1", "r")?lower_case?cap_first/>
					<para>
						${childName}: <@com.richText child/>
					</para>
				</#if>
			</#list>

			<#--3. Remarks on results-->
			<#if study.OverallRemarksAttachments.RemarksOnResults?has_content>
				<para>Overall remarks: <@com.richText study.OverallRemarksAttachments.RemarksOnResults/></para>
			</#if>

	</#compress>
</#macro>


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

<#--				<#if contextVal?has_content>-->

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
<#--				</#if>-->
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
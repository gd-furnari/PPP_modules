<#assign context = {"ToxicityToReproduction_generational" : [{"path" : "AdministrativeData.Endpoint", "val" : ["generation"], "qual" : "lk", "type" : "picklist"}],

                       "ToxicityToReproduction_developmental" : [{"path" : "AdministrativeData.Endpoint", "val" : ["developmental toxicity", "developmental immunotoxicity", "developmental neurotoxicity"],
                                                                     "qual" : "eq", "type" : "picklist"}],

                       "ToxicityToReproduction_other" : [{"path" : "AdministrativeData.Endpoint", "val" : ["developmental toxicity", "developmental immunotoxicity", "developmental neurotoxicity"],
                                                            "qual" : "ne", "type" : "picklist"},
                                                            {"path" : "AdministrativeData.Endpoint", "val" : ["generation"], "qual" : "nl", "type" : "picklist"}],
                       
                       "metabolismPlants" : [{"path": "AdministrativeData.Endpoint",
                                                        "val" : ["metabolism of residues in crops", "metabolism of residues in crops, other"],
                                                        "qual" : "eq",
                                                        "type" : "picklist"}],

	                    "metabolismRotationalCrops" : [{"path": "AdministrativeData.Endpoint",
	                                                "val" : ["metabolism of residues in rotational crops"],
	                                                "qual" : "eq",
	                                                "type" : "picklist"}],
	
	                    "magnitudePlants": [{"path": "AdministrativeData.Endpoint", "val" : ["residues in crops (field trials)"],
	                                            "qual" : "eq", "type" : "picklist"}],
	
	                    "magnitudeRotationalCrops": [{"path": "AdministrativeData.Endpoint",
	                                                    "val" : ["residues in rotational crops (limited field studies)"],
	                                                    "qual" : "eq",
	                                                    "type" : "picklist"}]}
/>

<sect1 label="${_prefix!}1">
    <title role="HEAD-1">Physical and chemical properties</title>
    
    <#if _summaries> 
    	<@keyPhysChemSummary.physicalChemicalPropertiesSummary _subject/>
    	<@com.emptyLine/>
    	<@keyPhysChemSummary.physicalChemicalPropertiesTable _subject/>
    	<#-- <@com.emptyLine/>
    	<@keyAppendixE.appendixEstudies subject=_subject docSubTypes=["WaterSolubility", "Partition"] includeStudies=_studies includeWaivers=_waivers/> -->
    </#if>
    
    <#if _studies>
	    <sect2>
	        <title role="HEAD-2">Solubility in water</title>
	        <@keyAppendixE.appendixEstudies subject=_subject docSubTypes="WaterSolubility" includeStudies=_studies includeWaivers=_waivers/>

	    </sect2>
  	
	    <?hard-pagebreak?>
	
	    <sect2>
	        <title role="HEAD-2">Partition coefficient n-octanol/water</title>
	        <@keyAppendixE.appendixEstudies subject=_subject docSubTypes=["Partition"] name="partition coefficient" includeStudies=_studies includeWaivers=_waivers/>
	    </sect2>

     </#if>
    
</sect1>

<sect1 label="${_prefix!}2">
	<#-- NOTE: not possible to split between "methods for enforcement of residues in food and feed of plant origin" vs ..."of animal origin"-->
    <title role="HEAD-1">Methods of analysis</title>
    <#if _summaries>
    	<@keyAnMeth.analyticalMethodsSummary _subject/>
    </#if>

	<@keyAppendixE.appendixEstudies subject=_subject docSubTypes="AnalyticalMethods" name="analytical methods" includeStudies=_studies includeWaivers=_waivers/>

</sect1>


<sect1 label="${_prefix!}3">
    <title role="HEAD-1">Mammalian toxicology</title>
    
        <sect2>
            <title role="HEAD-2">Absorption, distribution, metabolism and excretion (Toxicokinetics)</title>
            <#if _summaries>
                <@keyTox.toxPPPsummary _subject "Toxicokinetics" false false/>
            </#if>

            <@keyAppendixE.appendixEstudies subject=_subject docSubTypes="BasicToxicokinetics" name="toxicokinetics" includeMetabolites=false includeStudies=_studies includeWaivers=_waivers/>
        </sect2>

        <?hard-pagebreak?>

        <sect2>
            <title role="HEAD-2">Acute toxicity</title>
            <#if _summaries>
            	<@keyTox.toxPPPsummary subject=_subject docSubTypes=["AcuteToxicity", "IrritationCorrosion", "Sensitisation", "Phototoxicity"] includeMetabolites=false merge=true/>
				<#--<@com.emptyLine/>		 
				<@keyAppendixE.appendixEstudies subject=_subject 
						docSubTypes=["AcuteToxicityOral", "AcuteToxicityDermal", "AcuteToxicityInhalation", "SkinIrritationCorrosion", "EyeIrritation", "SkinSensitisation", "PhototoxicityVitro", "AcuteToxicityOtherRoutes"] 
						includeMetabolites=false includeStudies=false/> -->
			</#if>
			
			<#if _studies>
				<sect3 xml:id="CA521">
	                <title role="HEAD-3">Acute oral toxicity</title>
	                <@keyAppendixE.appendixEstudies _subject "AcuteToxicityOral" "" "acute oral toxicity" "" false _studies _waivers/>
	            </sect3>
	
	            <sect3>
	                <title role="HEAD-3">Acute dermal toxicity</title>
	                <@keyAppendixE.appendixEstudies _subject "AcuteToxicityDermal" "" "acute dermal toxicity" "" false _studies _waivers/>
	            </sect3>
	
	            <sect3>
	                <title role="HEAD-3">Acute inhalation toxicity</title>
	                <@keyAppendixE.appendixEstudies _subject "AcuteToxicityInhalation" "" "acute inhalation toxicity" "" false _studies _waivers/>
	            </sect3>
	
	            <sect3>
	                <title role="HEAD-3">Skin irritation</title>
	                <@keyAppendixE.appendixEstudies _subject "SkinIrritationCorrosion" "" "skin irritation" "" false _studies _waivers/>
	            </sect3>
	
	            <sect3>
	                <title role="HEAD-3">Eye irritation</title>
	                <@keyAppendixE.appendixEstudies _subject "EyeIrritation" "" "eye irritation" "" false _studies _waivers/>
	            </sect3>
	
	            <sect3>
	                <title role="HEAD-3">Skin sensitisation</title>
	                <@keyAppendixE.appendixEstudies _subject "SkinSensitisation" "" "skin sensitisation" "" false _studies _waivers/>
	            </sect3>
	
				<#if keyAppendixE.containsDoc(_subject, "ENDPOINT_STUDY_RECORD.PhototoxicityVitro", "", false)>
		            <sect3>
		                <title role="HEAD-3">Phototoxicity</title>
	                	<@keyAppendixE.appendixEstudies _subject "PhototoxicityVitro" "" "phototoxicity" "" false _studies _waivers/>
		            </sect3>
				</#if>
				
	            <#if keyAppendixE.containsDoc(_subject, "ENDPOINT_STUDY_RECORD.AcuteToxicityOtherRoutes" , "", false)>
	                <sect3>
	                    <title role="HEAD-3">Acute toxicity: other routes</title>
	                	<@keyAppendixE.appendixEstudies _subject "AcuteToxicityOtherRoutes" "" "acute toxicity via other routes" "" false _studies _waivers/>
	                </sect3>
	            </#if>
			</#if>
        </sect2>
 
        <?hard-pagebreak?>

        <sect2>
            <title role="HEAD-2">Short-term toxicity</title>
            <#-- NOTE: in reality this is "repeated dose toxicity", which can be short, subchronic, and chronic. If separation is needed, then use a context -->
            <#if _summaries>
            	<@keyTox.toxPPPsummary _subject "RepeatedDoseToxicity" false true/>
            	<#-- <@com.emptyLine/>
            	<@keyAppendixE.appendixEstudies subject=_subject docSubTypes=["RepeatedDoseToxicityOral", "RepeatedDoseToxicityDermal", "RepeatedDoseToxicityInhalation", "RepeatedDoseToxicityOther"] 
            		includeMetabolites=false includeStudies=false/> -->
			</#if>
			
            <#if _studies>
                <sect3>
                    <title role="HEAD-3">Short-term oral toxicity</title>
                    <@keyAppendixE.appendixEstudies subject=_subject docSubTypes=["RepeatedDoseToxicityOral"]
                       <#--  context=toxContext["RepeatedDoseToxicity_nochronic2"] -->
                        name="short-term oral toxicity" includeMetabolites=false includeStudies=_studies includeWaivers=_waivers/>
                </sect3>

                <sect3>
                    <title role="HEAD-3">Short-term dermal toxicity</title>
                    <@keyAppendixE.appendixEstudies subject=_subject docSubTypes=["RepeatedDoseToxicityDermal"]
                         <#--  context=toxContext["RepeatedDoseToxicity_nochronic2"] -->
                         name="short-term dermal toxicity" includeMetabolites=false includeStudies=_studies includeWaivers=_waivers/>
                </sect3>

                <sect3>
                    <title role="HEAD-3">Short-term inhalation toxicity</title>
                    <@keyAppendixE.appendixEstudies subject=_subject docSubTypes=["RepeatedDoseToxicityInhalation"]
                        <#--  context=toxContext["RepeatedDoseToxicity_nochronic2"] -->
                          name="short-term inhalation toxicity" includeMetabolites=false includeStudies=_studies includeWaivers=_waivers/>
                </sect3>

				<#if keyAppendixE.containsDoc(_subject, "ENDPOINT_STUDY_RECORD.RepeatedDoseToxicityOther", "", false)>    
                    <sect3>
                        <title role="HEAD-3">Short-term toxicity: other routes</title>
                        <@keyAppendixE.appendixEstudies subject=_subject docSubTypes=["RepeatedDoseToxicityOther"]
	                    	name="short-term toxicity via other routes" includeMetabolites=false includeStudies=_studies includeWaivers=_waivers/>
                    </sect3>
                </#if>
            </#if>
        </sect2>
 
        <?hard-pagebreak?>

        <sect2>
            <title role="HEAD-2">Genotoxicity testing</title>
            <#if _summaries>
            	<@keyTox.toxPPPsummary _subject "GeneticToxicity" false true/>
            	<#-- <@com.emptyLine/>
            	<@keyAppendixE.appendixEstudies subject=_subject docSubTypes=["GeneticToxicityVitro", "GeneticToxicityVivo"] includeMetabolites=false includeStudies=false/> -->
            </#if>

			<#if _studies>
	            <sect3>
	                <title role="HEAD-3">In vitro studies</title>
	                <@keyAppendixE.appendixEstudies _subject "GeneticToxicityVitro" "" "in vitro genotoxicity" "" false _studies _waivers/>
	            </sect3>
	
	            <sect3>
	                <title role="HEAD-3">In vivo studies (germ and somatic)</title>
	                <@keyAppendixE.appendixEstudies _subject "GeneticToxicityVivo" "" "in vivo genotoxicity" "" false _studies _waivers/>
	            </sect3>
	        </#if>
        </sect2>

        <?hard-pagebreak?>

        <sect2>
            <title role="HEAD-2">Long-term toxicity and carcinogenicity</title>
	            <#-- NOTE: long-term toxicity is also included under repeated dose toxicity, although it should not be reported there.-->
            <#if _summaries>
            	<@keyTox.toxPPPsummary _subject "Carcinogenicity_EU_PPP" false true/>
            </#if>
            <@keyAppendixE.appendixEstudies subject=_subject docSubTypes="Carcinogenicity" name="long-term toxicity and carcinogenicity" includeMetabolites=false includeStudies=_studies includeWaivers=_waivers/>
        </sect2>

        <?hard-pagebreak?>

        <sect2>
            <title role="HEAD-2">Reproductive toxicity</title>
            <#if _summaries>
            	<@keyTox.toxPPPsummary _subject "ToxicityToReproduction_EU_PPP" false true/>
				<#-- <@com.emptyLine/>            		
				<@keyAppendixE.appendixEstudies subject=_subject docSubTypes=["ToxicityReproduction", "DevelopmentalToxicityTeratogenicity", "ToxicityReproductionOther"] 
            			includeMetabolites=false includeStudies=false/> -->
            </#if>

			<#if _studies>
	            <sect3>
	                <title role="HEAD-3">Multi generation studies</title>
	                <@keyAppendixE.appendixEstudies _subject "ToxicityReproduction" context["ToxicityToReproduction_generational"] "generational studies" "" false _studies _waivers/>
	            </sect3>
	
	            <sect3>
	                <title role="HEAD-3">Developmental toxicity studies</title>
	                <@keyAppendixE.appendixEstudies subject=_subject docSubTypes=["ToxicityReproduction","DevelopmentalToxicityTeratogenicity"] context=context["ToxicityToReproduction_developmental"]
	                    name="developmental toxicity" includeMetabolites=false includeStudies=_studies includeWaivers=_waivers/>
	            </sect3>

				<#--  keyAppendixE.containsDoc needs to take care of context if to be used in this case -->
  				<#if keyAppendixE.containsDoc(_subject, ["ENDPOINT_STUDY_RECORD.ToxicityReproduction", "ENDPOINT_STUDY_RECORD.ToxicityReproductionOther"], 
													context["ToxicityToReproduction_other"], false)>
					<sect3>
	                    <title role="HEAD-3">Other studies on reproductive toxicity</title>
	                	<@keyAppendixE.appendixEstudies subject=_subject docSubTypes=["ToxicityReproduction", "ToxicityReproductionOther"] context=context["ToxicityToReproduction_other"]
	                    	name="reproductive toxicity" includeMetabolites=false includeStudies=_studies includeWaivers=_waivers/>
	                </sect3>
	            </#if>
	    	</#if>
        </sect2>

        <?hard-pagebreak?>

        <sect2>
            <title role="HEAD-2">Neurotoxicity studies</title>
            <#if _summaries>
            	<@keyTox.toxPPPsummary _subject "Neurotoxicity" false true/>
            </#if>
            <@keyAppendixE.appendixEstudies _subject "Neurotoxicity" "" "" "" false _studies _waivers/>
        </sect2>

        <?hard-pagebreak?>

        <sect2>
            <title role="HEAD-2">Further toxicological studies</title>
			    
			<#if _metabolites?? && _metabolites?has_content>
				<#assign summaryList=[]/>
                <#assign studyList=["BasicToxicokinetics", "AcuteToxicityOral", "AcuteToxicityDermal", "AcuteToxicityInhalation",
			                        "SkinIrinfectivenessritationCorrosion","EyeIrritation","SkinSensitisation","PhototoxicityVitro",
			                        "AcuteToxicityOtherRoutes", "RepeatedDoseToxicityOral", "RepeatedDoseToxicityInhalation",
			                        "RepeatedDoseToxicityDermal", "RepeatedDoseToxicityOther", "GeneticToxicityVitro", "GeneticToxicityVivo",
			                        "Carcinogenicity", "ToxicityReproduction", "ToxicityReproductionOther", "DevelopmentalToxicityTeratogenicity",
			                        "Neurotoxicity", "Immunotoxicity", "ToxicEffectsLivestock","IntermediateEffects", "EndocrineDisrupterMammalianScreening",
			                        "AdditionalToxicologicalInformation", "DermalAbsorption", "ExposureRelatedObservationsOther","SensitisationData",
			                        "DirectObservationsClinicalCases","EpidemiologicalData","HealthSurveillanceData"]/>
	            <sect3>
	                <title role="HEAD-3">Toxicity studies of metabolites</title>
	                <#if _summaries>
		                <#assign summaryList=["Toxicokinetics","AcuteToxicity", "IrritationCorrosion", "Sensitisation","Phototoxicity"
				                            ,"RepeatedDoseToxicity", "GeneticToxicity","Carcinogenicity_EU_PPP", "ToxicityToReproduction_EU_PPP"
				                            ,"Neurotoxicity", "AdditionalToxicologicalInformation", "Immunotoxicity", "ToxicEffectsLivestockPets"
				                            ,"ExposureRelatedObservationsHumans", "DermalAbsorption", "SpecificInvestigationsOtherStudies"
				                            ,"ToxRefValues", "NonDietaryExpo", "EndocrineDisruptingPropertiesAssessmentPest"]/>
				    </#if>
	                <@keyAppendixE.metabolitesStudies 
	                	metabList=_metabolites 
	                	summarySubTypes=summaryList
	                	studySubTypes=studyList
                        summaryMacroCall="keyTox.toxPPPsummary"
                        includeStudies=_studies includeWaivers=_waivers/>		  
		   		</sect3>
		   	</#if>
 			
			<#if keyAppendixE.containsDoc(_subject, ["ENDPOINT_SUMMARY.Immunotoxicity", "ENDPOINT_STUDY_RECORD.Immunotoxicity"], "", false)>
                <sect3>
                    <title role="HEAD-3">Immunotoxicity</title>
                    <#if _summaries>
                    	<@keyTox.toxPPPsummary _subject "Immunotoxicity" false true/>
                    </#if>
                    <@keyAppendixE.appendixEstudies _subject "Immunotoxicity" "" "" "" false _studies _waivers/>
                </sect3>
			</#if>
				
			<#if keyAppendixE.containsDoc(_subject, ["ENDPOINT_SUMMARY.ToxicEffectsLivestockPets", "ENDPOINT_STUDY_RECORD.ToxicEffectsLivestock"], "", false)>
                <sect3>
                    <title role="HEAD-3">Toxic effects on livestock</title>
                    <#if _summaries>
                    	<@keyTox.toxPPPsummary _subject "ToxicEffectsLivestockPets" false true/>
                    </#if>
                    <@keyAppendixE.appendixEstudies subject=_subject docSubTypes="ToxicEffectsLivestock" name="toxic effects on livestock" 
                    	includeMetabolites=false includeStudies=_studies includeWaivers=_waivers/>
                </sect3>
			</#if>
			
			<#if keyAppendixE.containsDoc(_subject, "FLEXIBLE_RECORD.IntermediateEffects", "", false)>
                <sect3>
               <#--  xml:id="IntEff_${_studies?c}">-->   
                      <title role="HEAD-3">Intermediate effects - mechanistic information</title>
                    <#if _summaries>
                    	<para>See corresponding studies on intermediate effects in Appendix C.</para>
                    <#else>
                    	<@keyAppendixE.appendixEstudies _subject "IntermediateEffects" "" "" "" false _studies _waivers/>
                    </#if>
                </sect3>
            </#if>

			<#if keyAppendixE.containsDoc(_subject, ["FLEXIBLE_SUMMARY.EndocrineDisruptingPropertiesAssessmentPest", "ENDPOINT_STUDY_RECORD.EndocrineDisrupterMammalianScreening"], "", false)>
	            <sect3>
	                <title role="HEAD-3">Endocrine disrupting properties</title>
					<#if _summaries>
						<@keyTox.toxPPPsummary _subject "EndocrineDisruptingPropertiesAssessmentPest" false true/>
					</#if>
	                <@keyAppendixE.appendixEstudies _subject "EndocrineDisrupterMammalianScreening" "" "endocrine disrupting properties" "" false _studies _waivers/>
	            </sect3>
	        </#if>
	        

			<#if keyAppendixE.containsDoc(_subject, ["ENDPOINT_SUMMARY.AdditionalToxicologicalInformation", "ENDPOINT_STUDY_RECORD.AdditionalToxicologicalInformation"], "", false)>
                <sect3>
                    <title role="HEAD-3">Additional toxicological information</title>
                    <#if _summaries>
                    	<@keyTox.toxPPPsummary _subject "AdditionalToxicologicalInformation" false true/>
                	</#if>
                    <@keyAppendixE.appendixEstudies _subject "AdditionalToxicologicalInformation" "" "" "" false _studies _waivers/>
                </sect3>
            </#if>
    	</sect2>

        <?hard-pagebreak?>

        <sect2>
            <title role="HEAD-2">Medical data</title>
            <#if _summaries>
            	<@keyTox.toxPPPsummary _subject "ExposureRelatedObservationsHumans" false false/>
            	<#-- <@keyAppendixE.appendixEstudies subject=_subject docSubTypes=["HealthSurveillanceData", "DirectObservationsClinicalCases", "ExposureRelatedObservationsOther", "EpidemiologicalData"] 
        				includeMetabolites=false includeStudies=false includeWaivers=true/> -->
            </#if>
            <#if _studies>
	            <sect3>
	                <title role="HEAD-3">Medical surveillance on manufacturing plant personnel</title>
	                <@keyAppendixE.appendixEstudies _subject "HealthSurveillanceData" "" "health surveillance" "" false _studies _waivers/>
	            </sect3>
	            <sect3>
	                <title role="HEAD-3">Clinical cases and poisoning (diagnosis, effects, treatment)</title>
	                <@keyAppendixE.appendixEstudies _subject "DirectObservationsClinicalCases" "" "direct observations / clinical cases" "" false _studies _waivers/>
	            </sect3>
	            <sect3>
	                <title role="HEAD-3">Observations on exposure</title>
	                <@keyAppendixE.appendixEstudies _subject "ExposureRelatedObservationsOther" "" "exposure related observations" "" false _studies _waivers/>
	            </sect3>
	            <sect3>
	                <title role="HEAD-3">Epidemiological studies</title>
	                <@keyAppendixE.appendixEstudies _subject "EpidemiologicalData" "" "" "" false _studies _waivers/>
	            </sect3>
	         </#if>
        </sect2>
        
        <?hard-pagebreak?>
        
        <sect2>
        	<title>Toxicological reference values</title>
            <@keyTox.toxPPPsummary _subject "ToxRefValues" false true/>
        </sect2>
        
</sect1>


<sect1 label="${_prefix!}4">
    <title role="HEAD-1">Residues</title>

    <#if _summaries><@keyRes.residuesSummary _subject "ResiduesInFoodAndFeedingstuffs" /></#if>

    <sect2>
        <title role="HEAD-2">Storage stability of residues</title>
        <#if _summaries><@keyRes.residuesSummary _subject "StabilityResiduesCommodities" /></#if>
        <@com.emptyLine/>
        <@keyAppendixE.appendixEstudies _subject "StabilityOfResiduesInStoredCommod" "" "storage stability of residues" "" true _studies _waivers/>
    </sect2>

    <?hard-pagebreak?>

    <sect2>
        <title role="HEAD-2">Residues in plants</title>
		<#--  
        <sect3>
            <title role="HEAD-3">Primary crops</title>

            <sect4>
                <title role="HEAD-4">Nature of residues</title>
                <#if _summaries><@keyRes.residuesSummary subject=_subject docSubType="MetabolismPlants" selection=["PrimaryCrops"]/></#if>
                <@com.emptyLine/>
                <@keyAppendixE.appendixEstudies _subject "MetabolismInCrops" context["metabolismPlants"] "metabolism of residues in plants" "" true _studies _waivers/>
            </sect4>

            <sect4>
                <title role="HEAD-4">Magnitude of residues</title>
                <#if _summaries><@keyRes.residuesSummary subject=_subject docSubType="MagnitudeResiduesPlants" selection="residues in crops"/></#if>
                <@com.emptyLine/>
                <@keyAppendixE.appendixEstudies _subject "ResiduesInRotationalCrops" context["magnitudePlants"] "magnitude of residues in plants" "" true _studies _waivers/>
            </sect4>
        </sect3>

        <sect3>
            <title role="HEAD-3">Rotational crops</title>
            <sect4>
                <title role="HEAD-4">Nature of residues (metabolism studies)</title>
                <#if _summaries><@keyRes.residuesSummary subject=_subject docSubType="MetabolismPlants" selection=["RotationalCrops"]/></#if>
                <@com.emptyLine/>
                <@keyAppendixE.appendixEstudies _subject "MetabolismInCrops" context["metabolismRotationalCrops"] "metabolism of residues in rotational crops" "" true _studies _waivers/>
            </sect4>

            <sect4>
                <title role="HEAD-4">Magnitude of residues (rotational field trials)</title>
                <#if _summaries><@keyRes.residuesSummary subject=_subject docSubType="MagnitudeResiduesPlants" selection="rotational crops"/></#if>
                <@com.emptyLine/>
                <@keyAppendixE.appendixEstudies _subject "ResiduesInRotationalCrops" context["magnitudeRotationalCrops"]
                    "magnitude of residues in rotational crops" "" true _studies _waivers/>
            </sect4>

        </sect3>
        -->
        <sect3>
            <title role="HEAD-3">Nature of residues</title>
			<#if _summaries><@keyRes.residuesSummary subject=_subject docSubType="MetabolismPlants"/></#if>
			<#if _studies>
	            <sect4>
	                <title role="HEAD-4">Primary crops</title>
	                <@keyAppendixE.appendixEstudies _subject "MetabolismInCrops" context["metabolismPlants"] "metabolism of residues in primary crops" "" true _studies _waivers/>
	            </sect4>
	
	            <sect4>
	                <title role="HEAD-4">Rotational crops</title>
	                <@keyAppendixE.appendixEstudies _subject "MetabolismInCrops" context["metabolismRotationalCrops"] "metabolism of residues in rotational crops" "" true _studies _waivers/>
	            </sect4>
	        </#if>
        </sect3>

        <sect3>
            <title role="HEAD-3">Magnitude of residues</title>
            <#if _summaries><@keyRes.residuesSummary subject=_subject docSubType="MagnitudeResiduesPlants"/></#if>
            <#if _studies>
	            <sect4>
	                <title role="HEAD-4">Primary crops</title>
	                 <@keyAppendixE.appendixEstudies _subject "ResiduesInRotationalCrops" context["magnitudePlants"] "magnitude of residues in primary crops" "" true _studies _waivers/>
	            </sect4>
	
	            <sect4>
	                <title role="HEAD-4">Rotational crops</title>
	                <@keyAppendixE.appendixEstudies _subject "ResiduesInRotationalCrops" context["magnitudeRotationalCrops"] "magnitude of residues in rotational crops" "" true _studies _waivers/>
	            </sect4>
			</#if>
        </sect3>
    </sect2>

    <?hard-pagebreak?>

    <sect2>
        <title role="HEAD-2">Residues in livestock</title>

        <sect3>
            <title role="HEAD-3">Nature of residues</title>
            <#if _summaries><@keyRes.residuesSummary _subject "MetabolismInLivestock" /></#if>
            <@com.emptyLine/>
            <@keyAppendixE.appendixEstudies _subject "MetabolismInLivestock" "" "metabolism of residues in livestock including fish" "" true _studies _waivers/>
        </sect3>

        <sect3>
            <title role="HEAD-2">Magnitude of residues (feeding studies)</title>
            <#if _summaries><@keyRes.residuesSummary _subject "ResiduesInLivestock" /></#if>
            <@com.emptyLine/>
            <@keyAppendixE.appendixEstudies _subject "ResiduesInLivestock" "" "residues in livestock including fish" "" true _studies _waivers/>
        </sect3>

    </sect2>

    <?hard-pagebreak?>

     <sect2>
        <title role="HEAD-2">Residues in processed commodities</title>
        <#if _summaries>
        	<@keyRes.residuesSummary _subject "NatureMagnitudeResiduesProcessedCommodities" />
        	<#-- <@com.emptyLine/>
            <@keyAppendixE.appendixEstudies subject=_subject docSubTypes=["NatureResiduesInProcessedCommod", "MagnitudeResidInProcessedComm"] name="residues in processed commodities"
            	includeStudies=_studies includeWaivers=_waivers/> -->
        </#if>

		<#if _studies>
	        <sect3>
	            <title role="HEAD-3">Nature of residues</title>
	            <@keyAppendixE.appendixEstudies _subject "NatureResiduesInProcessedCommod" "" "nature of the residues in processed commodities" "" true _studies _waivers/>
	        </sect3>

	        <sect3>
	            <title role="HEAD-3">Magnitude of residues</title>
	            <@keyAppendixE.appendixEstudies _subject "MagnitudeResidInProcessedComm" "" "magnitude of residues in processed commodities" "" true _studies _waivers/>
	        </sect3>
	    </#if>

    </sect2>


	<#if keyAppendixE.containsDoc(_subject, ["ENDPOINT_SUMMARY.SupplementaryStudies", "ENDPOINT_STUDY_RECORD.ResiduesProcessedCommodities",
											"ENDPOINT_SUMMARY.AdditionalInformationOnResiduesInFoodAndFeedingstuffs", "ENDPOINT_STUDY_RECORD.AdditionalInfoOnResiduesInFood"])>
	    <?hard-pagebreak?>

	    <sect2>
	        <title role="HEAD-2">Other studies</title>

			<#if keyAppendixE.containsDoc(_subject, ["ENDPOINT_SUMMARY.SupplementaryStudies",
	        										"ENDPOINT_STUDY_RECORD.ResiduesProcessedCommodities"])>
		        <sect3>
		            <title role="HEAD-3">Residue level in pollen and bee products</title>
		            <#if _summaries><@keyRes.residuesSummary _subject "SupplementaryStudies" /></#if>
		            <@com.emptyLine/>
		            <@keyAppendixE.appendixEstudies _subject "ResiduesProcessedCommodities" "" "residue levels in pollen and bee products" "" true _studies _waivers/>
		        </sect3>
		    </#if>

	        <#if keyAppendixE.containsDoc(_subject, ["ENDPOINT_SUMMARY.AdditionalInformationOnResiduesInFoodAndFeedingstuffs",
	        										"ENDPOINT_STUDY_RECORD.AdditionalInfoOnResiduesInFood"])>
	        	<sect3>
	                <title role="HEAD-3">Additional information on residues in food and feedingstuffs</title>
	            	<#if _summaries><@keyRes.residuesSummary _subject "AdditionalInformationOnResiduesInFoodAndFeedingstuffs" /></#if>
		            <@com.emptyLine/>
		            <@keyAppendixE.appendixEstudies _subject "AdditionalInfoOnResiduesInFood" "" "" "" true _studies _waivers/>
	            </sect3>
	        </#if>
	    </sect2>
	</#if>
</sect1>

<sect1 label="${_prefix!}5">

	<#if _summaries><@keyFate.fatePPPsummary _subject "EnvironmentalFateAndPathways"/></#if>
	
    <title role="HEAD-1">Fate and behaviour in the environment</title>
    <sect2>
        <title role="HEAD-2">Fate and behaviour in soil</title>

        <sect3>
            <title role="HEAD-3">Route of degradation in soil</title>

            <sect4 xml:id="CA7111_${_studies?c}">
                <title role="HEAD-4">Aerobic and anaerobic degradation</title>
                <#if _summaries><@keyFate.fatePPPsummary _subject "RouteDegSoil_EU_PPP"/><@com.emptyLine/></#if>
                <@keyAppendixE.appendixEstudies _subject "BiodegradationInSoil" "" "aerobic and anaerobic degradation" "" true _studies _waivers/>
            </sect4>

            <sect4>
                <title role="HEAD-4">Soil photolysis</title>
                <#if _summaries><@keyFate.fatePPPsummary _subject "PhototransformationInSoil"/><@com.emptyLine/></#if>
                <@keyAppendixE.appendixEstudies _subject "PhotoTransformationInSoil" "" "" "" true _studies _waivers/>
            </sect4>
        </sect3>

        <sect3>
            <title role="HEAD-2">Rate of degradation in soil</title>

            <sect4>
                <title role="HEAD-4">Laboratory studies</title>
                <#if _summaries><@keyFate.fatePPPsummary _subject "BiodegradationInSoil_EU_PPP"/><@com.emptyLine/></#if>
                <#if _studies><para>Laboratory studies can be found in section for <command  linkend="CA7111_true">Aerobic and anaerobic degradation</command> above.</para></#if>
            </sect4>

            <sect4>
                <title role="HEAD-4">Field studies</title>
                <#if _summaries><@keyFate.fatePPPsummary _subject "FieldStudies"/><@com.emptyLine/></#if>
                <@keyAppendixE.appendixEstudies _subject "FieldStudies" "" "" "" true _studies _waivers/>
            </sect4>
        </sect3>

        <sect3>
            <title role="HEAD-3">Adsorption and desorption in soil</title>
            <#if _summaries><@keyFate.fatePPPsummary _subject "AdsorptionDesorption"/><@com.emptyLine/></#if>
			<@keyAppendixE.appendixEstudies subject=_subject docSubTypes=["AdsorptionDesorption", "AgedSorption"] name="adsorption and desorption and/or aged sorption" includeStudies=_studies includeWaivers=_waivers/>
        </sect3>

        <sect3>
            <title role="HEAD-3">Mobility in soil</title>
            <#if _summaries><@keyFate.fatePPPsummary _subject "OtherDistributionData"/><@com.emptyLine/></#if>
			<@keyAppendixE.appendixEstudies _subject "OtherDistributionData" "" "mobility in soil" "" true _studies _waivers/>
        </sect3>
    </sect2>
</sect1>

<#if _summaries>
	<sect1 label="6">
	    <title role="HEAD-1">Literature data</title>
	    <@keyLit.literatureData _subject/>
	</sect1>
	
	
	<sect1 label="7">
	    <title role="HEAD-1">Consumer risk assessment</title>
	    <sect2>
	        <title role="HEAD-2">Estimation of the potential and actual exposure through diet and other sources</title>
	        <@keyRes.residuesSummary _subject "ExpectedExposure" />
	    </sect2>
	</sect1>
</#if>

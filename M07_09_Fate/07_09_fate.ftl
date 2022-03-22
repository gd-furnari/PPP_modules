<#assign fateContext = {
                        "fieldStudies_dissipation" : [{"path": "AdministrativeData.Endpoint",
                                                        "val" : ["dissipation"], "qual" : "lk", "type" : "picklist"}],

                        "fieldStudies_accumulation" : [{"path": "AdministrativeData.Endpoint",
                                                        "val" : ["accumulation"], "qual" : "lk", "type" : "picklist"}],

                        "fieldStudies_other" : [{"path": "AdministrativeData.Endpoint", "val" : ["dissipation", "accumulation"], "qual" : "nl", "type" : "picklist"}],

                        "otherDistribution_fieldLeaching" : [{"path": "AdministrativeData.Endpoint", "val" : ["field"], "qual" : "lk", "type" : "picklist"}],

                        "otherDistribution_columnLeaching" : [{"path": "AdministrativeData.Endpoint", "val" : ["column"], "qual" : "lk", "type" : "picklist"}],

                        "otherDistribution_lysimeter" : [{"path": "AdministrativeData.Endpoint", "val" : ["lysimeter"], "qual" : "lk", "type" : "picklist"}],

                        "otherDistribution_other" : [{"path": "AdministrativeData.Endpoint", "val" : ["field", "column", "lysimeter"], "qual" : "nl", "type" : "picklist"}]

}/>

<@keyFate.fatePPPsummary _subject "EnvironmentalFateAndPathways"/>

<#if workingContext=="CHEM">

    <#if _subject.documentType=="SUBSTANCE">

        <sect1>
            <title role="HEAD-2">Fate and behaviour in soil</title>

            <sect2>
                <title role="HEAD-3">Route of degradation in soil</title>

                <@keyFate.fatePPPsummary _subject "RouteDegSoil_EU_PPP"/>
                <sect3 xml:id="CA7111-2" label="1-7.1.1.2">
                    <#--  NOTE: section is merged due to the difficulty of separating aerobic/anaerobic-->
                    <title role="HEAD-4">Aerobic and anaerobic degradation</title>
                    <@keyAppendixE.appendixEstudies _subject "BiodegradationInSoil" "" "aerobic and anaerobic degradation"/>
                </sect3>

                <sect3 label="3">
                    <title role="HEAD-4">Soil photolysis</title>
                    <@keyFate.fatePPPsummary _subject "PhototransformationInSoil"/>
                    <@keyAppendixE.appendixEstudies _subject "PhotoTransformationInSoil"/>
                </sect3>
            </sect2>

            <sect2>
                <title role="HEAD-2">Rate of degradation in soil</title>

                <sect3>
                    <title role="HEAD-4">Laboratory studies</title>
                    <@keyFate.fatePPPsummary _subject "BiodegradationInSoil_EU_PPP"/>

                    <sect4 label="1-7.1.2.4">
                        <title role="HEAD-5">Aerobic and anaerobic degradation of the active substance, metabolites, breakdown and reaction products</title>
                        <para>Laboratory studies for the aerobic and anaerobic degradation of the active substance, metabolites, breakdown and reaction products
                            can be found in section <command  linkend="CA7111-2">7.1.1.1-2</command> above.
                        </para>
                    </sect4>
                </sect3>

                <sect3>
                    <title role="HEAD-4">Field studies</title>
                    <@keyFate.fatePPPsummary _subject "FieldStudies"/>

                    <sect4>
                        <title role="HEAD-5">Soil dissipation studies</title>
                        <@keyAppendixE.appendixEstudies _subject "FieldStudies" fateContext["fieldStudies_dissipation"] "soil dissipation"/>
                    </sect4>

                    <sect4>
                        <title role="HEAD-5">Soil accumulation studies</title>
                        <@keyAppendixE.appendixEstudies _subject "FieldStudies" fateContext["fieldStudies_accumulation"] "soil accumulation"/>
                    </sect4>

                    <#if keyAppendixE.containsDoc(_subject, "ENDPOINT_STUDY_RECORD.FieldStudies", fateContext["fieldStudies_other"])>
                        <sect4>
                            <title role="HEAD-4">Other field studies</title>
                            <@keyAppendixE.appendixEstudies _subject "FieldStudies" fateContext["fieldStudies_other"]/>
                        </sect4>
                    </#if>
                </sect3>
            </sect2>

            <sect2>
                <title role="HEAD-3">Adsorption and desorption in soil</title>
                <@keyFate.fatePPPsummary _subject "AdsorptionDesorption"/>

                <sect3>
                    <title role="HEAD-4">Adsorption and desorption</title>

                    <sect4>
                        <title role="HEAD-5">Adsorption and desorption of the active substance</title>
                        <@keyAppendixE.appendixEstudies _subject "AdsorptionDesorption" "" "adsorption and desorption of the active substance" "" false/>
                    </sect4>

                    <sect4>
                        <title role="HEAD-5">Adsorption and desorption of metabolites, breakdown and reaction products</title>
                        <#if _metabolites??>
                            <@keyAppendixE.appendixEstudies _metabolites "AdsorptionDesorption" ""
                            "adsorption and desorption of metabolites, breakdown and reaction products" "" false/>
                        <#else>
                            <para>No studies available for adsorption and desorption of metabolites, breakdown and reaction products.</para>
                        </#if>
                    </sect4>
                    
                </sect3>

                <sect3>
                    <title role="HEAD-4">Aged sorption</title>
                    <@keyAppendixE.appendixEstudies _subject "AgedSorption"/>
                </sect3>
            </sect2>

            <sect2>
                <title role="HEAD-3">Mobility in soil</title>
                <@keyFate.fatePPPsummary _subject "OtherDistributionData"/>

                <sect3>
                    <title role="HEAD-4">Column leaching studies</title>

                     <sect4>
                        <title role="HEAD-5">Column leaching of the active substance</title>
                        <@keyAppendixE.appendixEstudies _subject "OtherDistributionData" fateContext["otherDistribution_columnLeaching"]
                            "column leaching data of the active substance" "" false/>
                     </sect4>

                     <sect4>
                        <title role="HEAD-5">Column leaching of metabolites, breakdown and reaction products</title>
                         <#if _metabolites??>
                             <@keyAppendixE.appendixEstudies _metabolites "OtherDistributionData" fateContext["otherDistribution_columnLeaching"]
                             "column leaching data of metabolites, breakdown and reaction products" "" false/>
                         <#else>
                             <para>No studies available for column leaching data of metabolites, breakdown and reaction products.</para>
                         </#if>
                     </sect4>
                </sect3>

                <sect3>
                    <title role="HEAD-4">Lysimeter studies</title>
                    <@keyAppendixE.appendixEstudies _subject "OtherDistributionData" fateContext["otherDistribution_lysimeter"] "lysimeter"/>
                </sect3>

                <sect3>
                    <title role="HEAD-4">Field leaching studies</title>
                    <@keyAppendixE.appendixEstudies _subject "OtherDistributionData" fateContext["otherDistribution_fieldLeaching"] "field leaching"/>
                </sect3>

                <#if keyAppendixE.containsDoc(_subject, "ENDPOINT_STUDY_RECORD.OtherDistributionData", fateContext["otherDistribution_other"])>
                    <sect3>
                        <title role="HEAD-4">Other distribution data</title>
                        <@keyAppendixE.appendixEstudies _subject "OtherDistributionData" fateContext["otherDistribution_other"] "other distribution data"/>
                    </sect3>
                </#if>
            </sect2>
        </sect1>
        
        <?page-hardbreak?>

        <sect1>
            <title role="HEAD-2">Fate and behaviour in water and sediment</title>

            <sect2>
                <title role="HEAD-3">Route and rate of degradation in aquatic systems (chemical and photochemical degradation)</title>

                <sect3>
                    <title role="HEAD-4">Hydrolytic degradation</title>
                    <@keyFate.fatePPPsummary _subject "Hydrolysis"/>
                    <@com.emptyLine/>
                    <@keyAppendixE.appendixEstudies _subject "Hydrolysis" "" "hydrolytic degradation"/>
                </sect3>

                <sect3 xml:id="CA7212">
                    <title role="HEAD-4">Direct and indirect photochemical degradation</title>
                    <@keyFate.fatePPPsummary _subject "PhototransformationInWater"/>
                    <@com.emptyLine/>
                    <@keyAppendixE.appendixEstudies _subject "Phototransformation" "" "direct and indirect photochemical degradation"/>
                </sect3>
            </sect2>

            <sect2>
                <title role="HEAD-3">Route and rate of biological degradation in aquatic systems</title>

                <sect3 xml:id="CA7221">
                    <title role="HEAD-4">Ready biodegradability</title>
                    <@keyFate.fatePPPsummary _subject "BiodegradationInWaterScreeningTests"/>
                    <@com.emptyLine/>
                    <@keyAppendixE.appendixEstudies _subject "BiodegradationInWaterScreeningTests" "" "ready biodegradability"/>
                </sect3>

                <sect3>
                    <title role="HEAD-4">Biodegradation in water, sediment and surface water</title>
                    <@keyFate.fatePPPsummary _subject "RouteDegWaterSed_EU_PPP"/>
                    <@com.emptyLine/>
                    <@keyFate.fatePPPsummary _subject "BiodegradationInWaterAndSedimentSimulationTests_EU_PPP"/>
                    <@com.emptyLine/>
                    <@keyAppendixE.appendixEstudies _subject "BiodegradationInWaterAndSedimentSimulationTests" "" "biodegradation in water, sediment and surface water"/>
                </sect3>
            </sect2>

            <sect2>
                <title role="HEAD-4">Degradation in the saturated zone</title>
                <para>Studies on degradation in the saturated zone can be found in section <command  linkend="CA7221">7.2.2.1</command> above.</para>
            </sect2>

        </sect1>

        <?page-hardbreak?>

        <sect1>
            <title role="HEAD-2">Fate and behaviour in air</title>

            <sect2>
                <title role="HEAD-3">Route and rate of degradation in air</title>
                <@keyFate.fatePPPsummary _subject "PhototransformationInAir"/>
                <@com.emptyLine/>
                <@keyAppendixE.appendixEstudies _subject "PhototransformationInAir"/>
            </sect2>

            <sect2>
                <title role="HEAD-3">Transport via air</title>
                <@keyAppendixE.appendixEstudies _subject "TransportViaAir" />
            </sect2>

            <sect2>
                <title role="HEAD-3">Local and global effects</title>
                <para>For local and global effects, please refer to the general summary at the beginning of the chapter</para>
            </sect2>

        </sect1>

        <?page-hardbreak?>

        <sect1>
            <title role="HEAD-2">Definition of the residue</title>

            <sect2>
                <title role="HEAD-3">Definition of the residue for risk assessment</title>
                <@keyFate.fatePPPsummary _subject "DefinitionResidueFate" "ResidueDefinitionRiskAssessment"/>
            </sect2>

            <sect2>
                <title role="HEAD-3">Definition of the residue for monitoring</title>
                <@keyFate.fatePPPsummary _subject "DefinitionResidueFate" "ResidueDefinitionMonitoring"/>
            </sect2>
        </sect1>

        <?page-hardbreak?>

        <sect1>
            <title role="HEAD-2">Monitoring data</title>
            <@keyFate.fatePPPsummary _subject "MonitoringData"/>
            <@com.emptyLine/>
            <@keyAppendixE.appendixEstudies _subject "MonitoringData"/>
        </sect1>
        
        <#if keyAppendixE.containsDoc(_subject, ["ENDPOINT_SUMMARY.AdditionalInformationOnEnvironmentalFateAndBehaviour", "ENDPOINT_STUDY_RECORD.AdditionalInformationOnEnvironmentalFateAndBehaviour"])>
            <?page-hardbreak?>
            <sect1>
                <title role="HEAD-2">Additional information on fate and behaviour</title>
                 <@keyFate.fatePPPsummary _subject "AdditionalInformationOnEnvironmentalFateAndBehaviour"/>
	             <@com.emptyLine/>
	             <@keyAppendixE.appendixEstudies _subject "AdditionalInformationOnEnvironmentalFateAndBehaviour"/>
            </sect1>
        </#if>

    <#elseif _subject.documentType=="MIXTURE">

        <sect1>
            <title role="HEAD-2">Fate and behaviour in soil</title>

            <sect2>
                <title role="HEAD-3">Rate of degradation in soil</title>
                <@keyFate.fatePPPsummary _subject "BiodegradationInSoil_EU_PPP"/>

                <sect3>
                    <title role="HEAD-4">Laboratory studies</title>
                    <@keyAppendixE.appendixEstudies _subject "BiodegradationInSoil"/>
                </sect3>

                <sect3>
                    <title role="HEAD-4">Field studies</title>
                    <@keyFate.fatePPPsummary _subject "FieldStudies"/>

                    <sect4>
                        <title role="HEAD-5">Soil dissipation studies</title>
                        <@keyAppendixE.appendixEstudies _subject "FieldStudies" fateContext["fieldStudies_dissipation"] "soil dissipation"/>
                    </sect4>

                    <sect4>
                        <title role="HEAD-5">Soil accumulation studies</title>
                        <@keyAppendixE.appendixEstudies _subject "FieldStudies" fateContext["fieldStudies_accumulation"] "soil accumulation"/>
                    </sect4>
                    
                    <#if keyAppendixE.containsDoc(_subject, "ENDPOINT_STUDY_RECORD.FieldStudies", fateContext["fieldStudies_other"])>
                        <sect4>
                            <title role="HEAD-4">Other field studies</title>
                            <@keyAppendixE.appendixEstudies _subject "FieldStudies" fateContext["fieldStudies_other"]/>
                        </sect4>
                    </#if>
                </sect3>
            </sect2>

            <sect2>
                <title role="HEAD-3">Mobility in the soil</title>
                <@keyFate.fatePPPsummary _subject "OtherDistributionData"/>
                <sect3>
                    <title role="HEAD-4">Laboratory studies</title>
                    <@keyAppendixE.appendixEstudies _subject "OtherDistributionData" fateContext["otherDistribution_columnLeaching"] "column leaching data"/>
                </sect3>

                <sect3>
                    <title role="HEAD-4">Lysimeter studies</title>
                    <@keyAppendixE.appendixEstudies _subject "OtherDistributionData" fateContext["otherDistribution_lysimeter"] "lysimeter"/>
                </sect3>

                <sect3>
                    <title role="HEAD-4">Field leaching studies</title>
                    <@keyAppendixE.appendixEstudies _subject "OtherDistributionData" fateContext["otherDistribution_fieldLeaching"] "field leaching"/>
                </sect3>

                <#if keyAppendixE.containsDoc(_subject, "ENDPOINT_STUDY_RECORD.OtherDistributionData", fateContext["otherDistribution_other"])>
                    <sect3>
                        <title role="HEAD-4">Other distribution data</title>
                        <@keyAppendixE.appendixEstudies _subject "OtherDistributionData" fateContext["otherDistribution_other"] "other distribution data"/>
                    </sect3>
                </#if>
            </sect2>

            <sect2>
                <title role="HEAD-3">Estimation of concentration in soil</title>
                <@keyFate.estConcSummary _subject "EstConcSoil"/>
            </sect2>
        </sect1>

        <?page-hardbreak?>

        <sect1>
            <title role="HEAD-2">Fate and behaviour in water and sediment</title>

            <sect2 label="1-9.2.3">
                <title role="HEAD-3">Aerobic mineralisation in surface water, water/sediment and irradiated water/sediment studies</title>
                <@keyFate.fatePPPsummary _subject "RouteDegWaterSed_EU_PPP"/>
                <@com.emptyLine/>
                <@keyFate.fatePPPsummary _subject "BiodegradationInWaterAndSedimentSimulationTests_EU_PPP"/>
                <@com.emptyLine/>
                <@keyAppendixE.appendixEstudies _subject "BiodegradationInWaterAndSedimentSimulationTests" "" "aerobic mineralisation in surface water, water/sediment and/or irradiated water/sediment studies"/>
            </sect2>

            <sect2 label="4">
                <title role="HEAD-4">Estimation of concentrations in groundwater</title>
                <@keyFate.estConcSummary _subject "EstConcGroundwater"/>
            </sect2>

            <sect2 label="5">
                <title role="HEAD-4">Estimation of concentrations in surface water and sediment</title>
                <@keyFate.estConcSummary _subject "EstConcWaterSed"/>
            </sect2>
        </sect1>

        <?page-hardbreak?>

        <sect1>
            <title role="HEAD-2">Fate and behaviour in air</title>
            <@keyFate.fatePPPsummary _subject "PhototransformationInAir"/>

            <sect2>
                <title role="HEAD-3">Route and rate of degradation in air and transport via air</title>
                <@keyAppendixE.appendixEstudies subject=_subject docSubTypes=["PhototransformationInAir", "TransportViaAir"]
                    name="route and rate of degradation and transport in air"/>
            </sect2>
        </sect1>

        <?page-hardbreak?>

        <sect1>
            <title role="HEAD-2">Estimation of concentrations for other routes of exposure</title>
            <@keyFate.estConcSummary _subject "EstConcOtherRoutes"/>
        </sect1>
        
        <#if keyAppendixE.containsDoc(_subject, ["ENDPOINT_SUMMARY.AdditionalInformationOnEnvironmentalFateAndBehaviour", "ENDPOINT_STUDY_RECORD.AdditionalInformationOnEnvironmentalFateAndBehaviour"])>
            <?page-hardbreak?>
            <sect1>
                <title role="HEAD-2">Additional information on fate and behaviour</title>
                 <@keyFate.fatePPPsummary _subject "AdditionalInformationOnEnvironmentalFateAndBehaviour"/>
	             <@com.emptyLine/>
	             <@keyAppendixE.appendixEstudies _subject "AdditionalInformationOnEnvironmentalFateAndBehaviour"/>
            </sect1>
        </#if>
        
    </#if>

<#elseif workingContext=="MICRO">

    <#--    It's almost the same for mixture and substance-->

    <sect1>
        <title role="HEAD-2">Persistence and multiplication</title>
        <@keyFate.fatePPPsummary _subject "AdditionalInformationOnEnvironmentalFateAndBehaviour"/>
        <@com.emptyLine/>
        <@keyAppendixE.appendixEstudies _subject "AdditionalInformationOnEnvironmentalFateAndBehaviour"/>

        <#if _subject.documentType=="SUBSTANCE">
            <sect2>
                <title role="HEAD-3">Soil</title>
                <@keyFate.fatePPPsummary _subject "BiodegradationInSoil"/>
                <@com.emptyLine/>
                <@keyAppendixE.appendixEstudies _subject "BiodegradationInSoil"/>
            </sect2>

            <sect2>
                <title role="HEAD-4">Water</title>
                <@keyFate.fatePPPsummary _subject "BiodegradationInWaterAndSedimentSimulationTests"/>
                <@com.emptyLine/>
                <@keyAppendixE.appendixEstudies _subject "BiodegradationInWaterAndSedimentSimulationTests"/>
            </sect2>

            <sect2>
                <title role="HEAD-3">Air</title>
                <@keyFate.fatePPPsummary _subject "PhototransformationInAir"/>
                <@com.emptyLine/>
                <@keyAppendixE.appendixEstudies _subject "PhototransformationInAir" "" "route and rate of degradation and transport in air"/>
            </sect2>
        </#if>

    </sect1>

    <?page-hardbreak?>

    <sect1>
        <title role="HEAD-2">Mobility</title>
        <@keyFate.fatePPPsummary _subject "OtherDistributionData"/>
        <@com.emptyLine/>
        <@keyAppendixE.appendixEstudies _subject "OtherDistributionData" "" "mobility"/>
    </sect1>

    <#if _subject.documentType=="MIXTURE">
    
    	<#if keyAppendixE.containsDoc(_subject, "FLEXIBLE_SUMMARY.EstConcOtherRoutes")>
            <?page-hardbreak?>
            <sect1>
                <title role="HEAD-2">Predicted concentrations in the environment</title>
                <@keyFate.estConcSummary _subject "EstConcOtherRoutes"/>
            </sect1>
        </#if>

    </#if>
</#if>
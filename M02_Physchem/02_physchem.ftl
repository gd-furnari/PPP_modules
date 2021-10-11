<#--hashMap with contexts for physchem-->
<#assign physchemContext = {"wettability" : [{"path": "AdministrativeData.Endpoint", "val" : ["wettability"], "qual" : "eq", "type" : "picklist"}],
                            "foaming" : [{"path": "AdministrativeData.Endpoint", "val" : ["persistent of foaming"], "qual" : "eq", "type" : "picklist"}],
                            "suspensibility" : [{"path": "AdministrativeData.Endpoint", "val" : ["suspensibility, spontaneity and dispersion stability"], "qual" : "eq", "type" : "picklist"}],
                            "sizedustattrition" : [{"path": "AdministrativeData.Endpoint", "val" : ["particle size distribution, content of dust/fines, attrition, friability"], "qual" : "eq", "type" : "picklist"}],
                            "hardness" : [{"path": "AdministrativeData.Endpoint", "val" : ["hardness and integrity"], "qual" : "eq", "type" : "picklist"}],
                            "emulsifiability" : [{"path": "AdministrativeData.Endpoint", "val" : ["emulsifiability, re-emulsifiability and emulsion stability"], "qual" : "eq", "type" : "picklist"}],
                            "flowability" : [{"path": "AdministrativeData.Endpoint", "val" : ["flowability / pourability / dustability"], "qual" : "eq", "type" : "picklist"}],
                            "sievetest" : [{"path": "AdministrativeData.Endpoint", "val" : ["wet sieve analysis and dry sieve test"], "qual" : "eq", "type" : "picklist"}],
                            "seeds" : [{"path": "AdministrativeData.Endpoint", "val" : ["adherence to seeds", "distribution to seeds"], "qual" : "eq", "type" : "picklist"}],
                            "other" : [{"path": "AdministrativeData.Endpoint", "val" : ["wettability", "persistent of foaming", "suspensibility, spontaneity and dispersion stability",
                                            "particle size distribution, content of dust/fines, attrition, friability", "hardness and integrity", "emulsifiability, re-emulsifiability and emulsion stability",
                                            "flowability / pourability / dustability", "adherence to seeds", "distribution to seeds"], "qual" : "ne", "type" : "picklist"}],
                            "other_micro" : [{"path": "AdministrativeData.Endpoint", "val" : ["wettability", "persistent of foaming", "suspensibility, spontaneity and dispersion stability", "wet sieve analysis and dry sieve test",
                                            "particle size distribution, content of dust/fines, attrition, friability", "emulsifiability, re-emulsifiability and emulsion stability",
                                            "flowability / pourability / dustability", "adherence to seeds", "distribution to seeds"], "qual" : "ne", "type" : "picklist"}],
                            "physcomp" : [{"path": "DataSource.TypeOfCompatibility.TypeOfCompatibilityLabel", "val" : ["Physical compatibility"], "qual" : "eq", "type" : "picklist"}],
                            "chemcomp" : [{"path": "DataSource.TypeOfCompatibility.TypeOfCompatibilityLabel", "val" : ["Chemical compatibility"], "qual" : "eq", "type" : "picklist"}],
                            "biocomp" : [{"path": "DataSource.TypeOfCompatibility.TypeOfCompatibilityLabel", "val" : ["Biological compatibility", ""], "qual" : "eq", "type" : "picklist"}],

                            <#--for micro-->
                            "effectiveness_harmful" : [{"path": "AdministrativeData.Endpoint", "val" : ["effects on harmful organisms"], "qual" : "eq", "type" : "picklist"}],
                            "effectiveness_modeofaction" : [{"path": "AdministrativeData.Endpoint", "val" : ["mode of action"], "qual" : "eq", "type" : "picklist"}]
}/>

<#assign subjectId=_subject.documentKey.uuid/>

<#if _subject.documentType=="MIXTURE">

    <#if workingContext=="MICRO">

        <sect1>
            <title role="HEAD-2">Appearance</title>
            <@keyAppendixE.appendixEstudies subject=_subject docSubTypes="GeneralInformation" name="appearance"/>
        </sect1>

        <?hard-pagebreak?>

        <sect1>
            <title role="HEAD-2">Storage stability and shelf-life</title>

            <sect2>
                <title role="HEAD-3">Effects of light, temperature and humidity on technical characteristics of the plant protection product</title>
                <@keyAppendixE.appendixEstudies _subject "StabilityThermal" "" "effects of light, temperature and humidity"/>
            </sect2>

            <sect2>
                <title role="HEAD-3">Other factors affecting stability</title>
                <@keyAppendixE.appendixEstudies _subject "StorageStability" "" "storage stability"/>
            </sect2>
        </sect1>

        <?hard-pagebreak?>

        <sect1>
            <title role="HEAD-3">Explosivity and oxidising properties</title>
            <@keyAppendixE.appendixEstudies subject=_subject docSubTypes=["Explosiveness", "OxidisingProperties"] name="explosivity and oxidising properties"/>
        </sect1>

        <?hard-pagebreak?>

        <sect1>
            <title role="HEAD-2">Flash point and other indications of flammability or spontaneous ignition</title>
            <@keyAppendixE.appendixEstudies subject=_subject docSubTypes=[ "FlashPoint", "Flammability", "AutoFlammability"] name="flash point, flammability and self-heating"/>
        </sect1>

        <?hard-pagebreak?>

        <sect1>
            <title role="HEAD-2">Acidity, alkalinity and if necessary pH value</title>
            <@keyAppendixE.appendixEstudies subject=_subject docSubTypes="Ph" name="acidity/alkalinity and pH value"/>
        </sect1>

        <?hard-pagebreak?>

        <sect1>
            <title role="HEAD-2">Viscosity and surface tension</title>
            <@keyAppendixE.appendixEstudies subject=_subject docSubTypes=["Viscosity", "SurfaceTension"] name="viscosity and surface tension"/>
        </sect1>

        <?hard-pagebreak?>

        <sect1>
            <title role="HEAD-2">Technical characteristics of the plant protection product</title>
            <#-- NOTE: there is no summary for any of these-->
            <sect2>
                <title role="HEAD-2">Wettability</title>
                <@keyAppendixE.appendixEstudies subject=_subject docSubTypes="TechnicalCharacteristics" context=physchemContext["wettability"] name="wettability"/>
            </sect2>

            <sect2>
                <title role="HEAD-2">Persistent foaming</title>
                <@keyAppendixE.appendixEstudies subject=_subject docSubTypes="TechnicalCharacteristics" context=physchemContext["foaming"] name="persistent foaming"/>
            </sect2>

            <sect2>
                <title role="HEAD-2">Suspensibility and suspension stability</title>
                <@keyAppendixE.appendixEstudies subject=_subject docSubTypes="TechnicalCharacteristics" context=physchemContext["suspensibility"] name="suspensibility, spontaneity and dispersion stability"/>
            </sect2>

            <sect2>
                <title role="HEAD-2">Dry sieve test and wet sieve test</title>
                <@keyAppendixE.appendixEstudies subject=_subject docSubTypes="TechnicalCharacteristics" context=physchemContext["sievetest"] name="dry and wet sieve test"/>
            </sect2>

            <sect2>
                <title role="HEAD-2">Particle size distribution (dustable and wettable powders, granules), content of dust/fines (granules), attrition and friability (granules)</title>
                <@keyAppendixE.appendixEstudies subject=_subject docSubTypes="TechnicalCharacteristics" context=physchemContext["sizedustattrition"] name="size distribution, dust content and/or attrition"/>
            </sect2>

            <sect2>
                <title role="HEAD-2">Emulsifiability, re-emulsifiability, emulsion stability</title>
                <@keyAppendixE.appendixEstudies subject=_subject docSubTypes="TechnicalCharacteristics" context=physchemContext["emulsifiability"] name="emulsifiability, re-emulsifiability and emulsion stability"/>
            </sect2>

            <sect2>
                <title role="HEAD-2">Flowability, pourability (rinsability) and dustability</title>
                <@keyAppendixE.appendixEstudies subject=_subject docSubTypes="TechnicalCharacteristics" context=physchemContext["flowability"] name="flowability, pourability and dustability"/>
            </sect2>

        </sect1>

        <?hard-pagebreak?>

        <sect1>
            <title role="HEAD-2">Physical, chemical and biological compatibility with other products including plant protection products with which its use is to be authorised</title>

            <sect2>
                <title role="HEAD-2">Physical compatibility</title>
                <@keyAppendixE.appendixEstudies subject=_subject docSubTypes="PhysicalChemicalCompatibility" context=physchemContext["physcomp"] name="physical compatibility with other products"/>
            </sect2>

            <sect2>
                <title role="HEAD-2">Chemical compatibility</title>
                <@keyAppendixE.appendixEstudies subject=_subject docSubTypes="PhysicalChemicalCompatibility" context=physchemContext["chemcomp"] name="chemical compatibility with other products"/>
            </sect2>

            <sect2>
                <title role="HEAD-2">Biological compatibility</title>
                <@keyAppendixE.appendixEstudies subject=_subject docSubTypes="PhysicalChemicalCompatibility" context=physchemContext["biocomp"] name="biological compatibility with other products"/>
            </sect2>

        </sect1>

        <?hard-pagebreak?>

        <sect1>
            <title role="HEAD-2">Adherence and distribution to seeds</title>
            <@keyAppendixE.appendixEstudies subject=_subject docSubTypes="AdditionalPhysicoChemical" context=physchemContext["seeds"] name="adherence and distribution to seeds"/>
        </sect1>

        <?hard-pagebreak?>

        <sect1>
            <title role="HEAD-2">Other studies</title>
            <@keyAppendixE.appendixEstudies subject=_subject docSubTypes=["TechnicalCharacteristics","AdditionalPhysicoChemical"] context=physchemContext["other_micro"] name="other physico-chemical characteristics"/>
        </sect1>

        <?hard-pagebreak?>

        <sect1>
            <title role="HEAD-2">Summary and evaluation</title>
            <#-- Summary and evaluation of data presented under points 2.1 to 2.9-->
            <@keyPhysChemSummary.physicalChemicalPropertiesSummary _subject/>
            <@com.emptyLine/>
            <@keyPhysChemSummary.physicalChemicalPropertiesTable _subject/>
        </sect1>

    <#elseif workingContext=="CHEM">

        <@keyPhysChemSummary.physicalChemicalPropertiesSummary _subject/>
        <@com.emptyLine/>
        <@keyPhysChemSummary.physicalChemicalPropertiesTable _subject/>

        <?hard-pagebreak?>

        <sect1>
            <title role="HEAD-2">Appearance</title>
            <@keyAppendixE.appendixEstudies subject=_subject docSubTypes="GeneralInformation" name="appearance"/>
        </sect1>

        <?hard-pagebreak?>

        <sect1>
            <title role="HEAD-3">Explosive and oxidising properties</title>
            <#-- NOTE: these could be divided-->
            <@keyAppendixE.appendixEstudies subject=_subject docSubTypes=["Explosiveness", "OxidisingProperties"] name="explosive and oxidising properties"/>
        </sect1>

        <?hard-pagebreak?>

        <sect1>
            <title role="HEAD-2">Flammability and self-heating</title>
            <#-- NOTE: these could be divided-->
            <@keyAppendixE.appendixEstudies subject=_subject docSubTypes=["Flammability", "AutoFlammability", "FlashPoint"] name="flammability and self-heating"/>
        </sect1>

        <?hard-pagebreak?>

        <sect1>
            <title role="HEAD-2">Acidity/alkalinity and pH value</title>
            <@keyAppendixE.appendixEstudies subject=_subject docSubTypes="Ph" name="acidity/alkalinity and pH value"/>
        </sect1>

        <?hard-pagebreak?>

        <sect1>
            <title role="HEAD-2">Viscosity and surface tension</title>
            <@keyAppendixE.appendixEstudies subject=_subject docSubTypes=["Viscosity", "SurfaceTension"] name="viscosity and surface tension"/>
        </sect1>

        <?hard-pagebreak?>

        <sect1>
            <title role="HEAD-2">Relative density and bulk density</title>
            <@keyAppendixE.appendixEstudies subject=_subject docSubTypes="Density" name="relative and bulk density"/>
        </sect1>

        <?hard-pagebreak?>

        <sect1>
            <title role="HEAD-2">Storage stability and shelf-life: effects of temperature on technical characteristics of the plant protection product</title>
            <@keyAppendixE.appendixEstudies subject=_subject docSubTypes=["StorageStability", "StabilityThermal"] name="storage stability and shelf-life"/>
        </sect1>

        <?hard-pagebreak?>

        <sect1>
            <title role="HEAD-2">Technical characteristics of the plant protection product</title>
            <#-- NOTE: there is no summary for any of these-->
            <sect2>
                <title role="HEAD-2">Wettability</title>
                <@keyAppendixE.appendixEstudies subject=_subject docSubTypes="TechnicalCharacteristics" context=physchemContext["wettability"] name="wettability"/>
            </sect2>

            <sect2>
                <title role="HEAD-2">Persistent foaming</title>
                <@keyAppendixE.appendixEstudies subject=_subject docSubTypes="TechnicalCharacteristics" context=physchemContext["foaming"] name="persistent foaming"/>
            </sect2>

            <sect2>
                <title role="HEAD-2">Suspensibility, spontaneity of dispersion and dispersion stability</title>
                <@keyAppendixE.appendixEstudies subject=_subject docSubTypes="TechnicalCharacteristics" context=physchemContext["suspensibility"] name="suspensibility, spontaneity and dispersion stability"/>
            </sect2>

            <sect2>
                <title role="HEAD-2">Degree of dissolution and dilution stability</title>
                <@keyAppendixE.appendixEstudies subject=_subject docSubTypes="DegreeOfDissolutionAndDilutionStability"/>
            </sect2>

            <sect2>
                <title role="HEAD-2">Particle size distribution, dust content, attrition and mechanical stability</title>
                <sect3 label="1-2.8.3">
                    <title role="HEAD-2">Particle size distribution, dust content and attrition</title>
                    <@keyAppendixE.appendixEstudies subject=_subject docSubTypes="TechnicalCharacteristics" context=physchemContext["sizedustattrition"] name="size distribution, dust content and/or attrition"/>
                </sect3>

<#--                <sect3>-->
<#--                    <title role="HEAD-2">Dust content</title>-->
<#--                    <para>Study summaries for dust content are provided in <command  linkend="CP2851-${subjectId}">Section 2.8.5.1</command>.</para>-->
<#--                </sect3>-->

<#--                <sect3>-->
<#--                    <title role="HEAD-2">Attrition</title>-->
<#--                    <para>Study summaries for attrition are provided in <command  linkend="CP2851-${subjectId}">Section 2.8.5.1</command>.</para>-->
<#--                </sect3>-->

                <sect3 label="4">
                    <title role="HEAD-2">Hardness and integrity</title>
                    <@keyAppendixE.appendixEstudies subject=_subject docSubTypes="TechnicalCharacteristics" context=physchemContext["hardness"] name="hardness and integrity"/>
                </sect3>
            </sect2>

            <sect2>
                <title role="HEAD-2">Emulsifiability, re-emulsifiability, emulsion stability</title>
                <@keyAppendixE.appendixEstudies subject=_subject docSubTypes="TechnicalCharacteristics" context=physchemContext["emulsifiability"] name="emulsifiability, re-emulsifiability and emulsion stability"/>
            </sect2>

            <sect2>
                <title role="HEAD-2">Flowability, pourability and dustability</title>
                <@keyAppendixE.appendixEstudies subject=_subject docSubTypes="TechnicalCharacteristics" context=physchemContext["flowability"] name="flowability, pourability and dustability"/>
            </sect2>

        </sect1>

        <?hard-pagebreak?>

        <sect1>
            <title role="HEAD-2">Physical and chemical compatibility with other products including plant protection products with which its use is to be authorised</title>
            <#--NOTE: no summary-->
            <@keyAppendixE.appendixEstudies subject=_subject docSubTypes="PhysicalChemicalCompatibility" name="physical and chemical compatibility with other products"/>
        </sect1>

        <?hard-pagebreak?>

        <sect1>
            <title role="HEAD-2">Adherence and distribution to seeds</title>
            <@keyAppendixE.appendixEstudies subject=_subject docSubTypes="AdditionalPhysicoChemical" context=physchemContext["seeds"] name="adherence and distribution to seeds"/>
        </sect1>

        <?hard-pagebreak?>

        <sect1>
            <title role="HEAD-2">Other studies</title>
            <@keyAppendixE.appendixEstudies subject=_subject docSubTypes=["TechnicalCharacteristics","AdditionalPhysicoChemical"] context=physchemContext["other"] name="other physico-chemical characteristics"/>
        </sect1>
    </#if>

<#elseif _subject.documentType=="SUBSTANCE">

    <#if workingContext=="MICRO">

        <sect1>
            <title role="HEAD-2">History of the micro-organism and its uses. Natural occurrence and geographical distribution</title>

            <para>
                <para><@keyBioPropMicro.BioPropMicroSection  "BiologicalPropertiesOfTheMicroorganism.GeneralInformationOnTheMicroorganism.field1536"/></para>
            </para>

            <sect2>
                <title role="HEAD-2">Historical background</title>

                <para>
                    <para><emphasis role="bold">Historical background</emphasis></para>
                    <para><@keyBioPropMicro.BioPropMicroSection  "BiologicalPropertiesOfTheMicroorganism.GeneralInformationOnTheMicroorganism.HistoricalBackground.field7165"/></para>
                </para>

                <para>
                    <para><emphasis role="bold">Historical uses</emphasis></para>
                    <para><@keyBioPropMicro.BioPropMicroSection  "BiologicalPropertiesOfTheMicroorganism.GeneralInformationOnTheMicroorganism.HistoricalUses.field1752"/></para>
                </para>
            </sect2>

            <sect2>
                <title role="HEAD-2">Origin and natural occurrence</title>

                <para>
                    <para><@keyBioPropMicro.BioPropMicroSection  "BiologicalPropertiesOfTheMicroorganism.GeneralInformationOnTheMicroorganism.OriginNaturalOccurrenceAndGeographicalDistribution.field6386"/></para>
                </para>

            </sect2>
        </sect1>

        <?hard-pagebreak?>

        <sect1>
            <title role="HEAD-2">Information on target organism(s)</title>
            <@keyBioPropMicro.effectivenessTargetOrgSummary subject=_subject includeMetabolites=false/>

            <sect2>
                <title role="HEAD-2">Description of the target organism(s)</title>
                <@keyAppendixE.appendixEstudies subject=_subject docSubTypes="EffectivenessAgainstTargetOrganisms" context=physchemContext["effectiveness_harmful"]
                name="effects on harmful organisms" includeMetabolites=false/>
            </sect2>

            <sect2>
                <title role="HEAD-2">Mode of action</title>
                <@keyAppendixE.appendixEstudies subject=_subject docSubTypes="EffectivenessAgainstTargetOrganisms" context=physchemContext["effectiveness_modeofaction"] name="mode of action"
                includeMetabolites=false/>
            </sect2>
        </sect1>

        <?hard-pagebreak?>

        <sect1>
            <title role="HEAD-2">Host specificity range and effects on species other than the target harmful organism</title>
            <@keyBioPropMicro.toxicityToOtherAboveGroundOrganismsSummary subject=_subject includeMetabolites=false/>
            <@com.emptyLine/>
            <@keyAppendixE.appendixEstudies subject=_subject docSubTypes="ToxicityToOtherAboveGroundOrganisms" name="effects on species other than target organism" includeMetabolites=false/>
        </sect1>

        <?hard-pagebreak?>

        <sect1>
            <title role="HEAD-2">Development stages/life cycle of the micro-organism</title>
            <para><@keyBioPropMicro.BioPropMicroSection  "BiologicalPropertiesOfTheMicroorganism.DevelopmentStagesLifeCycleOfTheMicroorganism.field6313"/></para>

        </sect1>

        <sect1>
            <title role="HEAD-2">Infectiveness, dispersal and colonisation ability</title>

            <para><emphasis role="bold">Infectiveness, dispersal and colonisation ability</emphasis></para>
            <para><@keyBioPropMicro.BioPropMicroSection  "EffectivenessAgainstTargetOrganisms.InfectivenessDispersalAndColonisationAbility.field9314"/></para>

            <para><emphasis role="bold">Robustness to environmental factors</emphasis></para>
            <para><@keyBioPropMicro.BioPropMicroSection  "BiologicalPropertiesOfTheMicroorganism.RobustnessToEnvironmentalFactors.field9770"/></para>

             <#-- NOTE: this section should be under method of manufacture-->
             <para><emphasis role="bold">Methods to prevent loss of virulence of seed stock of the microorganism</emphasis></para>
             <para><@keyBioPropMicro.BioPropMicroSection  "EffectivenessAgainstTargetOrganisms.MethodsToPreventLossOfVirulenceOfSeedStockOfTheMicroorganism.field8887"/></para>

        </sect1>

        <sect1>
            <title role="HEAD-2">Relationships to known plant or animal or human pathogens</title>
            <@keyBioPropMicro.BioPropMicroSection  "BiologicalPropertiesOfTheMicroorganism.RelationshipsToKnownPlantOrAnimalOrHumanPathogens.field7482"/>

        </sect1>

        <sect1>
            <title role="HEAD-2">Genetic stability and factors affecting it</title>
            <@keyBioPropMicro.BioPropMicroSection  "BiologicalPropertiesOfTheMicroorganism.GeneticStabilityAndFactorsAffectingIt.field3673"/>
        </sect1>

        <sect1>
            <title role="HEAD-2">Information on the production of metabolites (especially toxins)</title>
            <@keyBioPropMicro.BioPropMicroSection  "BiologicalPropertiesOfTheMicroorganism.InformationOnTheProductionOfMetabolitesEspeciallyToxins.field1601"/>
        </sect1>

        <sect1>
            <title role="HEAD-2">Antibiotics and other anti-microbial agents</title>
            <@keyBioPropMicro.BioPropMicroSection  "BiologicalPropertiesOfTheMicroorganism.ProductionAndResistanceToAntibioticsAndOtherAntimicrobialAgents.field5725"/>
        </sect1>

        <#--        NOTES: sections not used from biopropmicro-->
        <#--        FLEXIBLE_RECORD.BioPropertiesMicro.BiologicalPropertiesOfTheMicroorganism.FurtherInformationOnTheMicroorganism.field5857-->
        <#--        FLEXIBLE_RECORD.BioPropertiesMicro.MeasuresNecessaryToProtectHumansAnimalsAndTheEnvironment.MonitoringPlanToBeUsedForTheActiveMicroorganismIncludingHandlingStorageTransportAndUse.field1483-->
        <#--        FLEXIBLE_RECORD.BioPropertiesMicro.ClassificationLabellingOfTheMicroorganism.RelevantRiskGroupSpecifiedInArticle2OfDirective200054EC.field1556-->
        <#--        FLEXIBLE_RECORD.BioPropertiesMicro.BiologicalPropertiesOfTheMicroorganismInTheBiocidalProduct.field6878-->

    <#elseif workingContext=="MRL">

        <@keyPhysChemSummary.physicalChemicalPropertiesSummary _subject/>
        <@com.emptyLine/>
        <@keyPhysChemSummary.physicalChemicalPropertiesTable _subject/>
        <?hard-pagebreak?>

        <sect1>
            <title role="HEAD-2">Solubility in water</title>
            <@keyAppendixE.appendixEstudies _subject "WaterSolubility"/>
        </sect1>

        <?hard-pagebreak?>

        <sect1>
            <title role="HEAD-2">Partition coefficient n-octanol/water</title>
            <@keyAppendixE.appendixEstudies _subject "Partition" "" "partition coefficient"/>
            <#-- NOTE: summary "PartitionCoefficient"-->
        </sect1>

    <#elseif workingContext=="CHEM">

        <@keyPhysChemSummary.physicalChemicalPropertiesSummary _subject/>
        <@com.emptyLine/>
        <@keyPhysChemSummary.physicalChemicalPropertiesTable _subject/>
        <?hard-pagebreak?>

        <sect1>
            <title role="HEAD-2">Melting point and boiling point</title>
            <@keyAppendixE.appendixEstudies subject=_subject docSubTypes=["Melting", "BoilingPoint"] name="melting and/or boiling point"/>
            <#--NOTE: this could be divided-->
            <#--        <sect2>-->
            <#--            <title role="HEAD-3">Melting point</title>-->
            <#--            <@keyAppendixE.appendixEstudies _subject "Melting" "" "melting_point"/>-->

            <#--        </sect2>-->
            <#--        <sect2>-->
            <#--            <title role="HEAD-3">Boiling point</title>-->
            <#--            <@keyAppendixE.appendixEstudies _subject "BoilingPoint"/>-->

            <#--        </sect2>-->
        </sect1>

        <?hard-pagebreak?>

        <sect1>
            <title role="HEAD-2">Vapour pressure, volatility</title>
            <@keyAppendixE.appendixEstudies subject=_subject docSubTypes=["Vapour", "HenrysLawConstant"] name="vapour pressure and volatility"/>
            <#--NOTE: this could be divided-->
            <#--        <sect2>-->
            <#--            <title role="HEAD-3">Vapour pressure</title>-->
            <#--            <@keyAppendixE.appendixEstudies _subject "Vapour" "" "vapour pressure"/>-->
            <#--        </sect2>-->
            <#--        <sect2>-->
            <#--            <title role="HEAD-3">Volatility (Henry's Law Constant)</title>-->
            <#--            <@keyAppendixE.appendixEstudies _subject "HenrysLawConstant" "" "volatility"/>-->
            <#--        </sect2>-->
        </sect1>

        <?hard-pagebreak?>

        <sect1>
            <title role="HEAD-2">Appearance (physical state, colour)</title>
            <@keyAppendixE.appendixEstudies _subject "GeneralInformation" "" "appearance"/>
        </sect1>

        <?hard-pagebreak?>

        <sect1>
            <title role="HEAD-2">Spectra (UV/VIS, IR, NMR, MS), molar extinction at relevant wavelengths, optical purity</title>
            <@keyPhyschem.opticalStudies _subject />
        </sect1>

        <?hard-pagebreak?>

        <sect1>
            <title role="HEAD-2">Solubility in water</title>
            <@keyAppendixE.appendixEstudies _subject "WaterSolubility"/>
        </sect1>

        <?hard-pagebreak?>

        <sect1>
            <title role="HEAD-2">Solubility in organic solvents</title>
            <@keyAppendixE.appendixEstudies _subject "SolubilityOrganic" "" "solubility in organic solvents"/>
        </sect1>

        <?hard-pagebreak?>

        <sect1>
            <title role="HEAD-2">Partition coefficient n-octanol/water</title>
            <@keyAppendixE.appendixEstudies _subject "Partition" "" "partition coefficient"/>
        </sect1>

        <?hard-pagebreak?>

        <sect1>
            <title role="HEAD-2">Dissociation in water</title>
            <@keyAppendixE.appendixEstudies _subject "DissociationConstant" "" "dissociation in water"/>
        </sect1>

        <?hard-pagebreak?>

        <sect1>
            <title role="HEAD-2">Flammability and self-heating</title>
            <@keyAppendixE.appendixEstudies subject=_subject docSubTypes=["Flammability", "AutoFlammability"] name="flammability and self heating"/>
            <#--NOTE: this could be divided-->
            <#--        <sect2>-->
            <#--            <title role="HEAD-3">Flammability</title>-->
            <#--            <@keyAppendixE.appendixEstudies _subject "Flammability"/>-->
            <#--        </sect2>-->
            <#--        <sect2>-->
            <#--            <title role="HEAD-3">Self heating</title>-->
            <#--            <@keyAppendixE.appendixEstudies _subject "AutoFlammability" "" "self heating"/>-->
            <#--        </sect2>-->
        </sect1>

        <?hard-pagebreak?>

        <sect1>
            <title role="HEAD-2">Flash point</title>
            <@keyAppendixE.appendixEstudies _subject "FlashPoint"/>
        </sect1>

        <?hard-pagebreak?>

        <sect1>
            <title role="HEAD-2">Explosive properties</title>
            <@keyAppendixE.appendixEstudies _subject "Explosiveness"/>
        </sect1>

        <?hard-pagebreak?>

        <sect1>
            <title role="HEAD-2">Surface tension</title>
            <@keyAppendixE.appendixEstudies _subject "SurfaceTension"/>
        </sect1>

        <?hard-pagebreak?>

        <sect1>
            <title role="HEAD-2">Oxidising properties</title>
            <@keyAppendixE.appendixEstudies _subject "OxidisingProperties"/>
        </sect1>

        <?hard-pagebreak?>

        <sect1>
            <title role="HEAD-2">Other studies</title>
            <@keyAppendixE.appendixEstudies _subject "AdditionalPhysicoChemical" "" "other physico-chemical characteristics"/>
        </sect1>

    </#if>
</#if>
<#assign ecotoxContext = { "ToxicityToBirds_oral" : [{"path": "AdministrativeData.Endpoint", "val" : ["acute oral"], "qual" : "lk", "type" : "picklist"}],

                            "ToxicityToBirds_dietary" : [{"path": "AdministrativeData.Endpoint", "val" : ["dietary"], "qual" : "lk", "type" : "picklist"}],

                            "ToxicityToBirds_long" : [{"path": "AdministrativeData.Endpoint", "val" : ["long-term"], "qual" : "lk", "type" : "picklist"}],

                            "ToxicityToBirds_other" : [{"path": "AdministrativeData.Endpoint", "val" : ["acute oral", "dietary","long-term" ],
                                                            "qual" : "nl", "type" : "picklist"}],

                            "ToxicityToBirds_field" : [{"path": "AdministrativeData.Endpoint", "val" : ["effects in field conditions"], "qual" : "lk", "type" : "picklist"}],

                            "ToxicityToBirds_other2" : [{"path": "AdministrativeData.Endpoint", "val" : ["acute oral", "effects in field conditions"], "qual" : "nl", "type" : "picklist"}],

                            "LongTermToxToFish_early" : [{"path": "AdministrativeData.Endpoint", "val" : ["fish early-life", "embryo and sac-fry", "juvenile growth"],
                                                            "qual" : "lk", "type" : "picklist"}],

                            "LongTermToxToFish_full" : [{"path": "AdministrativeData.Endpoint", "val" : ["fish early-life", "embryo and sac-fry", "juvenile growth"],
                                                            "qual" : "nl", "type" : "picklist"}],

                            "ShortTermToxicityToAquaInv_daphnia" : [{"path": "MaterialsAndMethods.TestOrganisms.TestOrganismsSpecies", "val" : ["Daphnia magna"],
                                                                        "qual" : "lk", "type" : "picklist"}],

                            "ShortTermToxicityToAquaInv_other" : [{"path": "MaterialsAndMethods.TestOrganisms.TestOrganismsSpecies",
                                                                        "val" : ["Daphnia magna"], "qual" : "nl", "type" : "picklist"}],

                            "LongTermToxicityToAquaInv_daphnia" : [{"path": "MaterialsAndMethods.TestOrganisms.TestOrganismsSpecies",
                                                                        "val" : ["Daphnia magna"], "qual" : "lk", "type" : "picklist"}],

                            "LongTermToxicityToAquaInv_chironomus" : [{"path": "MaterialsAndMethods.TestOrganisms.TestOrganismsSpecies",
                                                                        "val" : ["Chironomus riparius"], "qual" : "lk", "type" : "picklist"}],

                            "LongTermToxicityToAquaInv_other" : [{"path": "MaterialsAndMethods.TestOrganisms.TestOrganismsSpecies",
                                                                            "val" : ["Chironomus riparius", "Daphnia magna"], "qual" : "nl", "type" : "picklist"}],

                            "ToxicityToAquaticAlgae_green" : [{"path": "AdministrativeData.Endpoint", "val" : ["green algae"],
                                                                            "qual" : "lk", "type" : "picklist"}],

                            "ToxicityToAquaticAlgae_additional" : [{"path": "AdministrativeData.Endpoint", "val" : ["green algae"],
                                                                            "qual" : "nl", "type" : "picklist"}],

                            "ToxicityToTerrestrialArthropods_acuteOralBees" : [{"path": "AdministrativeData.Endpoint",
                                                                                "val" : ["toxicity to bees: acute oral"], "qual" : "eq", "type" : "picklist"}],

                            "ToxicityToTerrestrialArthropods_acuteContactBees" : [{"path": "AdministrativeData.Endpoint",
                                                                                    "val" : ["toxicity to bees: acute contact"], "qual" : "eq", "type" : "picklist"}],

                            "ToxicityToTerrestrialArthropods_chronicOralBees" : [{"path": "AdministrativeData.Endpoint",
                                                                                    "val" : ["toxicity to bees: chronic oral"], "qual" : "eq", "type" : "picklist"}],

                            "ToxicityToTerrestrialArthropods_developmentBees" : [{"path": "AdministrativeData.Endpoint",
                                                                                    "val" : ["bee larval", "residues on foliage, nectar and pollen",
                                                                                                "cage and tunnel", "field tests"],
                                                                                    "qual" : "lk", "type" : "picklist"}],

                            "ToxicityToTerrestrialArthropods_developmentBees2" : [{"path": "AdministrativeData.Endpoint",
                                                                                "val" : ["bee larval", "residues on foliage, nectar and pollen"],
                                                                                "qual" : "lk", "type" : "picklist"}],

                            "ToxicityToTerrestrialArthropods_cageBees" : [{"path": "AdministrativeData.Endpoint", "val" : ["cage and tunnel"],
                                                                        "qual" : "lk", "type" : "picklist"}],

                            "ToxicityToTerrestrialArthropods_fieldBees" : [{"path": "AdministrativeData.Endpoint", "val" : ["toxicity to bees: field tests"],
                                                                        "qual" : "lk", "type" : "picklist"}],

                            "ToxicityToTerrestrialArthropods_sublethalBees" : [{"path": "AdministrativeData.Endpoint", "val" : ["bees: sublethal"],
                                                                                    "qual" : "lk", "type" : "picklist"}],

                            "ToxicityToTerrestrialArthropods_aphidiusRho" : [{"path": "AdministrativeData.Endpoint", "val" : ["bee"], "qual" : "nl", "type" : "picklist"},
                                                                                {"path": "MaterialsAndMethods.TestOrganisms.TestOrganismsSpecies", "val" : ["Aphidius rhopalosiphi"], "qual" : "lk", "type" : "picklist"}],

                            "ToxicityToTerrestrialArthropods_typhlodromusPyr" : [{"path": "AdministrativeData.Endpoint", "val" : ["bee"], "qual" : "nl", "type" : "picklist"},
                                                                                    {"path": "MaterialsAndMethods.TestOrganisms.TestOrganismsSpecies",
                                                                                        "val" : ["Typhlodromus pyri"], "qual" : "lk", "type" : "picklist"}],

                            "ToxicityToTerrestrialArthropods_folsomiaAndHypoaspis" : [{"path": "AdministrativeData.Endpoint", "val" : ["bee"], "qual" : "nl", "type" : "picklist"},
                                                                                                    {"path": "MaterialsAndMethods.TestOrganisms.TestOrganismsSpecies",
                                                                                                        "val" : ["Folsomia candida","Hypoaspis aculeifer"],
                                                                                                        "qual" : "lk", "type" : "picklist"}],

                            "ToxicityToTerrestrialArthropods_soilMesofauna" : [{"path": "AdministrativeData.Endpoint", "val" : ["bee"], "qual" : "nl", "type" : "picklist"},
                                                                                {"path": "MaterialsAndMethods.TestOrganisms.AnimalGroup", "val" : ["soil-dwelling"], "qual" : "lk", "type" : "picklist"},
                                                                                {"path": "MaterialsAndMethods.TestOrganisms.TestOrganismsSpecies",
                                                                                            "val" : ["Typhlodromus pyri", "Aphidius rhopalosiphi", "Folsomia candida","Hypoaspis aculeifer"],
                                                                                            "qual" : "nl", "type" : "picklist"}],

                            "ToxicityToTerrestrialArthropods_other" : [{"path": "AdministrativeData.Endpoint", "val" : ["bee"], "qual" : "nl", "type" : "picklist"},
                                                                        {"path": "MaterialsAndMethods.TestOrganisms.AnimalGroup", "val" : ["soil-dwelling"], "qual" : "nl", "type" : "picklist"},
                                                                        {"path": "MaterialsAndMethods.TestOrganisms.TestOrganismsSpecies",
                                                                                    "val" : ["Typhlodromus pyri", "Aphidius rhopalosiphi", "Folsomia candida", "Hypoaspis aculeifer"], "qual" : "nl", "type" : "picklist"}],

                            "ToxicityToTerrestrialArthropods_otherAgedResidue" : [{"path": "AdministrativeData.Endpoint", "val" : ["aged residue"], "qual" : "lk", "type" : "picklist"},
                                                                                    {"path": "MaterialsAndMethods.TestOrganisms.AnimalGroup", "val" : ["soil-dwelling"], "qual" : "nl", "type" : "picklist"},
                                                                                    {"path": "MaterialsAndMethods.TestOrganisms.TestOrganismsSpecies",
                                                                                        "val" : ["Folsomia candida", "Hypoaspis aculeifer"], "qual" : "nl", "type" : "picklist"}],

                            "ToxicityToTerrestrialArthropods_otherStandard" : [{"path": "AdministrativeData.Endpoint", "val" : ["bee", "aged residue", "semi-field", "field"],
                                                                                    "qual" : "nl", "type" : "picklist"},
                                                                                {"path": "MaterialsAndMethods.TestOrganisms.AnimalGroup", "val" : ["soil-dwelling"], "qual" : "nl", "type" : "picklist"},
                                                                                {"path": "MaterialsAndMethods.TestOrganisms.TestOrganismsSpecies",
                                                                                    "val" : ["Folsomia candida", "Hypoaspis aculeifer"], "qual" : "nl", "type" : "picklist"},
                                                                                 {"path": "MaterialsAndMethods.StudyDesign.StudyType", "val" : ["laboratory study"],"qual" : "eq", "type" : "picklist"}],

                            "ToxicityToTerrestrialArthropods_otherExtended" : [{"path": "AdministrativeData.Endpoint", "val" : ["bee", "semi-field", "field", "aged residue"], "qual" : "nl", "type" : "picklist"},
                                                                                {"path": "MaterialsAndMethods.TestOrganisms.AnimalGroup", "val" : ["soil-dwelling"], "qual" : "nl", "type" : "picklist"},
                                                                                {"path": "MaterialsAndMethods.TestOrganisms.TestOrganismsSpecies",
                                                                                    "val" : ["Folsomia candida", "Hypoaspis aculeifer"], "qual" : "nl", "type" : "picklist"},
                                                                                {"path": "MaterialsAndMethods.StudyDesign.StudyType", "val" : ["extended laboratory study"], "qual" : "eq", "type" : "picklist"}],

                            "ToxicityToTerrestrialArthropods_otherSemifield" : [{"path": "AdministrativeData.Endpoint", "val" : ["semi-field"], "qual" : "lk", "type" : "picklist"},
                                                                                {"path": "MaterialsAndMethods.TestOrganisms.AnimalGroup", "val" : ["soil-dwelling"], "qual" : "nl", "type" : "picklist"},
                                                                                {"path": "MaterialsAndMethods.TestOrganisms.TestOrganismsSpecies",
                                                                                        "val" : ["Folsomia candida", "Hypoaspis aculeifer"], "qual" : "nl", "type" : "picklist"}],
                            <#--NOTE: could be also in study type-->

                            "ToxicityToTerrestrialArthropods_otherField" : [{"path": "AdministrativeData.Endpoint", "val" : ["field studies"], "qual" : "lk", "type" : "picklist"},
                                                                            {"path": "AdministrativeData.Endpoint", "val" : ["semi-field studies"], "qual" : "nl", "type" : "picklist"},
                                                                            {"path": "MaterialsAndMethods.TestOrganisms.AnimalGroup", "val" : ["soil-dwelling"], "qual" : "nl", "type" : "picklist"},
                                                                            {"path": "MaterialsAndMethods.TestOrganisms.TestOrganismsSpecies",
                                                                                "val" : ["Folsomia candida", "Hypoaspis aculeifer"], "qual" : "nl", "type" : "picklist"}],
                            <#--NOTE: could be also in study type-->

                            "ToxicityToTerrestrialArthropods_otherOther" : [{"path": "AdministrativeData.Endpoint", "val" : ["bee", "aged residue", "semi-field", "field"],
                                                                                "qual" : "nl", "type" : "picklist"},
                                                                             {"path": "MaterialsAndMethods.TestOrganisms.AnimalGroup", "val" : ["soil-dwelling"], "qual" : "nl", "type" : "picklist"},
                                                                             {"path": "MaterialsAndMethods.TestOrganisms.TestOrganismsSpecies",
                                                                                "val" : ["Folsomia candida", "Hypoaspis aculeifer"], "qual" : "nl", "type" : "picklist"},
                                                                             {"path": "MaterialsAndMethods.StudyDesign.StudyType",
                                                                                "val" : ["laboratory study", "extended laboratory study"],
                                                                                "qual" : "ne", "type" : "picklist"}],

                            "ToxicityToTerrestrialArthropods_bees" : [{"path": "AdministrativeData.Endpoint", "val" : ["bee"], "qual" : "lk", "type" : "picklist"}],

                            <#--    probably this is wrong-->
                            "ToxicityToTerrestrialArthropods_other_micro" : [{"path": "AdministrativeData.Endpoint", "val" : ["bee"], "qual" : "nl", "type" : "picklist"}],

                            "ToxicityToSoilMacroorganismsExceptArthropods_earthworm" : [
                                            <#-- {"path": "MaterialsAndMethods.TestOrganisms.TestOrganismsSpecies",-->
                                            <#--"val" : ["Eisenia", "Aporrectodea", "Enchytraeus", "Lumbricus", "Cognettia"],-->
                                                    <#-- other possibilities:-->
                                                    <#-- "Allolobophor", "Murchieona", "Octolasion", "Prosellodrilus", "Microscolex", "Hormogaster", "Dendrobaena", "Octodrilus", -->
                                                    <#-- "Postandrilus", "Scherotheca", "Amynthas", "Eukerria", "Ocnerodrilus"],-->
                                            <#-- "qual" : "lk", "type" : "picklist"}-->
                                            {"path": "MaterialsAndMethods.TestOrganisms.AnimalGroup", "val":["annelids"], "qual" : "lk", "type" : "picklist"}],

                            "ToxicityToSoilMacroorganismsExceptArthropods_earthwormNofield" : [{"path": "MaterialsAndMethods.StudyDesign.StudyType", "val" : ["field study"],
                                                                                                "qual" : "ne", "type" : "picklist"},
                                                                                                {"path": "MaterialsAndMethods.TestOrganisms.AnimalGroup", "val":["annelids"],
                                                                                                "qual" : "lk", "type" : "picklist"}],

                            "ToxicityToSoilMacroorganismsExceptArthropods_earthwormField" : [{"path": "MaterialsAndMethods.StudyDesign.StudyType", "val" : ["field study"],
                                                                                                "qual" : "eq", "type" : "picklist"},
                                                                                                {"path": "MaterialsAndMethods.TestOrganisms.AnimalGroup", "val":["annelids"],
                                                                                                "qual" : "lk", "type" : "picklist"}],

                            "ToxicityToSoilMacroorganismsExceptArthropods_noEarthworm" : [{"path": "MaterialsAndMethods.TestOrganisms.AnimalGroup", "val":["annelids"],
                                                                                            "qual" : "nl", "type" : "picklist"}],

                            "ToxicityToTerrestrialPlants_extended":[{"path": "MaterialsAndMethods.StudyDesign.StudyType",
                                                                        "val" : ["extended laboratory study"],
                                                                        "qual" : "eq", "type" : "picklist"}],

                            "ToxicityToTerrestrialPlants_fieldSemifield":[{"path": "MaterialsAndMethods.StudyDesign.StudyType",
                                                                        "val" : ["semi-field study", "field study"],
                                                                        "qual" : "eq", "type" : "picklist"}],

                            "ToxicityToTerrestrialPlants_other":[{"path": "MaterialsAndMethods.StudyDesign.StudyType",
                                                                        "val" : ["semi-field study", "field study", "extended laboratory study"],
                                                                        "qual" : "ne", "type" : "picklist"}]
}/>


<#if workingContext=="CHEM">

    <#if _subject.documentType=="SUBSTANCE">

        <sect1>
            <title role="HEAD-2">Effects on birds and other terrestrial vertebrates</title>

            <sect2>
                <title role="HEAD-3">Effects on birds</title>
                <@keyEcotox.ecotoxPPPsummary _subject "ToxicityBirds_EU_PPP"/>
                <sect3>
                    <title role="HEAD-4">Acute oral toxicity to birds</title>
                    <@keyAppendixE.appendixEstudies _subject "ToxicityToBirds" ecotoxContext["ToxicityToBirds_oral"] "acute oral toxicity to birds"/>
                </sect3>
                <sect3>
                    <title role="HEAD-4">Short-term dietary toxicity to birds</title>
                    <@keyAppendixE.appendixEstudies _subject "ToxicityToBirds" ecotoxContext["ToxicityToBirds_dietary"] "short-term dietary toxicity to birds"/>
                </sect3>

                <sect3>
                    <title role="HEAD-4">Sub-chronic and reproductive toxicity to birds</title>
                    <@keyAppendixE.appendixEstudies _subject "ToxicityToBirds" ecotoxContext["ToxicityToBirds_long"] "sub-chronic and reproductive toxicity to birds"/>
                </sect3>
                
                <#if keyAppendixE.containsDoc(_subject, "ENDPOINT_STUDY_RECORD.ToxicityToBirds", ecotoxContext["ToxicityToBirds_other"])>	
                    <sect3>
                        <title role="HEAD-4">Other toxicity to birds</title>
                        <@keyAppendixE.appendixEstudies _subject "ToxicityToBirds" ecotoxContext["ToxicityToBirds_other"] "other toxicity to birds"/>
                    </sect3>
                </#if>


            </sect2>

            <sect2>
                <title role="HEAD-3">Effects on terrestrial vertebrates other than birds</title>
                <@keyEcotox.ecotoxPPPsummary _subject "TerrestrialToxicity"/>

                <sect3>
                    <title role="HEAD-4">Acute oral toxicity to mammals</title>
                    <para>Study summaries for acute oral toxicity to mammals are provided in Section 5 (<command  linkend="CA521">5.2.1</command>).</para>
                </sect3>

                <sect3>
                    <title role="HEAD-4">Long-term and reproduction toxicity to mammals</title>
                    <para>Study summaries for long-term and reproductive toxicity to mammals are provided in Section 5
                        (<command  linkend="CA55">5.5</command> and <command  linkend="CA56">5.6.1-3</command>, respectively).</para>
                </sect3>
            </sect2>

            <sect2 xml:id="CA813">
                <#-- NOTE: not sure these are the right docs...-->
                <title role="HEAD-3">Effects of active substance bioconcentration in prey of birds and mammals</title>
                <@keyEcotox.ecotoxPPPsummary _subject "BioaccumulationTerrestrial"/>
                <@com.emptyLine/>
                <@keyAppendixE.appendixEstudies _subject "BioaccumulationTerrestrial"/>
            </sect2>

            <sect2>
                <title role="HEAD-3">Effects on terrestrial vertebrate wildlife (birds, mammals, reptiles and amphibians)</title>
                <@keyEcotox.ecotoxPPPsummary _subject "ToxicityToOtherAboveGroundOrganisms_EU_PPP"/>
                <@com.emptyLine/>
                <@keyAppendixE.appendixEstudies _subject "ToxicityToOtherAboveGroundOrganisms"/>
            </sect2>

            <sect2>
                <title role="HEAD-3">Endocrine disrupting properties</title>
                <para>Study summaries for endocrine disrupting properties are provided in Section 5 (<command  linkend="CA583">5.8.3</command>).</para>

            </sect2>
        </sect1>

        <?page-hardbreak?>

        <sect1>
            <title role="HEAD-2">Effects on aquatic organisms</title>
            <@keyEcotox.ecotoxPPPsummary _subject "AquaticToxicityRacReporting"/>

            <sect2>
                <title role="HEAD-3">Acute toxicity to fish</title>
                <@keyEcotox.ecotoxPPPsummary _subject "Short-termToxicityToFish_EU_PPP"/>
                <@com.emptyLine/>
                <@keyAppendixE.appendixEstudies _subject "ShortTermToxicityToFish"/>
            </sect2>

            <sect2>
                <title role="HEAD-3">Long-term and chronic toxicity to fish</title>
                <@keyEcotox.ecotoxPPPsummary _subject "LongTermToxicityToFish_EU_PPP"/>
                <#-- NOTE: applies to both early and full life stages-->
                <sect3>
                    <title role="HEAD-4">Fish early life stage toxicity test</title>
                    <@keyAppendixE.appendixEstudies _subject "LongTermToxToFish" ecotoxContext["LongTermToxToFish_early"] "toxicity in fish early life stages"/>
                </sect3>

                <sect3>
                    <title role="HEAD-4">Fish full life cycle test</title>
                    <@keyAppendixE.appendixEstudies _subject "LongTermToxToFish" ecotoxContext["LongTermToxToFish_full"] "toxicity in fish full life cycle"/>
                </sect3>

                <sect3>
                    <title role="HEAD-4">Bioconcentration in fish</title>
                    <@keyEcotox.ecotoxPPPsummary _subject "BioaccumulationAquaticSediment_EU_PPP"/>
                    <@com.emptyLine/>
                    <@keyAppendixE.appendixEstudies _subject "BioaccumulationAquaticSediment" "" "bioconcentration in fish"/>
                </sect3>
            </sect2>

            <sect2>
                <title role="HEAD-3">Endocrine disrupting properties</title>
                <@keyAppendixE.appendixEstudies _subject "EndocrineDisrupterTestingInAqua" "" "endocrine disrupting properties"/>
            </sect2>

            <sect2>
                <title role="HEAD-3">Acute toxicity to aquatic invertebrates</title>
                <@keyEcotox.ecotoxPPPsummary _subject "ShortTermToxicityAquaInvert_EU_PPP"/>
                <sect3>
                    <title role="HEAD-4">Acute toxicity to Daphnia magna</title>
                    <@keyAppendixE.appendixEstudies _subject "ShortTermToxicityToAquaInv" ecotoxContext["ShortTermToxicityToAquaInv_daphnia"]
                        "acute toxicity to Daphnia magna"/>
                </sect3>

                <sect3>
                    <title role="HEAD-4">Acute toxicity to an additional aquatic invertebrate species</title>
                    <@keyAppendixE.appendixEstudies _subject "ShortTermToxicityToAquaInv" ecotoxContext["ShortTermToxicityToAquaInv_other"]
                    "other aquatic invertebrate species"/>
                </sect3>
            </sect2>

            <sect2>
                <title role="HEAD-3">Long-term and chronic toxicity to aquatic invertebrates</title>
                <@keyEcotox.ecotoxPPPsummary _subject "LongTermToxicityToAquaticInvertebrates_EU_PPP"/>

                <sect3>
                    <title role="HEAD-4">Reproductive and development toxicity to Daphnia magna </title>
                    <@keyAppendixE.appendixEstudies _subject "LongTermToxicityToAquaInv" ecotoxContext["LongTermToxicityToAquaInv_daphnia"]
                    "reproductive and development toxicity to Daphnia magna"/>
                </sect3>

                <sect3>
                    <title role="HEAD-4">Reproductive and development toxicity to an additional aquatic invertebrate species</title>
                    <@keyAppendixE.appendixEstudies _subject "LongTermToxicityToAquaInv" ecotoxContext["LongTermToxicityToAquaInv_other"]
                    "reproductive and development toxicity to other aquatic invertebrate species"/>
                </sect3>

                <sect3>
                    <title role="HEAD-4">Development and emergence in Chironomus species</title>
                    <@keyAppendixE.appendixEstudies _subject "LongTermToxicityToAquaInv" ecotoxContext["LongTermToxicityToAquaInv_chironomus"]
                    "development and emergence in Chironomus species"/>
                </sect3>

                <sect3>
                    <title role="HEAD-4">Sediment dwelling organisms</title>
                    <@keyEcotox.ecotoxPPPsummary _subject "SedimentToxicity_EU_PPP"/>
                    <@com.emptyLine/>
                    <@keyAppendixE.appendixEstudies _subject "SedimentToxicity" "" "toxicity to sediment dwelling organisms"/>
                </sect3>

            </sect2>

            <sect2>
                <title role="HEAD-3">Effects on algal growth</title>
                <@keyEcotox.ecotoxPPPsummary _subject "ToxicityToAquaticAlgae_EU_PPP"/>

                <sect3>
                    <title role="HEAD-4">Effects on  growth of green algae</title>
                    <@keyAppendixE.appendixEstudies _subject "ToxicityToAquaticAlgae" ecotoxContext["ToxicityToAquaticAlgae_green"]
                    "toxicity to green algae"/>
                </sect3>

                <sect3>
                    <title role="HEAD-4">Effects on growth of an additional algal species</title>
                    <@keyAppendixE.appendixEstudies _subject "ToxicityToAquaticAlgae" ecotoxContext["ToxicityToAquaticAlgae_additional"]
                    "toxicity to other algae species"/>
                </sect3>
            </sect2>

            <sect2>
                <title role="HEAD-3">Effects on aquatic macrophytes</title>
                <@keyEcotox.ecotoxPPPsummary _subject "ToxicityPlants_EU_PPP"/>
                <@com.emptyLine/>
                <@keyAppendixE.appendixEstudies _subject "ToxicityToAquaticPlant" "" "toxicity to aquatic plants"/>
            </sect2>

            <sect2>
                <title role="HEAD-3">Further testing on aquatic organisms</title>
                <para>For any other study summaries on aquatic organisms, see  <command linkend="CA87">Section 8.7</command></para>
            </sect2>

        </sect1>

        <?page-hardbreak?>

        <sect1>
            <title role="HEAD-2">Effect on arthropods</title>
            <@keyEcotox.ecotoxPPPsummary _subject "ToxicityTerrestrialArthropods_EU_PPP"/>

            <sect2>
                <title role="HEAD-3">Effects on bees</title>

                <sect3>
                    <title role="HEAD-4">Acute toxicity to bees</title>

                    <sect4>
                        <title role="HEAD-4">Acute oral toxicity</title>
                        <@keyAppendixE.appendixEstudies _subject "ToxicityToTerrestrialArthropods" ecotoxContext["ToxicityToTerrestrialArthropods_acuteOralBees"]
                        "acute oral toxicity to bees"/>
                    </sect4>
                    <sect4>
                        <title role="HEAD-4">Acute contact toxicity</title>
                        <@keyAppendixE.appendixEstudies _subject "ToxicityToTerrestrialArthropods" ecotoxContext["ToxicityToTerrestrialArthropods_acuteContactBees"]
                        "acute contact toxicity to bees"/>
                    </sect4>
                </sect3>
                <sect3>
                    <title role="HEAD-4">Chronic toxicity to bees</title>
                    <@keyAppendixE.appendixEstudies _subject "ToxicityToTerrestrialArthropods" ecotoxContext["ToxicityToTerrestrialArthropods_chronicOralBees"]
                    "chronic toxicity to bees"/>
                </sect3>
                <sect3>
                    <title role="HEAD-4">Effects on honeybee development and other honeybee life stages</title>
                    <@keyAppendixE.appendixEstudies _subject "ToxicityToTerrestrialArthropods" ecotoxContext["ToxicityToTerrestrialArthropods_developmentBees"]
                    "toxicity to bee development and other life stages"/>
                </sect3>
                <sect3>
                    <title role="HEAD-4">Sub-lethal effects</title>
                    <@keyAppendixE.appendixEstudies _subject "ToxicityToTerrestrialArthropods" ecotoxContext["ToxicityToTerrestrialArthropods_sublethalBees"]
                    "sub-lethal effects to bees"/>
                </sect3>

            </sect2>

            <sect2>
                <title role="HEAD-3">Effects on non-target arthropods other than bees</title>
                <sect3>
                    <title role="HEAD-4">Effects on Aphidius rhopalosiphi</title>
                    <@keyAppendixE.appendixEstudies _subject "ToxicityToTerrestrialArthropods" ecotoxContext["ToxicityToTerrestrialArthropods_aphidiusRho"]
                    "toxicity to Aphidius rhopalosiphi"/>
                </sect3>

                <sect3>
                    <title role="HEAD-4">Effects on Typhlodromus pyri</title>
                    <@keyAppendixE.appendixEstudies _subject "ToxicityToTerrestrialArthropods" ecotoxContext["ToxicityToTerrestrialArthropods_typhlodromusPyr"]
                    "toxicity to Typhlodromus pyri"/>
                </sect3>
                
                <#if keyAppendixE.containsDoc(_subject, "ENDPOINT_STUDY_RECORD.ToxicityToTerrestrialArthropods", ecotoxContext["ToxicityToTerrestrialArthropods_other"])>
                    <sect3>
                        <title role="HEAD-4">Effects on other non-target arthropods</title>
                        <@keyAppendixE.appendixEstudies _subject "ToxicityToTerrestrialArthropods" ecotoxContext["ToxicityToTerrestrialArthropods_other"] "toxicity to other arthropods"/>
                    </sect3>
                </#if>
            </sect2>

        </sect1>

        <?page-hardbreak?>

        <sect1>
            <title role="HEAD-2">Effects on non-target soil meso- and macrofauna</title>

            <sect2>
                <title role="HEAD-3">Earthworm, sub-lethal effects</title>
                <@keyEcotox.ecotoxPPPsummary _subject "ToxicitySoilMacroorganisms_EU_PPP"/>
                <@com.emptyLine/>
                <@keyAppendixE.appendixEstudies _subject "ToxicityToSoilMacroorganismsExceptArthropods" ecotoxContext["ToxicityToSoilMacroorganismsExceptArthropods_earthworm"]
                    "toxicity to earthworms"/>
            </sect2>

            <sect2>
                <title role="HEAD-3"> Effects on non-target soil meso- and macrofauna (other than earthworms) </title>

                <sect3>
                    <title role="HEAD-4">Species level testing</title>
                    <#-- For Folsomia candida and Hypoaspis aculeifer -->
                    <@keyAppendixE.appendixEstudies _subject "ToxicityToTerrestrialArthropods" ecotoxContext["ToxicityToTerrestrialArthropods_folsomiaAndHypoaspis"]
                    "toxicity to Folsomia candida and Hypoaspis aculeifer species"/>
                </sect3>
                
                <#if keyAppendixE.containsDoc(_subject, "ENDPOINT_STUDY_RECORD.ToxicityToTerrestrialArthropods", ecotoxContext["ToxicityToTerrestrialArthropods_soilMesofauna"])>
                    <sect3>
                        <title role="HEAD-4">Other soil-dwelling arthropods</title>
                        <@keyAppendixE.appendixEstudies _subject "ToxicityToTerrestrialArthropods"
                        ecotoxContext["ToxicityToTerrestrialArthropods_soilMesofauna"] "toxicity to other soil-dwelling arthropods"/>
                    </sect3>
                </#if>
                
                <#if keyAppendixE.containsDoc(_subject, "ENDPOINT_STUDY_RECORD.ToxicityToSoilMacroorganismsExceptArthropods", ecotoxContext["ToxicityToSoilMacroorganismsExceptArthropods_noEarthworm"])>
                    <sect3>
                        <title role="HEAD-4">Other soil meso- and macrofauna </title>
                        <@keyAppendixE.appendixEstudies _subject "ToxicityToSoilMacroorganismsExceptArthropods"
                        ecotoxContext["ToxicityToSoilMacroorganismsExceptArthropods_noEarthworm"] "toxicity to other soil meso- and macrofauna"/>
                    </sect3>
                </#if>

            </sect2>

        </sect1>

        <?page-hardbreak?>

        <sect1>
            <title role="HEAD-2">Effects on soil nitrogen transformation</title>
            <@keyEcotox.ecotoxPPPsummary _subject "ToxicitySoilMacroorganisms_EU_PPP"/>
            <@com.emptyLine/>
            <@keyAppendixE.appendixEstudies _subject "ToxicityToSoilMicroorganisms"/>
        </sect1>

        <?page-hardbreak?>

        <sect1>
            <title role="HEAD-2">Effects on terrestrial non-target higher plants</title>
            <@keyEcotox.ecotoxPPPsummary _subject "ToxicityToTerrestrialPlants_EU_PPP"/>
            <#--NOTE: there are two subsections in legislation...-->
            <#--        Summary of screening data-->
            <#--        Testing on non-target plants-->
            <sect2 xml:id="CA861">
                <title role="HEAD-3">Summary of screening data</title>
                <@keyAppendixE.appendixEstudies _subject "ToxicityToTerrestrialPlants"/>
            </sect2>
            <sect2>
                <title role="HEAD-3">Testing on non-target plants</title>
                <para>For general testing on non-target plants see <command  linkend="CA861">Section 8.6.1</command> above.</para>

            </sect2>
        </sect1>

        <?page-hardbreak?>

        <sect1 xml:id="CA87">
            <title role="HEAD-2">Effects on other terrestrial organisms (flora and fauna)</title>
            <@keyEcotox.ecotoxPPPsummary _subject "AdditionalEcotoxicologicalInformation"/>
            <@com.emptyLine/>
            <@keyAppendixE.appendixEstudies _subject "AdditionalEcotoxicologicalInformation"/>
        </sect1>

        <?page-hardbreak?>

        <sect1>
            <title role="HEAD-2">Effects on biological methods for sewage treatment</title>
            <@keyEcotox.ecotoxPPPsummary _subject "EffectsBioMethodSewageTreatment"/>
            <@com.emptyLine/>
            <@keyAppendixE.appendixEstudies _subject "ToxicityToMicroorganisms"/>
        </sect1>

        <?page-hardbreak?>

        <sect1>
            <title role="HEAD-2">Monitoring data</title>
            <@keyEcotox.ecotoxPPPsummary _subject "BiologicalEffectsMonitoring"/>
            <@com.emptyLine/>
            <@keyAppendixE.appendixEstudies _subject "BiologicalEffectsMonitoring"/>
        </sect1>

    <#elseif _subject.documentType=="MIXTURE">

        <@keyEcotox.ecotoxRiskAssessmentPPP/>

        <sect1>
            <title role="HEAD-2">Effects on birds and other terrestrial vertebrates</title>

            <sect2>
                <title role="HEAD-3">Effects on birds</title>
                <@keyEcotox.ecotoxPPPsummary _subject "ToxicityBirds_EU_PPP"/>
                <sect3>
                    <title role="HEAD-4">Acute oral toxicity</title>
                    <@keyAppendixE.appendixEstudies _subject "ToxicityToBirds" ecotoxContext["ToxicityToBirds_oral"] "acute oral toxicity to birds"/>
                </sect3>
                <sect3>
                    <title role="HEAD-4">Higher tier data on birds</title>
                    <@keyAppendixE.appendixEstudies _subject "ToxicityToBirds" ecotoxContext["ToxicityToBirds_field"] "effects in field conditions"/>
                </sect3>
                
                <#if keyAppendixE.containsDoc(_subject, "ENDPOINT_STUDY_RECORD.ToxicityToBirds", ecotoxContext["ToxicityToBirds_other2"])>
                    <sect3>
                        <title role="HEAD-4">Other toxicity to birds</title>
                       <@keyAppendixE.appendixEstudies _subject "ToxicityToBirds" ecotoxContext["ToxicityToBirds_other2"] "other toxicity to birds"/>
                    </sect3>
                </#if>

            </sect2>

            <sect2 xml:id="CP1012">
                <title role="HEAD-3">Effects on terrestrial vertebrates other than birds</title>
                <@keyEcotox.ecotoxPPPsummary _subject "ToxicityToOtherAboveGroundOrganisms_EU_PPP"/>

                <sect3>
                    <title role="HEAD-4">Acute oral toxicity to mammals</title>
                    <para>Study summaries for acute oral toxicity to mammals are provided in Section 7 (<command  linkend="CP711">7.7.1</command>).</para>
                </sect3>

                <sect3 xml:id="CP10122">
                    <title role="HEAD-4">Higher tier data on mammals</title>
                    <para>Higher tier data on mammals are included in <command  linkend="CP107">Section 10.7</command>.</para>
                </sect3>
                
                <#if keyAppendixE.containsDoc(_subject, "ENDPOINT_STUDY_RECORD.ToxicityToOtherAboveGroundOrganisms")>
                    <sect3>
                        <title role="HEAD-4">Other toxicity to terrestrial vertebrates</title>
                        <@keyAppendixE.appendixEstudies _subject "ToxicityToOtherAboveGroundOrganisms"/>
                    </sect3>
                </#if>

            </sect2>

            <sect2>
                <title role="HEAD-3">Effects on other terrestrial vertebrate wildlife (reptiles and amphibians)</title>
                <para>Any study summaries for toxicity on other terrestrial vertebrate wildlife including reptiles and amphibians can be found in <command  linkend="CP1012">Section 10.1.2</command> above.</para>
            </sect2>
        </sect1>

        <?page-hardbreak?>

        <sect1>
            <title role="HEAD-2">Effects on aquatic organisms</title>
            <@keyEcotox.ecotoxPPPsummary _subject "AquaticToxicityRacReporting"/>

            <sect2>
                <title role="HEAD-3">Acute toxicity to fish, aquatic invertebrates, or effects on aquatic algae and macrophytes</title>
				<#-- NOTE: it could be split into the different sections-->
                <@keyEcotox.ecotoxPPPsummary subject=_subject
                    docSubTypes=["Short-termToxicityToFish_EU_PPP","ShortTermToxicityAquaInvert_EU_PPP", "ToxicityToAquaticAlgae_EU_PPP", "ToxicityPlants_EU_PPP"]
                    merge=true/>
                <@com.emptyLine/>
                <@keyAppendixE.appendixEstudies subject=_subject
                        docSubTypes=["ShortTermToxicityToFish", "ShortTermToxicityToAquaInv", "ToxicityToAquaticAlgae", "ToxicityToAquaticPlant"]
                        name="acute toxicity to aquatic organisms"/>
            </sect2>

            <sect2>
                <title role="HEAD-3">Add. long-term and chronic tox. studies on fish, aquatic invert., sediment dwelling org.</title>
                <@keyEcotox.ecotoxPPPsummary subject=_subject
                    docSubTypes=["LongTermToxicityToFish_EU_PPP","LongTermToxicityToAquaticInvertebrates_EU_PPP", "SedimentToxicity_EU_PPP"]
                    merge=true/>
                <@com.emptyLine/>
                <@keyAppendixE.appendixEstudies subject=_subject docSubTypes=["LongTermToxToFish","LongTermToxicityToAquaInv", "SedimentToxicity"]
                    name="long term and chronic toxicity to aquatic organisms"/>
            </sect2>

            <sect2>
                <title role="HEAD-3">Further testing on aquatic organisms</title>
                <@keyEcotox.ecotoxPPPsummary _subject "BioaccumulationAquaticSediment_EU_PPP"/>
                <@com.emptyLine/>
                <@keyAppendixE.appendixEstudies _subject "BioaccumulationAquaticSediment" "" "bioconcentration in fish"/>
            </sect2>
        </sect1>
  
        <?page-hardbreak?>

        <sect1>
            <title role="HEAD-2">Effects on arthropods</title>
            <@keyEcotox.ecotoxPPPsummary _subject "ToxicityTerrestrialArthropods_EU_PPP"/>

            <sect2>
                <title role="HEAD-3">Effects on bees</title>

                <sect3>
                    <title role="HEAD-4">Acute toxicity to bees</title>

                    <sect4>
                        <title role="HEAD-4">Acute oral toxicity to bees</title>
                        <@keyAppendixE.appendixEstudies _subject "ToxicityToTerrestrialArthropods" ecotoxContext["ToxicityToTerrestrialArthropods_acuteOralBees"]
                            "acute oral toxicity to bees"/>
                    </sect4>

                    <sect4>
                        <title role="HEAD-4">Acute contact toxicity to bees</title>
                        <@keyAppendixE.appendixEstudies _subject "ToxicityToTerrestrialArthropods" ecotoxContext["ToxicityToTerrestrialArthropods_acuteContactBees"]
                            "acute contact toxicity to bees"/>
                    </sect4>
                </sect3>

                <sect3>
                    <title role="HEAD-4">Chronic toxicity to bees</title>
                    <@keyAppendixE.appendixEstudies _subject "ToxicityToTerrestrialArthropods" ecotoxContext["ToxicityToTerrestrialArthropods_chronicOralBees"]
                        "chronic toxicity to bees"/>
                </sect3>

                <sect3>
                    <title role="HEAD-4">Effects on honeybee development and other honeybee life stages</title>
                    <@keyAppendixE.appendixEstudies _subject "ToxicityToTerrestrialArthropods" ecotoxContext["ToxicityToTerrestrialArthropods_developmentBees2"]
                        "effects on bee development and other life stages"/>
                </sect3>

                <sect3>
                    <title role="HEAD-4">Sub-lethal effects</title>
                    <@keyAppendixE.appendixEstudies _subject "ToxicityToTerrestrialArthropods" ecotoxContext["ToxicityToTerrestrialArthropods_sublethalBees"]
                        "sub-lethal effects"/>
                </sect3>

                <sect3>
                    <title role="HEAD-4">Cage and tunnel tests</title>
                    <@keyAppendixE.appendixEstudies _subject "ToxicityToTerrestrialArthropods" ecotoxContext["ToxicityToTerrestrialArthropods_cageBees"]
                        "cage and tunnel tests"/>
                </sect3>

                <sect3>
                    <title role="HEAD-4">Field tests with honeybees</title>
                    <@keyAppendixE.appendixEstudies _subject "ToxicityToTerrestrialArthropods" ecotoxContext["ToxicityToTerrestrialArthropods_fieldBees"]
                            "field tests with bees"/>
                </sect3>

            </sect2>

            <sect2>
                <title role="HEAD-3">Effects on non-target arthropods other than bees</title>

                <sect3>
                    <title role="HEAD-4">Standard laboratory testing for non-target arthropods</title>
                    <@keyAppendixE.appendixEstudies _subject "ToxicityToTerrestrialArthropods" ecotoxContext["ToxicityToTerrestrialArthropods_otherStandard"]
                        "standard laboratory testing for non-target arthropods"/>
                </sect3>

                <sect3>
                    <title role="HEAD-4">Extended laboratory testing, aged residue studies with non-target arthropods</title>
                    <sect4>
                        <title role="HEAD-4">Extended laboratory testing</title>
                        <@keyAppendixE.appendixEstudies _subject "ToxicityToTerrestrialArthropods" ecotoxContext["ToxicityToTerrestrialArthropods_otherExtended"]
                            "extended laboratory tests with non-target arthropods"/>
                    </sect4>

                    <sect4>
                        <title role="HEAD-4">Aged residue studies</title>
                        <@keyAppendixE.appendixEstudies _subject "ToxicityToTerrestrialArthropods" ecotoxContext["ToxicityToTerrestrialArthropods_otherAgedResidue"]
                        "aged residue studies"/>
                    </sect4>

                </sect3>

                <sect3>
                    <title role="HEAD-4">Semi-field studies with non-target arthropods</title>
                    <@keyAppendixE.appendixEstudies _subject "ToxicityToTerrestrialArthropods" ecotoxContext["ToxicityToTerrestrialArthropods_otherSemifield"]
                        "semi-field tests with non-target arthropods"/>
                </sect3>

                <sect3>
                    <title role="HEAD-4">Field studies with non-target arthropods</title>
                    <@keyAppendixE.appendixEstudies _subject "ToxicityToTerrestrialArthropods" ecotoxContext["ToxicityToTerrestrialArthropods_otherField"]
                        "field tests with non-target arthropods"/>
                </sect3>

                <sect3>
                    <#-- NOTE: this sections contains everything left from the ones above-->
                    <title role="HEAD-4">Other routes of exposure for non-target arthropods</title>
                      <@keyAppendixE.appendixEstudies _subject "ToxicityToTerrestrialArthropods" ecotoxContext["ToxicityToTerrestrialArthropods_otherOther"]
                        "other toxicity for non-target arthropods"/>
                </sect3>

            </sect2>

        </sect1>

        <?hard-pagebreak?>

        <sect1>
            <title role="HEAD-2">Effects on non-target soil meso- and macrofauna</title>

            <sect2>
                <title role="HEAD-3">Earthworms</title>

                <@keyEcotox.ecotoxPPPsummary _subject "ToxicitySoilMacroorganisms_EU_PPP"/>

                <sect3>
                <title role="HEAD-4">Earthworms, sub-lethal effects</title>
                <@keyAppendixE.appendixEstudies _subject "ToxicityToSoilMacroorganismsExceptArthropods" ecotoxContext["ToxicityToSoilMacroorganismsExceptArthropods_earthwormNofield"]
                    "earthworms"/>
                </sect3>

                <sect3>
                    <title role="HEAD-4">Earthworms - field studies</title>
                    <@keyAppendixE.appendixEstudies _subject "ToxicityToSoilMacroorganismsExceptArthropods" ecotoxContext["ToxicityToSoilMacroorganismsExceptArthropods_earthwormField"]
                        "field tests with earthworms"/>
                </sect3>

            </sect2>

            <sect2>
                <title role="HEAD-3"> Effects on non-target soil meso- and macrofauna (other than earthworms) </title>

                    <sect3>
                        <title role="HEAD-4">Species level testing</title>
                        <@keyAppendixE.appendixEstudies _subject "ToxicityToTerrestrialArthropods" ecotoxContext["ToxicityToTerrestrialArthropods_folsomiaAndHypoaspis"]
                            "effects on Folsomia candida and/or Hypoaspis aculeifer"/>
                    </sect3>

                    <sect3>
                        <title role="HEAD-4">Higher tier testing</title>
                         <#--   NOTE: anything not earthworm, since guidelines include microcosm studies.-->
  
                        <#if keyAppendixE.containsDoc(_subject, "ENDPOINT_STUDY_RECORD.ToxicityToSoilMacroorganismsExceptArthropods", ecotoxContext["ToxicityToSoilMacroorganismsExceptArthropods_noEarthworm"])>
                            <sect4>
                                <title role="HEAD-5">Other soil meso- and macrofauna </title>
                                <@keyAppendixE.appendixEstudies _subject "ToxicityToSoilMacroorganismsExceptArthropods"
                            		ecotoxContext["ToxicityToSoilMacroorganismsExceptArthropods_noEarthworm"] "toxicity to other soil meso- and macrofauna"/>
                            </sect4>
                        </#if>

                        <#if keyAppendixE.containsDoc(_subject, "ENDPOINT_STUDY_RECORD.ToxicityToTerrestrialArthropods", ecotoxContext["ToxicityToTerrestrialArthropods_soilMesofauna"])>
                            <sect4>
                                <title role="HEAD-5">Other soil-dwelling arthropods</title>
                                <@keyAppendixE.appendixEstudies _subject "ToxicityToTerrestrialArthropods"
                            		ecotoxContext["ToxicityToTerrestrialArthropods_soilMesofauna"] "toxicity to other soil-dwelling arthropods"/>
                            </sect4>
                        </#if>

                        <#if !(keyAppendixE.containsDoc(_subject, "ENDPOINT_STUDY_RECORD.ToxicityToTerrestrialArthropods", ecotoxContext["ToxicityToTerrestrialArthropods_soilMesofauna"])) &&
                        		!(keyAppendixE.containsDoc(_subject, "ENDPOINT_STUDY_RECORD.ToxicityToSoilMacroorganismsExceptArthropods", ecotoxContext["ToxicityToSoilMacroorganismsExceptArthropods_noEarthworm"]))>
                            <para>No individual studies available for higher tier testing</para>
                        </#if>
                    </sect3>

            </sect2>
        </sect1>

        <?hard pagebreak?>

        <sect1>
            <title role="HEAD-2">Effects on soil nitrogen transformation</title>
            <@keyEcotox.ecotoxPPPsummary _subject "ToxicityToSoilMicroorganisms_EU_PPP"/>
            <@com.emptyLine/>
            <@keyAppendixE.appendixEstudies _subject "ToxicityToSoilMicroorganisms"/>
        </sect1>

        <sect1>
            <title role="HEAD-2">Effects on terrestrial non-target higher plants</title>
            <@keyEcotox.ecotoxPPPsummary _subject "ToxicityToTerrestrialPlants_EU_PPP"/>
            <#--NOTE: The first two sections are really not clear, so everything (not in 3 and 4) is included in the first one-->
            <#--        Summary of screening data-->
            <#--        Testing on non-target plants-->
            <sect2 xml:id="CP1061">
                <title role="HEAD-3">Summary of screening data</title>
                <@keyAppendixE.appendixEstudies _subject "ToxicityToTerrestrialPlants" ecotoxContext["ToxicityToTerrestrialPlants_other"]
                                "non-target plants"/>
            </sect2>
            <sect2>
                <title role="HEAD-3">Testing on non-target plants</title>
                <para>For general testing on non-target plants see <command  linkend="CP1061">Section 10.6.1 above</command>.</para>

            </sect2>
            <sect2>
                <title role="HEAD-3">Extended laboratory studies on non-target plants</title>
                <@keyAppendixE.appendixEstudies _subject "ToxicityToTerrestrialPlants" ecotoxContext["ToxicityToTerrestrialPlants_extended"]
                "extended laboratory tests on non-target plants"/>
            </sect2>
            <sect2>
                <title role="HEAD-3">Semi-field and field tests on non-target plants</title>
                <@keyAppendixE.appendixEstudies _subject "ToxicityToTerrestrialPlants" ecotoxContext["ToxicityToTerrestrialPlants_fieldSemifield"]
                "semi-field and field tests on non-target plants"/>
            </sect2>

        </sect1>

        <sect1 xml:id="CP107">
            <title role="HEAD-2">Effects on other terrestrial organisms (flora and fauna)</title>
            <@keyEcotox.ecotoxPPPsummary _subject "AdditionalEcotoxicologicalInformation"/>
            <@com.emptyLine/>
            <@keyAppendixE.appendixEstudies _subject "AdditionalEcotoxicologicalInformation"/>
        </sect1>

        <sect1>
            <title role="HEAD-2">Monitoring data</title>
            <@keyEcotox.ecotoxPPPsummary _subject "BiologicalEffectsMonitoring"/>
            <@com.emptyLine/>
            <@keyAppendixE.appendixEstudies _subject "BiologicalEffectsMonitoring"/>
        </sect1>  -->
    </#if>

<#elseif workingContext=="MICRO">

    <#--    NOTE: substance and mixture have the same content, except for the first summary (and the additional studies)-->

    <#if _subject.documentType=="MIXTURE">
        <@keyEcotox.ecotoxicologicalInformationSummary/>
    </#if>

    <sect1>
        <title role="HEAD-2">Effects on birds</title>
        <@keyEcotox.ecotoxPPPsummary _subject "ToxicityBirds_EU_PPP"/>
        <@com.emptyLine/>
        <@keyAppendixE.appendixEstudies _subject "ToxicityToBirds"/>

    </sect1>

    <?hard-pagebreak?>

    <sect1>
        <title role="HEAD-2">Effects on aquatic organisms</title>
        <@keyEcotox.ecotoxPPPsummary _subject "AquaticToxicity"/>
        <sect2>
            <title role="HEAD-3">Effects on fish</title>
            <@keyEcotox.ecotoxPPPsummary subject=_subject docSubTypes=["Short-termToxicityToFish_EU_PPP","LongTermToxicityToFish_EU_PPP"] merge=true/>
            <@com.emptyLine/>
            <@keyAppendixE.appendixEstudies subject=_subject docSubTypes=["ShortTermToxicityToFish","LongTermToxToFish"] name="toxicity to fish"/>
        </sect2>

        <sect2>
            <title role="HEAD-3">Effects on freshwater invertebrates</title>
            <@keyEcotox.ecotoxPPPsummary subject=_subject
                docSubTypes=["ShortTermToxicityAquaInvert_EU_PPP","LongTermToxicityToAquaticInvertebrates_EU_PPP"] merge=true/>
            <@com.emptyLine/>
            <@keyAppendixE.appendixEstudies subject=_subject docSubTypes=["ShortTermToxicityToAquaInv","LongTermToxicityToAquaInv"]
                name="toxicity to freshwater invertebrates"/>
        </sect2>

        <sect2>
            <title role="HEAD-3">Effects on algae growth</title>
            <@keyEcotox.ecotoxPPPsummary _subject "ToxicityToAquaticAlgae_EU_PPP"/>
            <@com.emptyLine/>
            <@keyAppendixE.appendixEstudies _subject "ToxicityToAquaticAlgae"/>
        </sect2>

        <sect2>
            <title role="HEAD-3">Effects on plants other than algae</title>
            <@keyEcotox.ecotoxPPPsummary _subject "ToxicityPlants_EU_PPP"/>
            <@com.emptyLine/>
            <@keyAppendixE.appendixEstudies _subject "ToxicityToAquaticPlant" "" "toxicity to plants other than algae"/>
        </sect2>
    </sect1>

    <?hard-pagebreak?>

    <sect1>
        <title role="HEAD-2">Effects on bees</title>
        <#--            NOTE summary repeated-->
        <@keyEcotox.ecotoxPPPsummary _subject "ToxicityTerrestrialArthropods_EU_PPP"/>
        <@com.emptyLine/>
        <@keyAppendixE.appendixEstudies _subject "ToxicityToTerrestrialArthropods" ecotoxContext["ToxicityToTerrestrialArthropods_bees"]
            "toxicity to bees"/>
    </sect1>

    <?hard-pagebreak?>

    <sect1>
        <title role="HEAD-2">Effects on arthropods other than bees</title>
        <#--            NOTE summary repeated with bees...-->
        <@keyEcotox.ecotoxPPPsummary _subject "ToxicityTerrestrialArthropods_EU_PPP"/>
        <@com.emptyLine/>
        <@keyAppendixE.appendixEstudies _subject "ToxicityToTerrestrialArthropods" ecotoxContext["ToxicityToTerrestrialArthropods_other_micro"]
            "toxicity to arthropods other than bees"/>

    </sect1>

    <?hard-pagebreak?>

    <sect1>
        <title role="HEAD-2">Effects on earthworms</title>
            <@keyEcotox.ecotoxPPPsummary _subject "ToxicitySoilMacroorganisms_EU_PPP"/>
			<#-- NOTE: covers more than just earthworms-->
            <@com.emptyLine/>
            <@keyAppendixE.appendixEstudies _subject "ToxicityToSoilMacroorganismsExceptArthropods" "" "toxicity to earthworms and other macroorganisms"/>
    </sect1>

    <?hard-pagebreak?>

    <sect1>
        <title role="HEAD-2">Effects on non-target soil micro-organisms</title>
        <@keyEcotox.ecotoxPPPsummary _subject "ToxicityToSoilMicroorganisms_EU_PPP"/>
        <@com.emptyLine/>
        <@keyAppendixE.appendixEstudies _subject "ToxicityToSoilMicroorganisms"/>
    </sect1>

    <?hard-pagebreak?>

    <sect1>
        <title role="HEAD-2">Additional studies</title>
        <#--        NOTE: for mixtures there is only Terrestrial Plants-->
        <#if _subject.documentType=="SUBSTANCE">
            <@keyEcotox.ecotoxPPPsummary subject=_subject
            docSubTypes=["ToxicityMicroorganisms","ToxicityToTerrestrialPlants_EU_PPP","AdditionalEcotoxicologicalInformation"] merge=true/>
            <@com.emptyLine/>
            <@keyAppendixE.appendixEstudies subject=_subject docSubTypes=["ToxicityToTerrestrialPlants", "ToxicityToMicroorganisms", "AdditionalEcotoxicologicalInformation"]
            name="other toxicity"/>
        <#elseif _subject.documentType=="MIXTURE">
            <@keyEcotox.ecotoxPPPsummary _subject "ToxicityToTerrestrialPlants_EU_PPP"/>
            <@com.emptyLine/>
            <@keyAppendixE.appendixEstudies _subject "ToxicityToTerrestrialPlants" "" "other toxicity"/>
        </#if>
    </sect1>
</#if>
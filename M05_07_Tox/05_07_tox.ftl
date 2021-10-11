<#assign toxContext = { "BasicToxicokinetics_oral" : [{"path": "MaterialsAndMethods.AdministrationExposure.RouteOfAdministration",
                                                            "val" : ["oral: capsule", "oral: drinking water", "oral: feed",  "oral: gavage", "oral: unspecified", "oral"],
                                                            "qual" : "eq",
                                                            "type" : "picklist"}],

                        "BasicToxicokinetics_other" : [{"path": "MaterialsAndMethods.AdministrationExposure.RouteOfAdministration",
                                                            "val" : ["oral: capsule", "oral: drinking water", "oral: feed",  "oral: gavage", "oral: unspecified", "oral"],
                                                            "qual" : "ne",
                                                            "type" : "picklist"}],

                        "RepeatedDoseToxicityOral_28" : [{"path": "AdministrativeData.Endpoint",
                                                            "val" : ["short-term repeated dose toxicity: oral"],
                                                            "qual" : "eq",
                                                            "type" : "picklist"}],

                        "RepeatedDoseToxicityOral_90" : [{"path": "AdministrativeData.Endpoint",
                                                            "val" : ["sub-chronic toxicity: oral"],
                                                            "qual" : "eq",
                                                            "type" : "picklist"}],

                        "RepeatedDoseToxicityOral_other" : [{"path": "AdministrativeData.Endpoint",
                                                            "val" : ["repeated dose toxicity: oral, other"],
                                                            "qual" : "eq",
                                                            "type" : "picklist"}],

                        <#--NOTE: maybe it would be better to just EXCLUDE the chronic endpoints-->
                        "RepeatedDoseToxicity_nochronic" : [{"path": "AdministrativeData.Endpoint",
                                                            "val" : ["repeated dose toxicity: oral, other",
                                                                        "short-term repeated dose toxicity: inhalation", "sub-chronic toxicity: inhalation", "repeated dose toxicity: inhalation, other",
                                                                        "short-term repeated dose toxicity: dermal", "sub-chronic toxicity: dermal", "repeated dose toxicity: dermal, other",
                                                                        "short-term repeated dose toxicity: other route", "sub-chronic toxicity: other route", "repeated dose toxicity: other route"],
                                                            "qual" : "eq",
                                                            "type" : "picklist"}],

                        "RepeatedDoseToxicity_chronic-Carcinogenicity" : [{"path": "AdministrativeData.Endpoint", "val" : ["chronic toxicity", "carcinogenicity"], "qual" : "lk", "type" : "picklist"},
                                                                            {"path": "AdministrativeData.Endpoint", "val" : ["sub-chronic"], "qual" : "nl", "type" : "picklist"}],

                        "ToxicityToReproduction_generational" : [{"path" : "AdministrativeData.Endpoint", "val" : ["generation"], "qual" : "lk", "type" : "picklist"}],

                        "ToxicityToReproduction_developmental" : [{"path" : "AdministrativeData.Endpoint", "val" : ["developmental toxicity", "developmental immunotoxicity", "developmental neurotoxicity"],
                                                                     "qual" : "eq", "type" : "picklist"}],


                        "ToxicityToReproduction_other" : [{"path" : "AdministrativeData.Endpoint", "val" : ["developmental toxicity", "developmental immunotoxicity", "developmental neurotoxicity"],
                                                            "qual" : "ne", "type" : "picklist"},
                                                            {"path" : "AdministrativeData.Endpoint", "val" : ["generation"], "qual" : "nl", "type" : "picklist"} ],

                        "Neurotoxicity_rodents": [{"path" : "MaterialsAndMethods.TestAnimals.Species", "val" : ["mouse", "rat", "hamster", "gerbil", "guinea pig"], "qual" : "lk", "type" : "picklist"},
                                                    {"path" : "AdministrativeData.Endpoint", "val" : ["delayed polyneuropathy", "delayed neuropathy", "delayed neurotoxicity"], "qual" : "nl", "type" : "picklist"}],

                        "Neurotoxicity_noRodents": [{"path" : "MaterialsAndMethods.TestAnimals.Species", "val" : ["mouse", "rat", "hamster", "gerbil", "guinea pig"], "qual" : "nl", "type" : "picklist"},
                                                    {"path" : "AdministrativeData.Endpoint", "val" : ["delayed polyneuropathy", "delayed neuropathy", "delayed neurotoxicity"], "qual" : "nl", "type" : "picklist"}],

                        "Neurotoxicity_delayed": [{"path" : "AdministrativeData.Endpoint", "val" : ["delayed polyneuropathy", "delayed neuropathy", "delayed neurotoxicity"], "qual" : "lk", "type" : "picklist"}],
                        "RepeatedDoseToxicity_short" : [{"path": "AdministrativeData.Endpoint", "val" : ["short-term"], "qual" : "lk", "type" : "picklist"}],
                        "RepeatedDoseToxicity_noshort" : [{"path": "AdministrativeData.Endpoint", "val" : ["short-term", "intraperitoneal"], "qual" : "nl", "type" : "picklist"}],
                        "SpecificInvestigations_intraperitoneal" : [{"path": "AdministrativeData.Endpoint", "val" : ["intraperitoneal"], "qual" : "lk", "type" : "picklist"}]
            }
/>

<#if _subject.documentType=="MIXTURE">

    <#if workingContext=="MICRO">

        <sect1>
            <title role="HEAD-2">Basic acute toxicity studies</title>
            <@keyTox.summaryAll subject=_subject docSubTypes="AcuteToxicity" resultFormat="table"/>

            <sect2>
                <title role="HEAD-3">Acute oral toxicity</title>
                <@keyAppendixE.appendixEstudies _subject "AcuteToxicityOral" "" "acute oral toxicity"/>
            </sect2>

            <sect2>
                <title role="HEAD-3">Acute inhalation toxicity</title>
                <@keyAppendixE.appendixEstudies _subject "AcuteToxicityInhalation" "" "acute inhalation toxicity"/>
            </sect2>

            <sect2>
                <title role="HEAD-3">Acute percutaneous toxicity</title>
                <@keyAppendixE.appendixEstudies _subject "AcuteToxicityDermal" "" "acute dermal toxicity"/>
            </sect2>
        </sect1>

        <?hard-pagebreak?>

        <sect1>
            <title role="HEAD-2">Additional acute toxicity studies</title>
            <@keyTox.summaryAll subject=_subject docSubTypes=["IrritationCorrosion", "Sensitisation"] resultFormat="table"/>

            <sect2>
                <title role="HEAD-3">Skin irritation</title>
                <@keyAppendixE.appendixEstudies _subject "SkinIrritationCorrosion" "" "skin irritation"/>
            </sect2>

            <sect2>
                <title role="HEAD-3">Eye irritation</title>
                <@keyAppendixE.appendixEstudies _subject "EyeIrritation" "" "eye irritation"/>
            </sect2>

            <sect2>
                <title role="HEAD-3">Skin sensitisation</title>
                <@keyAppendixE.appendixEstudies _subject "SkinSensitisation" "" "skin sensitisation"/>
            </sect2>
        </sect1>

        <?hard-pagebreak?>

        <sect1>
            <title role="HEAD-2">Data on exposure</title>
            <@keyTox.summarySingle _subject "NonDietaryExpo"/>
        </sect1>

        <?hard-pagebreak?>

        <sect1>
            <title role="HEAD-2">Available toxicological data relating to non-active substances</title>
            <para>Not available.</para>
        </sect1>

        <?hard-pagebreak?>

        <sect1>
            <title role="HEAD-2">Supplementary studies for combinations of plant protection products</title>
            <@keyAppendixE.appendixEstudies _subject "AdditionalToxicologicalInformation"/>
        </sect1>

        <?hard-pagebreak?>

        <sect1>
            <title role="HEAD-2">Summary and evaluation of health effects</title>
            <@keyTox.summarySingle _subject "AdditionalToxicologicalInformation" "none"/>
        </sect1>

    <#elseif workingContext=="CHEM">

        <sect1>
            <title role="HEAD-2">Acute toxicity</title>
            <@keyTox.summaryAll subject=_subject docSubTypes=["AcuteToxicity", "IrritationCorrosion", "Sensitisation", "Phototoxicity"] resultFormat="table"/>

            <sect2>
                <title role="HEAD-3">Oral toxicity</title>
                <@keyAppendixE.appendixEstudies _subject "AcuteToxicityOral" "" "oral toxicity"/>
            </sect2>
            <sect2>
                <title role="HEAD-3">Dermal toxicity</title>
                <@keyAppendixE.appendixEstudies _subject "AcuteToxicityDermal" "" "dermal toxicity"/>
            </sect2>
            <sect2>
                <title role="HEAD-3">Inhalation toxicity</title>
                <@keyAppendixE.appendixEstudies _subject "AcuteToxicityInhalation" "" "inhalation toxicity"/>
            </sect2>
            <sect2>
                <title role="HEAD-3">Skin irritation</title>
                <@keyAppendixE.appendixEstudies _subject "SkinIrritationCorrosion" "" "skin irritation"/>
            </sect2>
            <sect2>
                <title role="HEAD-3">Eye irritation</title>
                <@keyAppendixE.appendixEstudies _subject "EyeIrritation"/>
            </sect2>
            <sect2>
                <title role="HEAD-3">Skin sensitisation</title>
                <@keyAppendixE.appendixEstudies _subject "SkinSensitisation"/>
            </sect2>
            <sect2 xml:id="CP717">
                <title role="HEAD-3">Supplementary studies on the plant protection product</title>
                <@keyAppendixE.appendixEstudies _subject "AcuteToxicityOtherRoutes" "" "other routes"/>
            </sect2>
            <sect2>
                <title role="HEAD-3">Supplementary studies for combinations of plant protection products</title>
                <para>Any available study summaries for combinations of plant protection products are provided in <command  linkend="CP717">Section 7.1.7</command>.</para>
            </sect2>
        </sect1>

        <sect1>
            <title role="HEAD-2">Data on exposure</title>
            <@keyTox.summarySingle _subject "NonDietaryExpo"/>
            <@keyAppendixE.appendixEstudies _subject "ExposureRelatedObservationsOther" "" "exposure"/>
        </sect1>

        <sect1>
            <title role="HEAD-2">Dermal absorption</title>
            <@keyTox.summarySingle _subject "DermalAbsorption"/>
            <@keyAppendixE.appendixEstudies _subject "DermalAbsorption"/>
        </sect1>

        <sect1>
            <title role="HEAD-2">Available toxicological data relating to co-formulants</title>
            <para>Not available. For confidential information, use Document J.</para>
        </sect1>

    </#if>

<#elseif _subject.documentType=="SUBSTANCE">

    <#if workingContext=="MICRO">

        <@keyTox.summaryAll _subject "ToxRefValues"/>

        <?hard-pagebreak?>

        <sect1>
            <title role="HEAD-2">Basic information</title>
            <@keyTox.summarySingle _subject "ExposureRelatedObservationsHumans" "none"/>

            <sect2 xml:id="MA511">
                <title role="HEAD-3">Medical data</title>
                <@keyAppendixE.appendixEstudies _subject "HealthSurveillanceData" "" "medical data"/>
            </sect2>

            <sect2>
                <title role="HEAD-3">Medical surveillance on manufacturing plant personnel</title>
                <para>Information on medical surveillance on manufacturing plant personnel is provided in <command  linkend="MA511">Section 5.1.1</command> above.</para>
            </sect2>

            <sect2 >
                <title role="HEAD-3">Sensitisation/allergenicity observations, if appropriate</title>
                <@keyAppendixE.appendixEstudies _subject "SensitisationData" "" "sensitisation and allergenicity"/>
            </sect2>
            <sect2 xml:id="MA514">
                <title>Direct observation, e.g. clinical cases</title>
                <@keyAppendixE.appendixEstudies _subject "DirectObservationsClinicalCases" "" "direct observations"/>
            </sect2>
        </sect1>

        <?hard-pagebreak?>

        <sect1>
            <title role="HEAD-2">Basic studies</title>
            <#--        <@keyTox.summaryAll _subject=dataset docSubTypes=["Sensitisation", "AcuteToxicity", "SpecificInvestigationsOtherStudies"] resultFormat="table"/>-->

            <sect2>
                <title role="HEAD-3">Sensitisation</title>
                <@keyTox.summarySingle _subject "Sensitisation" "table"/>
                <@com.emptyLine/>
                <@keyAppendixE.appendixEstudies _subject "SkinSensitisation"/>
            </sect2>

            <sect2>
                <title role="HEAD-3">Acute toxicity, pathogenicity and infectiveness</title>
                <@keyTox.summaryAll subject=_subject docSubTypes=["AcuteToxicity", "SpecificInvestigationsOtherStudies"] resultFormat="table"/>

                <sect3>
                    <title role="HEAD-4">Acute oral toxicity, pathogenicity and infectiveness</title>
                    <@keyAppendixE.appendixEstudies _subject "AcuteToxicityOral" "" "acute oral toxicity"/>
                </sect3>

                <sect3>
                    <title role="HEAD-4">Acute inhalation toxicity, pathogenicity and infectiveness</title>
                    <@keyAppendixE.appendixEstudies _subject "AcuteToxicityInhalation" "" "actute inhalation toxicity"/>
                </sect3>

                <sect3>
                    <title role="HEAD-4">Intraperitoneal/subcutaneous single dose</title>
                    <#-- Repeated if also included above-->
                    <#-- <@keyTox.summaryAll _subject=dataset docSubTypes=["SpecificInvestigationsOtherStudies"] resultFormat="none"/>-->
                    <@keyAppendixE.appendixEstudies subject=_subject docSubTypes="SpecificInvestigations"
                        context=toxContext['SpecificInvestigations_intraperitoneal'] name="intraperitoneal subcutaneous single dose and other toxicity"/>
                </sect3>
            </sect2>

            <sect2>
                <title role="HEAD-3">Genotoxicity testing</title>
                <@keyTox.summaryAll _subject "GeneticToxicity" "table"/>

                <sect3 xml:id="MA5231">
                    <title role="HEAD-4">In vitro studies</title>
                    <@keyAppendixE.appendixEstudies _subject "GeneticToxicityVitro"/>
                </sect3>

            </sect2>

            <sect2>
                <title>Cell culture study</title>
                <@keyAppendixE.appendixEstudies _subject "CellCultureStudy"/>
            </sect2>

            <sect2>
                <title>Information on short-term toxicity and pathogenicity</title>
                <@keyTox.summaryAll _subject "RepeatedDoseToxicity" "table"/>

                <sect3>
                    <title role="HEAD-4">Health effects after repeated inhalatory exposure</title>
                    <@keyAppendixE.appendixEstudies subject=_subject docSubTypes="RepeatedDoseToxicityInhalation" context=toxContext['RepeatedDoseToxicity_short'] name="short-term repeated inhalatory exposure"/>
                </sect3>

                <sect3>
                    <title role="HEAD-4">Health effects after repeated exposure by other routes </title>
                    <@keyAppendixE.appendixEstudies subject=_subject docSubTypes=["RepeatedDoseToxicityOral", "RepeatedDoseToxicityDermal"] context=toxContext['RepeatedDoseToxicity_short'] name="short-term repeated exposure via other routes"/>

                </sect3>
            </sect2>

            <sect2>
                <title>Proposed treatment: first aid measures, medical treatment</title>
                 <para>Information on proposed treatments can be found under <command  linkend="MA514">Section 5.1.4</command>.</para>
            </sect2>
        </sect1>

        <?hard-pagebreak?>

        <sect1>
            <title role="HEAD-2">Specific toxicity, pathogenicity and infectiveness studies</title>
                <#-- Include other specific investigations and rep dose studies not short_term, since from legislation: studies on chronic toxicity, pathogenicity and infectiveness, carcinogenicity and reproductive toxicity-->
                <@keyAppendixE.appendixEstudies subject=_subject docSubTypes=["SpecificInvestigations", "RepeatedDoseToxicityInhalation", "RepeatedDoseToxicityOral", "RepeatedDoseToxicityDermal"]
                    context=toxContext['RepeatedDoseToxicity_noshort'] name="other repeated exposures"/>
        </sect1>

        <?hard-pagebreak?>

        <sect1 xml:id="MA54">
            <title role="HEAD-2">In vivo studies in somatic cells</title>
            <@keyAppendixE.appendixEstudies _subject "GeneticToxicityVivo" "" "in vito toxicity (somatic and germ cells)"/>
        </sect1>

        <?hard-pagebreak?>

        <sect1>
            <title role="HEAD-2">Genotoxicity — In vivo studies in germ cells</title>
            <para>In vivo genotoxicity studies in germ cells are provided in <command  linkend="MA54">Section 5.4</command> above.</para>
        </sect1>

        <?hard-pagebreak?>

        <sect1>
            <title role="HEAD-2">Summary of mammalian toxicity, pathogenicity and infectiveness and overall evaluation</title>
            <@keyTox.summaryAll _subject "AdditionalToxicologicalInformation" "table"/>
            <@keyAppendixE.appendixEstudies _subject "AdditionalToxicologicalInformation"/>
        </sect1>

    <#else>
        <@keyTox.summaryAll _subject "ToxRefValues" "flat" false/>

        <sect1>
            <title role="HEAD-2">Studies on absorption, distribution, metabolism and excretion in mammals</title>
            <@keyTox.summarySingle _subject  "Toxicokinetics" "flat" false />

            <sect2>
                <title role="HEAD-3">Absorption, distribution, metabolism and excretion by oral route</title>
                <@keyAppendixE.appendixEstudies subject=_subject docSubTypes="BasicToxicokinetics" context=toxContext["BasicToxicokinetics_oral"]
                    name="ADME by oral route" includeMetabolites=false/>
            </sect2>

            <sect2>
                <title role="HEAD-3">Absorption, distribution, metabolism and excretion by other routes</title>
                <@keyAppendixE.appendixEstudies _subject "BasicToxicokinetics" toxContext["BasicToxicokinetics_other"]
                    "ADME by other routes" "" false/>
            </sect2>
        </sect1>

        <?hard-pagebreak?>

        <sect1>
            <title role="HEAD-2">Acute toxicity</title>
            <@keyTox.summaryAll subject=_subject docSubTypes=["AcuteToxicity", "IrritationCorrosion", "Sensitisation", "Phototoxicity"] resultFormat="table" includeMetabolites=false/>

            <sect2 xml:id="CA521">
                <title role="HEAD-3">Oral (includes acute oral toxicity to mammals)</title>
                <@keyAppendixE.appendixEstudies _subject "AcuteToxicityOral" "" "acute oral toxicity" "" false/>
            </sect2>

            <sect2>
                <title role="HEAD-3">Dermal</title>
                <@keyAppendixE.appendixEstudies _subject "AcuteToxicityDermal" "" "acute dermal toxicity" "" false/>
            </sect2>

            <sect2>
                <title role="HEAD-3">Inhalation</title>
                <@keyAppendixE.appendixEstudies _subject "AcuteToxicityInhalation" "" "acute inhalation toxicity" "" false/>
            </sect2>

            <sect2>
                <title role="HEAD-3">Skin irritation</title>
                <@keyAppendixE.appendixEstudies _subject "SkinIrritationCorrosion" "" "skin irritation" "" false/>
            </sect2>

            <sect2>
                <title role="HEAD-3">Eye irritation</title>
                <@keyAppendixE.appendixEstudies _subject "EyeIrritation" "" "eye irritation" "" false/>
            </sect2>

            <sect2>
                <title role="HEAD-3">Skin sensitisation</title>
                <@keyAppendixE.appendixEstudies _subject "SkinSensitisation" "" "skin sensitisation" "" false/>
            </sect2>

            <sect2>
                <title role="HEAD-3">Phototoxicity</title>
                <@keyAppendixE.appendixEstudies _subject "PhototoxicityVitro" "" "phototoxicity" "" false/>
            </sect2>

            <#-- NOTE: THIS SECTION DOESN'T EXIST IN KCA:-->
            <sect2>
                <title role="HEAD-3">Acute toxicity: other routes</title>
                <@keyAppendixE.appendixEstudies _subject "AcuteToxicityOtherRoutes" "" "acute toxicity via other routes" "" false/>
            </sect2>

        </sect1>

        <?hard-pagebreak?>

        <sect1>
            <title role="HEAD-2">Short-term toxicity</title>
            <@keyTox.summaryAll _subject "RepeatedDoseToxicity" "table" false/>

            <#if workingContext=="CHEM">
                <sect2>
                    <title role="HEAD-3">Oral 28-day study (short-term repeated)</title>
                    <@keyAppendixE.appendixEstudies _subject "RepeatedDoseToxicityOral" toxContext["RepeatedDoseToxicityOral_28"] "short-term oral toxicity" "" false/>
                </sect2>

                <sect2>
                    <title role="HEAD-3">Oral 90-day study (sub-chronic)</title>
                    <@keyAppendixE.appendixEstudies _subject "RepeatedDoseToxicityOral" toxContext["RepeatedDoseToxicityOral_90"] "sub-chronic oral toxicity" "" false/>
                </sect2>

                <sect2>
                    <title role="HEAD-3">Other routes</title>
                    <#--merge all the subsections + remainder of dosetoxicityoral; could also be split into several -->
                    <@keyAppendixE.appendixEstudies subject=_subject docSubTypes=["RepeatedDoseToxicityOral", "RepeatedDoseToxicityInhalation", "RepeatedDoseToxicityDermal", "RepeatedDoseToxicityOther"]
                        context=toxContext["RepeatedDoseToxicity_nochronic"] name="other routes" includeMetabolites=false/>
                </sect2>
            <#else>
                <#--merge all the subsections-->
                <@keyAppendixE.appendixEstudies subject=_subject docSubTypes=["RepeatedDoseToxicityOral", "RepeatedDoseToxicityInhalation", "RepeatedDoseToxicityDermal", "RepeatedDoseToxicityOther"]
                    name="short-term toxicity" includeMetabolites=false/>
            </#if>
        </sect1>

        <?hard-pagebreak?>

        <sect1>
            <title role="HEAD-2">Genotoxicity testing</title>
            <@keyTox.summaryAll _subject "GeneticToxicity" "table" false/>

            <sect2>
                <title role="HEAD-3">In vitro studies</title>
                <@keyAppendixE.appendixEstudies _subject "GeneticToxicityVitro" "" "in vitro genotoxicity" "" false/>
            </sect2>

            <sect2>
                <title role="HEAD-3">In vivo studies (germ and somatic)</title>
                <@keyAppendixE.appendixEstudies _subject "GeneticToxicityVivo" "" "in vivo genotoxicity" "" false/>
            </sect2>
        </sect1>

        <?hard-pagebreak?>

        <sect1 xml:id="CA55">
            <title role="HEAD-2">Long-term toxicity and carcinogenicity</title>
            <#-- NOTE: long-term toxicity is also included under repeated dose toxicity, although it should not be reported there. Here such cases are consider just in case applicants use such endpoints.-->
            <@keyTox.summaryAll _subject "Carcinogenicity_EU_PPP" "table" false/>
            <@com.emptyLine/>
            <@keyAppendixE.appendixEstudies subject=_subject docSubTypes=["RepeatedDoseToxicityOral","RepeatedDoseToxicityInhalation","RepeatedDoseToxicityDermal","RepeatedDoseToxicityOther", "Carcinogenicity"]
                    context=toxContext["RepeatedDoseToxicity_chronic-Carcinogenicity"] name="long-term toxicity and carcinogenicity" includeMetabolites=false/>
        </sect1>

        <?hard-pagebreak?>

        <sect1  xml:id="CA56">
            <title role="HEAD-2">Reproductive toxicity</title>
            <@keyTox.summaryAll _subject "ToxicityToReproduction_EU_PPP" "table" false/>

            <sect2>
                <title role="HEAD-3">Generational studies</title>
                <@keyAppendixE.appendixEstudies _subject "ToxicityReproduction" toxContext["ToxicityToReproduction_generational"] "generational studies" "" false/>
            </sect2>

            <sect2>
                <title role="HEAD-3">Developmental toxicity studies</title>
                <@keyAppendixE.appendixEstudies subject=_subject docSubTypes=["ToxicityReproduction","DevelopmentalToxicityTeratogenicity"] context=toxContext["ToxicityToReproduction_developmental"]
                    name="developmental toxicity" includeMetabolites=false/>
            </sect2>

            <sect2>
                <title role="HEAD-3">Other studies on reproductive toxicity</title>
                <@keyAppendixE.appendixEstudies subject=_subject docSubTypes=["ToxicityReproduction", "ToxicityReproductionOther"] context=toxContext["ToxicityToReproduction_other"]
                    name="reproductive toxicity" includeMetabolites=false/>
            </sect2>
        </sect1>

        <?hard-pagebreak?>

        <sect1>
            <title role="HEAD-2">Neurotoxicity studies</title>
            <@keyTox.summaryAll _subject "Neurotoxicity" "table" false/>
            <@com.emptyLine/>
            <@keyAppendixE.appendixEstudies _subject "Neurotoxicity" "" "" "" false/>
        </sect1>

        <?hard-pagebreak?>

        <sect1>
            <title role="HEAD-2">Other toxicological studies</title>

            <sect2>
                <title role="HEAD-3">Toxicity studies of metabolites</title>
                <#if _metabolites?? && _metabolites?has_content>

                    <@keyAppendixE.metabolitesStudies

                        metabList=_metabolites

                        studySubTypes=[
                            "BasicToxicokinetics", "AcuteToxicityOral", "AcuteToxicityDermal", "AcuteToxicityInhalation",
                            "SkinIrinfectivenessritationCorrosion","EyeIrritation","SkinSensitisation","PhototoxicityVitro",
                            "AcuteToxicityOtherRoutes", "RepeatedDoseToxicityOral", "RepeatedDoseToxicityInhalation",
                            "RepeatedDoseToxicityDermal", "RepeatedDoseToxicityOther", "GeneticToxicityVitro", "GeneticToxicityVivo",
                            "Carcinogenicity", "ToxicityReproduction", "ToxicityReproductionOther", "DevelopmentalToxicityTeratogenicity",
                            "Neurotoxicity", "Immunotoxicity", "ToxicEffectsLivestock","IntermediateEffects", "EndocrineDisrupterMammalianScreening",
                            "AdditionalToxicologicalInformation", "DermalAbsorption", "ExposureRelatedObservationsOther","SensitisationData",
                            "DirectObservationsClinicalCases","EpidemiologicalData","HealthSurveillanceData"]

                        summarySubTypes=[
                            "Toxicokinetics","AcuteToxicity", "IrritationCorrosion", "Sensitisation","Phototoxicity"
                            ,"RepeatedDoseToxicity", "GeneticToxicity","Carcinogenicity_EU_PPP", "ToxicityToReproduction_EU_PPP"
                            ,"Neurotoxicity", "AdditionalToxicologicalInformation", "Immunotoxicity", "ToxicEffectsLivestockPets"
                            ,"ExposureRelatedObservationsHumans", "DermalAbsorption", "SpecificInvestigationsOtherStudies"
                            ,"ToxRefValues", "NonDietaryExpo"]
<#--                        "EndocrineDisruptingPropertiesAssessmentPest"-->

                        summaryMacroCall="keyTox.summarySingle"
                    />
                <#else>
                    <para>No toxicity studies of metabolites are available. </para>
                </#if>

            </sect2>

            <sect2>
                <title role="HEAD-3">Supplementary studies on the active substance</title>

                <sect3>
                    <title role="HEAD-3">Immunotoxicity</title>
                    <@keyTox.summaryAll _subject "Immunotoxicity" "table" false/>
                    <@keyAppendixE.appendixEstudies _subject "Immunotoxicity" "" "" "" false/>
                </sect3>

                <sect3>
                    <title role="HEAD-3">Toxic effects on livestock</title>
                    <@keyTox.summaryAll _subject "ToxicEffectsLivestockPets" "table" false/>
                    <@keyAppendixE.appendixEstudies subject=_subject docSubTypes="ToxicEffectsLivestock" name="toxic effects on livestock" includeMetabolites=false/>
                </sect3>

                <sect3>
                    <title role="HEAD-3">Intermediate effects - mechanistic information</title>
                    <#-- <@keyTox.intermediateEffectsStudies _subject/>-->
                    <@keyAppendixE.appendixEstudies _subject "IntermediateEffects" "" "" "" false/>
                </sect3>

                <sect3>
                    <title role="HEAD-3">Additional toxicological information</title>
                    <@keyTox.summaryAll _subject "AdditionalToxicologicalInformation" "table" false/>
                    <@keyAppendixE.appendixEstudies _subject "AdditionalToxicologicalInformation" "" "" "" false/>
                </sect3>

            </sect2>

            <sect2 xml:id="CA583">
                <title role="HEAD-3">Endocrine disrupting properties</title>
<#--                <@keyTox.summaryAll _subject "EndocrineDisruptingPropertiesAssessmentPest" "table" false/>-->
                <@keyAppendixE.appendixEstudies _subject "EndocrineDisrupterMammalianScreening" "" "endocrine disrupting properties" "" false/>
            </sect2>

        </sect1>

        <?hard-pagebreak?>

        <sect1>
            <title role="HEAD-2">Medical data</title>
            <@keyTox.summarySingle _subject "ExposureRelatedObservationsHumans" "none" false/>
            <sect2>
                <title role="HEAD-3">Medical surveillance on manufacturing plant personnel and monitoring studies</title>
                <@keyAppendixE.appendixEstudies _subject "HealthSurveillanceData" "" "" "" false/>
            </sect2>
            <sect2>
                <title role="HEAD-3">Data collected on humans</title>
                <@keyAppendixE.appendixEstudies _subject "ExposureRelatedObservationsOther" "" "" "" false/>
            </sect2>
            <sect2 xml:id="CA593">
                <title role="HEAD-3">Direct observations</title>
                <@keyAppendixE.appendixEstudies _subject "DirectObservationsClinicalCases" "" "" "" false/>
            </sect2>
            <sect2>
                <title role="HEAD-3">Epidemiological studies</title>
                <@keyAppendixE.appendixEstudies _subject "EpidemiologicalData" "" "" "" false/>
            </sect2>

            <#if workingContext=="CHEM">
                <sect2>
                    <title role="HEAD-3">Diagnosis of poisoning (determination of active substance, metabolites), specific signs of poisoning, clinical tests</title>
                    <para>Information on diagnosis and specific signs of poisoning, and clinical tests are provided in <command  linkend="CA593">Section 5.9.3</command> above.</para>
                </sect2>
                <sect2>
                    <title role="HEAD-3">Proposed treatment: first aid measures, antidotes, medical treatment</title>
                    <para>Information on proposed treatments is provided in <command  linkend="CA593">Section 5.9.3</command> above.</para>
                </sect2>
                <sect2>
                    <title role="HEAD-3">Expected effects of poisoning</title>
                    <para>Expected effects of poisoning are described in <command  linkend="CA593">Section 5.9.3</command> above.</para>
                </sect2>
            </#if>
        </sect1>

    </#if>
</#if>
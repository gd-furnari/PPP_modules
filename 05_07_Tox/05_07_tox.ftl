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

                        "Neurotoxicity_rodents": [{"path" : "MaterialsAndMethods.TestAnimals.Species", "val" : ["mouse", "rat"], "qual" : "eq", "type" : "picklist"},
                                                    {"path" : "AdministrativeData.Endpoint", "val" : ["delayed polyneuropathy", "delayed neuropathy", "delayed neurotoxicity"], "qual" : "nl", "type" : "picklist"}],

                        "Neurotoxicity_noRodents": [{"path" : "MaterialsAndMethods.TestAnimals.Species", "val" : ["mouse", "rat"], "qual" : "ne", "type" : "picklist"},
                                                    {"path" : "AdministrativeData.Endpoint", "val" : ["delayed polyneuropathy", "delayed neuropathy", "delayed neurotoxicity"], "qual" : "nl", "type" : "picklist"}],

                        "Neurotoxicity_delayed": [{"path" : "AdministrativeData.Endpoint", "val" : ["delayed polyneuropathy", "delayed neuropathy", "delayed neurotoxicity"], "qual" : "lk", "type" : "picklist"}],
                        "RepeatedDoseToxicity_short" : [{"path": "AdministrativeData.Endpoint", "val" : ["short-term"], "qual" : "lk", "type" : "picklist"}],
                        "RepeatedDoseToxicity_noshort" : [{"path": "AdministrativeData.Endpoint", "val" : ["short-term"], "qual" : "nl", "type" : "picklist"}]
            }
/>

<#if _subject.documentType=="MIXTURE">

    <#if workingContext=="MICRO">

        <sect1>
            <title role="HEAD-2">Basic acute toxicity studies</title>
            <@keyTox.summaryAll _subject=_subject docSubTypes="AcuteToxicity" resultFormat="table"/>

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
            <@keyTox.summaryAll _subject=_subject docSubTypes=["IrritationCorrosion", "Sensitisation"] resultFormat="table"/>

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
            <para>Not available.
<#--                Look in co-formulat datasets (EU PPP Other substance 5 Toxicological and metabolism studies on the substance)-->
            </para>
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
            <@keyTox.summaryAll _subject=_subject docSubTypes=["AcuteToxicity", "IrritationCorrosion", "Sensitisation", "Phototoxicity"] resultFormat="table"/>

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
            <para>Not available.
<#--                EU PPP Other substance dataset 7.4 (Cf. co-formulant datasets) Available toxicological data relating to co-formulants-->
            </para>
        </sect1>

    </#if>
<#elseif _subject.documentType=="SUBSTANCE">

    <#if workingContext=="MICRO">

        <@keyTox.summaryAll _subject "ToxRefValues"/>

        <?hard-pagebreak?>

        <sect1>
            <title role="HEAD-2">Basic information</title>
            <@keyTox.summarySingle _subject "ExposureRelatedObservationsHumans"/>

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
            <#--        Could come here or in the individual sections but also genotox etc...-->
            <#--        <@keyTox.summaryAll _subject=dataset docSubTypes=["Sensitisation", "AcuteToxicity", "SpecificInvestigationsOtherStudies"] resultFormat="table"/>-->

            <sect2>
                <title role="HEAD-3">Sensitisation</title>
                <@keyTox.summarySingle _subject "Sensitisation"/>
                <@keyAppendixE.appendixEstudies _subject "SkinSensitisation"/>
            </sect2>

            <sect2>
                <title role="HEAD-3">Acute toxicity, pathogenicity and infectiveness</title>
                <@keyTox.summaryAll _subject=_subject docSubTypes=["AcuteToxicity", "SpecificInvestigationsOtherStudies"] resultFormat="table"/>

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
                    <#--This would include everything, not just  intraperitoneal / subcutaneous single dose-->
                    <@keyAppendixE.appendixEstudies _subject "SpecificInvestigations" "" "intraperitoneal subcutaneous single dose and other toxicity"/>
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
                <para>For cell culture studies, check <command  linkend="MA5231">Section 5.2.3.1</command>.</para>
            </sect2>

            <sect2>
                <title>Information on short-term toxicity and pathogenicity</title>
                <@keyTox.summaryAll _subject "RepeatedDoseToxicity" "table"/>

                <sect3>
                    <title role="HEAD-4">Health effects after repeated inhalatory exposure</title>
                    <@keyAppendixE.appendixEstudies _subject=_subject docSubTypes="RepeatedDoseToxicityInhalation" context=toxContext['RepeatedDoseToxicity_short'] name="short-term repeated inhalatory exposure"/>
                </sect3>

                <sect3>
                    <title role="HEAD-4">Health effects after repeated exposure by other routes </title>
                    <@keyAppendixE.appendixEstudies _subject=_subject docSubTypes=["RepeatedDoseToxicityOral", "RepeatedDoseToxicityDermal"] context=toxContext['RepeatedDoseToxicity_short'] name="short-term repeated exposure via other routes"/>

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
                <#-- Include other rep dose studies not short_term, since from legislation: studies on chronic toxicity, pathogenicity and infectiveness, carcinogenicity and reproductive toxicity-->
                <@keyAppendixE.appendixEstudies _subject=_subject docSubTypes=["RepeatedDoseToxicityInhalation", "RepeatedDoseToxicityOral", "RepeatedDoseToxicityDermal"]
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
            <para>In vivo genotoxicity studies in germ cells are provided in <command  linkend="MA54">Section 5.4</command>.</para>
        </sect1>

        <?hard-pagebreak?>

        <sect1>
            <title role="HEAD-2">Summary of mammalian toxicity, pathogenicity and infectiveness and overall evaluation</title>
            <@keyTox.summaryAll _subject "AdditionalToxicologicalInformation" "table"/>
            <@keyAppendixE.appendixEstudies _subject "AdditionalToxicologicalInformation"/>
        </sect1>

    <#else>
<#--        if workingContext=="CHEM" || workingContext=="MRL">-->

        <@keyTox.summaryAll _subject "ToxRefValues"/>

        <sect1>
            <title role="HEAD-2">Studies on absorption, distribution, metabolism and excretion in mammals</title>
            <#--    Existing macro:-->
            <#--    <@keyTox.toxicokineticsSummaryAndDiscussion activeSubstance/>-->

            <@keyTox.summarySingle _subject  "Toxicokinetics" />

            <sect2>
                <title role="HEAD-3">Absorption, distribution, metabolism and excretion by oral route</title>
                <@keyAppendixE.appendixEstudies _subject "BasicToxicokinetics" toxContext["BasicToxicokinetics_oral"] />
            </sect2>

            <sect2>
                <title role="HEAD-3">Absorption, distribution, metabolism and excretion by other routes</title>
                <@keyAppendixE.appendixEstudies _subject "BasicToxicokinetics" toxContext["BasicToxicokinetics_other"]/>
            </sect2>
        </sect1>

        <?hard-pagebreak?>

        <sect1>
            <title role="HEAD-2">Acute toxicity</title>
            <#--    Existing macro:-->
            <#--    <@keyTox.acuteToxicitySummaryStudies activeSubstance/>-->
            <@keyTox.summaryAll _subject=_subject docSubTypes=["AcuteToxicity", "IrritationCorrosion", "Sensitisation", "Phototoxicity"] resultFormat="table"/>

            <sect2 xml:id="CA521">
                <title role="HEAD-3">Oral (includes acute oral toxicity to mammals)</title>
                <@keyAppendixE.appendixEstudies _subject "AcuteToxicityOral"/>
            </sect2>
            <sect2>
                <title role="HEAD-3">Dermal</title>
                <@keyAppendixE.appendixEstudies _subject "AcuteToxicityDermal"/>

            </sect2>
            <sect2>
                <title role="HEAD-3">Inhalation</title>
                <@keyAppendixE.appendixEstudies _subject "AcuteToxicityInhalation"/>

            </sect2>
            <sect2>
                <title role="HEAD-3">Skin irritation</title>
                <#--    Existing macro:-->
                <#--            <@keyTox.irritationSummary dataset/>-->
                <@keyAppendixE.appendixEstudies _subject "SkinIrritationCorrosion"/>
            </sect2>
            <sect2>
                <title role="HEAD-3">Eye irritation</title>
                <@keyAppendixE.appendixEstudies _subject "EyeIrritation"/>
            </sect2>

            <sect2>
                <title role="HEAD-3">Skin sensitisation</title>
                <#--    Existing macro:-->
                <#--        <@keyTox.sensitisationSummary activeSubstance/>-->
                <@keyAppendixE.appendixEstudies _subject "SkinSensitisation"/>
            </sect2>
            <sect2>
                <title role="HEAD-3">Phototoxicity</title>
                <@keyAppendixE.appendixEstudies _subject "PhototoxicityVitro"/>
            </sect2>
            <#--NOTE: THIS SECTION DOESN'T EXIST IN KCA:-->
            <sect2>
                <title role="HEAD-3">Acute toxicity: other routes</title>
                <@keyAppendixE.appendixEstudies _subject "AcuteToxicityOtherRoutes"/>
            </sect2>
        </sect1>

        <?hard-pagebreak?>

        <sect1>
            <title role="HEAD-2">Short-term toxicity</title>
            <#--    Existing macro: -->
             <#--    <@keyTox.repeatedDoseToxicitySummary activeSubstance/>-->
            <@keyTox.summaryAll _subject "RepeatedDoseToxicity" "table"/>

            <#-- NOTE: general question -> what to do with "other" endpoints, with non-specified duration-->
            <sect2>
                <title role="HEAD-3">Oral 28-day study (short-term repeated)</title>
                <@keyAppendixE.appendixEstudies _subject "RepeatedDoseToxicityOral" toxContext["RepeatedDoseToxicityOral_28"]/>
            </sect2>

            <sect2>
                <title role="HEAD-3">Oral 90-day study (sub-chronic)</title>
                <@keyAppendixE.appendixEstudies _subject "RepeatedDoseToxicityOral" toxContext["RepeatedDoseToxicityOral_90"]/>
            </sect2>

            <sect2>
                <title role="HEAD-3">Other routes</title>
                <#--merge all the subsections + remainder of dosetoxicityoral; could also be split into several -->
                <@keyAppendixE.appendixEstudies _subject=_subject docSubTypes=["RepeatedDoseToxicityOral", "RepeatedDoseToxicityInhalation", "RepeatedDoseToxicityDermal", "RepeatedDoseToxicityOther"]
                    context=toxContext["RepeatedDoseToxicity_nochronic"] name="other routes"/>
            </sect2>
        </sect1>

        <?hard-pagebreak?>

        <sect1>
            <title role="HEAD-2">Genotoxicity testing</title>
            <#--    Existing macro: -->
            <#--    <@keyTox.mutagenicitySummary activeSubstance/>-->
            <@keyTox.summaryAll _subject "GeneticToxicity" "table"/>

            <sect2>
                <title role="HEAD-3">In vitro studies</title>
                <@keyAppendixE.appendixEstudies _subject "GeneticToxicityVitro"/>
            </sect2>
            <#--Problem: separating in vivo studies for ambiguous endpoints (germ and somatic cell studies)- not separated so far-->
            <sect2 label="2-3">
                <title role="HEAD-3">In vivo studies (germ and somatic)</title>
                <@keyAppendixE.appendixEstudies _subject "GeneticToxicityVivo"/>
            </sect2>
        </sect1>

        <?hard-pagebreak?>

        <sect1 xml:id="CA55">
            <title role="HEAD-2">Long-term toxicity and carcinogenicity</title>
            <#--    NOTE: the summary Carcinogenicity_EU_PPP includes long-term toxicity. But also long term toxicity is included in the summary of repeated dose tox.-->
            <@keyTox.summaryAll _subject "Carcinogenicity_EU_PPP" "table"/>
            <@keyAppendixE.appendixEstudies _subject=_subject docSubTypes=["RepeatedDoseToxicityOral","RepeatedDoseToxicityInhalation","RepeatedDoseToxicityDermal","RepeatedDoseToxicityOther", "Carcinogenicity"]
                    context=toxContext["RepeatedDoseToxicity_chronic-Carcinogenicity"] name="long-term toxicity and carcinogenicity"/>

            <#--    Existing macro: but not for carcinogenicity PPP-->
            <#--    <@keyTox.carcinogenicitySummary activeSubstance/>-->
        </sect1>

        <?hard-pagebreak?>

        <sect1  xml:id="CA56">
            <title role="HEAD-2">Reproductive toxicity</title>
            <#--    This section is confusing and makes no sense: endpoints don't seem to be in the right places, now there are rearranged-->
            <@keyTox.summaryAll _subject "ToxicityToReproduction_EU_PPP" "table"/>

            <sect2>
                <title role="HEAD-3">Generational studies</title>
                <@keyAppendixE.appendixEstudies _subject "ToxicityReproduction" toxContext["ToxicityToReproduction_generational"] "generational studies"/>
            </sect2>
            <sect2>
                <title role="HEAD-3">Developmental toxicity studies</title>
                <@keyAppendixE.appendixEstudies _subject=_subject docSubTypes=["ToxicityReproduction","DevelopmentalToxicityTeratogenicity"] context=toxContext["ToxicityToReproduction_developmental"] name="developmental toxicity"/>
            </sect2>

            <sect2>
                <title role="HEAD-3">Other studies on reproductive toxicity</title>
                <@keyAppendixE.appendixEstudies _subject=_subject docSubTypes=["ToxicityReproduction", "ToxicityReproductionOther"] context=toxContext["ToxicityToReproduction_other"] name="reproductive toxicity"/>
            </sect2>
        </sect1>

        <?hard-pagebreak?>

        <sect1>
            <title role="HEAD-2">Neurotoxicity studies</title>
            <#--existing macro-->
            <#--    <@keyTox.otherEffectsSummary activeSubstance/>-->
            <#--new macro-->
            <@keyTox.summaryAll _subject "Neurotoxicity" "table"/>

            <sect2>
                <title role="HEAD-3">Neurotoxicity studies in rodents</title>
                <@keyAppendixE.appendixEstudies _subject "Neurotoxicity" toxContext["Neurotoxicity_rodents"]/>
            </sect2>

            <sect2>
                <title role="HEAD-3">Delayed polyneuropathy studies</title>
                <@keyAppendixE.appendixEstudies _subject "Neurotoxicity" toxContext["Neurotoxicity_delayed"]/>
            </sect2>

            <sect2>
                <title role="HEAD-3">Other neurotoxicity studies</title>
                <@keyAppendixE.appendixEstudies _subject "Neurotoxicity" toxContext["Neurotoxicity_noRodents"]/>
            </sect2>

        </sect1>

        <?hard-pagebreak?>

        <sect1>
            <title role="HEAD-2">Other toxicological studies</title>

            <sect2>
                <title role="HEAD-3">Toxicity studies of metabolites</title>
                <#if _subjectMixture??>
                    <@keyTox.metabolitesTox mixture=_subjectMixture activeSubstance=_subject/>
                <#else>
                    <para>Not available.</para>
                </#if>

            </sect2>

            <sect2>
                <title role="HEAD-3">Supplementary studies on the active substance</title>
                <#-- NOTE: review sections - many do not exist in legislation: should they all come here?-->
                <sect3>
                    <title role="HEAD-3">Immunotoxicity</title>
                    <@keyTox.summaryAll _subject "Immunotoxicity" "table"/>
                    <@keyAppendixE.appendixEstudies _subject "Immunotoxicity"/>
                </sect3>
                <sect3>
                    <title role="HEAD-3">Toxic effects on livestock</title>
                    <@keyTox.summaryAll _subject "ToxicEffectsLivestockPets" "table"/>
                    <@keyAppendixE.appendixEstudies _subject=_subject docSubTypes="ToxicEffectsLivestock" name="toxic effects on livestock"/>
                </sect3>
                <sect3>
                    <title role="HEAD-3">Intermediate effects - mechanistic information</title>
                    <@keyTox.intermediateEffectsStudies _subject/>
                </sect3>
                <sect3>
                    <title role="HEAD-3">Additional toxicological information</title>
                    <@keyTox.summaryAll _subject "AdditionalToxicologicalInformation" "table"/>
                    <@keyAppendixE.appendixEstudies _subject "AdditionalToxicologicalInformation"/>
                </sect3>

            </sect2>

            <sect2 xml:id="CA583">
                <title role="HEAD-3">Endocrine disrupting properties</title>
                <@keyTox.summaryAll _subject "EndocrineDisruptingPropertiesAssessmentPest" "table"/>
                <@keyAppendixE.appendixEstudies _subject "EndocrineDisrupterMammalianScreening"/>
            </sect2>

        </sect1>

        <?hard-pagebreak?>

        <sect1>
            <title role="HEAD-2">Medical data</title>
            <@keyTox.toxicokineticsSummary _subject/>
            <sect2>
                <title role="HEAD-3">Medical surveillance on manufacturing plant personnel and monitoring studies</title>
                <@keyAppendixE.appendixEstudies _subject "HealthSurveillanceData"/>
            </sect2>
            <sect2>
                <title role="HEAD-3">Data collected on humans</title>
                <@keyAppendixE.appendixEstudies _subject "ExposureRelatedObservationsOther"/>
            </sect2>
            <sect2 xml:id="CA593">
                <title role="HEAD-3">Direct observations</title>
                <@keyAppendixE.appendixEstudies _subject "DirectObservationsClinicalCases"/>
            </sect2>
            <sect2>
                <title role="HEAD-3">Epidemiological studies</title>
                <@keyAppendixE.appendixEstudies _subject "EpidemiologicalData"/>
            </sect2>
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
        </sect1>

    </#if>
</#if>
<#assign anmethContext = {  "micro" : [{"path": "AdministrativeData.Endpoint", "val" : ["microorganism as manufactured"], "qual" : "lk", "type" : "picklist"}],

                            "micro_seedStockVar" : [{"path": "AdministrativeData.Endpoint", "val" : ["variability of seed stock"], "qual" : "lk", "type" : "picklist"}],

                            "micro_mutant" : [{"path": "AdministrativeData.Endpoint", "val" : ["mutant"], "qual" : "lk", "type" : "picklist"}],

                            "micro_seedStockPurity" : [{"path": "AdministrativeData.Endpoint", "val" : ["purity of seed stock"], "qual" : "lk", "type" : "picklist"}],

                            "micro_contaminant" : [{"path": "AdministrativeData.Endpoint", "val" : ["contaminating microorganisms"], "qual" : "lk", "type" : "picklist"}],

                            "micro_stability" : [{"path": "AdministrativeData.Endpoint", "val" : ["storage stability"], "qual" : "lk", "type" : "picklist"}],

                            "residues" : [{"path": "AdministrativeData.Endpoint", "val" : ["residues"], "qual" : "lk", "type" : "picklist"}],

                            "other_micro" : [{"path": "AdministrativeData.Endpoint",
                                                "val" : ["microorganism as manufactured", "relevant impurities", "storage stability", "residues",
                                                            "variability of seed stock", "mutant", "purity of seed stock", "contaminating microorganisms"],
                                                "qual" : "nl", "type" : "picklist"}],

                            "sub" : [{"path": "AdministrativeData.Endpoint",
                                           "val" : ["active substance", "seed stock", "storage stability"],
                                           "qual" : "lk", "type" : "picklist"}],

                            "impurities" : [{"path": "AdministrativeData.Endpoint", "val" : ["relevant impurities"],
                                           "qual" : "lk", "type" : "picklist"}],

                            "risk" : [{"path": "AdministrativeData.Endpoint", "val" : ["risk"], "qual" : "lk", "type" : "picklist"}],

                            "monitoring_plants" : [{"path": "AdministrativeData.Endpoint", "val" : ["post-approval control and monitoring"], "qual" : "lk", "type" : "picklist"},
                                                    {"path": "MaterialsAndMethods.MatrixMedium", "val":["plant", "egg", "honey", "meat", "milk"], "qual":"lk", "type":"picklistMultiple"}],

                            "monitoring_tissues" : [{"path": "AdministrativeData.Endpoint", "val" : ["post-approval control and monitoring"], "qual" : "lk", "type" : "picklist"},
                                                {"path": "MaterialsAndMethods.MatrixMedium", "val":["animal and human body fluids and tissues", "fat", "liver", "kidney", "blood", "urine"], "qual":"lk", "type":"picklistMultiple"},
                                                {"path": "MaterialsAndMethods.MatrixMedium", "val":["plant", "egg", "honey", "meat", "milk"], "qual":"nl", "type":"picklistMultiple"}],

                            "monitoring_soil" : [{"path": "AdministrativeData.Endpoint", "val" : ["post-approval control and monitoring"], "qual" : "lk", "type" : "picklist"},
                                                {"path": "MaterialsAndMethods.MatrixMedium", "val":["soil", "sediment"], "qual":"lk", "type":"picklistMultiple"},
                                                {"path": "MaterialsAndMethods.MatrixMedium", "val":["plant", "egg", "honey", "meat", "milk", "animal and human body fluids and tissues", "fat", "liver", "kidney", "blood", "urine"], "qual":"nl", "type":"picklistMultiple"}],

                            "monitoring_water" : [{"path": "AdministrativeData.Endpoint", "val" : ["post-approval control and monitoring"], "qual" : "lk", "type" : "picklist"},
                                                {"path": "MaterialsAndMethods.MatrixMedium", "val":["water"], "qual":"lk", "type":"picklistMultiple"},
                                                {"path": "MaterialsAndMethods.MatrixMedium", "val":["plant", "egg", "honey", "meat", "milk", "animal and human body fluids and tissues", "fat", "liver", "kidney", "blood", "urine", "soil", "sediment"], "qual":"nl", "type":"picklistMultiple"}],

                            "monitoring_soilWater" : [{"path": "AdministrativeData.Endpoint", "val" : ["post-approval control and monitoring"], "qual" : "lk", "type" : "picklist"},
                                                {"path": "MaterialsAndMethods.MatrixMedium", "val":["soil", "sediment", "water"], "qual":"lk", "type":"picklistMultiple"},
                                                {"path": "MaterialsAndMethods.MatrixMedium", "val":["plant", "egg", "honey", "meat", "milk", "animal and human body fluids and tissues", "fat", "liver", "kidney", "blood", "urine"], "qual":"nl", "type":"picklistMultiple"}],

                            "monitoring_air" : [{"path": "AdministrativeData.Endpoint", "val" : ["post-approval control and monitoring"], "qual" : "lk", "type" : "picklist"},
                                                {"path": "MaterialsAndMethods.MatrixMedium", "val":["air"], "qual":"lk", "type":"picklistMultiple"},
                                                {"path": "MaterialsAndMethods.MatrixMedium", "val":["plant", "egg", "honey", "meat", "milk", "animal and human body fluids and tissues", "fat", "liver", "kidney", "blood", "urine", "soil", "sediment", "water"], "qual":"nl", "type":"picklistMultiple"}],

                            "monitoring_other" : [{"path": "AdministrativeData.Endpoint", "val" : ["post-approval control and monitoring"], "qual" : "lk", "type" : "picklist"},
                                                {"path": "MaterialsAndMethods.MatrixMedium", "val":["plant", "egg", "honey", "meat", "milk", "animal and human body fluids and tissues", "fat", "liver", "kidney", "blood", "urine", "soil", "sediment", "water", "air"], "qual":"nl", "type":"picklistMultiple"}],

                            "other_sub" : [{"path": "AdministrativeData.Endpoint",
                                                "val" : ["active substance", "seed stock", "relevant impurities", "storage stability", "risk", "post-approval control and monitoring"],
                                                "qual" : "nl", "type" : "picklist"}],

                            "micro_mix" : [{"path": "AdministrativeData.Endpoint",
                                        "val" : ["formulated", "microorganism as manufactured"],
                                        "qual" : "lk", "type" : "picklist"}],

                            "micro_mix_uniformity" : [{"path": "AdministrativeData.Endpoint",
                                        "val" : ["seed stock", "relevant impurities", "mutant"],
                                        "qual" : "lk", "type" : "picklist"}],

                            "other_micro_mix" : [{"path": "AdministrativeData.Endpoint",
                                                "val" : ["formulated", "microorganism as manufactured", "contaminating microorganisms",
                                                            "seed stock", "relevant impurities", "mutant", "storage stability", "residues"],
                                                "qual" : "nl", "type" : "picklist"}],

                            "sub_mix" : [{"path": "AdministrativeData.Endpoint",
                                            "val" : ["formulated", "active substance", "seed stock", "storage stability"],
                                            "qual" : "lk", "type" : "picklist"}],

                            "other_sub_mix" : [{"path": "AdministrativeData.Endpoint",
                                                "val" : ["formulated", "active substance", "seed stock", "relevant impurities",
                                                            "storage stability", "residues", "post-approval control and monitoring"],
                                                "qual" : "nl", "type" : "picklist"}]

}/>

<#--create hashmap with analytical methods-->
<#global _doc2SectHashMap={}/>
<#global _toc=iuclid.localizeTreeFor(_subject.documentType, _subject.submissionType, _subject.documentKey)/>
<#recurse _toc/>
<#--add metabolites: if metabolites, list and recurse-->
<#if _metabolites?? && _metabolites?has_content>
    <#list _metabolites as metab>
        <#global _toc=iuclid.localizeTreeFor(metab.documentType, metab.submissionType, metab.documentKey)/>
        <#recurse _toc/>
    </#list>
</#if>

<@keyAnMeth.analyticalMethodsSummary _subject/>

<#if _subject.documentType=="MIXTURE">

    <#if workingContext=="MICRO">

        <sect1>
            <title role="HEAD-2">Methods for the analysis of the preparation</title>
            <#-- — Methods, which must be described in full, must be provided for the identification and the determination of the content of the micro-organism in the preparation. In the case of a preparation containing more than one micro-organism, methods capable of identifying and determining the content of each one should be provided.-->
            <#-- — Methods to establish regular control of the final product (preparation) in order to show that it does not contain other organisms than the indicated ones and to establish its uniformity.-->
            <#-- — Methods to identify any contaminating micro-organisms of the preparation.-->
            <#-- — Methods used to determine the storage stability and shelf life of the preparation must be provided.-->
            <sect2>
                <title role="HEAD-3">Methods for the identification and determination of the content of the micro-organism</title>
                    <@keyAppendixE.appendixEstudies _subject "AnalyticalMethods" anmethContext["micro_mix"] "methods for the analysis of the preparation"/>
            </sect2>

            <sect2>
                <title role="HEAD-3">Methods to establish the uniformity of the final product (preparation)</title>
                    <@keyAppendixE.appendixEstudies _subject "AnalyticalMethods" anmethContext["micro_mix_uniformity"]
                        "methods to establish the uniformity of the final product (preparation)"/>
            </sect2>

            <sect2>
                <title role="HEAD-3">Methods to identify any contaminating micro-organisms of the preparation</title>
                    <@keyAppendixE.appendixEstudies _subject "AnalyticalMethods" anmethContext["micro_contaminant"]
                        "methods to identify and quantify contaminating microorganisms"/>
            </sect2>

            <sect2>
                <title role="HEAD-3">Methods to determine the storage stability and shelf life of the preparation</title>
                    <@keyAppendixE.appendixEstudies _subject "AnalyticalMethods" anmethContext["micro_stability"]
                    "methods to determine storage stability/shelf life"/>
            </sect2>
        </sect1>

        <?hard-pagebreak?>

        <sect1>
            <title role="HEAD-2">Methods to determine and quantify residues</title>
            <@keyAppendixE.appendixEstudies _subject "AnalyticalMethods" anmethContext["residues"] "methods to determine and quantify residues"/>
        </sect1>

         <#--NEW section-->
         <#assign otherMicrMixAnMeth>
            <@keyAppendixE.appendixEstudies _subject "AnalyticalMethods" anmethContext["other_micro_mix"] "other analytical methods"/>
         </#assign>
         <#if otherMicrMixAnMeth?has_content && !(otherMicrMixAnMeth?contains("No relevant individual"))>
            <?hard-pagebreak?>

            <sect1><title role="HEAD-2">Other analytical methods</title>
                ${otherMicrMixAnMeth}
            </sect1>
        </#if>

    <#elseif workingContext=="CHEM">

       <sect1>
        <title role="HEAD-2">Methods used for the generation of pre-authorisation data</title>

        <sect2>
            <title role="HEAD-2">Methods for the analysis of the plant protection product</title>
            <#-- (a) active substance and/or variant in the plant protection product;-->
            <#-- (b) relevant impurities identified in the technical material or which may be formed during manufacture of the plant protection product or from degradation of the plant protection product during storage;-->
            <#-- (c) relevant co-formulants or components of co-formulants, where required by the national competent authorities. NOT CONSIDERED-->

            <sect3><title role="HEAD-4">Active substance and/or variant</title>
                <@keyAppendixE.appendixEstudies _subject "AnalyticalMethods" anmethContext["sub_mix"] "methods for the analysis of the plant protection product"/>
            </sect3>

            <sect3><title role="HEAD-4">Relevant impurities</title>
                <@keyAppendixE.appendixEstudies _subject "AnalyticalMethods" anmethContext["impurities"] "methods for the analysis of relevant impurities"/>
            </sect3>

        </sect2>

        <sect2>
            <title role="HEAD-2">Methods for the determination of residues</title>
            <#-- (a) in soil, water, sediment, air and any additional matrices used in support of environmental fate studies;-->
            <#-- (b) in soil, water and any additional matrices used in support of efficacy studies;-->
            <#-- (c) in feed, body fluids and tissues, air and any additional matrices used in support of toxicology studies;-->
            <#-- (d) in body fluids, air and any additional matrices used in support of operator, worker, resident and bystander exposure studies;-->
            <#-- (e) in or on plants, plant products, processed food commodities, food of plant and animal origin, feed and any additional matrices used in support of residues studies;-->
            <#-- (f) in soil, water, sediment, feed and any additional matrices used in support of ecotoxicology studies;-->
            <#-- (g) in water, buffer solutions, organic solvents and any additional matrices resulting from the physical and chemical properties tests.-->

                <sect3><title role="HEAD-4">In physical and chemical properties studies</title>
                    <@keyAppendixE.appendixEstudies _subject "AnalyticalMethods" anmethContext["residues"]
                        "methods for the determination of residues in support of physical and chemical properties studies" "2"/>
                </sect3>

                <sect3><title role="HEAD-4">In efficacy studies</title>
                    <@keyAppendixE.appendixEstudies subject=_subject docSubTypes="AnalyticalMethods" context=anmethContext["residues"]
                     name="methods for the determination of residues in support of efficacy studies" section="6"/>
                </sect3>

                <sect3><title role="HEAD-4">In toxicology studies</title>
                    <@keyAppendixE.appendixEstudies subject=_subject docSubTypes="AnalyticalMethods" context=anmethContext["residues"]
                     name="methods for the determination of residues in support of toxicology studies" section=["7.1", "7.3"]/>
                </sect3>

                <sect3><title role="HEAD-4">In operator, worker, resident and bystander exposure studies</title>
                    <@keyAppendixE.appendixEstudies _subject "AnalyticalMethods" anmethContext["residues"]
                     "methods for the determination of residues in support of operator, worker, resident and bystanders exposure studies" "7.2"/>
                </sect3>

                <sect3><title role="HEAD-4">In residues studies</title>
                    <para>Please, refer to CA 4: methods for risk assessment in residues studies.</para>
                </sect3>

                <sect3><title role="HEAD-4">In environmental fate studies</title>
                    <@keyAppendixE.appendixEstudies _subject "AnalyticalMethods" anmethContext["residues"]
                     "methods for the determination of residues in support of environmental fate studies" "9"/>
                </sect3>

                <sect3><title role="HEAD-4">In ecotoxicology studies</title>
                    <@keyAppendixE.appendixEstudies _subject "AnalyticalMethods" anmethContext["residues"]
                    "methods for the determination of residues in support of ecotoxicology studies" "10"/>
                </sect3>

                <#assign otherResUnclassifiedAnMeth>
                    <@keyAppendixE.appendixEstudies subject=_subject docSubTypes="AnalyticalMethods" context=anmethContext["residues"]
                     name="other methods for the determination of residues" section=["1.", "3", "4", "11", "12", "13", "NA"]/>
                 </#assign>
                 <#if otherResUnclassifiedAnMeth?has_content && !(otherResUnclassifiedAnMeth?contains("No relevant individual"))>
                    <sect3><title role="HEAD-4">In other studies (unclassified)</title>
                        ${otherResUnclassifiedAnMeth}
                    </sect3>
                </#if>
        </sect2>
        </sect1>

        <?hard-pagebreak?>

        <sect1>
            <title role="HEAD-2">Methods for post-authorisation control and monitoring purposes</title>
            <#-- — in or on plants, plant products, processed food commodities, food and feed of plant and animal origin,-->
            <#-- — in body fluids and tissues,-->
            <#-- — in soil,-->
            <#-- — in water,-->
            <#-- — in air, unless the applicant shows that exposure of operators, workers, residents or bystanders is negligible.-->
            <sect2>
                <title role="HEAD-3">In or on plants, plant products, processed food commodities, food and feed of plant and animal origin</title>
                <@keyAppendixE.appendixEstudies _subject "AnalyticalMethods" anmethContext["monitoring_plants"]
                    "methods for post-approval and monitoring in plants, plant products, food and feedingstuffs of plant and animal origin"/>
            </sect2>

            <sect2>
                <title role="HEAD-3">In body fluids and tissues</title>
                <@keyAppendixE.appendixEstudies _subject "AnalyticalMethods" anmethContext["monitoring_tissues"]
                    "methods for post-approval and monitoring in animal and human body fluids and tissues"/>
            </sect2>

            <sect2>
                <title role="HEAD-3">In soil and sediment</title>
                <@keyAppendixE.appendixEstudies _subject "AnalyticalMethods" anmethContext["monitoring_soil"]
                    "methods for post-approval and monitoring in soil and sediment"/>
            </sect2>

            <sect2>
                <title role="HEAD-3">In water</title>
                <@keyAppendixE.appendixEstudies _subject "AnalyticalMethods" anmethContext["monitoring_water"]
                    "methods for post-approval and monitoring in water"/>
            </sect2>

            <sect2>
                <title role="HEAD-3">In air</title>
                <@keyAppendixE.appendixEstudies _subject "AnalyticalMethods" anmethContext["monitoring_air"]
                    "methods for post-approval and monitoring in air"/>
            </sect2>

            <#assign otherPostAppAnMeth>
                 <@keyAppendixE.appendixEstudies _subject "AnalyticalMethods" anmethContext["monitoring_other"]
                "methods for post-approval and monitoring in other matrices not listed above"/>
            </#assign>
             <#if otherPostAppAnMeth?has_content && !(otherPostAppAnMeth?contains("No relevant individual"))>
                <sect2><title role="HEAD-3">In any other matrices</title>
                    ${otherPostAppAnMeth}
                </sect2>
            </#if>
        </sect1>

         <#--NEW section-->
         <#assign otherSubMixAnMeth>
             <@keyAppendixE.appendixEstudies _subject "AnalyticalMethods" anmethContext["other_sub_mix"] "other analytical methods"/>
         </#assign>
         <#if otherSubMixAnMeth?has_content && !(otherSubMixAnMeth?contains("No relevant individual"))>
            <?hard-pagebreak?>

            <sect1><title role="HEAD-2">Other analytical methods</title>
                ${otherSubMixAnMeth}
            </sect1>
        </#if>
    </#if>

<#elseif _subject.documentType=="SUBSTANCE">

    <#if workingContext=="MICRO">

        <sect1>
            <title role="HEAD-2">Methods for the analysis of the micro-organism as manufactured</title>
            <#-- — Methods for the identification of the micro-organism.-->
            <#-- — Methods for providing information on possible variability of seed stock/active micro-organism.EN 3.4.2013 Official Journal of the European Union L 93/73-->
            <#-- — Methods to differentiate a mutant of the micro-organism from the parent wild strain.-->
            <#-- — Methods for the establishment of purity of seed stock from which batches are produced and methods to control that purity.-->
            <#-- — Methods to determine the content of the micro-organism in the manufactured material used for the production of formulated products and methods to show that contaminating micro-organisms are controlled to an acceptable level.-->
            <#-- — Methods for the determination of relevant impurities in the manufactured material.-->
            <#-- — Methods to control the absence and to quantify (with appropriate limits of determination) the possible presence of any human and mammalian pathogens.-->
            <#-- — Methods to determine storage stability, shelf-life of the micro-organism, if appropriate.-->

            <sect2>
                <title role="HEAD-3">Methods for the identification of the micro-organism</title>
                    <@keyAppendixE.appendixEstudies _subject "AnalyticalMethods" anmethContext["micro"] "methods for the analysis of the microorganism"/>
            </sect2>

            <sect2>
                <title role="HEAD-3">Methods for providing information on possible variability of seed stock/active micro-organism</title>
                    <@keyAppendixE.appendixEstudies _subject "AnalyticalMethods" anmethContext["micro_seedStockVar"]
                        "methods for providing information on possible variability of seed stock/active micro-organism"/>
            </sect2>

            <sect2>
                <title role="HEAD-3">Methods to differentiate a mutant of the micro-organism from the parent wild strain</title>
                    <@keyAppendixE.appendixEstudies _subject "AnalyticalMethods" anmethContext["micro_mutant"]
                        "methods to differentiate a mutant of the micro-organism from the parent wild strain"/>
            </sect2>

            <sect2>
                <title role="HEAD-3">Methods for the establishment of purity of seed stock from which batches are produced and methods to control that purity</title>
                    <@keyAppendixE.appendixEstudies _subject "AnalyticalMethods" anmethContext["micro_seedStockPurity"]
                        "methods for providing information on purity of seed stock/active micro-organism"/>
            </sect2>

            <sect2>
                <title role="HEAD-3">Methods for the identification and quantification of contaminating micro-organisms, human and mammalian pathogens</title>
                    <@keyAppendixE.appendixEstudies _subject "AnalyticalMethods" anmethContext["micro_contaminant"]
                        "methods to identify and quantify contaminating microorganisms"/>
            </sect2>

            <sect2>
                <title role="HEAD-3">Methods for the determination of relevant impurities in the manufactured material</title>
                    <@keyAppendixE.appendixEstudies _subject "AnalyticalMethods" anmethContext["impurities"] "methods for relevant impurities and/or metabolites of concern"/>
            </sect2>

            <sect2>
                <title role="HEAD-3">Methods to determine storage stability, shelf-life of the micro-organism</title>
                    <@keyAppendixE.appendixEstudies _subject "AnalyticalMethods" anmethContext["micro_stability"] "methods to determine storage stability/shelf life"/>
            </sect2>

        </sect1>

        <?hard-pagebreak?>

        <sect1>
            <title role="HEAD-2">Methods to determine and quantify residues (viable or non-viable) </title>
            <@keyAppendixE.appendixEstudies _subject "AnalyticalMethods" anmethContext["residues"] "methods to determine and quantify residues"/>
            <#-- — the active micro-organism(s),-->
            <#-- — relevant metabolites (especially toxins),-->
        </sect1>

         <#--NEW section-->
         <#assign otherMicroAnMeth>
            <@keyAppendixE.appendixEstudies _subject "AnalyticalMethods" anmethContext["other_micro"] "other analytical methods"/>
         </#assign>
         <#if otherMicroAnMeth?has_content && !(otherMicroAnMeth?contains("No relevant individual"))>
            <?hard-pagebreak?>

            <sect1><title role="HEAD-2">Other analytical methods</title>
                ${otherMicroAnMeth}
            </sect1>
        </#if>

    <#elseif workingContext=="CHEM">

        <sect1>
            <title role="HEAD-2">Methods used for the generation of pre-approval data</title>

            <sect2>
                <title role="HEAD-2">Methods for the analysis of the active substance as manufactured</title>
                <#-- (a) pure active substance in the active substance as manufactured and specified in the dossier submitted in support of approval under Regulation (EC) No 1107/2009;-->
                <#-- (b) significant and relevant impurities and additives (such as stabilisers) in the active substance as manufactured.-->

                <sect3><title role="HEAD-4">Pure active substance</title>
                    <@keyAppendixE.appendixEstudies _subject "AnalyticalMethods" anmethContext["sub"] "methods for the analysis of the active substance"/>
                </sect3>

                <sect3><title role="HEAD-4">Significant and relevant impurities and additives</title>
                    <@keyAppendixE.appendixEstudies _subject "AnalyticalMethods" anmethContext["impurities"] "methods for relevant impurities and/or metabolites of concern"/>
                </sect3>

            </sect2>

            <sect2>
                <title role="HEAD-3">Methods for risk assessment</title>
                <#-- Note: studies will appear only in the lowest-numbered section in case they are used in more than 1 section-->
                <#-- (a) in soil, water, sediment, air and any additional matrices used in support of environmental fate studies;-->
                <#-- (b) in soil, water and any additional matrices used in support of efficacy studies; NOTE: not possible to split since section doesn't exist-->
                <#-- (c) in feed, body fluids and tissues, air and any additional matrices used in support of toxicology studies;-->
                <#-- (d) in body fluids, air and any additional matrices used in support of operator, worker, resident and bystander exposure studies;-->
                <#-- (e) in or on plants, plant products, processed food commodities, food of plant and animal origin, feed and any additional matrices used in support of residues studies;-->
                <#-- (f) in soil, water, sediment, feed and any additional matrices used in support of ecotoxicology studies;-->
                <#-- (g) in water, buffer solutions, organic solvents and any additional matrices used in the physical and chemical properties tests.-->

                <sect3><title role="HEAD-4">In physical and chemical properties studies</title>
                    <@keyAppendixE.appendixEstudies _subject "AnalyticalMethods" anmethContext["risk"]
                        "methods for risk assessment in support of physical and chemical properties studies" "2"/>
                </sect3>

                <sect3><title role="HEAD-4">In toxicology studies</title>
                    <@keyAppendixE.appendixEstudies subject=_subject docSubTypes="AnalyticalMethods" context=anmethContext["risk"]
                     name="methods for risk assessment in support of toxicology studies" section=["5.1", "5.2", "5.3", "5.4", "5.5", "5.6", "5.7", "5.8"]/>
                </sect3>

                <sect3><title role="HEAD-4">In operator, worker, resident and bystander exposure studies</title>
                    <@keyAppendixE.appendixEstudies _subject "AnalyticalMethods" anmethContext["risk"]
                     "methods for risk assessment in support of toxicology studies" "5.9"/>
                </sect3>

                <sect3><title role="HEAD-4">In residues studies</title>
                    <@keyAppendixE.appendixEstudies _subject "AnalyticalMethods" anmethContext["risk"]
                     "methods for risk assessment in support of residues studies" "6"/>
                </sect3>

                <sect3><title role="HEAD-4">In environmental fate studies</title>
                    <@keyAppendixE.appendixEstudies _subject "AnalyticalMethods" anmethContext["risk"]
                     "methods for risk assessment in support of environmental fate studies" "7"/>
                </sect3>

                <sect3><title role="HEAD-4">In ecotoxicology studies</title>
                    <@keyAppendixE.appendixEstudies _subject "AnalyticalMethods" anmethContext["risk"]
                    "methods for risk assessment in support of ecotoxicology studies" "8"/>
                </sect3>

                <#assign otherRiskUnclassifiedAnMeth>
                    <@keyAppendixE.appendixEstudies subject=_subject docSubTypes="AnalyticalMethods" context=anmethContext["risk"]
                     name="other methods for risk assessment" section=["1", "3", "9", "10", "11", "NA"]/>
                 </#assign>
                 <#if otherRiskUnclassifiedAnMeth?has_content && !(otherRiskUnclassifiedAnMeth?contains("No relevant individual"))>
                    <sect3><title role="HEAD-4">In other studies (unclassified)</title>
                        ${otherRiskUnclassifiedAnMeth}
                    </sect3>
                </#if>

            </sect2>
        </sect1>

        <?hard-pagebreak?>

        <sect1>
            <title role="HEAD-2">Methods for post-approval control and monitoring purposes</title>
            <#-- (a) the determination of all components included in the monitoring residue definition as submitted in accordance with the provisions of point 6.7.1 in order to enable Member States to determine compliance with established maximum residue levels (MRLs); they shall cover residues in or on food and feed of plant and animal origin;-->
            <#-- (b) the determination of all components included for monitoring purposes in the residue definitions for soil and water as submitted in accordance with the provisions of point 7.4.2;-->
            <#-- (c) the analysis in air of the active substance and relevant breakdown products formed during or after application, unless the applicant shows that exposure of operators, workers, residents or bystanders is negligible;-->
            <#-- (d) the analysis in body fluids and tissues for active substances and relevant metabolites.-->

                <#--Separate based on matrix-->
                <sect2>
                    <title role="HEAD-3">In or on plants, plant products, processed food commodities, food and feed of plant and animal origin</title>
                    <@keyAppendixE.appendixEstudies _subject "AnalyticalMethods" anmethContext["monitoring_plants"]
                        "methods for post-approval and monitoring in plants, plant products, food and feedingstuffs"/>
                </sect2>

                <sect2>
                    <title role="HEAD-3">In body fluids and tissues</title>
                    <@keyAppendixE.appendixEstudies _subject "AnalyticalMethods" anmethContext["monitoring_tissues"]
                        "methods for post-approval and monitoring in animal and human body fluids and tissues"/>
                </sect2>

                <sect2>
                    <title role="HEAD-3">In soil, sediment and water</title>
                    <@keyAppendixE.appendixEstudies _subject "AnalyticalMethods" anmethContext["monitoring_soilWater"]
                        "methods for post-approval and monitoring in soil, sediment and water"/>
                </sect2>

                <sect2>
                    <title role="HEAD-3">In air</title>
                    <@keyAppendixE.appendixEstudies _subject "AnalyticalMethods" anmethContext["monitoring_air"]
                        "methods for post-approval and monitoring in air"/>
                </sect2>

                <#assign otherMonitoringMatrixAnMeth>
                    <@keyAppendixE.appendixEstudies _subject "AnalyticalMethods" anmethContext["monitoring_other"]
                        "methods for post-approval and monitoring in other matrices not listed above"/>
                 </#assign>
                 <#if otherMonitoringMatrixAnMeth?has_content && !(otherMonitoringMatrixAnMeth?contains("No relevant individual"))>
                     <sect2>
                        <title role="HEAD-3">In any other matrices</title>
                        ${otherMonitoringMatrixAnMeth}
                    </sect2>
                </#if>
        </sect1>

        <#--New section in case any remaining docs-->
         <#assign otherSubAnMeth>
            <@keyAppendixE.appendixEstudies _subject "AnalyticalMethods" anmethContext["other_sub"] "other analytical methods"/>
         </#assign>
         <#if otherSubAnMeth?has_content && !(otherSubAnMeth?contains("No relevant individual"))>
            <?hard-pagebreak?>
            <sect1>
                <title role="HEAD-2">Other analytical methods</title>
                 ${otherSubAnMeth}
            </sect1>
         </#if>

    <#elseif workingContext=="MRL">
        <@keyAppendixE.appendixEstudies _subject "AnalyticalMethods" "" "analytical methods"/>
    </#if>
</#if>

<#--Macros for iterating over IUCLID to find analytical methods-->
<#macro "section_tree_node">

    <#local contents=(.node.content)!/>

    <#if contents?has_content>
        <#list contents as doc>

            <#if doc.documentType=="ENDPOINT_STUDY_RECORD">

                <#if doc.AdministrativeData.CrossReference?has_content>
                    <#list doc.AdministrativeData.CrossReference as cref>
                        <#local crefDoc = iuclid.getDocumentForKey(cref.RelatedInformation) />

                        <#if crefDoc?has_content && crefDoc.documentType=="ENDPOINT_STUDY_RECORD" && crefDoc.documentSubType=="AnalyticalMethods" >

                            <#local anMethName><@com.text crefDoc.name/></#local>
                            <#local anMethUUID = crefDoc.documentKey.uuid/>
                            <#local anMethEndpoint><@com.picklist crefDoc.AdministrativeData.Endpoint/></#local>

                            <#local docTypeSubType>${doc.documentType}.${doc.documentSubType}</#local>
                            <#local docSecNb = _toc.nodeFor[docTypeSubType].number />
                            <#local docSecName = _toc.nodeFor[docTypeSubType].title />
                            <#local docSecEntry= {"nb": docSecNb, "name": docSecName}/>

                            <#if _doc2SectHashMap?keys?seq_contains(anMethUUID)>
                                <#local prevSecEntry=_doc2SectHashMap[anMethUUID]/>
                                <#local newSecEntry=prevSecEntry["section"] + [docSecEntry]/>
                            <#else>
                                <#local newSecEntry=[docSecEntry]/>
                            </#if>

                            <#local newEntry={"name":anMethName, "endpoint": anMethEndpoint, "section":newSecEntry}/>
                            <#global _doc2SectHashMap = _doc2SectHashMap + {anMethUUID: newEntry}/>
                        </#if>
                    </#list>
                </#if>
            </#if>
        </#list>
    </#if>

    <#recurse/>
</#macro>
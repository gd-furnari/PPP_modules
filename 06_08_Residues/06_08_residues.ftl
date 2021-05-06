<#assign residuesContext = { "metabolismPlants" : [{"path": "AdministrativeData.Endpoint",
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
                                                            "type" : "picklist"}]
}/>

<#--This is always for the substance-->
<#if workingContext=="CHEM" || workingContext=="MRL">

    <@keyRes.residuesSummary _subject "ResiduesInFoodAndFeedingstuffs" />

    <sect1>
        <title role="HEAD-2">Storage stability of residues</title>
        <@keyRes.residuesSummary _subject "StabilityResiduesCommodities" />
        <@keyAppendixE.appendixEstudies _subject "StabilityOfResiduesInStoredCommod" "" "storage stability of residues"/>
    </sect1>

    <?hard-pagebreak?>

    <sect1>
        <title role="HEAD-2">Metabolism, distribution and expression of residues</title>

        <sect2 xml:id="CA621">
            <title role="HEAD-3">Plants</title>
            <@keyRes.residuesSummary _subject=_subject docSubType="MetabolismPlants" selection=["PrimaryCrops"]/>
            <@keyAppendixE.appendixEstudies _subject "MetabolismInCrops" residuesContext["metabolismPlants"] "metabolism of residues in plants"/>

        </sect2>

        <#-- NOTE: for all these sections there is just one document, which we could separate by
             MaterialsAndMethods.TestAnimals.GeneralTestAnimalInformation.Species e.g. IN ("hen") but there is also possibility to write "other"
             so it would be risky. Probably best is to merge, as follows:
        -->
        <sect2 label="2-5">
            <title role="HEAD-3">Livestock (poultry, lactating ruminants, pigs, fish)</title>
            <@keyRes.residuesSummary _subject "MetabolismInLivestock" />
            <@keyAppendixE.appendixEstudies _subject "MetabolismInLivestock" "" "metabolism of residues in livestock including fish"/>
        </sect2>

        <#--        <sect2>-->
        <#--            <title role="HEAD-3">Poultry</title>-->
        <#--        </sect2>-->

        <#--        <sect2>-->
        <#--            <title role="HEAD-3">Lactating ruminants</title>-->
        <#--        </sect2>-->

        <#--        <sect2>-->
        <#--            <title role="HEAD-3">Pigs</title>-->
        <#--        </sect2>-->

        <#--        <sect2>-->
        <#--            <title role="HEAD-3">Fish</title>-->
        <#--        </sect2>-->

    </sect1>

    <?hard-pagebreak?>

    <sect1 xml:id="CA63">
        <title role="HEAD-2">Magnitude of residue trials in plants</title>
            <@keyRes.residuesSummary _subject=_subject docSubType="MagnitudeResiduesPlants" selection="primary plants"/>
            <@keyAppendixE.appendixEstudies _subject "ResiduesInRotationalCrops" residuesContext["magnitudePlants"] "magnitude of residues in plants"/>
    </sect1>

    <?hard-pagebreak?>

    <sect1>
        <title role="HEAD-2">Feeding studies</title>
        <@keyRes.residuesSummary _subject "ResiduesLivestock" />
        <#-- NOTE: happens the same than with metabolism-->
        <sect2 label="1-4">
            <title role="HEAD-3">Livestock (poultry, ruminants, pigs, fish)</title>
            <@keyAppendixE.appendixEstudies _subject "ResiduesInLivestock" "" "residues in livestock including fish"/>
        </sect2>

<#--        <sect2>-->
<#--            <title role="HEAD-3">Poultry</title>-->
<#--        </sect2>-->

<#--        <sect2>-->
<#--            <title role="HEAD-3">Ruminants</title>-->
<#--        </sect2>-->

<#--        <sect2>-->
<#--            <title role="HEAD-3">Pigs</title>-->
<#--        </sect2>-->

<#--        <sect2>-->
<#--            <title role="HEAD-3">Fish</title>-->
<#--        </sect2>-->

    </sect1>

    <?hard-pagebreak?>

    <sect1>
        <title role="HEAD-2">Effects of processing</title>
        <@keyRes.residuesSummary _subject "NatureMagnitudeResiduesProcessedCommodities" />

        <sect2>
            <title role="HEAD-3">Nature of the residue</title>
            <@keyAppendixE.appendixEstudies _subject "NatureResiduesInProcessedCommod" "" "nature of the residues"/>
        </sect2>

       <sect2>
            <title role="HEAD-3">Distribution of the residue in inedible peel and pulp</title>
            <#-- Summary is repeated: ENDPOINT_SUMMARY.MagnitudeResiduesPlants -->
            <#--            <@keyAppendixE.appendixEstudies _subject "ResiduesInRotationalCrops" residuesContext["magnitudePeelPulp"] "residues in inedible peel and pulp"/>-->
            <#-- NOTE: this context is wrong (it's a repeatable block etc). Check if this is regardless of type of endpoint (crops vs rotational crops); if not then add and remove this condition from general case-->
           <para>Studies on the distribution of residues in inedible peel and pulp are provided in <command  linkend="CA63">Section 6.3</command>).</para>

        </sect2>

        <sect2>
            <title role="HEAD-3">Magnitude of residues in processed commodities</title>
            <@keyAppendixE.appendixEstudies _subject "MagnitudeResidInProcessedComm" "" "magnitude of residues in processed commodities"/>
        </sect2>
    </sect1>

    <?hard-pagebreak?>

    <sect1>
        <title role="HEAD-2">Residues in rotational crops</title>

        <sect2>
            <title role="HEAD-3">Metabolism in rotational crops</title>
            <@keyRes.residuesSummary _subject=_subject docSubType="MetabolismPlants" selection=["RotationalCrops"]/>
            <#--NOTE: we could just take the part of the summary containing the info on rotational crops-->
<#--            <para>Summary information on metabolism in rotational crops is provided in <command  linkend="CA621">Section 6.2.1</command>).</para>-->
            <@keyAppendixE.appendixEstudies _subject "MetabolismInCrops" residuesContext["metabolismRotationalCrops"] "metabolism of residues in rotational crops"/>
        </sect2>

        <sect2>
            <title role="HEAD-3">Magnitude of residues in rotational crops</title>
            <@keyRes.residuesSummary _subject=_subject docSubType="MagnitudeResiduesPlants" selection="rotational crops"/>
            <#-- NOTE: we could separate it by taking the results from KeyInformation.SummaryResiduesData.ResultsApplicableTo-->
            <@keyAppendixE.appendixEstudies _subject "ResiduesInRotationalCrops" residuesContext["magnitudeRotationalCrops"]
                "magnitude of residues in rotational crops"/>
        </sect2>
    </sect1>

    <?hard-pagebreak?>

    <sect1>
        <title role="HEAD-2">Proposed residue definitions and maximum residue levels</title>

        <sect2>
            <title role="HEAD-3">Proposed residue definitions</title>
            <@keyRes.residuesSummary _subject "ResidueFood" />
        </sect2>

        <sect2 xml:id="CA672">
            <title role="HEAD-3">Proposed maximum residue levels (MRLs) and justification of the acceptability of the levels proposed</title>
            <@keyRes.residuesSummary _subject "MRLProposal" />
        </sect2>

        <sect2>
            <title role="HEAD-3">Proposed maximum residue levels (MRLs) and justification of the acceptability of the levels proposed for imported products (import tolerance)</title>
            <para>For proposed MRLs for imported products see <command  linkend="CA672">Section 6.7.2</command> above.</para>
            <#--NOTE: since it's repeated, need to use context MaximumResidueLevel.RationaleForMrl="import of food of animal origin". Is this enough?-->
        </sect2>
    </sect1>

    <?hard-pagebreak?>

    <sect1>
        <title role="HEAD-2">Proposed safety intervals</title>
        <para>For proposed safety intervals, please check documents D on the use of the plant protection product (GAP).</para>
    </sect1>

    <?hard-pagebreak?>

    <sect1>
        <title role="HEAD-2">Estimation of the potential and actual exposure through diet and other sources</title>
        <@keyRes.residuesSummary _subject "ExpectedExposure" />
        <@keyAppendixE.appendixEstudies _subject "ExpectedExposureAndProposedAcceptableResidues"/>
    </sect1>

    <?hard-pagebreak?>

    <sect1>
        <title role="HEAD-2">Other studies</title>
        <@keyRes.residuesSummary _subject "AdditionalInformationOnResiduesInFoodAndFeedingstuffs" />
        <@keyAppendixE.appendixEstudies _subject "AdditionalInfoOnResiduesInFood"/>

        <sect2>
            <title role="HEAD-3">Residue level in pollen and bee products</title>
            <@keyRes.residuesSummary _subject "SupplementaryStudies" />
            <@keyAppendixE.appendixEstudies _subject "ResiduesProcessedCommodities" "" "residue levels in pollen and bee products"/>
        </sect2>

        <sect2>
            <#--            NOTE: this doesn't exist in requirements-->
            <title role="HEAD-3">Migration of residues into and their behaviour on food or feeding stuffs</title>
            <@keyRes.residuesSummary _subject "MigrationOfResiduesIntoAndTheirBehaviourOnFoodOrFeedingstuffs" />
            <@keyAppendixE.appendixEstudies _subject "MigrationOfResidues" "" "residue levels in pollen and bee products"/>
        </sect2>

    </sect1>


<#elseif workingContext=="MICRO">

    <sect1>
        <title role="HEAD-2">Persistence and likelihood of multiplication in or on crops, feedingstuffs or foodstuffs</title>
        <@keyRes.residuesSummary _subject "MigrationOfResiduesIntoAndTheirBehaviourOnFoodOrFeedingstuffs" />
        <@keyAppendixE.appendixEstudies _subject "MigrationOfResidues"/>

    </sect1>

    <?hard-pagebreak?>

    <sect1>
        <title role="HEAD-2">Further information required</title>
        <#-- NOTE: is it maybe better to add a subsection for "other information"?-->
        <@keyRes.residuesSummary _subject "AdditionalInformationOnResiduesInFoodAndFeedingstuffs" />
        <@keyAppendixE.appendixEstudies _subject "AdditionalInfoOnResiduesInFood"/>

        <sect2  label="1-2">
            <title role="HEAD-3">Viable and non-viable residues</title>
            <#-- NOTE: this section cannot be split as of now between viable and non-viable; could be split between residues and magnitude-->
            <@keyRes.residuesSummary _subject "MagnitudeResiduesPlants"/>
            <@keyRes.residuesSummary _subject "NatureMagnitudeResiduesProcessedCommodities"/>

            <@keyAppendixE.appendixEstudies _subject=_subject docSubTypes=["ResiduesInRotationalCrops","MagnitudeResidInProcessedComm"]
                name="viable and non-viable residues in rotational crops and/or processed commodities" />
        </sect2>

        <#--        <sect2>-->
        <#--            <title role="HEAD-3">Non-viable residues</title>-->
        <#--        </sect2>-->

        <#--        <sect2>-->
        <#--            <title role="HEAD-3">Viable residues</title>-->
        <#--        </sect2>-->

    </sect1>

    <?hard-pagebreak?>

    <sect1>
        <title role="HEAD-2">Summary and evaluation of residue behaviour resulting from data submitted under points 6.1 and 6.2</title>
        <@keyRes.residuesSummary _subject "ResiduesInFoodAndFeedingstuffs"/>

    </sect1>

</#if>
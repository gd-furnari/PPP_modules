
<#--This is always for the substance-->
<#--<#if _subject.documentType=="MIXTURE">-->

<#if workingContext=="CHEM">

    <sect1>
        <title role="HEAD-2">Storage stability of residues</title>
<#--        ENDPOINT_SUMMARY.StabilityResiduesCommodities-->
        <@keyAppendixE.appendixEstudies _subject "StabilityOfResiduesInStoredCommod" "" "storage stability of residues"/>
    </sect1>

    <?hard-pagebreak?>

    <sect1>
        <title role="HEAD-2">Metabolism, distribution and expression of residues</title>

        <sect2>
            <title role="HEAD-3">Plants</title>
<#--            ENDPOINT_SUMMARY.MetabolismPlants-->
            <@keyAppendixE.appendixEstudies _subject "MetabolismInCrops" residuesContext["metabolismPlants"] "metabolism of residues in plants"/>
<#--            context: ENDPOINT_STUDY_RECORD.MetabolismInCrops.AdministrativeData.Endpoint="metabolism of residues in crops"-->
<#--            but also: Endpoint="metabolism of residues in crops, other"-->

        </sect2>

<#--        NOTE: for all these sections there is just one document, which we could separate by
            MaterialsAndMethods.TestAnimals.GeneralTestAnimalInformation.Species e.g. IN ("hen") but there is also possibility to write "other"
            so it would be risky. Probably best is to merge, as follows:-->
        <sect2 label="2-5">
            <title role="HEAD-3">Livestock (poultry, lactating ruminants, pigs, fish)</title>
<#--            ENDPOINT_SUMMARY.MetabolismInLivestock-->
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

    <sect1>
        <title role="HEAD-2">Magnitude of residue trials in plants</title>
<#--        ENDPOINT_SUMMARY.MagnitudeResiduesPlants-->
            <@keyAppendixE.appendixEstudies _subject "ResiduesInRotationalCrops" "" "magnitude of residues in plants"/>
    </sect1>

    <?hard-pagebreak?>

    <sect1>
        <title role="HEAD-2">Feeding studies</title>
<#--        ENDPOINT_SUMMARY.ResiduesLivestock-->
<#--        NOTE: happens the same than with metabolism-->
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
<#--        ENDPOINT_SUMMARY.NatureMagnitudeResiduesProcessedCommodities-->

        <sect2>
            <title role="HEAD-3">Nature of the residue</title>
            <@keyAppendixE.appendixEstudies _subject "NatureResiduesInProcessedCommod" "" "nature of the residues"/>
        </sect2>

       <sect2>
            <title role="HEAD-3">Distribution of the residue in inedible peel and pulp</title>
<#--            NOTE: summary ENDPOINT_SUMMARY.MagnitudeResiduesPlants is repeated-->
            <@keyAppendixE.appendixEstudies _subject "ResiduesInRotationalCrops" "" "residues in inedible peel and pulp"/>

<#--            context?:ResultsAndDiscussion.SummaryOfRadioactiveResiduesInCrops.SamplingAndResidues.SampledMaterialCommodity IN ("FI 0030", "FT 0026")-->
<#--            NOTE: check if this is regardless of type of endpoint (crops vs rotational crops); if not then add and remove this condition from general case-->
        </sect2>

        <sect2>
            <title role="HEAD-3">Magnitude of residues in processed commodities</title>
            <@keyAppendixE.appendixEstudies _subject "MagnitudeResidInProcessedComm" "" "magnitude of residues in processed commodities"/>
        </sect2>

    </sect1>

    <?hard-pagebreak?>
<#--    CONTINUEHERE and check contexts for metabolism and residues in crops/rotational crops-->
    <sect1>
        <title role="HEAD-2">Residues in rotational crops</title>

        <sect2>
            <title role="HEAD-3">Metabolism in rotational crops</title>
        </sect2>

        <sect2>
            <title role="HEAD-3">Magnitude of residues in rotational crops</title>
        </sect2>
    </sect1>

    <?hard-pagebreak?>

    <sect1>
        <title role="HEAD-2">Proposed residue definitions and maximum residue levels</title>

        <sect2>
            <title role="HEAD-3">Proposed residue definitions</title>
        </sect2>

        <sect2>
            <title role="HEAD-3">Proposed maximum residue levels (MRLs) and justification of the acceptability of the levels proposed</title>
        </sect2>

        <sect2>
            <title role="HEAD-3">Proposed maximum residue levels (MRLs) and justification of the acceptability of the levels proposed for imported products (import tolerance)</title>
        </sect2>
    </sect1>

    <?hard-pagebreak?>

    <sect1>
        <title role="HEAD-2">Proposed safety intervals</title>
    </sect1>

    <?hard-pagebreak?>

    <sect1>
        <title role="HEAD-2">Estimation of the potential and actual exposure through diet and other sources</title>
    </sect1>

    <?hard-pagebreak?>

    <sect1>
        <title role="HEAD-2">Other studies</title>

        <sect2>
            <title role="HEAD-3">Residue level in pollen and bee products</title>
        </sect2>
    </sect1>




<#else workingContext=="MICRO">

    <sect1>
        <title role="HEAD-2">Persistence and likelihood of multiplication in or on crops, feedingstuffs or foodstuffs</title>
    </sect1>

    <?hard-pagebreak?>

    <sect1>
        <title role="HEAD-2">Further information required</title>

        <sect2>
            <title role="HEAD-3">Non-viable residues</title>
        </sect2>

        <sect2>
            <title role="HEAD-3">Viable residues</title>
        </sect2>

    </sect1>

    <?hard-pagebreak?>

    <sect1>
        <title role="HEAD-2">Summary and evaluation of residue behaviour resulting from data submitted under points 6.1 and 6.2</title>
    </sect1>

</#if>

<#--MRL follows IUCLID? To ask to Lucien-->
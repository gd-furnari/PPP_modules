<#assign effContext = { "effects" : [{"path": "AdministrativeData.Endpoint",
                                                "val" : ["effects on harmful"],"qual" : "lk", "type" : "picklist"}],
                        "resistance" : [{"path": "AdministrativeData.Endpoint",
                                                "val" : ["occurrence of resistance"],"qual" : "lk", "type" : "picklist"}],
                        "function" : [{"path": "AdministrativeData.Endpoint",
                                            "val" : ["function"],"qual" : "lk", "type" : "picklist"}],
                        "moa" : [{"path": "AdministrativeData.Endpoint",
                                            "val" : ["mode of action"],"qual" : "lk", "type" : "picklist"}]
}/>

<#if _subject.documentType=="MIXTURE">

    <#if workingContext=="MICRO">

        <sect1>
            <title role="HEAD-2">Packaging and compatibility of the preparation with proposed packaging materials</title>
            <@keyAdm.packaging _subject/>
        </sect1>

        <?hard-pagebreak?>

        <sect1 label="MP 4.2, 4.4-4.6">
            <title role="HEAD-2">Recommended methods, precautions, emergency measures and procedures for cleaning application equipment and destruction or decontamination of the plant protection product and its packaging</title>
            <@keyAdm.protectionMeasures _subject/>
        </sect1>

        <?hard-pagebreak?>

        <sect1>
            <title role="HEAD-2" label="MMP 4.3">Re-entry periods, necessary waiting periods or other precautions to protect man, livestock and the environment</title>
            <para>For details on re-entry and waiting periods and other precautions, please refer to Documents D.</para>
        </sect1>


    <#elseif workingContext=="CHEM">
        <sect1>
            <title role="HEAD-2">Safety intervals and other precautions to protect humans, animals and the environment</title>
            <para>For details on safety intervals and other precautions, please refer to Documents D.</para>
        </sect1>

        <?hard-pagebreak?>

        <sect1 label="CP 4.2, 4.3, 4.5">
            <title role="HEAD-2">Recommended methods, precautions, emergency measures and procedures for destruction or decontamination of the plant protection product and its packaging</title>
            <@keyAdm.protectionMeasures _subject/>
        </sect1>

        <?hard-pagebreak?>

        <sect1 label="CP 4.4">
            <title role="HEAD-2">Packaging, compatibility of the plant protection product with proposed packaging materials</title>
            <@keyAdm.packaging _subject/>
        </sect1>
    </#if>


<#elseif _subject.documentType=="SUBSTANCE">

    <#if workingContext=="MICRO">

        <sect1>
            <title role="HEAD-2">Function</title>
            <@keyAppendixE.appendixEstudies subject=_subject docSubTypes="EffectivenessAgainstTargetOrganisms" context=effContext["function"] name="function" includeMetabolites=false/>
        </sect1>

        <?hard-pagebreak?>

        <sect1 label="MA 3.2, 3.3">
            <title role="HEAD-2">Field of use envisaged, and crops or products protected or treated</title>
            <para>For details on uses of the active substance, field of use envisaged, and crops or products protected or treated, please refer to Documents D</para>

        </sect1>

        <?hard-pagebreak?>

        <sect1 label="MA 3.4, 3.6">
            <title role="HEAD-2">Method of production and quality control, and methods to prevent loss of virulence of seed stock of the microorganism</title>
            <@keyAdm.manufacturer _subject/>
        </sect1>

        <?hard-pagebreak?>

        <sect1 label="MA 3.5">
            <title role="HEAD-2">Info on the (possible) occurrence of resistance development and appropriate management strategies</title>
            <@keyAppendixE.appendixEstudies subject=_subject docSubTypes="EffectivenessAgainstTargetOrganisms" context=effContext["resistance"] name="possible occurrence of resistance development" includeMetabolites=false/>
        </sect1>

        <?hard-pagebreak?>

        <sect1 label="MA 3.7-3.9">
            <title role="HEAD-2">Methods and precautions for handling, storage, transport or fire, procedures for destruction or decontamination, and emergency measures</title>
            <@keyAdm.protectionMeasures _subject/>
        </sect1>

    <#elseif workingContext=="CHEM">

        <@keyBioPropMicro.effectivenessTargetOrgSummary subject=_subject includeMetabolites=false/>

        <?hard-pagebreak?>

        <sect1 label="${docNameCode} 3.1, 3.4, 3.5">
            <title role="HEAD-2">Use of the active substance, harmful organisms controlled and products treated</title>
            <para>For details on uses of the active substance, field of use envisaged and harmful organisms controlled and crops or products protected or treated, please refer to Documents D</para>

        </sect1>

        <?hard-pagebreak?>

        <sect1>
            <title role="HEAD-2">Function</title>
            <@keyAppendixE.appendixEstudies subject=_subject docSubTypes="EffectivenessAgainstTargetOrganisms" context=effContext["function"] name="function" includeMetabolites=false/>
        </sect1>

        <?hard-pagebreak?>

        <sect1>
            <title role="HEAD-2">Effects on harmful organisms</title>
            <@keyAppendixE.appendixEstudies subject=_subject docSubTypes="EffectivenessAgainstTargetOrganisms" context=effContext["effects"] name="effects on harmful organisms" includeMetabolites=false/>

        </sect1>

        <?hard-pagebreak?>

        <sect1 label="${docNameCode} 3.6">
            <title role="HEAD-2">Mode of action</title>
            <@keyAppendixE.appendixEstudies subject=_subject docSubTypes="EffectivenessAgainstTargetOrganisms"
                context=effContext["moa"] name="mode of action" includeMetabolites=false/>
        </sect1>

        <?hard-pagebreak?>

        <sect1 label="${docNameCode} 3.7">
            <title role="HEAD-2">Info on the (possible) occurrence of resistance development and appropriate management strategies</title>
            <@keyAppendixE.appendixEstudies subject=_subject docSubTypes="EffectivenessAgainstTargetOrganisms" context=effContext["resistance"] name="possible occurrence of resistance development" includeMetabolites=false/>
        </sect1>

        <?hard-pagebreak?>

        <sect1 label="${docNameCode} 3.8, 3.9">
            <title role="HEAD-2">Methods and precautions for handling, storage, transport or fire, procedures for destruction or decontamination, and emergency measures</title>
            <@keyAdm.protectionMeasures _subject/>
        </sect1>

    <#elseif workingContext=="MRL">

        <@keyBioPropMicro.effectivenessTargetOrgSummary subject=_subject includeMetabolites=false/>

        <sect1>
            <title role="HEAD-2">Use of the active substance (GAP)</title>
            <para>For details on uses of the active substance please refer to the GAP table - Documents D (GAP).</para>
        </sect1>

        <?hard-pagebreak?>

        <sect1>
            <title role="HEAD-2">Effects on harmful organisms, function, mode of action and possible resistance</title>
            <@keyAppendixE.appendixEstudies subject=_subject docSubTypes="EffectivenessAgainstTargetOrganisms"
              name="effects on harmful organisms, function, mode of action and possible resistance" includeMetabolites=false/>
        </sect1>

    </#if>
</#if>
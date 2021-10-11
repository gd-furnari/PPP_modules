<#--This is only for the mixture-->
<#assign efficacyContext = { "preliminaryTests" : [{"path": "AdministrativeData.Endpoint",
                                "val" : ["preliminary tests"],"qual" : "lk", "type" : "picklist"}],
                            "efficacy_other" : [{"path": "AdministrativeData.Endpoint",
                                "val" : ["preliminary tests"],"qual" : "nl", "type" : "picklist"}]
<#--,-->
<#--                            "effectiveness" : [{"path": "AdministrativeData.Endpoint",-->
<#--                                                "val" : ["effects on harmful"],"qual" : "lk", "type" : "picklist"}],-->
<#--                            "resistance" : [{"path": "AdministrativeData.Endpoint",-->
<#--                                                "val" : ["occurrence of resistance"],"qual" : "lk", "type" : "picklist"}]-->
}/>

<#if workingContext=="CHEM">
    <@keyEfficacy.efficacySummary _subject "Efficacy"/>
</#if>

<sect1>
    <title role="HEAD-2">Preliminary tests</title>
    <@keyAppendixE.appendixEstudies _subject "EfficacyData" efficacyContext["preliminaryTests"] "preliminary tests on efficacy" "" false/>
</sect1>

<?hard-pagebreak?>

<#--<sect1>-->
<#--    <title role="HEAD-2">Testing effectiveness</title>-->
<#--    <@keyEfficacy.efficacySummary _subject "EffectivenessAgainstTargetOrganisms"/>-->
<#--    <@keyAppendixE.appendixEstudies _subject "EffectivenessAgainstTargetOrganisms" efficacyContext["effectiveness"]/>-->

<#--</sect1>-->

<#--<?hard-pagebreak?>-->

<#--<sect1>-->
<#--    <title role="HEAD-2">Information on the occurrence or possible occurrence of the development of resistance</title>-->
<#--    &lt;#&ndash;    No summary here in order not to repeat&ndash;&gt;-->
<#--    <@keyAppendixE.appendixEstudies _subject "EffectivenessAgainstTargetOrganisms" efficacyContext["resistance"]/>-->

<#--</sect1>-->

<?hard-pagebreak?>

<#if workingContext=="CHEM">

    <sect1 label="CP 6.2-6.5">
        <title role="HEAD-2">
<#--            Adverse effects on treated crops; Observations on other undesirable or unintended side-effects-->
            Efficacy data
        </title>
        <@keyAppendixE.appendixEstudies _subject "EfficacyData" efficacyContext["efficacy_other"] "efficacy" "" false/>
    </sect1>

<#elseif workingContext=="MICRO">

    <sect1 label="MP 6.2-6.6">
        <title role="HEAD-2">
<#--            Effects on the yield of treated plants or plant products in terms of quantity and/or quality;-->
<#--            Phytotoxicity to target plants (including different cultivars), or to target plant products; Observations on undesirable or unintended side-effects-->
            Efficacy data
        </title>
        <@keyAppendixE.appendixEstudies _subject "EfficacyData" efficacyContext["efficacy_other"] "efficacy" "" false/>
    </sect1>

    <?hard-pagebreak?>

    <sect1 label="MP 6.7">
        <title role="HEAD-2">Summary and evaluation of data presented under 6.1 to 6.6</title>
        <@keyEfficacy.efficacySummary _subject "Efficacy"/>
    </sect1>
</#if>
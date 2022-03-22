<#--This is only for the mixture-->
<#assign efficacyContext = { "preliminaryTests" : [{"path": "AdministrativeData.Endpoint",
                                "val" : ["preliminary tests"],"qual" : "lk", "type" : "picklist"}],
                            "efficacy_other" : [{"path": "AdministrativeData.Endpoint",
                                "val" : ["preliminary tests"],"qual" : "nl", "type" : "picklist"}]
}/>

<#if workingContext=="CHEM">
    <@keyEfficacy.efficacySummary _subject "Efficacy"/>
</#if>

<sect1>
    <title role="HEAD-2">Preliminary tests</title>
    <@keyAppendixE.appendixEstudies _subject "EfficacyData" efficacyContext["preliminaryTests"] "preliminary tests on efficacy" "" false/>
</sect1>

<#if workingContext=="CHEM">

    <sect1 label="CP 6.2-6.5">
        <title role="HEAD-2">Efficacy data</title>
        <@keyAppendixE.appendixEstudies _subject "EfficacyData" efficacyContext["efficacy_other"] "efficacy" "" false/>
    </sect1>

<#elseif workingContext=="MICRO">

    <sect1 label="MP 6.2-6.6">
        <title role="HEAD-2">Efficacy data</title>
        <@keyAppendixE.appendixEstudies _subject "EfficacyData" efficacyContext["efficacy_other"] "efficacy" "" false/>
    </sect1>

    <?hard-pagebreak?>

    <sect1 label="MP 6.7">
        <title role="HEAD-2">Summary and evaluation of data presented under 6.1 to 6.6</title>
        <@keyEfficacy.efficacySummary _subject "Efficacy"/>
    </sect1>
</#if>
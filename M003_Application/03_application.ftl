<sect1 label="${docNameCode} 3.1, 3.3-3.8">
    <title role="HEAD-2">Uses and application</title>
    <para>For details on intended and authorised uses of the plant protection product and its application, please refer to Documents D.</para>
    <#--        NOTE: instructions for use are in 4.2 document although not indicated in crosswalks.-->
</sect1>

<?hard-pagebreak?>

<sect1>
    <title role="HEAD-2" ><#if workingContext=="MICRO">Mode of action (effectiveness against target organisms)<#else>Effects on harmful organisms</#if></title>
    <@keyBioPropMicro.effectivenessTargetOrgSummary subject=_subject includeMetabolites=false/>
    <@com.emptyLine/>
    <@keyAppendixE.appendixEstudies subject=_subject docSubTypes="EffectivenessAgainstTargetOrganisms" name="effects on harmful organisms" includeMetabolites=false/>
</sect1>


<sect1>
    <title role="HEAD-2">Applicant</title>
    <@keyAdm.applicant _subject/>
</sect1>

<?hard-pagebreak?>

<sect1>
    <title role="HEAD-2">
        <#if _subject.documentType=="MIXTURE">
            <#if workingContext=="MICRO">
                Manufacturer of the preparation and the micro-organism(s)
            <#else>
                Producer of the plant protection product and the active substances
            </#if>
        <#else>
            Producer
        </#if>
    </title>

    <sect2>
        <title role="HEAD-3">Producer(s)</title>
        <@keyAdm.producer _subject/>
    </sect2>

    <sect2>
        <title role="HEAD-3">Manufacturing plant(s)</title>
        <@keyAdm.manufacturingPlant _subject/>
    </sect2>
</sect1>

<?hard-pagebreak?>

<#if _subject.documentType=="MIXTURE">

    <sect1>
        <title role="HEAD-2">Trade name or proposed trade name and producer’s development code number</title>
        <@keyProd.productIdentity _subject/>
        <@com.emptyLine/>
        <@keyAdm.producerDevCodeNos _subject/>

    </sect1>

    <?hard-pagebreak?>

    <sect1 label="${docNameCode} 1.4-1.5">
        <title role="HEAD-2">Detailed quantitative and qualitative information on the composition</title>
        <#--NOTE: includes     Type and code of the plant protection product / Physical state and nature of the preparation (probably this goes merged with previous)-->
        <@keyProd.mixtureComposition _subject/>
    </sect1>

    <?hard-pagebreak?>

    <sect1 label="${docNameCode} 1.6">
        <title role="HEAD-2">Function</title>
        <#--From efectiveness-->
        <@keyProd.functionsOfMixture _subject/>

    </sect1>

<#--NOTE: the function can be extracted in a loop from the documents of effectiveness, the rest of sections seem ok-->
<#elseif _subject.documentType=="SUBSTANCE">

    <#if workingContext=="MICRO">

        <sect1>
            <title role="HEAD-2">Name and species description, strain characterisation</title>
            <#-- NOTE: labels won't correspond to micro-->
            <#assign microIdentity><@keySub.substanceIdentity  _subject/></#assign>
            ${microIdentity?replace("IUPAC", "Scientific")}
        </sect1>

        <?hard-pagebreak?>

        <sect1>
            <title role="HEAD-2">Specification of the material used for manufacturing of formulated products</title>
            <@keyComp.substanceComposition _subject/>
        </sect1>

    <#elseif workingContext=="CHEM">

        <sect1 label="${docNameCode} 1.3-1.7">
            <title role="HEAD-2">Names, identifiers and molecular information of the active substance</title>
            <@keySub.substanceIdentity  _subject/>
            <@com.emptyLine/>
            <@keyAdm.producerDevCodeNos _subject/>
        </sect1>

        <?hard-pagebreak?>

        <sect1 label="${docNameCode} 1.8">
            <title role="HEAD-2">Method of manufacture (synthesis pathway) of the active substance</title>
            <@keyAdm.manufacturer _subject/>
        </sect1>

        <?hard-pagebreak?>

        <sect1 label="${docNameCode} 1.9-1.10">
            <title role="HEAD-2">Purity of the active substance, additives and impurities</title>
             <@keyComp.substanceComposition _subject false/>
        </sect1>

        <?hard-pagebreak?>

        <sect1 label="${docNameCode} 1.11">
            <title role="HEAD-2">Analytical profile of batches</title>
            <@keyComp.batchAnalysisSummary _subject/>
        </sect1>

    </#if>
        
</#if>
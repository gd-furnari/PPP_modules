<#assign anmethContext = {  "micro" : [{"path": "AdministrativeData.Endpoint",
                                           "val" : ["microorganism", "micro-organism", "relevant impurities", "storage stability"],
                                           "qual" : "lk", "type" : "picklist"}],

                            "residues" : [{"path": "AdministrativeData.Endpoint", "val" : ["residues"], "qual" : "lk", "type" : "picklist"}],
                            "other_micro" : [{"path": "AdministrativeData.Endpoint",
                                                "val" : ["microorganism", "micro-organism", "relevant impurities", "storage stability", "residues"],
                                                "qual" : "nl", "type" : "picklist"}],

                            "sub" : [{"path": "AdministrativeData.Endpoint",
                                           "val" : ["active substance", "seed stock", "relevant impurities", "storage stability"],
                                           "qual" : "lk", "type" : "picklist"}],

                            "risk" : [{"path": "AdministrativeData.Endpoint", "val" : ["risk", "determination of residues"], "qual" : "lk", "type" : "picklist"}],

                            "monitoring" : [{"path": "AdministrativeData.Endpoint", "val" : ["monitoring"], "qual" : "lk", "type" : "picklist"}],

                            "other_sub" : [{"path": "AdministrativeData.Endpoint",
                                                "val" : ["active substance", "seed stock", "relevant impurities", "storage stability", "risk", "determination of residues", "monitoring"],
                                                "qual" : "nl", "type" : "picklist"}],

                            "micro_mix" : [{"path": "AdministrativeData.Endpoint",
                                        "val" : ["formulated", "microorganism", "micro-organism", "relevant impurities", "storage stability"],
                                        "qual" : "lk", "type" : "picklist"}],

                            "other_micro_mix" : [{"path": "AdministrativeData.Endpoint",
                                                "val" : ["formulated", "microorganism", "micro-organism", "relevant impurities", "storage stability", "residues"],
                                                "qual" : "nl", "type" : "picklist"}],
                            "sub_mix" : [{"path": "AdministrativeData.Endpoint",
                                            "val" : ["formulated", "active substance", "seed stock", "relevant impurities", "storage stability"],
                                            "qual" : "lk", "type" : "picklist"}],

                            "residues2" : [{"path": "AdministrativeData.Endpoint", "val" : ["determination of residues"], "qual" : "lk", "type" : "picklist"}],

                            "other_sub_mix" : [{"path": "AdministrativeData.Endpoint",
                                                "val" : ["formulated", "active substance", "seed stock", "relevant impurities", "storage stability", "determination of residues", "monitoring"],
                                                "qual" : "nl", "type" : "picklist"}]

}/>

<@keyAnMeth.analyticalMethodsSummary _subject/>

<#if _subject.documentType=="MIXTURE">

    <#if workingContext=="MICRO">

        <sect1>
            <title role="HEAD-2">Methods for the analysis of the preparation</title>
            <@keyAppendixE.appendixEstudies _subject "AnalyticalMethods" anmethContext["micro_mix"] "methods for the analysis of the preparation"/>

        </sect1>

        <?hard-pagebreak?>

        <sect1>
            <title role="HEAD-2">Methods to determine and quantify residues</title>
            <@keyAppendixE.appendixEstudies _subject "AnalyticalMethods" anmethContext["residues"] "methods to determine and quantify residues"/>
        </sect1>

        <?hard-pagebreak?>

        <#--NEW section-->
        <sect1>
            <title role="HEAD-2">Additional analytical methods</title>
            <@keyAppendixE.appendixEstudies _subject "AnalyticalMethods" anmethContext["other_micr_mix"] "other analytical methods"/>
        </sect1>

    <#elseif workingContext=="CHEM">

       <sect1>
        <title role="HEAD-2">Methods used for the generation of pre-authorisation data</title>

        <sect2>
            <title role="HEAD-2">Analysis of the plant protection product</title>
            <@keyAppendixE.appendixEstudies _subject "AnalyticalMethods" anmethContext["sub_mix"] "methods for the analysis of the plant protection product"/>

            <#--Endpoint="methods for the analysis of the (formulated) product"        -->
        </sect2>

        <sect2>
            <title role="HEAD-2">Methods for the determination of residues</title>
            <@keyAppendixE.appendixEstudies _subject "AnalyticalMethods" anmethContext["residues"] "methods to determine residues"/>
        </sect2>
        </sect1>

        <?hard-pagebreak?>

        <sect1>
            <title role="HEAD-2">Methods for post-authorisation control and monitoring purposes</title>
            <@keyAppendixE.appendixEstudies _subject "AnalyticalMethods" anmethContext["monitoring"] "methods for post-approval and monitoring"/>
        </sect1>

         <?hard-pagebreak?>

        <#--NEW section-->
        <sect1>
            <title role="HEAD-2">Additional analytical methods</title>
            <@keyAppendixE.appendixEstudies _subject "AnalyticalMethods" anmethContext["other_sub_mix"] "other analytical methods"/>
        </sect1>

    </#if>
<#elseif _subject.documentType=="SUBSTANCE">

    <#if workingContext=="MICRO">

        <sect1>
            <title role="HEAD-2">Methods for the analysis of the micro-organism as manufactured</title>
            <@keyAppendixE.appendixEstudies _subject "AnalyticalMethods" anmethContext["micro"] "methods for the analysis of the microorganism"/>
        </sect1>

        <?hard-pagebreak?>

        <sect1>
            <title role="HEAD-2">Methods to determine and quantify residues (viable or non-viable) </title>
            <@keyAppendixE.appendixEstudies _subject "AnalyticalMethods" anmethContext["residues"] "methods to determine and quantify residues"/>

        </sect1>

        <?hard-pagebreak?>

        <#--NEW section-->
        <sect1>
            <title role="HEAD-2">Additional analytical methods</title>
            <@keyAppendixE.appendixEstudies _subject "AnalyticalMethods" anmethContext["other_micro"] "other analytical methods"/>
        </sect1>

    <#else>

    <sect1>
        <title role="HEAD-2">Methods used for the generation of pre-approval data</title>

        <sect2>
            <title role="HEAD-2">Methods for the analysis of the active substance as manufactured</title>
            <@keyAppendixE.appendixEstudies _subject "AnalyticalMethods" anmethContext["sub"] "methods for the analysis of the active substance"/>
        </sect2>

        <sect2>
            <title role="HEAD-2">Methods for risk assessment</title>
            <@keyAppendixE.appendixEstudies _subject "AnalyticalMethods" anmethContext["risk"] "methods for risk assessment"/>
        </sect2>
    </sect1>

    <?hard-pagebreak?>

    <sect1>
        <title role="HEAD-2">Methods for post-approval control and monitoring purposes</title>
            <@keyAppendixE.appendixEstudies _subject "AnalyticalMethods" anmethContext["monitoring"] "methods for post-approval and monitoring"/>
    </sect1>

     <?hard-pagebreak?>

    <#--NEW section-->
    <sect1>
        <title role="HEAD-2">Additional analytical methods</title>
        <@keyAppendixE.appendixEstudies _subject "AnalyticalMethods" anmethContext["other_sub"] "other analytical methods"/>
    </sect1>

     </#if>
</#if>
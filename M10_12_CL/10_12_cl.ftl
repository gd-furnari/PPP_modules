<#if workingContext=="CHEM">

    <sect1>
        <title role="HEAD-2">Classification and labelling of the
            <#if _subject.documentType=="SUBSTANCE">active substance
            <#elseif _subject.documentType=="MIXTURE">plant protection product
            </#if>
            according to CLP / GHS</title>

        <!-- classification and labelling for common_macro_classification_and_labelling -->
        <@keyCl.classificationAndLabellingTable _subject/>

    </sect1>

    <#if _subject.documentType=="SUBSTANCE">

        <#assign pbtRecordList = iuclid.getSectionDocumentsForParentKey(_subject.documentKey, "FLEXIBLE_RECORD", "PbtAssessment") />
        <#if pbtRecordList?has_content>

            <?page-hardbreak?>

            <sect1>
                <title role="HEAD-2">Assessment of PBT/vPvB properties of the active substance</title>
                <@keyPbt.pbtandvPvBcriteriaAndJustification _subject/>

            </sect1>

        </#if>
    </#if>

    <#if _metabolites?? && _metabolites?has_content>

        <#assign isFirst=true/>
        <#list _metabolites as metab>

            <#assign recordListMetab = iuclid.getSectionDocumentsForParentKey(metab.documentKey, "FLEXIBLE_RECORD", "Ghs") />
            <#assign recordListMetab2 = iuclid.getSectionDocumentsForParentKey(metab.documentKey, "FLEXIBLE_RECORD", "PbtAssessment") />

            <#if recordListMetab?has_content || recordListMetab2?has_content>

                <#if isFirst>
                    <#assign isFirst=false/>

                    <?page-hardbreak?>

                    <sect1><title>Classification and labelling of metabolites</title>
                </#if>

                <sect2>
                    <title role="HEAD-3">Metabolite <@com.text metab.ChemicalName/></title>

                    <sect3>
                        <title role="HEAD-2">Classification and labelling according to CLP / GHS</title>

                        <@keyCl.classificationAndLabellingTable metab/>

                    </sect3>

                    <#if pbtRecordList?has_content>

                        <sect3>
                            <title role="HEAD-2">Assessment of PBT/vPvB properties</title>
                            <@keyPbt.pbtandvPvBcriteriaAndJustification metab/>

                        </sect3>

                    </#if>

                </sect2>

            </#if>
        </#list>

        <#if (!isFirst)>
            </sect1>
        </#if>
    </#if>
</#if>
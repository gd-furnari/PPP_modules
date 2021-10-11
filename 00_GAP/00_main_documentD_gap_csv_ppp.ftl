<#-- Import common macros and functions -->
<#import "macros_common_general.ftl" as com>
<#assign locale = "en" />
<#assign sysDateTime = .now>
<#-- Initialize the following variables:
	* _dossierHeader (:DossierHashModel) //The header document of a proper or 'raw' dossier, can be empty
	* _subject (:DocumentHashModel) //The dossier subject document or, if not in a dossier context, the root document, never empty
	-->
<@com.initializeMainVariables/>
<#assign ownerLegalEntity = iuclid.getDocumentForKey(_subject.OwnerLegalEntity) />
<#assign gapList = iuclid.getSectionDocumentsForParentKey(_subject.documentKey, "FLEXIBLE_RECORD", "GAP") />
<#-- Print the headears for each column -->
<@printGAPcsv gapList "header"/>

<#-- Print the content-->
<#assign content><@printGAPcsv gapList "content"/></#assign>
<#assign content=content?replace('", "', '","')/>
${content}

<#--macros-->
<#macro printGAPcsv gapList content="">
    <#compress>
        <#assign printHeader=false>
        <#if content=="header">
            <#assign printHeader=true/>
        </#if>

        <#list gapList as gap>
            <@compress single_line=true>

<#--            &lt;#&ndash;Use&ndash;&gt;-->
<#--            <#if printHeader>-->
<#--                Use (document),-->
<#--            <#else>-->
<#--            </#if>-->
            <#--Name-->
            <#if printHeader>
                Name,
            <#else>
                "<@com.text gap.name/>",
            </#if>

            <#--Legal Entity-->
            <#if printHeader>
                Owner (legal entity),
            <#else>
                <#if ownerLegalEntity?? && ownerLegalEntity?has_content>
                    "<@com.text ownerLegalEntity.GeneralInfo.LegalEntityName/>",
                <#else>
                    "",
                </#if>
            </#if>

            <#--Product and composition -->
            <#assign product=iuclid.getDocumentForKey(gap.AdministrativeDataSummary.Product)/>
            <#if printHeader>
                Product,Formulation Type,Active Substance,Safeners,Synergists,
            <#else>
                <#if product?has_content>
                    "<@com.text product.GeneralInformation.Name/>",
                    "<@com.picklistMultiple product.GeneralInformation.FormulationType/>",
                    <#assign actSub><@mixtureComponent product "active substance"/></#assign>
                    "${actSub?replace("&gt;", ">")?replace("&lt;", "<")?replace("&amp;", "&")}",
                    <#assign safeners><@mixtureComponent product "safener"/></#assign>
                    "${safeners?replace("&gt;", ">")?replace("&lt;", "<")?replace("&amp;", "&")}",
                    <#assign synergists><@mixtureComponent product "synergist"/></#assign>
                    "${synergists?replace("&gt;", ">")?replace("&lt;", "<")?replace("&amp;", "&")}",
                 <#else>
                    "","","","","",
                 </#if>
            </#if>

            <#--Purpose application-->
            <#local purpose=gap.KeyInformation.PurposeOfTheGAP/>
            <@printChildren purpose printHeader/>

            <#--Crop info-->
            <#assign cropInfo=gap.KeyInformation.CropInformation/>
            <@printChildren cropInfo printHeader/>

            <#--Pest treated-->
            <#assign pestTreat=gap.PestDiseaseTreated/>
            <@printChildren path=pestTreat header=printHeader exclude=["ApplicationDetails"]/>

            <#--Application details-->
            <#assign appDet=gap.PestDiseaseTreated.ApplicationDetails/>
            <@printChildren appDet printHeader/>

            <#--Key Info-->
            <#if printHeader>
                Key Information,
            <#else>
                <#if gap.KeyInformation.field9074?has_content>"Content exists. See original document.",
                <#else>"",
                </#if>
            </#if>

             <#--Additional Info-->
            <#if printHeader>
                Additional information,
            <#else>
                <#if gap.AdditionalInformation.field7935?has_content>"Content exists. See original document."
                </#if>
            </#if>
            </@compress>

            <#if printHeader><#break></#if>
        </#list>
    </#compress>
</#macro>

<#macro printChildren path header=false exclude=[]>
    <#list path?children as child>
        <#if !exclude?seq_contains(child?node_name)>
            <#if header>
                ${child?node_name?replace("_list", "")?replace("([A-Z]{1})", " $1", "r")?lower_case?cap_first},
            <#else>
                <#if child?node_name=="GrowthStageAndSeason_list">
                    "<@growthStageSeasonList child/>",
                <#elseif child?node_name=="TargetOrganisms_list">
                    "<@targetOrgList child/>",
                <#elseif child?node_name=="NonTargetAS_list">
                    "<@nonTargetAsList child/>",
                <#else>
                    "<@printNode child/>",
                </#if>
            </#if>
        </#if>
    </#list>
</#macro>

<#macro targetOrgList path>
    <#compress>
        <#if path?has_content>
            <#list path as targOrg>
                <#if (path?size > 1)>#{targOrg_index+1}: </#if>

                <#if targOrg.ScientificName?has_content>
                    <@com.picklist targOrg.ScientificName/>
                    <#if targOrg.CommonName?has_content>
                        (<@com.text targOrg.CommonName/>)
                    </#if>
                <#elseif targOrg.CommonName?has_content>
                    <@com.text targOrg.CommonName/>.
                </#if>

                <#if targOrg.DevelopmentStagePest?has_content || targOrg.DevelopmentStagePlant?has_content>
                    - Developmental stages:
                    pest: <@com.picklistMultiple targOrg.DevelopmentStagePest/>,
                    plant: <@com.picklistMultiple targOrg.DevelopmentStagePlant/>
                </#if>

                <#if targOrg_has_next>; </#if>
            </#list>
        </#if>
    </#compress>
</#macro>

<#macro growthStageSeasonList path>
    <#compress>
        <#if path?has_content>
            <#list path as gss>

                <#if (path?size > 1)>#{gss_index+1}: </#if>

                growth stage first application: <@com.picklist gss.GrowthStageCropFirst/>,
                growth stage last application: <@com.picklist gss.GrowthStageCropLast/>,
                season: <@com.picklistMultiple gss.TreatmentSeason/>

                <#if gss_has_next>; </#if>
            </#list>
        </#if>
    </#compress>
</#macro>

<#macro nonTargetAsList path>
    <#compress>
        <#local ntasContent><#compress>
            <#if path?has_content>
                <#list path as ntas>
                    <#if (path?size > 1)>#{ntas_index+1}: </#if>
                    <#local sub = iuclid.getDocumentForKey(ntas.NonTargetAS)/>
                    substance: <@com.text sub.ReferenceSubstanceName/>,
                    application rate: <@com.range ntas.ApplicationRatePerTreatmentForOtherASRange/>,
                    maximum annual application rate: <@com.range ntas.MaximumAnnualApplicationRateForOtherAS/>
                    <#if ntas_has_next>; </#if>
                </#list>
            </#if>
        </#compress></#local>

        <#if ntasContent?has_content>
            <#-- remove escaping...-->
            <#local ntasContent=ntasContent?replace("&gt;", ">")?replace("&lt;", "<")?replace("&amp;", "&")/>
            ${ntasContent}
        </#if>

    </#compress>
</#macro>

<#macro printNode node>
    <#compress>
        <#assign nodeVal=""/>

        <#if node?has_content>
            <#assign nodeType=node?node_type/>

            <#assign nodeVal><#compress>
                <#if nodeType=="range">
                    <@range2  node/>
                <#elseif nodeType=="picklist_single">
                    <@picklist2  node/>
                <#elseif nodeType=="picklist_multi">
                    <@com.picklistMultiple node/>
                <#elseif nodeType=="quantity">
                    <@com.quantity node/>
                <#elseif nodeType=="decimal">
                    <@com.number node/>
                <#elseif nodeType=="multilingual_text_html">
                    <@com.richText node/>
                <#elseif nodeType?contains("text")>
                    <@com.text node/>
                <#elseif nodeType=="date">
                    <@com.text node/>
                <#elseif nodeType=="boolean">
                    <#if node>Y<#else>N</#if>
                </#if>
            </#compress></#assign>

            <#-- remove escaping...-->
            <#assign nodeVal=nodeVal?replace("&gt;", ">")?replace("&lt;", "<")?replace("&amp;", "&")/>
            ${nodeVal}
    </#if>

	</#compress>
</#macro>

<#macro mixtureComponent product compType>
    <#compress>
        <#list product.Components.Components as comp>
            <#local function><@com.picklist comp.Function/></#local>
            <#if function==compType>
                <#local substance=iuclid.getDocumentForKey(comp.Reference)/>

                <#if (function=="active substance" && substance.documentType=="SUBSTANCE") || function!="active substance">
                        <#if substance.documentType=="SUBSTANCE">
                            <@com.text substance.ChemicalName/>
                        <#elseif substance.documentType=="REFERENCE_SUBSTANCE">
                            <@com.text substance.ReferenceSubstanceName/>
                        </#if>

                        : <@com.range comp.TypicalConcentration/>
                        <#if comp.ConcentrationRange?has_content>
                            (<@com.range comp.ConcentrationRange/>)
                        </#if>
                        <#if comp.Remarks?has_content>
                            (<@com.text comp.Remarks/>)
                        </#if>
                        .
                </#if>
            </#if>
        </#list>
    </#compress>
</#macro>

<#--<#function getDtype gap>-->
<#--    <#local keyInfo><@com.richText gap.KeyInformation.field9074/></#local>-->
<#--    <#if keyInfo?matches(".*authori[sz]{1}ed use.*", "i")>-->
<#--        <#return "D2">-->
<#--    </#if>-->
<#--    <#return "D1"/>-->
<#--</#function>-->

<#macro range2 rangeValue locale="en">
    <#compress>
        <#if rangeValue?has_content>
                <#if rangeValue.lower.value?has_content>
                    ${rangeValue.lower.qualifier!}<@com.number rangeValue.lower.value/>
                </#if>
                <#if rangeValue.lower.value?has_content && rangeValue.upper.value?has_content>-</#if>
                <#if rangeValue.upper.value?has_content>
                    ${rangeValue.upper.qualifier!}<@com.number rangeValue.upper.value/>
                </#if>
            <#if rangeValue.unit?has_content>
                <@picklist2 rangeValue.unit locale/>
            </#if>
        </#if>
    </#compress>
</#macro>

<#macro picklist2 picklistValue locale="en" printOtherPhrase=false>
    <#compress>
            <#local localizedPhrase = iuclid.localizedPhraseDefinitionFor(picklistValue.code, locale) />
            <#if localizedPhrase?has_content>
                <#if !localizedPhrase.open || !(localizedPhrase.text?matches("other:")) || printOtherPhrase>
                    ${localizedPhrase.text} <#t>
                </#if>
                <#if localizedPhrase.open && picklistValue.otherText?has_content>
                    ${picklistValue.otherText}<#t>
                </#if>
                <#if localizedPhrase.description?has_content>
                    [${localizedPhrase.description}]
                </#if>
            </#if>
            <#if picklistValue.remarks?has_content>
                - ${picklistValue.remarks}
            </#if>
            <#lt>
    </#compress>
</#macro>
<?xml version="1.0" encoding="UTF-8"?>

<#-- Import common modules to quickly access their substance and study content -->
<#import "macros_common_general.ftl" as com>
<#import "macros_gap.ftl" as keyGap>

<#assign locale = "en" />
<#assign sysDateTime = .now>

<#-- Initialize the following variables:
	* _dossierHeader (:DossierHashModel) //The header document of a proper or 'raw' dossier, can be empty
	* _subject (:DocumentHashModel) //The dossier subject document or, if not in a dossier context, the root document, never empty
	-->
<@com.initializeMainVariables/>

<#assign ownerLegalEntity = iuclid.getDocumentForKey(_subject.OwnerLegalEntity) />

<#assign docDtitle={"D1":"Intended uses supported in the EU for which data have been provided ",
                    "D2":"List of currently authorized uses and extent of use",
                    "D3":"Intended uses supported in the EU for which data will be provided "}/>

<#assign workingContext="CHEM"/>    
<#assign docFullName="Documents D (GAP)"/> 
<#assign docSubTitle="Uses of the plant protection product"/>                                   
<#if _subject.submissionType?has_content && _subject.submissionType?matches(".*MAXIM.*", "i") >
    <#assign workingContext="MRL"/>
    <#assign docFullName="GAP Table"/>
    <#assign docSubTitle="Good Agricultural Practices (GAPs) supported in the MRL application"/>                                   
</#if>

<book version="5.0" xmlns="http://docbook.org/ns/docbook" xmlns:xi="http://www.w3.org/2001/XInclude">
    <#assign left_header_text = ''/>
    <#assign central_header_text = com.getReportSubject(rootDocument).name?html />
    <#assign right_header_text = ''/>

    <#assign left_footer_text = sysDateTime?string["dd/MM/yyyy"] + " - IUCLID 6 " + iuclid6Version!/>
    <#assign central_footer_text = docFullName/>
    <#assign right_footer_text = ''/>

    <info>
        <title>
            <#--			NOTE it overlaps in the ToC...-->
            <para role="i6header5_nobold"><#if ownerLegalEntity?has_content><@com.text ownerLegalEntity.GeneralInfo.LegalEntityName/></#if></para>
            <@com.emptyLine/>

            <para role="rule">

                <#assign prodDocUrl=iuclid.webUrl.entityView(_subject.documentKey)/>

                <@com.emptyLine/>
                <ulink url="${prodDocUrl}">
                <@com.text _subject.MixtureName/>
                </ulink>
            </para>
        </title>

        <subtitle>
            <@com.emptyLine/>
            <para role="rule"/>
        </subtitle>

        <subtitle>
            <para role="align-right">
                <para>${docFullName}</para>
                <para>${docSubTitle}</para>
            </para>
			 <@com.emptyLine/>

			<para role="align-right">
                <para role="cover.i6subtext">
                    ${left_footer_text}
                </para>
            </para>
        </subtitle>
        <cover>
            <para role="align-right">
                <!-- <para role="cover.i6subtext"> -->
                    <!-- ${left_footer_text} -->
                <!-- </para> -->
            </para>
        </cover>
        <@com.metadataBlock left_header_text central_header_text right_header_text left_footer_text central_footer_text right_footer_text />
    </info>
    
    <#if workingContext=="CHEM">

	    <chapter>
	        <title role="HEAD-4">Document D1: ${docDtitle["D1"]} </title>
	
	        <#assign D1><@keyGap.GAPsummary _subject "D1"/></#assign>
	        <#if D1?has_content && D1?contains("Product")>
	            ${D1}
	        <#else>
	            <para>No data have been provided for the intended uses of this product.</para>
	        </#if>
	    </chapter>
	
	    <#assign D2><@keyGap.GAPsummary _subject "D2"/></#assign>
	    <chapter>
	        <title role="HEAD-4">Document D2: ${docDtitle["D2"]} </title>
	
	        <#if D2?has_content && D2?contains("Product")>
	            ${D2}
	        <#else>
	            <para>No authorised uses currently exist for this product.</para>
	        </#if>
	    </chapter>
	
	    <#assign D3><@keyGap.GAPsummary _subject "D3"/></#assign>
	    <chapter>
	        <title role="HEAD-4">Document D3: ${docDtitle["D3"]} </title>
	
	        <#if D3?has_content && D3?contains("Product")>
	            ${D2}
	        <#else>
	            <para>No intended uses for which data will be provided have been reported for this product.</para>
	        </#if>
	    </chapter>
	
	<#elseif workingContext=="MRL">
		<chapter>
	        <title role="HEAD-4">Good Agricultural Practices (GAPs) supported in the MRL application</title>
			<@keyGap.GAPsummary _subject/>
	    </chapter>
	
	</#if>

</book>
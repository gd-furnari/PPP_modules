<?xml version="1.0" encoding="UTF-8"?>

<#-- Import common modules to quickly access their substance and study content -->
<#import "macros_common_general.ftl" as com>
<#import "macros_docN.ftl" as docN>

<#assign locale = "en" />
<#assign sysDateTime = .now>

<#-- Initialize the following variables:
	* _dossierHeader (:DossierHashModel) //The header document of a proper or 'raw' dossier, can be empty
	* _subject (:DocumentHashModel) //The dossier subject document or, if not in a dossier context, the root document, never empty
	-->
<@com.initializeMainVariables/>

<#assign ownerLegalEntity = iuclid.getDocumentForKey(_subject.OwnerLegalEntity) />

<book version="5.0" xmlns="http://docbook.org/ns/docbook" xmlns:xi="http://www.w3.org/2001/XInclude">
    <#assign left_header_text = ''/>
    <#assign central_header_text = com.getReportSubject(rootDocument).name?html />
    <#assign right_header_text = ''/>

    <#assign left_footer_text = sysDateTime?string["dd/MM/yyyy"] + " - IUCLID 6 " + iuclid6Version!/>
    <#assign central_footer_text = 'Document N3 (Substance and metabolites)' />
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
                <para>Document N3</para>
                <para>Substance and metabolites: structure, codes, synonyms</para>
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


    <chapter>
        <title role="HEAD-4">Substances and metabolites: structures, codes, synonyms</title>
        <@docN.metabolitesList mixture=_subject/>
    </chapter>

</book>
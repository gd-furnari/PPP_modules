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
            <para role="rule">                 
                <#assign activeSubstance=com.getComponents(_subject,"active substance",false)[0]/>
                <#assign substanceName = activeSubstance.ChemicalName/>
                <#assign substanceUrl = iuclid.webUrl.entityView(activeSubstance.documentKey)/>
                <ulink url="${substanceUrl}"><@com.value substanceName/></ulink>
            </para>
        </title>
        
        <subtitle>
            <#--  <@com.emptyLine/>  -->
            <para role="rule"/>
        </subtitle> 
        
        <subtitle>
            <para role="align-right">
                <para>Document N3</para>
                <para>Substance and metabolites: structure, codes, synonyms</para>
            </para>
            <#--  <@com.emptyLine/>  -->
            
        </subtitle>
    	
        <cover>
          	<#--  <#if _dossierHeader?has_content>
              	<#assign dossier = _dossierHeader />
                <para role="cover.rule"/>
	              <emphasis role="bold">Dossier details:</emphasis>
	                <para role="indent">
	                <itemizedlist>
	                    <listitem>Dossier name: <#assign dossierUrl=iuclid.webUrl.entityView(dossier.documentKey)/><ulink url="${dossierUrl}"><@com.text dossier.name /></ulink></listitem>
                        <listitem>Dossier UUID: <@com.text dossier.subjectKey /></listitem>
	                    <listitem>Dossier creation date and time: <@com.text dossier.creationDate /></listitem>
	                    <listitem>Submission type: <@com.text dossier.submissionType /></listitem>
	                    <#assign submittingLegalEntity = iuclid.getDocumentForKey(dossier.submittingLegalEntityKey) />
                		<#if submittingLegalEntity?has_content>
                			<listitem>Submitting legal entity:
                    			<@com.text submittingLegalEntity.GeneralInfo.LegalEntityName/>
                    		</listitem>
                		</#if>
                		<#assign ownerLegalEntity = iuclid.getDocumentForKey(_subject.OwnerLegalEntity) />
	                    <#if ownerLegalEntity?has_content && ((!submittingLegalEntity?has_content) || (ownerLegalEntity.documentKey!=submittingLegalEntity.documentKey))>
	                        <listitem>Owner legal entity: <@com.text ownerLegalEntity.GeneralInfo.LegalEntityName/></listitem>
	                    </#if> 
	                </itemizedlist>
	                </para>
            </#if>  -->

            <para role="align-right">
                <para role="cover.i6subtext">
                    ${left_footer_text}
                </para>
            </para>
	    
		</cover>
       

    </info>

    <chapter>
        <title role="HEAD-4">Substances and metabolites: structures, codes, synonyms</title>
        <@docN.metabolitesList mixture=_subject/>
    </chapter>

</book>
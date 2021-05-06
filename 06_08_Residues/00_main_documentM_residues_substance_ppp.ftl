<?xml version="1.0" encoding="UTF-8"?>

<#--Documents M - Section 6 (Residues) for an active substance.
    To be run from a DOSSIER. -->

<#-- Import common modules to quickly access their substance and study content -->
<#import "macros_common_general.ftl" as com>
<#import "macros_common_studies_and_summaries.ftl" as studyandsummaryCom>
<#import "common_module_residues.ftl" as keyRes/>
<#import "appendixE.ftl" as keyAppendixE>

<#assign locale = "en" />
<#assign sysDateTime = .now>

<#-- Initialize the following variables:
	* _dossierHeader (:DossierHashModel) //The header document of a proper or 'raw' dossier, can be empty
	* _subject (:DocumentHashModel) //The dossier subject document or, if not in a dossier context, the root document, never empty
	-->
<@com.initializeMainVariables/>

<#--Initialize relevance-->
<@com.initiRelevanceForPPP relevance/>

<#assign ownerLegalEntity = iuclid.getDocumentForKey(_subject.OwnerLegalEntity) />
<#assign docUrl=iuclid.webUrl.entityView(_subject.documentKey)/>

<#--get the context, and docname to print
    NOTE: this works for dossier only; in future also for dataset.-->
<#assign docFullName="Residues in or on treated products, food and feed"/>
<#assign docName=""/>
<#if _subject.submissionType?has_content>
    <#if _subject.submissionType?matches(".*MICRO.*", "i")>
        <#assign workingContext="MICRO"/>
        <#assign docName="MA"/>

    <#elseif _subject.submissionType?matches(".*MAXIM.*", "i") >
        <#assign workingContext="MRL"/>
        <#assign docName="MRL"/>

    <#else>
        <#assign workingContext="CHEM"/>
        <#assign docName="CA"/>
    </#if>
</#if>

<#--get name of the entity-->
<#if _subject.documentType=="MIXTURE">
    <#assign activeSubstanceList = getActiveSubstanceComponents(_subject) />
    <#if activeSubstanceList?has_content>
        <#assign activeSubstance = activeSubstanceList[0] />
        <#global _subject=activeSubstance/>
    </#if>
<#elseif _subject.documentType=="SUBSTANCE">
    <#assign activeSubstance=_subject/>
</#if>

<#--section number hardcoded for individual sections-->
<#assign sectionNb="6"/>

<#--get error message if no active substance or dossier-->
<#if !(activeSubstance??)>
    <#assign errorMessage="The mixture does not contain an active substance! Please, add an active substance in the mixture composition and try again">
<#elseif !(workingContext??)>
    <#assign errorMessage="Please, run Report Generator from a dossier.">
</#if>

<#--interim solution: if there is no working context (because RGen run from dataset) just print an error message in an empty document-->
<#if !(errorMessage??)>
<book version="5.0" xmlns="http://docbook.org/ns/docbook" xmlns:xi="http://www.w3.org/2001/XInclude">

    <#assign left_header_text = ''/>
    <#assign central_header_text = com.getReportSubject(rootDocument).name?html />
    <#assign right_header_text = ''/>

    <#assign left_footer_text = sysDateTime?string["dd/MM/yyyy"] + " - IUCLID 6 " + iuclid6Version!/>
    <#assign central_footer_text = 'M${docName} - Section ${sectionNb}' />
    <#assign right_footer_text = ''/>

    <info>


        <title>
            <#--			NOTE it overlaps in the ToC...-->
            <para role="i6header5_nobold"><#if ownerLegalEntity?has_content><@com.text ownerLegalEntity.GeneralInfo.LegalEntityName/></#if></para>
            <@com.emptyLine/>

            <para role="rule">

            <@com.emptyLine/>
            <ulink url="${docUrl}">${_subject.ChemicalName}</ulink>
            </para>

        </title>

        <subtitle>
            <para role="align-center">
            </para>
            <@com.emptyLine/>
            <para role="rule"/>
        </subtitle>

        <subtitle>
            <para role="align-right">
                <para role="HEAD-3">Document M-${docName}<?linebreak?>Section ${sectionNb}</para>
                <@com.emptyLine/>
                <para role="HEAD-4">${docFullName}</para>
            </para>
        </subtitle>

        <cover>
            <para role="align-right">
                <para role="cover.i6subtext">
                    ${left_footer_text}
                </para>
            </para>
        </cover>
        <@com.metadataBlock left_header_text central_header_text right_header_text left_footer_text central_footer_text right_footer_text />
    </info>

    <#-- Here add all the parts-->
    <chapter label="${docName} ${sectionNb}">
        <title role="HEAD-1">${docFullName}</title>
        <#include "06_08_residues.ftl" encoding="UTF-8" />
    </chapter>

    <#-- Annex for materials-->
    <chapter label="Annex">
        <title role="HEAD-1">Information on Test Material</title>
        <#include "Annex2_test_materials.ftl" encoding="UTF-8" />
    </chapter>

</book>
<#else>
    <book version="5.0" xmlns="http://docbook.org/ns/docbook" xmlns:xi="http://www.w3.org/2001/XInclude">
        <info>
            <title>${errorMessage}</title>
        </info>
        <part></part>
    </book>

</#if>

<#function getActiveSubstanceComponents mixture>

    <#local componentsList = []/>

    <#local compositionList = iuclid.getSectionDocumentsForParentKey(mixture.documentKey, "FLEXIBLE_RECORD", "MixtureComposition") />

    <#list compositionList as composition>
        <#local componentList = composition.Components.Components />
        <#list componentList as component>
            <#if component.Reference?has_content && isComponentActiveSubstance(component)>
                <#local substance = iuclid.getDocumentForKey(component.Reference)/>
                <#if substance?has_content && substance.documentType=="SUBSTANCE">
                    <#local componentsList = com.addDocumentToSequenceAsUnique(substance, componentsList)/>
                </#if>
            </#if>
        </#list>
    </#list>

    <#return componentsList />
</#function>

<#function isComponentActiveSubstance component>
    <#return component.Function?has_content && com.picklistValueMatchesPhrases(component.Function, ["active substance"]) />
</#function>

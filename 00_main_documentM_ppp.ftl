<?xml version="1.0" encoding="UTF-8"?>

<#-- Import common modules to quickly access their substance and study content -->
<#import "macros_common_general.ftl" as com>
<#import "macros_common_studies_and_summaries.ftl" as studyandsummaryCom>
<#import "common_module_physical_chemical_summary_properties.ftl" as keyPhysChemSummary/>
<#import "common_module_human_health_hazard_assessment_of_physicochemical_properties.ftl" as keyPhyschem>
<#import "common_module_human_health_hazard_assessment.ftl" as keyTox>
<#import "common_module_environmental_hazard_assessment.ftl" as keyEcotox>
<#import "appendixE.ftl" as keyAppendixE>

<#assign locale = "en" >
<#assign sysDateTime = .now>
<#assign workingContext="CHEM">
<#-- Initialize the following variables:
	* _dossierHeader (:DossierHashModel) //The header document of a proper or 'raw' dossier, can be empty
	* _subject (:DocumentHashModel) //The dossier subject document or, if not in a dossier context, the root document, never empty 
	-->
<@com.initializeMainVariables/>

<#--Initialize relevance-->
<@com.initiRelevanceForPPP relevance/>
<#--<@com.initiRelevanceForDAR relevance/>-->
<#--<@com.initiRelevanceForRAR relevance/>-->

<#-- get your root substance or mixture document (this is the main subject of the report) -->
<#--<#assign mixture = _subject/>-->
<#--<#assign activeSubstanceList = getActiveSubstanceComponents(mixture) />-->
<#--<#if activeSubstanceList?has_content>-->
<#--	<#assign activeSubstance = activeSubstanceList[0] />-->
<#--</#if>-->

<#assign ownerLegalEntity = iuclid.getDocumentForKey(_subject.OwnerLegalEntity) />

<book version="5.0" xmlns="http://docbook.org/ns/docbook" xmlns:xi="http://www.w3.org/2001/XInclude">

	<#assign left_header_text = ''/>
	<#assign central_header_text = com.getReportSubject(rootDocument).name?html />
	<#assign right_header_text = ''/>

	<#assign left_footer_text = sysDateTime?string["dd/MM/yyyy"] + " - IUCLID 6 " + iuclid6Version!/>
	<#assign central_footer_text = 'KCA/KCP' />
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
					<#if _subject.documentType=="MIXTURE"><@com.text _subject.MixtureName/>
					<#elseif _subject.documentType=="SUBSTANCE"><@com.text _subject.ChemicalName/>
					</#if>
				</ulink>
			</para>
		</title>

		<subtitle>
			<para role="align-center">
<#--				<#if activeSubstance??>-->
<#--					<#assign asDocUrl=iuclid.webUrl.entityView(activeSubstance.documentKey)/>-->
<#--					(active substance:	<ulink url="${asDocUrl}"><@com.text activeSubstance.ChemicalName/></ulink>)-->
<#--				</#if>-->
			</para>
			<@com.emptyLine/>
			<para role="rule"/>
		</subtitle>

		<subtitle>
			<para role="align-right">
				<para role="HEAD-3">Document M-<#if _subject.documentType=="MIXTURE">CP<#elseif _subject.documentType=="SUBSTANCE">CA</#if>
				</para>
				<@com.emptyLine/>
				<para role="HEAD-4"></para>
			</para>
		</subtitle>

<#--		<biblioid class="isbn">978-0-596-8050-2-9</biblioid>-->
<#--		<authorgroup>-->
<#--			<author>-->
<#--				<personname>-->
<#--					<firstname>Name</firstname>-->
<#--					<surname>LastName</surname>-->
<#--				</personname>-->
<#--			</author>-->
<#--		</authorgroup>-->
<#--		<publisher>-->
<#--			<publishername>Name</publishername>-->
<#--			<address><city>City</city></address>-->
<#--			</publisher>-->
<#--		<copyright>-->
<#--			<year>Year</year>-->
<#--			<holder>Holder</holder>-->
<#--		</copyright>-->
<#--		<releaseinfo>Published by X</releaseinfo>-->
<#--		<editor>-->
<#--			<personname>-->
<#--				<firstname>Name</firstname>-->
<#--				<surname>LastName</surname>-->
<#--			</personname>-->
<#--		</editor>-->
<#--		<revhistory>-->
<#--			<revision>-->
<#--				<date>Date2</date>-->
<#--				<revremark>Second Edition.</revremark>-->
<#--			</revision>-->
<#--			<revision>-->
<#--				<date>Date1</date>-->
<#--				<revremark>First Edition.</revremark>-->
<#--			</revision>-->
<#--		</revhistory>-->
<#--		<legalnotice>-->
<#--			<para></para>-->
<#--		</legalnotice>-->

		<cover>
			<para role="align-right">
				<para role="cover.i6subtext">
					${left_footer_text}
				</para>
			</para>
		</cover>
		<#-- NOTE: metadata doesn't work-->
<#--		<@com.metadataBlock left_header_text central_header_text right_header_text left_footer_text central_footer_text right_footer_text />-->
	</info>


	<#-- Here add all the mixture parts-->
	<#if _subject.documentType=="MIXTURE">
<#--		<chapter label="CP 2">-->
<#--			<title role="HEAD-1">Physical, chemical and technical properties of the plant protection product</title>-->
<#--			<#include "02_physchem.ftl" encoding="UTF-8" />-->
<#--		</chapter>-->
<#--		<chapter label="CP 7">-->
<#--			<title role="HEAD-1">Toxicological studies</title>-->
<#--			<#include "05_tox.ftl" encoding="UTF-8" />-->
<#--		</chapter>-->
		<chapter label="CP 10">
			<title role="HEAD-1">Ecotoxicological studies on the plant protection product</title>
			<#include "08_10_ecotox.ftl" encoding="UTF-8" />
		</chapter>
	<#elseif _subject.documentType=="SUBSTANCE">
<#--			<chapter label="CA 2">-->
<#--				<title role="HEAD-1">Physical and chemical properties of the active substance</title>-->
<#--				<#include "02_physchem.ftl" encoding="UTF-8" />-->
<#--			</chapter>-->

<#--			<chapter label="CA 5">-->
<#--				<title role="HEAD-1">Toxicological and metabolism studies on the active substance</title>-->
<#--				<#include "05_tox.ftl" encoding="UTF-8" />-->
<#--			</chapter>-->

		<chapter label="CA 8">
			<title role="HEAD-1">Ecotoxicological studies on the active substance</title>
			<#include "08_10_ecotox.ftl" encoding="UTF-8" />
		</chapter>

	</#if>

	<#-- Add annex for materials: will need to be modified-->
	<chapter label="Annex">
		<title role="HEAD-1">Information on Test Material</title>
		<!-- include the Annex 2 module 'Annex2_test_materials.ftl' to list the additional test material information in an annex -->
		<#include "Annex2_test_materials.ftl" encoding="UTF-8" />
	</chapter>

</book>


<#--<!-- Macros and functions for reports containing an active substance component of a mixture or a report generating mixture-specific documents &ndash;&gt;-->
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

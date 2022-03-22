<#import "appendixE.ftl" as keyAppendixE>
<#import "macros_common_general.ftl" as com>
<#import "macros_common_studies_and_summaries.ftl" as studyandsummaryCom>
<#import "common_module_substance_composition.ftl" as keyComp>
<#import "common_module_substance_basic_information.ftl" as keySub>
<#import "common_module_administrative_information.ftl" as keyAdm>
<#import "common_module_biological_properties_microorganism.ftl" as keyBioPropMicro/>
<#import "common_module_physical_chemical_summary_properties.ftl" as keyPhysChemSummary/>
<#import "common_module_human_health_hazard_assessment_of_physicochemical_properties.ftl" as keyPhyschem>
<#import "common_module_analytical_methods.ftl" as keyAnMeth>
<#import "common_module_human_health_hazard_assessment.ftl" as keyTox>
<#import "common_module_residues.ftl" as keyRes/>
<#import "common_module_environmental_fate_properties.ftl" as keyFate>
<#import "common_module_literature_data.ftl" as keyLit>

<#assign locale = "en" />
<#assign sysDateTime = .now>

<#-- Initialize the following variables:
	* _dossierHeader (:DossierHashModel) //The header document of a proper or 'raw' dossier, can be empty
	* _subject (:DocumentHashModel) //The dossier subject document or, if not in a dossier context, the root document, never empty
	-->
<@com.initializeMainVariables/>

<#--Initialize relevance-->
<@com.initiRelevanceForPPP relevance/>

<#--get name of the entity-->
<#assign ownerLegalEntityMain = iuclid.getDocumentForKey(_subject.OwnerLegalEntity) />
<#assign thirdPartyLegalEntityMain = iuclid.getDocumentForKey(_subject.ThirdParty) />
<#if _dossierHeader??><#assign submittingLegalEntity = iuclid.getDocumentForKey(_dossierHeader.submittingLegalEntityKey) /></#if>

<#if _subject.documentType=="MIXTURE">
    <#global _metabolites = com.getMetabolites(_subject)/>

    <#assign activeSubstanceList = com.getComponents(_subject, "active substance") />

    <#if activeSubstanceList?has_content>
        <#assign activeSubstance = activeSubstanceList[0] />

        <#global _subjectMixture=_subject/>

        <#global _subject=activeSubstance/>
    </#if>

<#elseif _subject.documentType=="SUBSTANCE">
    <#assign activeSubstance=_subject/>
</#if>
<#assign workingContext="MRL"/>
<#assign docNameCode=""/>

<#--get LE and url-->
<#assign ownerLegalEntity = iuclid.getDocumentForKey(_subject.OwnerLegalEntity) />
<#assign docUrl=iuclid.webUrl.entityView(_subject.documentKey)/>

<#if !(activeSubstance??)>
    <#assign errorMessage="The mixture does not contain an active substance! Please, add an active substance in the mixture composition and try again"/>
<#elseif !(_dossierHeader??)>
    <#assign errorMessage="Not a dossier! Plase, run Report Generator from a dossier."/>
</#if>

<#if !(errorMessage??)>
<book version="5.0" xmlns="http://docbook.org/ns/docbook" xmlns:xi="http://www.w3.org/2001/XInclude">

    <#assign left_header_text = ''/>
    <#assign central_header_text = com.getReportSubject(rootDocument).name?html />
    <#assign right_header_text = ''/>

    <#assign left_footer_text = sysDateTime?string["dd/MM/yyyy"] + " - IUCLID 6 " + iuclid6Version!/>
    <#assign central_footer_text = 'MRL Application Report' />
    <#assign right_footer_text = ''/>

    <info>
        <title>MRL APPLICATION REPORT</title>
        <cover>
            <@com.emptyLine/>
            <para>
                <para>
                    <emphasis role="bold">Substance Name:</emphasis> <@com.substanceName _subject/>
                </para>
                <para>
                    <emphasis role="bold">Applicant's Identity: </emphasis><#if ownerLegalEntityMain?has_content><@com.text ownerLegalEntityMain.GeneralInfo.LegalEntityName/></#if>
                </para>
            </para>
        </cover>
        <@com.metadataBlock left_header_text central_header_text right_header_text left_footer_text central_footer_text right_footer_text />
    </info>
    
 
	<chapter label="I"><title>Background</title>
	
		<#assign app=_dossierHeader.MRLApplication.DossierSpecificInformation/>
        <#assign nosinfo=_dossierHeader.NotificationOfStudies/>
		
        <#assign ownerLegalEntityName>
            <#if ownerLegalEntityMain?has_content><@com.text ownerLegalEntityMain.GeneralInfo.LegalEntityName/></#if>
        </#assign>
        
        <#assign submittingLegalEntityName>
            <#if submittingLegalEntity?has_content>
                <@com.text submittingLegalEntity.GeneralInfo.LegalEntityName/>
            <#elseif ownerLegalEntityName?has_content>
            	<@com.text ownerLegalEntity.GeneralInfo.LegalEntityName/>
            </#if>
		</#assign>
		
        <#assign thirdPartyName>
            <#if thirdPartyLegalEntityMain?has_content>
                <@com.text thirdPartyLegalEntityMain.GeneralInfo.LegalEntityName/>
            </#if>
		</#assign>
		<#--  
		<#assign extraLegalEntityNames=[]/>
		<#if submittingLegalEntityName!=ownerLegalEntityName && ownerLegalEntityName?has_content>
			<#assign extraLegalEntityNames=extraLegalEntityNames + ["owner: ${ownerLegalEntityName}"]/> 
		</#if>
    	<#if thirdPartyMainName!=ownerLegalEntityName && thirdPartyMainName!=submittingLegalEntityName && thirdPartyName?has_content>
    		<#assign extraLegalEntityNames=extraLegalEntityNames + ["third party: ${thirdPartyName}"]/> 
		</#if>
		-->
		<@com.emptyLine/>
		
		<para>
    		<#--  NOTE: date is creation date, which might not be same as submission date. Not included. -->

    		The applicant <emphasis role="underline">${ownerLegalEntityName}</emphasis>
    		<#--  <#if extraLegalEntityNames?has_content>(${extraLegalEntityNames?join("; ")})</#if>-->
    		<#if thirdPartyName?has_content>(third party: ${thirdPartyName})</#if>
    		submitted an MRL application
    		to the Evaluating Member State (EMS) <emphasis role="underline"><@com.picklist app.EMS/></emphasis>:
    		<itemizedlist>
    		    <listitem>European Reference Number: <@com.text app.EUReferenceNumber/></listitem>
    			<listitem>Dossier UUID: ${sanitizeUUID(_dossierHeader.subjectKey)}</listitem>
    			<#-- <listitem>Dossier creation date and time: <@com.text _dossierHeader.creationDate /></listitem>-->
    		</itemizedlist>
    		
    	</para>	 
    	
    	<@com.emptyLine/>
    	
    	<#if _dossierHeader.remarks?has_content>
    		<para>The applicant made the following remarks: <@com.text _dossierHeader.remarks /></para>
    		<@com.emptyLine/>
		</#if>

		
    	<#assign purposeSize = (app.Purpose?size>1) />
    	<para>
    		The following purpose<#if purposeSize>s were<#else> was</#if> indicated by the applicant: 
			<#if !purposeSize>
				<@com.picklistMultiple app.Purpose/>
			<#else>
				<itemizedlist>
				<#list app.Purpose as purpose>
					<listitem><@com.picklist purpose/></listitem>
				</#list>
				</itemizedlist>
			</#if>
		</para>
			
		<@com.emptyLine/>
			
		<#assign applicantSize = (app.Applicant?size>1) />
    	<para>
    		The applicant<#if applicantSize>s are<#else> is</#if>: 
			<#if !applicantSize>
				<@com.picklistMultiple app.Applicant/>
			<#else>
				<itemizedlist>
				<#list app.Applicant as applicant>
					<listitem><@com.picklist applicant/></listitem>
				</#list>
				</itemizedlist>
			</#if>
		</para>	
		
		<@com.emptyLine/>

		<para>This application should be assessed under <emphasis role="underline"><@com.picklist app.DataRequirements/></emphasis>.</para>
		
		<@com.emptyLine/>

		<#if _dossierHeader.OtherSubmissionRelatedInformation.PartOfActiveSubstanceAppl>
			<para>The MRL application is submitted as part of the following <emphasis role="underline">active substance application: 
				<@com.text _dossierHeader.OtherSubmissionRelatedInformation.SubmissionNumber/></emphasis>
			</para>
		</#if>
		
		<#assign allPurposes><@com.picklistMultiple app.Purpose/></#assign>
		<#assign isImportTolerance=false/>
		<#if allPurposes?contains("set import tolerance")>
			<@importTolerance _subject "registration"/>
			<@importTolerance _subject "legislation"/>
			<#assign isImportTolerance=true/>
		</#if>
		
		<para>
		
			<@mrlTable _subject/>
		
		</para>
		
	</chapter>
     
    <chapter label="II">
        <title>The active substance and its use pattern</title>
     
        <sect1 label="1">
            <title role="HEAD-1">Identity of the active substance</title>
            
	        <sect2>
	            <title role="HEAD-2">Names, identifiers and molecular information of the active substance</title>
	            <@keySub.substanceIdentity  _subject/>
	        </sect2>
	
	
	        <sect2>
	            <title role="HEAD-2">Method of manufacture (synthesis pathway) of the active substance</title>
	            <@keyAdm.manufacturer _subject/>
	        </sect2>
	
	        <sect2>
	            <title role="HEAD-2">Specification of purity of the active substance, additives and impurities</title>
	            <@keyComp.substanceComposition _subject false/>
	        </sect2>
	
	        <#if keyAppendixE.containsDoc(_subject, "FLEXIBLE_SUMMARY.Metabolites" , "", false)>
		        <sect2>
		            <title role="HEAD-2">Information on metabolites</title>
		            <@keyComp.metabolitesInformation _subjectMixture/>
		        </sect2>
			</#if>
        </sect1>
        
        <?hard-pagebreak?>
 
        <sect1 label="2">
            <title role="HEAD-1">Assessments on the active substance</title>
            <@keyAdm.assessmentOtherAuthorities _subject false/> 
        </sect1>
        
        <?hard-pagebreak?>

        <sect1 label="3">
            <title role="HEAD-2">Use of the active substance (GAP)</title>
            <para>For details on uses of the active substance please refer to the <command  linkend="appA">Appendix A</command>.</para>
        </sect1>
        
        <?hard-pagebreak?>

        <sect1 label="4">
            <title role="HEAD-2">Effects on harmful organisms, function, mode of action and possible resistance</title>
             <@keyBioPropMicro.effectivenessTargetOrgSummary subject=_subject includeMetabolites=false/>
        	 <@com.emptyLine/>
        	 <@keyAppendixE.appendixEstudies subject=_subject docSubTypes="EffectivenessAgainstTargetOrganisms"
              name="effects on harmful organisms, function, mode of action and possible resistance" includeMetabolites=false/>
        </sect1>
        
    </chapter>	    
	    
	<chapter label="III">
    	<title>Assessment</title>
 
        <#global _summaries=true>
        <#global _studies=false>
        <#global _waivers=false>
          
		<#include "mrl_assessment.ftl"/>
	</chapter>
 
	<chapter label="IV">

        <title>Conclusions and recommendations</title>
        
        <sect1 label="1">
            <title role="HEAD-2">Proposed residue definitions</title>
            <@keyRes.residuesSummary _subject "ResidueFood" />
        </sect1>

        <?hard-pagebreak?>

        <sect1 label="2">
            <title role="HEAD-2">Proposed maximum residue levels (MRLs)</title>
            <@keyRes.residuesSummary _subject "MRLProposal" />
        </sect1>
        
    </chapter>
 

	<#-- NOTE: using <appendix> automatically adds "Appendix" as title but doesn't show in ToC -->
	<chapter label="Appendix A" xml:id="appA">
		<title>Good Agricultural Practices (GAP) supported in the MRL application</title>
		<para>Please, use the standalone report for Good Agricultural Practices (GAP) available in Report Generator.</para>
		<#--  <@keyGAP.GAPsummary _subjectMixture/> -->
	</chapter>


	<chapter label="Appendix B">
		<title>Pesticide Residues Intake Model (PRIMo)</title>
		<para>Not available.</para>
	</chapter>

	<chapter label="Appendix C">
		<title>Detailed evaluation of the additional studies relied on</title>
		<#global _summaries=false/>
        <#global _studies=true/>
        <#global _waivers=true/>
		<#global _prefix="C."/>
		          

		<#include "mrl_assessment.ftl"/>
		</chapter>
		
 
	<chapter label="Appendix D">
		<title>Import tolerances</title>
		<@keyAdm.importTolerances _subject/> 
	</chapter>

	
    <chapter label="Annex 1">
        <title>Information on Test Materials</title>
        <#include "Annex2_test_materials.ftl" encoding="UTF-8" />
    </chapter> 
	
	<chapter label="Annex 2">
        <title>Information on Reference Substances</title>
        <#list keyComp.referenceSubstancesInformation as refSub>
            <sect4 role="NotInToc" xml:id="${refSub.documentKey.uuid!}">
                <#assign refSubName><@com.text refSub.ReferenceSubstanceName/></#assign>
                <#assign refSubInfo>
                    <para role="small">
                        <@keySub.referenceSubstanceInfo refSub true "Reference substance: ${refSubName}"/>
                    </para>
                </#assign>
                ${refSubInfo}
            </sect4>

            <@com.emptyLine/>

        </#list>
     </chapter>
     
     <chapter label="References">
     	<title>Additional studies relied on</title>
		<para>Please, use the standalone report for List of Literature References available in Report Generator.</para>
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


<#--  -----------------------------MACROS------------------------- -->
<#macro importTolerance subject selection="registration">
	<#compress>
	
		<#if selection=="registration">
			<#local tolerancePath="RegistrationInExportingCountry"/>
			<#local remarkPath="RegistrationInExportingCountryRemark"/>
			<#local sentence="The applicant provided the evidence of registration in the exporting country">
		<#elseif selection=="legislation">
			<#local tolerancePath="LegislationInExportingCountry"/>
			<#local remarkPath="LegislationExportingCountryRemark"/>
			<#local sentence="MRL(s) in the exporting country were provided by the applicant">
		</#if>
		
		<#local studyList = iuclid.getSectionDocumentsForParentKey(subject.documentKey, "FLEXIBLE_RECORD", "AssessmentOtherAuthorities") />

		<#local tolerances=[]/>
		<#if studyList?has_content>
			<#list studyList as study>
				<#if study.AdditionalInformation[tolerancePath]>
					<#local tolerances = tolerances + [study.AdditionalInformation[remarkPath]]/>
				</#if>
			</#list>
		</#if>

		<#if tolerances?has_content>
					
			<para>
				${sentence}:
				<#list tolerances as tolerance>
	
					<#if (tolerances?size>1) >
						<para role="indent">(#${tolerance_index+1}) <@com.text tolerance/></para>
					<#else>
						<@com.text tolerance/>
					</#if>
				</#list>
			</para>
			<@com.emptyLine/>
		</#if>

	</#compress>
</#macro>

<#function getMRLhash subject>
	
	<#local mrlHash={}/>
	
	<#-- Parse MRL Proposal document -->
	<#local summaryList = iuclid.getSectionDocumentsForParentKey(subject.documentKey, "FLEXIBLE_SUMMARY", "MRLProposal") />

	<#list summaryList as summary>
	
		<#-- proposed MRls -->
		<#if summary.KeyInformation.MaximumResidueLevel?has_content>
	        <#list summary.KeyInformation.MaximumResidueLevel as item>
	        	<#local mrlHash = add2MrlHash(mrlHash,item, "proposed")/>
	       	</#list>
	    </#if>
	    
	</#list>
	
	<#-- Parse Assessment document -->
	<#local summaryList = iuclid.getSectionDocumentsForParentKey(subject.documentKey, "FLEXIBLE_RECORD", "AssessmentOtherAuthorities") />
	
	<#list summaryList as summary>
	
		<#-- existing MRLs in the EU -->
		<#if summary.AssessmentsEurope.ExistingMrl.EuMrl?has_content>      
	        <#list summary.AssessmentsEurope.ExistingMrl.EuMrl as item>
	        	<#local mrlHash = add2MrlHash(mrlHash,item, "existing")/>
	       	</#list>
	    </#if>
	    
	    <#-- existing MRLs in exporting country -->
	    <#if summary.AssessmentsOutsideEurope.MrlExportingCountries.ExportingCountryMrl?has_content>
	        <#list summary.AssessmentsOutsideEurope.MrlExportingCountries.ExportingCountryMrl as item>
	        	<#local mrlHash = add2MrlHash(mrlHash,item, "exporting")/>
	       	</#list>
	    </#if>
	    
	</#list>
	
	<#return mrlHash/>
	
</#function>

<#function add2MrlHash mrlHash item name>

	<#local MRL>
		<#compress>
			<#if item.hasElement("MrlProposal")>
				<@com.quantity item.MrlProposal/>
			<#elseif item.hasElement("MrlValue")>
				<@com.quantity item.MrlValue/>
			</#if>
		</#compress>
	</#local>
	
	<#local RD>
		<#compress>
			<#if item.hasElement("ResidueDefinitionMonitoring")>
				<@com.text item.ResidueDefinitionMonitoring/>
			<#elseif item.hasElement("ResidueMonitoring")>
				<@com.text item.ResidueMonitoring/>
			</#if>
		</#compress>
	</#local>
	
	<#local LOQ><#if item.hasElement("MrlLoq")>${item.MrlLoq?c}</#if></#local>
	
	<#local Country><#if item.hasElement("Country")><@com.picklistMultiple item.Country "en" false false false/></#if></#local>

	
	<#list item.Commodity as comm>
		<#local commValue><@com.picklist comm/></#local>
		
		<#local entryList = [{'MRL': MRL, 'RD': RD, 'LOQ': LOQ, 'Country': Country}]/>
		
		<#if mrlHash?keys?seq_contains(commValue)>
			<#if mrlHash[commValue]?keys?seq_contains(name)>
				<#local entryList = mrlHash[commValue][name] + entryList/>
			</#if>
			
			<#local commHash = mrlHash[commValue] + {name: entryList}>
				
		<#else>
		
			<#local commHash = {name: entryList}/>
		</#if>
		
		<#local mrlHash = mrlHash + {commValue:commHash}/>
	</#list>

	<#return mrlHash/>
</#function>


<#macro mrlTable subject>
	<#compress>
	
		<#local mrlHash=getMRLhash(subject)/>
 
 		<#local mrlTypeList=["existing", "proposed"]/>
        <#if isImportTolerance>
        	<#local mrlTypeList = mrlTypeList + ["exporting"]>
        </#if>
	                    
		<#if mrlHash?has_content>
			
	
	        <table border="1">
				<title>Summary of existing MRLs and proposed MRLs</title>
	            <thead align="center" valign="middle">
	            <tr>
	                <th><?dbfo bgcolor="#FBDDA6" ?><emphasis role="bold">Commodity</emphasis></th>
	                <th><?dbfo bgcolor="#FBDDA6" ?><emphasis role="bold">Existing EU MRL (RD)</emphasis></th>
	                <th><?dbfo bgcolor="#FBDDA6" ?><emphasis role="bold">Proposed MRL (RD)</emphasis></th>
	                <#if isImportTolerance>
	                	<th><?dbfo bgcolor="#FBDDA6" ?><emphasis role="bold">For import tolerance:<?linebreak?>MRL in exporting country (RD)</emphasis></th>
	                </#if>
	            </tr>
	            </thead>
	
	            <tbody valign="middle">
				
	            <#list mrlHash as key,value>
	            	
	                <tr>
	                    <td>${key}</td>
	                    
	                    
	                    
	                    <#list mrlTypeList as mrlType>
	                    	<td>
		                    	<#if value?keys?seq_contains(mrlType)>
		                   
			                    	<#local entryList=value[mrlType]/>
		                    		<#list entryList as entry>
			                    		${entry.MRL}<#if entry.LOQ=="true">*</#if>
			                    		<#if entry.RD?has_content>(${entry.RD})</#if>
			                    		<#if entry.Country?has_content>[${entry.Country}]</#if>
			                    		<#if entry?has_next>;<?linebreak?></#if>
			                    	</#list>
			                    </#if>
			                </td>
			            </#list>    
			           </tr>
	            </#list>

	            </tbody>
	        </table>
		</#if>
		
	</#compress>
</#macro>

<#function sanitizeUUID uuidPath>
	
	<#local uuid><@com.text uuidPath/></#local>
	<#--  <#if uuid?matches("[az09-]{5,100}/[az09-]{5,100}", 'r')>-->
	<#if uuid?matches(".{2,50}/.{2,50}", "r")>
		<#local uuid=uuid?replace(".*/", '', 'r')/>
		<#-- <#local uuid=uuid?replace("^[az09-]{5,100}/", '', 'r')/> -->
	</#if>
	<#return uuid/>
</#function>
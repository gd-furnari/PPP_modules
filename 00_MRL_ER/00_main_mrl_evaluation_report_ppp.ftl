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
<#--Note: GAP missing-->

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
<#if _subject.documentType=="MIXTURE">
    <#global _metabolites = com.getMetabolites(_subject)/>

    <#assign activeSubstanceList = com.getComponents(_subject, "active substance") />

    <#if activeSubstanceList?has_content>
        <#assign activeSubstance = activeSubstanceList[0] />
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
    <#assign errorMessage="The mixture does not contain an active substance! Please, add an active substance in the mixture composition and try again">
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
                    <emphasis role="bold">Registrant's Identity: </emphasis><#if ownerLegalEntity?has_content><@com.text ownerLegalEntity.GeneralInfo.LegalEntityName/></#if>
                </para>
            </para>
        </cover>
        <@com.metadataBlock left_header_text central_header_text right_header_text left_footer_text central_footer_text right_footer_text />
    </info>

    <part>
        <title>The active substance and its use pattern</title>

        <chapter>
            <title role="HEAD-1">Identity of the active substance</title>
            <#include "01_identity.ftl" encoding="UTF-8" />
        </chapter>

        <chapter>
            <title role="HEAD-1">Further information on the active substance</title>
            <#include "03_04_furtherinfo.ftl" encoding="UTF-8" />
        </chapter>

    </part>

    <part>
        <title>Assessment</title>

        <chapter label="1">
            <title role="HEAD-1">Physical and chemical properties</title>
            <#include "02_physchem.ftl" encoding="UTF-8" />
        </chapter>

        <chapter label="2">
            <title role="HEAD-1">Methods of analysis</title>
            <#include "04_05_methods.ftl" encoding="UTF-8" />
        </chapter>

        <chapter label="3">
            <title role="HEAD-1">Mammalian toxicology</title>
            <#include "05_07_tox.ftl" encoding="UTF-8" />
        </chapter>

        <chapter label="4">
            <title role="HEAD-1">Residues</title>
            <#include "06_08_residues.ftl" encoding="UTF-8" />
        </chapter>

        <chapter label="5">
            <title role="HEAD-1">Consumer risk assessment</title>
            <sect1>
                <title role="HEAD-2">Estimation of the potential and actual exposure through diet and other sources</title>
                <@keyRes.residuesSummary _subject "ExpectedExposure" />
            </sect1>
        </chapter>

        <chapter label="6">
            <title role="HEAD-1">Fate and behaviour in the environment</title>
            <#include "07_09_fate.ftl" encoding="UTF-8" />
        </chapter>

        <chapter label="7">
            <title role="HEAD-1">Literature data</title>
            <#include "09_11_literature.ftl" encoding="UTF-8" />
        </chapter>

    </part>

    <part>
        <title>Conclusions and recommendations</title>
        <chapter label="1">
            <title>Proposed residue definitions and maximum residue levels</title>

            <sect1>
                <title role="HEAD-2">Proposed residue definitions</title>
                <@keyRes.residuesSummary _subject "ResidueFood" />
            </sect1>

            <?hard-pagebreak?>

            <sect1>
                <title role="HEAD-2">Proposed maximum residue levels (MRLs)</title>
                <@keyRes.residuesSummary _subject "MRLProposal" />
            </sect1>
        </chapter>
    </part>

    <part>
        <title>Annexes</title>

        <chapter label="1">
            <title role="HEAD-1">Information on Reference Substances</title>
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

        <chapter label="2">
            <title role="HEAD-1">Information on Test Material</title>

            <#include "Annex2_test_materials.ftl" encoding="UTF-8" />
        </chapter>
    </part>

</book>

<#else>
    <book version="5.0" xmlns="http://docbook.org/ns/docbook" xmlns:xi="http://www.w3.org/2001/XInclude">
        <info>
            <title>${errorMessage}</title>
        </info>
        <part></part>
    </book>

</#if>
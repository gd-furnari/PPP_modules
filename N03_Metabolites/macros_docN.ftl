<#--  <#macro activeSubstance mixture>
    <#compress>
        <#local compositionList = iuclid.getSectionDocumentsForParentKey(mixture.documentKey, "FLEXIBLE_RECORD", "MixtureComposition") />

        <#list compositionList as composition>
            <#local componentList = composition.Components.Components />
            
            <#list componentList as component>

                <#if component.Reference?has_content>
                    <#local function><@com.value component.Function/></#local>
                    <#if function=="active substance">
                        <#local activeSubstance = iuclid.getDocumentForKey(component.Reference)/>
                        <#local substanceName = activeSubstance.ChemicalName/>
                        <#local substanceUrl = iuclid.webUrl.entityView(activeSubstance.documentKey)/>
                        <para>
                            <ulink url="${substanceUrl}"><@com.value substanceName/></ulink>
                        </para>

                    </#if>
                </#if>
            </#list>
        </#list>
    </#compress>
</#macro>  -->




<#--NOTE: subject needs to be mixture-->
<#macro metabolitesList mixture>
    <#compress>

        <para role="small">
            <table border="1">

                <col width="15%" />
                <col width="30%" />
                <col width="20%" />
                <col width="35%" />

                <tbody valign="middle">
                <tr>
                    <th><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">Name</emphasis></th>
                    <th><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">IUPAC name, SMILES, InChi</emphasis></th>
                    <th><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">Structure</emphasis></th>
                    <th><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">Remarks</emphasis></th>
                </tr>

                <#local metabolitesDocList = iuclid.getSectionDocumentsForParentKey(mixture.documentKey, "FLEXIBLE_SUMMARY", "Metabolites") />
                
                <#list metabolitesDocList as metabolitesDoc>

                    <#list metabolitesDoc.ListMetabolites.Metabolites as metaboliteRow>
                        
                        <#local metabolite = iuclid.getDocumentForKey(metaboliteRow.LinkMetaboliteDataset)/>

                        <#if metabolite?has_content>
                            
                            <#-- A metabolite could be a SUBSTANCE or a REFERENCE_SUBSTANCE -->
                            <#if metabolite.documentType=="SUBSTANCE">

                                <#local substanceName = metabolite.ChemicalName/>
                                <#local refSubstance = iuclid.getDocumentForKey(metabolite.ReferenceSubstance.ReferenceSubstance)/>
                                
                            <#elseif metabolite.documentType=="REFERENCE_SUBSTANCE">

                                <#local substanceName=""/>
                                <#local refSubstance = metabolite/>

                            </#if>

                            <#if refSubstance?has_content>
                                <#local refSubstanceUrl=iuclid.webUrl.entityView(refSubstance.documentKey)/>
                            </#if>

                            <#--  Output row  -->
                            <tr>
                                <td>
                                    <#if substanceName?has_content>
                                        <#local substanceUrl=iuclid.webUrl.entityView(metabolite.documentKey)/>
                                        <ulink url="${substanceUrl}"><@com.value substanceName/></ulink>

                                        <#if refSubstance?has_content && refSubstance.ReferenceSubstanceName?has_content>
                                            <#--  <?linebreak?>  -->
                                            <para>
                                            (ref.: <ulink url="${refSubstanceUrl}"><@com.value refSubstance.ReferenceSubstanceName/></ulink> )
                                            </para>
                                        </#if>
                                    <#else>
                                        <ulink url="${refSubstanceUrl}"><@com.value refSubstance.ReferenceSubstanceName/></ulink>
                                    </#if>
                                </td>
    
                                <td>
                                    <#if refSubstance?has_content>
                                        <para><@com.iupacName refSubstance/></para>
                                        <para><@com.smilesNotation refSubstance/></para>
                                        <para><@com.inchi refSubstance/></para>
                                    </#if>
                                </td>

                                <td>
                                    <#if refSubstance?has_content>
                                        <@com.structuralFormula refSubstance 100 false/>
                                    </#if>
                                </td>

                                <td>
                                    <@com.value metaboliteRow.Remarks/>
                                </td>

                            </tr>
                        </#if>
                    </#list>
                </#list>

                </tbody>
            </table>
        </para>

    </#compress>
</#macro>


<#macro refSubstanceChemicalInfo ref>  
    <#-- <#if referenceMetabolite.IupacName?has_content>-->
    <#--     <para>IUPAC: <@com.text referenceMetabolite.IupacName/></para>-->
    <#-- </#if>-->
    <para>IUPAC: <@com.iupacName ref/></para>

    <#-- <#if referenceMetabolite.MolecularStructuralInfo.SmilesNotation?has_content>-->
    <#--    <para>SMILES: <@com.text referenceMetabolite.MolecularStructuralInfo.SmilesNotation/></para>-->
    <#-- </#if>-->
    <para>SMILES: <@com.smilesNotation ref/></para>

    <#-- Inchi missing in macros-->
    <para>InChI: <@com.inchi ref/></para>
</#macro>

<#--NOTE: subject needs to be mixture-->
<#macro metabolitesList mixture>
    <#compress>

        <para role="small">
            <table border="1">

                <col width="15%" />
                <col width="30%" />
                <col width="20%" />
                <col width="35%" />

                <thead align="center" valign="middle">
                <tr>
                    <th><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">Name</emphasis></th>
                    <th><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">Chemical identifiers</emphasis></th>
                    <th><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">Structure</emphasis></th>
                    <th><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">Found in</emphasis></th>
                </tr>
                </thead>

                <tbody valign="middle">


        <#--Get the active substance(s) (and their uuids) and metabolites-->
        <#local activeSubstances = com.getComponents(mixture, "active substance")/>
        <#local activeSubstancesUUID=getUUIDs(activeSubstances)>

        <#local metabolites = com.getMetabolites(mixture)/>

        <#local allSubstances = activeSubstances + metabolites/>

        <#--Get the metabolites-->
        <#global toc=iuclid.localizeTreeFor(_subject.documentType, _subject.submissionType, _subject.documentKey)/>
        <#local excludedDocSubTypes=["MixtureComposition", "SubstanceComposition", "Metabolites"] />
        <#local excludedDocTypes=["SUBSTANCE", "MIXTURE"] />

        <#list allSubstances as metaboliteDataset>
            <#local metabInRefList=[]>
            <#global metabOutRefList=[]>
                        <#-- Since the metabolite can be a substance or ref substance, if it's the proper then a reference substance must be present and needs to be fetched-->
                        <#if metaboliteDataset.documentType=="SUBSTANCE">
                            <#local metaboliteDsName=metaboliteDataset.ChemicalName/>
                            <#local referenceMetabolite=iuclid.getDocumentForKey(metaboliteDataset.ReferenceSubstance.ReferenceSubstance)/>
                        <#elseif metaboliteDataset.documentType=="REFERENCE_SUBSTANCE">
                            <#local referenceMetabolite=metaboliteDataset/>
                        </#if>

                        <#if referenceMetabolite?has_content>

                            <#local metaboliteName=referenceMetabolite.ReferenceSubstanceName/>
                        <#if !activeSubstancesUUID?seq_contains(metaboliteDataset.documentKey.uuid)>
                            <#--Get inbound references (in case of SUBSTANCE, for both SUBSTANCE and REFERENCE_SUBSTANCE entities)-->
                            <#local inboundReferences=com.inboundReferences(metaboliteDataset.documentKey)/>
                            <#if metaboliteDataset.documentType=="SUBSTANCE">
                                <#local inboundReferences = inboundReferences + com.inboundReferences(referenceMetabolite.documentKey)/>
                            </#if>

                            <#if inboundReferences?has_content>
                                <#list inboundReferences as inboundReferenceKey>
                                    <#if inboundReferenceKey?has_content >
                                        <#local inboundReference = iuclid.getDocumentForKey(inboundReferenceKey) />
                                        <#if inboundReference?has_content &&
                                                !(excludedDocSubTypes?seq_contains(inboundReference.documentSubType)) &&
                                                !(excludedDocTypes?seq_contains(inboundReference.documentType))   >

    <#--                                        ToC cannot be obtained for inbound references, but if i could retrieve the entity it belongs to, then i could.-->

    <#--                                        <#global toc=iuclid.localizeTreeFor(inboundReference.documentType, inboundReference.submissionType, inboundReference.documentKey)/>-->
    <#--                                        <#assign sectionNb = toc.nodeFor["${inboundReference.documentType}.${inboundReference.documentSubType}"].number! />-->
    <#--                                        <#assign sectionTitle = toc.nodeFor["${inboundReference.documentType}.${inboundReference.documentSubType}"].title! />-->


                                                <#local metabInRefList = metabInRefList + [{'type': "in",
                                                                                     'section' : "",
                                                                                    'uuid': inboundReference.documentKey.uuid,
                                                                                    'url': iuclid.webUrl.documentView(inboundReference.documentKey),
                                                                                     'name': inboundReference.name,
                                                                                     'info':getDocInfo(inboundReference)}]/>
                                        </#if>
                                    </#if>
                                </#list>
                            </#if>

                            <#--Get documents in substance dataset -->
                            <#if metaboliteDataset.documentType=="SUBSTANCE">
                                <#global toc=iuclid.localizeTreeFor(metaboliteDataset.documentType, metaboliteDataset.submissionType, metaboliteDataset.documentKey)/>
                                <#recurse toc/>
                            </#if>


                            <#--Iterate over lists to create table-->
                            <#local metabRefList = metabInRefList + metabOutRefList/>

                        <#else>
                            <#local metabRefList=[{'type': "",'section' : "",'uuid':'','url':'',
                                                    'name': '', 'info':''}]/>
                        </#if>


                            <#list metabRefList as metabRef>
                                <tr>
                                <#if metabRef_index==0>
                                    <td rowspan="${metabRefList?size}">
                                        ${metaboliteName}
                                    </td>

                                    <td rowspan="${metabRefList?size}">
                                        <@refSubstanceChemicalInfo referenceMetabolite/>
                                    </td>

                                    <td rowspan="${metabRefList?size}">
                                        <@com.structuralFormula referenceMetabolite 100 false/>
                                    </td>
                                </#if>
                                <td>
                                    <#if metabRef['type']?has_content>
                                        (${metabRef['type']}?)
                                        <#if metabRef["section"]?has_content>
                                            ${metabRef['section']}:
                                        </#if>
                                        <#if metabRef['info']?has_content>
                                            - ${metabRef['info']}
                                        </#if>
                                        <ulink url="${metabRef["url"]}">
                                            ${metabRef['name']}
                                        </ulink>
                                    </#if>
                                </td>

                                </tr>

                            </#list>

                        </#if>
<#--                        </#if>-->

                    </#list>
<#--                </#list>-->

<#--        </#if>-->
        </tbody></table></para>
    </#compress>
</#macro>

<#function getDocInfo(doc)>

    <#local info="">

    <#if doc.hasElement("AdministrativeData.Endpoint") && doc.AdministrativeData.Endpoint?has_content>
        <#local endpoint><@com.value doc.AdministrativeData.Endpoint/></#local>
        <#local info=info+endpoint/>
    </#if>

    <#if doc.hasElement("MaterialsAndMethods.TestAnimals.Species") && doc.MaterialsAndMethods.TestAnimals.Species?has_content>
        <#local species><@com.value doc.MaterialsAndMethods.TestAnimals.Species/></#local>
        <#local info = info + "(" + species + ")"/>
    </#if>

    <#return info>
</#function>

<#macro refSubstanceChemicalInfo ref>
<#--                                        <#if referenceMetabolite.IupacName?has_content>-->
<#--                                            <para>IUPAC: <@com.text referenceMetabolite.IupacName/></para>-->
<#--                                        </#if>-->
    <para>IUPAC: <@com.iupacName ref/></para>

<#--                                        <#if referenceMetabolite.MolecularStructuralInfo.SmilesNotation?has_content>-->
<#--                                            <para>SMILES: <@com.text referenceMetabolite.MolecularStructuralInfo.SmilesNotation/></para>-->
<#--                                        </#if>-->
    <para>SMILES: <@com.smilesNotation ref/></para>

<#-- Inchi missing in macros-->
    <para>InChI: <@com.inchi ref/></para>
</#macro>

<#macro "section_tree_node">

    <#local contents=(.node.content)!/>

    <#if contents?has_content>
        <#list contents as doc>

            <#if (doc.documentType=="ENDPOINT_STUDY_RECORD" || doc.documentType=="FLEXIBLE_RECORD") &&
                    doc.documentType!="SUBSTANCE" && doc.documentType!="MIXTURE" &&
                    doc.documentSubType!="SubstanceComposition">

                <#assign sectionNb = toc.nodeFor["${doc.documentType}.${doc.documentSubType}"].number! />

                <#assign sectionTitle = toc.nodeFor["${doc.documentType}.${doc.documentSubType}"].title! />

                <#global metabOutRefList = metabOutRefList + [{'type': "out",
                                                                'section' : "${sectionNb} ${sectionTitle}",
                                                                'uuid': doc.documentKey.uuid,
                                                                'url': iuclid.webUrl.documentView(doc.documentKey),
                                                                'name': doc.name,
                                                                'info':getDocInfo(doc)}]
                />

            </#if>
        </#list>
    </#if>

    <#recurse/>
</#macro>

<#function getUUIDs docList>
    <#local uuids=[]/>
    <#list docList as doc>
        <#local uuids = uuids + [doc.documentKey.uuid]/>
    </#list>
    <#return uuids>
</#function>
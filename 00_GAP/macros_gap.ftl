<#macro GAPsummary _subject selectedDoc="">

    <#local gapFullList = iuclid.getSectionDocumentsForParentKey(_subject.documentKey, "FLEXIBLE_RECORD", "GAP") />

    <#if gapFullList?has_content>
    
        <#--initialize hashMap with GAP data-->
        <#local gapDhash=getGapDhash(gapFullList, selectedDoc)/>

        <#if gapDhash?has_content>

            <#list gapDhash?keys as prodKey>
                            
                <#local gapList=gapDhash[prodKey]/>

                <#local product=iuclid.getDocumentForKey(gapList[0].AdministrativeDataSummary.Product)/>
                <#local docUrl=getDocUrl(_subject, product)/>

                <#-- if more than one product, create separate sections, otherwise no need-->
                <#if (gapDhash?keys?size > 1)>
                    <sect1 label="${prodKey_index+1}">
                        <title>Product ${prodKey_index+1}:
                            <ulink url="${docUrl}"><@com.text product.GeneralInformation.Name/></ulink>
                        </title>

                        <@com.emptyLine/>
                <#else>
                    <para>Product
                        <emphasis role="HEAD-WoutNo">
                            <ulink url="${docUrl}"><@com.text product.GeneralInformation.Name/></ulink>
                        </emphasis>
                    </para>
                </#if>
                    
                <#-- Get mixture composition-->
                <para>
                    <emphasis role="bold">Characteristics of the mixture composition:</emphasis>
                    <para role="indent">
                        <@mixtureComposition _subject product/>
                        <#-- Alternative table version:-->
                        <#-- <@mixtureComposition_ product/>-->
                    </para>
                </para>

                <@com.emptyLine/>

                <#--GAP table-->
                <para><emphasis role="bold">GAP table:</emphasis></para>
                <para role="small">
                    <table border="1">

                        <col width="11%" />
                        <col width="5%" />
                        <col width="3%" />
                        <col width="11%" />
                        <col width="10%" />
                        <col width="10%" />
                        <col width="3%" />
                        <col width="5%" />
                        <col width="6%" />
                        <col width="6%" />
                        <col width="6%" />
                        <col width="4%" />
                        <col width="20%" />

                        <tbody valign="middle">

                        <tr>
                            <th rowspan="2" align="center"><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">Crop /<?linebreak?>situation</emphasis></th>
                            <th rowspan="2" align="center"><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">MS /<?linebreak?>country</emphasis></th>
                            <th rowspan="2" align="center"><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">F, G<?linebreak?>or I</emphasis></th>
                            <th rowspan="2" align="center"><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">Pests controlled</emphasis></th>
                            <th colspan="4" align="center"><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">Application</emphasis> </th>
                            <th colspan="3" align="center"><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">Application rate per treatment</emphasis></th>
                            <th rowspan="2" align="center"><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">PHI</emphasis></th>
                            <th rowspan="2" align="center"><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">Remarks</emphasis></th>
                        </tr>

                        <tr>
                            <td align="center"><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold" >Method /<?linebreak?>kind </emphasis></td>
                            <td align="center"><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold" >Growth stage<?linebreak?>and season</emphasis></td>
                            <td align="center"><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold" >No</emphasis></td>
                            <td align="center"><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold" >Interval</emphasis></td>
                            <td align="center"><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold" >A.s.</emphasis></td>
                            <td align="center"><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold" >Water</emphasis></td>
                            <td align="center"><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold" >Conc. dilution</emphasis></td>
                        </tr>
                        
                        <#-- Iterate over gap documents of this product and D document-->
                        <#list gapList as gap>
                            <@GAPtableRow _subject gap/>
                        </#list>
                        </tbody>
                    </table>
                </para>

            <#if (gapDhash?keys?size > 1)>
                </sect1>
            </#if>

            <@com.emptyLine/>

            </#list>
        </#if>
    </#if>
</#macro>

<#macro GAPtableRow _subject gap>
    <#compress>

        <tr>
            <#--Crop and/or situation, and link to document-->
            <td>${getCrop(gap)}</td>
            
            <#--Member State or Country-->
            <td>${getMScountry(gap, false)}</td>
      
            <#-- F, G or I-->
            <td>${getCropLocation(gap)}</td>
              
            <#--Pests or group of pests controlled-->
            <td>${getTargetOrgs(gap)}</td>

            <#-- Application-->
            <#local app=gap.PestDiseaseTreated.ApplicationDetails/>

            <#-- 1. method kind-->
            <td>${getMethodTypeOnTarget(gap)}</td>

            <#-- 2. range of growth stages and seasons: repeatable block-->
            <td>${getGrowthStage(gap)}</td>

            <#--3. numbermin-max: range-->
            <td><@com.range app.ApplicationsRange/></td>

            <#--4. Interval between application (min)-->
            <td><#if app.RetreatmentInterval?has_content><@com.range app.RetreatmentInterval/>d</#if></td>

            <#--Application rate per treatment-->
            <#--1. A.s. per ha-->
            <td><@com.range app.ApplicationRateForTarget/></td>

            <#--2. Water -->
            <td><@com.range app.WaterAmountPerTreatment/></td>

            <#--3. Concentration in dilution -->
            <td><@com.range app.ConcentrationFormulationDilution/></td>

            <#-- PHI -->
            <td>
            	<#local phi><@com.picklist app.PreharvestInterval/></#local>
            	<#if phi=="not applicable">n.a.<#else>${phi}</#if>
            </td>

            <#-- Remarks: rest of fields (per block). Rich text not included. Missing: product application -->
            <td>
                <#if gap.KeyInformation.CropInformation.CropDestination?has_content || gap.PestDiseaseTreated.MajorMinorUse?has_content || app.TypeOfUser?has_content>
                    <para>
                    	<#if gap.KeyInformation.CropInformation.CropDestination?has_content>Crop destination: <@com.picklistMultiple gap.KeyInformation.CropInformation.CropDestination/>.</#if>
                    	<#if gap.PestDiseaseTreated.MajorMinorUse?has_content><@com.picklist picklistValue=gap.PestDiseaseTreated.MajorMinorUse printRemarks=false printDescription=false/>.</#if>
                		<#if gap.PestDiseaseTreated.ApplicationDetails.TypeOfUser?has_content>User: <@com.picklistMultiple gap.PestDiseaseTreated.ApplicationDetails.TypeOfUser/>.</#if>
	                </para>
                </#if>

                <#if app.ApplicationEquipment?has_content>
                    <para>App. equipment: <@com.picklistMultiple app.ApplicationEquipment/></para>
                </#if>
                
                <#if app.TreatmentWindowDispensers?has_content>
                    <para>Treatment window: <@com.text app.TreatmentWindowDispensers/></para>
                </#if>
                
                <#if app.ApplicationRatePerTreatment?has_content || app.SeasonalAplication?has_content || app.RemarksOnApplicationRate?has_content>
                	<para>
                		<#if app.ApplicationRatePerTreatment?has_content>App. rate product: <@com.range app.ApplicationRatePerTreatment/>.</#if>
		            	<#if app.SeasonalAplication?has_content>Max. annual a.s.: <@com.range app.SeasonalAplication/>.</#if>
		            	<@com.text app.RemarksOnApplicationRate/>	
					</para>
				</#if>
				
                <#if app.NonTargetAS?has_content>${getNTasRate(gap)}</#if>
                
                <#if app.SafenerSynergistAdjuvant?has_content>
                	<#local ssa><@com.picklist picklistValue=app.SafenerSynergistAdjuvant printRemarks=false printDescription=false/></#local>
	                <#if ssa!="no"><para>Safener / synergist / adjuvant: <@com.picklist app.SafenerSynergistAdjuvant/></para></#if>
                </#if>

                <#if app.MaxSeedingRate?has_content || app.PlantingDensity?has_content>
                    <para>
                    	<#if app.MaxSeedingRate?has_content>Max. seeding rate: <@com.range app.MaxSeedingRate/>.</#if>
                    	<#if app.PlantingDensity?has_content>Planting density: <@com.text app.PlantingDensity/>.</#if>
                    </para>
                </#if>
                
                <#if app.ReentryPeriod?has_content || app.ReentryPeriodLivestock?has_content || app.WithholdingPeriod?has_content || app.WaitingPeriod?has_content
                		|| app.PlantbackInterval?has_content>
                	<#local sep="">
                	
					<para>Safety intervals:
		                <#if app.ReentryPeriod?has_content || app.ReentryPeriodLivestock?has_content>
		                    ${sep}Re-entry: 
	                    	<#if app.ReentryPeriod?has_content><@com.quantity app.ReentryPeriod/> (humans)</#if>
	                    	<#if app.ReentryPeriodLivestock?has_content><@com.quantity app.ReentryPeriodLivestock/>(livestock)</#if>
	                    	<#local sep=";">
		                </#if>
		                <#if app.WithholdingPeriod?has_content>${sep}Withholding: <@com.quantity app.WithholdingPeriod/><#local sep=";"></#if>
		                <#if app.WaitingPeriod?has_content>${sep}Waiting: <@com.quantity app.WaitingPeriod/><#local sep=";"></#if>
		                <#if app.PlantbackInterval?has_content>${sep}Plant-back: <@com.quantity app.PlantbackInterval/><#local sep=";"></#if>
	                </para>
                </#if>

                <#if app.VentilationPractices?has_content>
                    <para>Ventilation practices: <@com.text app.VentilationPractices/></para>
                </#if>

                <#if app.Restrictions?has_content>
                    <para>Restrictions: <@com.text app.Restrictions/></para>
                </#if>
				
				<#-- 
                <#local keyInfo><@com.richText gap.KeyInformation.field9074/></#local>
                <#if gap.AdditionalInformation.field7935?has_content || (gap.KeyInformation.field9074?has_content && keyInfo!="authorised use")>
                    <para>NOTE: more information in corresponding GAP document (key/additional information).</para>
                </#if>
                 -->
            </td>

        </tr>

    </#compress>
</#macro>

<#--Macro for mixture composition in list format-->
<#macro mixtureComposition _subject product printFormulation=true>
    <#compress>

        <itemizedlist>
            <#if printFormulation><listitem>formulation type: <@com.picklistMultiple product.GeneralInformation.FormulationType/></listitem></#if>

            <listitem>active substance: <@mixtureComponents product "active substance"/></listitem>
			<#local otherComps><@mixtureComponents product=product exclude=["active substance"]/></#local>
			<#if otherComps?has_content>
            	<listitem>other components: <@mixtureComponents product=product exclude=["active substance"]/></listitem>
			</#if>
        </itemizedlist>

    </#compress>
</#macro>

<#--Macro for mixture composition in table format (not used)-->
<#macro mixtureCompositionTable product>
    <#compress>

        <#if product.GeneralInformation.FormulationType?has_content>
            <para><emphasis role="underline">Formulation type:</emphasis> <@com.picklistMultiple product.GeneralInformation.FormulationType/></para>
        </#if>

        <!-- Components -->
        <#local itemList = product.Components.Components />
        <#if itemList?has_content>
            <#local itemList = iuclid.sortByField(itemList, "Function", ["active substance", "active substance (other, not to be assessed)", "synergist", "safener"]) />

            <@com.emptyLine/>

            <para><emphasis role="underline">Components:</emphasis></para>

            <para role="small">
            <table border="1">
                <title>Components</title>
                <col width="25%" />
                <col width="20%" />
                <col width="15%" />
                <col width="15%" />
                <col width="25%" />
                <tbody>
                <tr>
                    <th><?dbfo bgcolor="#FBDDA6" ?><emphasis role="bold">Constituent</emphasis></th>
                    <th><?dbfo bgcolor="#FBDDA6" ?><emphasis role="bold">Function</emphasis></th>
                    <th><?dbfo bgcolor="#FBDDA6" ?><emphasis role="bold">Typical concentration</emphasis></th>
                    <th><?dbfo bgcolor="#FBDDA6" ?><emphasis role="bold">Concentration range</emphasis></th>
                    <th><?dbfo bgcolor="#FBDDA6" ?><emphasis role="bold">Remarks</emphasis></th>
                </tr>
                <#list itemList as item>
                    <tr>
                        <td>
                            <#--NOTE: this can be a substance, a reference substance or even a mixture-->
                            <@componentId item.Reference/>
                        </td>
                        <td>
                            <#local function><@com.picklist item.Function/></#local>
                            <#if function=="active substance"><emphasis role="bood">${function}</emphasis><#else>${function}</#if>
                        </td>
                        <td>
                            <@com.value item.TypicalConcentration/>
                        </td>
                        <td>
                            <@com.range item.ConcentrationRange/>
                        </td>
                        <td>
                            <#if item.SubstanceOfConcern><emphasis role="bold">Substance of concern</emphasis><?linebreak?></#if>
                            <#if item.Gci><emphasis>Generic component identifier (CGI)</emphasis><?linebreak?></#if>
                            <#if item.Icg><emphasis>Interchangeable component group (ICG)</emphasis><?linebreak?></#if>
                            <#if item.Sfc><emphasis>Standard formula (SF) component</emphasis><?linebreak?></#if>
                            <#if item.SubstanceGeneratedInSitu><emphasis>Substance generated in situ</emphasis><?linebreak?></#if>

                            <@com.text item.Remarks/>
                        </td>
                    </tr>
                </#list>
                </tbody>
            </table>
            </para>
        </#if>
        <@com.emptyLine/>

    </#compress>
</#macro>

<#--Macro to extract componentIds (substance, mixture, ref substance) for composition table (not used)    -->
<#macro componentId link>
    <#compress>
        <#if link?has_content>
            <#local component=iuclid.getDocumentForKey(link)/>
            <#if component?has_content>
                <#if component.documentType=="MIXTURE">
                    mixture <@com.mixtureName component/>
                <#elseif component.documentType=="SUBSTANCE">
                    substance <@com.substanceName component/>
                    <#if component.ReferenceSubstance.ReferenceSubstance?has_content>
                        (ref. <@componentId component.ReferenceSubstance.ReferenceSubstance/>)
                    </#if>
                <#elseif component.documentType=="REFERENCE_SUBSTANCE">
                    <#local refSubst = iuclid.getDocumentForKey(link) />
                    <#if refSubst?has_content>
                        <command linkend="${refSubst.documentKey.uuid!}"><@com.text refSubst.ReferenceSubstanceName/></command>
                        <#if referenceSubstancesInformation??>
                            <#assign referenceSubstancesInformation = com.addDocumentToSequenceAsUnique(refSubst, referenceSubstancesInformation) />
                        </#if>
                    </#if>
                </#if>
            </#if>
        </#if>
    </#compress>
</#macro>

<#--Macro to extract mixture components by specific type (not used)-->
<#macro mixtureComponent product compType>
    <#compress>
        <#list product.Components.Components as comp>
            <#local function><@com.picklist comp.Function/></#local>
            <#if function==compType>
                <#local substance=iuclid.getDocumentForKey(comp.Reference)/>

                <#if (function=="active substance" && substance.documentType=="SUBSTANCE") || function!="active substance">

                    <para role="indent2">
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
                    </para>

                   </#if>
            </#if>
        </#list>
    </#compress>
</#macro>

<#--Macro to extract mixture components by type (all types if empty, but sorted by type); with possibility to exclude certain types-->
<#macro mixtureComponents product compType="" exclude=[] role="indent2">
    <#compress>

        <#local compFunctions={}/>

        <#-- Get all component functions in hashMap-->
        <#local compList = iuclid.sortByField(product.Components.Components, "Function", ["active substance", "active substance (other, not to be assessed)", "synergist", "safener"]) />
        <#list compList as comp>
            <#local function><@com.picklist comp.Function/></#local>
            <#if function==compType || compType=="">
                <#if compFunctions?keys?seq_contains(function)>
                    <#local funcList = compFunctions[function] + [comp]/>
                <#else>
                    <#local funcList = [comp]/>
                </#if>
                <#local compFunctions = compFunctions + {function:funcList}/>
            </#if>
        </#list>

        <#-- Read hashMap -->
        <#if compFunctions?has_content>

            <#list compFunctions?keys as func>

                <#if !exclude?seq_contains(func)>

                    <#if compType=""><para role="${role}">- ${func}: </#if>

                    <#local comps = compFunctions[func]/>

                    <#list comps as comp>

                        <#local substance=iuclid.getDocumentForKey(comp.Reference)/>
						<#if substance?has_content>
	                        <#if substance.documentType=="SUBSTANCE">
	                            <@com.text substance.ChemicalName/>
	                        <#elseif substance.documentType=="REFERENCE_SUBSTANCE">
	                            <@com.text substance.ReferenceSubstanceName/>
	                        </#if>
						</#if>
                        : <@com.range comp.TypicalConcentration/>

                        <#if comp.ConcentrationRange?has_content>
                            (<@com.range comp.ConcentrationRange/>)
                        </#if>

                        <#if comp.Remarks?has_content>
                            (<@com.text comp.Remarks/>)
                        </#if>

                        <#if comp?has_next>; </#if>

                    </#list>

                    <#if compType=""></para></#if>
                </#if>
            </#list>
        </#if>
    </#compress>
</#macro>

<#-- Macro to extract a table for safety intervals -->
<#macro GAPpart _subject selection>

    <#local gapFullList = iuclid.getSectionDocumentsForParentKey(_subject.documentKey, "FLEXIBLE_RECORD", "GAP") />

    <#if gapFullList?has_content>
    
        <#--initialize hashMap with GAP data-->
        <#local gapDhash=getGapDhash(gapFullList)/>

        <#if gapDhash?has_content>

            <#list gapDhash?keys as prodKey>
                            
                <#local gapList=gapDhash[prodKey]/>

                <#local product=iuclid.getDocumentForKey(gapList[0].AdministrativeDataSummary.Product)/>
                <#local docUrl=getDocUrl(_subject, product)/>

                <#-- if more than one product, write name-->
                <#if (gapDhash?keys?size > 1)>
                    <para><emphasis role="underline">Product ${prodKey_index+1}: <ulink url="${docUrl}"><@com.text product.GeneralInformation.Name/></ulink></emphasis></para>
					<@com.emptyLine/>
                </#if>
               
                <#--GAP table parts -->
                <#if selection=="safety">
                	<@safetyTable gapList/>
                	
                <#elseif selection=="application rate">
                	<para><emphasis role="bold">Composition of the 
                		<#if (gapDhash?keys?size == 1)><ulink url="${docUrl}">formulation:</ulink>
                		<#else>formulation:
                		</#if>
                	</emphasis></para>
                	<@mixtureComposition _subject product false/>
                	<@com.emptyLine/>
                	<para><emphasis role="bold">Application rate: </emphasis></para>
                	<@applicationRateTable gapList/>
                	
                <#elseif selection=="application method">
                	<@applicationMethodTable gapList/>
                	
                <#elseif selection=="application number">
                
                    <para><emphasis role="bold">Number of applications, treatment intervals and crop growth stage</emphasis></para>
                	<@applicationNumberTable gapList/>
                	
                	<#local tarOrgList = getTargetOrgList(gapList)/>
                	<#if tarOrgList?has_content>
                		<@com.emptyLine/>
                		<para><emphasis role="bold">Target organisms and developmental stage</emphasis></para>
                		<#--  <para>The target organisms controlled across the relevant crops are: ${tarOrgList}</para>
                		<@com.emptyLine/>
                		<para>List of target organism by crop:</para>-->
						<@targetOrgsTable gapList/>
                	</#if>
                	
                <#elseif selection=="intended use">
                	<@intendedUseTable gapList/>
                	
                	<#if hasKeyInfo(gapList)>
                		<@com.emptyLine/>
                		<para><emphasis role='bold'>Key information</emphasis> is provided for the following crops / trated objects:</para>
                		<@keyInfoTable gapList/>
                	</#if>
                	
                	<#local tarOrgList = getTargetOrgList(gapList)/>
                	<#if tarOrgList?has_content>
                		<@com.emptyLine/>
                		<para><emphasis role="bold">Target organisms</emphasis> controlled across the relevant crops are: ${tarOrgList}.
                			<?linebreak?>Detailed information is provided in the next sections.
                		</para>
                	</#if>
                	
                <#elseif selection=="additional info">
                	<@additionalInfoTable gapList/>
                	
                </#if>

            <@com.emptyLine/>

            </#list>
        </#if>
    </#if>

</#macro>


<#macro safetyTable gapList>
	
    <para role="small">
        <table border="1">
        	<col width="17%"/>
        	<col width="16%"/>
        	<col width="10%"/>
        	<col width="10%"/>
        	<col width="10%"/>
        	<col width="10%"/>
        	<col width="10%"/>
        	<col width="17%"/>

			<tbody valign="middle">
                <tr>
                    <th rowspan="2" align="center"><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">Crop</emphasis></th>
                    <th rowspan="2" align="center"><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">PHI</emphasis></th>
                    <th colspan="2" align="center"><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">Re-entry period</emphasis></th>
                    <th rowspan="2" align="center"><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">Witholding period</emphasis></th>
                    <th colspan="2" align="center"><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">Waiting period</emphasis></th>
                    <th rowspan="2" align="center"><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">Restrictions / other information</emphasis></th>
                </tr>

                <tr>
                    <td align="center"><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">livestock</emphasis></td>
                    <td align="center"><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">humans</emphasis></td>
                    <td align="center"><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">handling</emphasis></td>
                    <td align="center"><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">planting</emphasis></td>
                </tr>

	            <#list gapList as gap>
	            
	        		<#local app=gap.PestDiseaseTreated.ApplicationDetails/>
	            	<tr>
	                    <td>${getCrop(gap)}</td>
	                    <td><@com.picklist app.PreharvestInterval/></td>
	                    <td><@com.quantity app.ReentryPeriodLivestock/></td>
	                    <td><@com.quantity app.ReentryPeriod/></td>
		                <td><@com.quantity app.WithholdingPeriod/></td>
		                <td><@com.quantity app.WaitingPeriod/></td>
	                    <td><@com.quantity app.PlantbackInterval/></td>
	                    <td>
	                    	<@com.text app.Restrictions/>
	                    	<#if app.VentilationPractices?has_content><para><@com.text app.VentilationPractices/></para></#if>
	                    </td>
	                </tr>
	            </#list>
            </tbody>
        </table>
    </para>

</#macro>


<#macro applicationRateTable gapList>
		
    <para role="small">
        <table border="1">
        	<col width="15%"/>
        	<col width="12%"/>
        	<col width="12%"/>
        	<col width="12%"/>
        	<col width="12%"/>
        	<col width="12%"/>
        	<col width="25%"/>

			<tbody valign="middle">
                <tr>
                    <th rowspan="2" align="center"><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">Crop</emphasis></th>
                    <th colspan="2" align="center"><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">Application rate per treatment</emphasis></th>
                    <th rowspan="2" align="center"><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">Max. annual appliation rate (a.s.)</emphasis></th>
                    <th rowspan="2" align="center"><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">Water amount / spray volume</emphasis></th>
                    <th rowspan="2" align="center"><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">Conc. of formulation in dilution</emphasis></th>
                    <th rowspan="2" align="center"><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">Remarks</emphasis></th>
                </tr>

                <tr>
                    <td align="center"><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">product</emphasis></td>
                    <td align="center"><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">active substance</emphasis></td>
                </tr>
            
	            <#list gapList as gap>
	            
	        		<#local app=gap.PestDiseaseTreated.ApplicationDetails/>
	            	<tr>
	                    <td>${getCrop(gap)}</td>
		            	<td><@com.range app.ApplicationRatePerTreatment/></td>
		            	<td><@com.range app.ApplicationRateForTarget/></td>
		            	<td><@com.range app.SeasonalAplication/></td>
			            <td><@com.range app.WaterAmountPerTreatment/></td>
			            <td><@com.range app.ConcentrationFormulationDilution/></td>
	                   	<td>
	                   		<@com.text app.RemarksOnApplicationRate/>
	                   		
	                   		<#if app.NonTargetAS?has_content>${getNTasRate(gap)}</#if>
	                   		
	                   		<#if app.SafenerSynergistAdjuvant?has_content>
	                   			<#local ssa><@com.picklist picklistValue=app.SafenerSynergistAdjuvant printRemarks=false printDescription=false/></#local>
	                   			<#if ssa!="no"><para>Safener / synergist / adjuvant: <@com.picklist app.SafenerSynergistAdjuvant/></para></#if>
	                   		</#if>
	                   	</td>
	                </tr>
	            </#list>
            </tbody>
        </table>
    </para>

</#macro>


<#macro applicationMethodTable gapList>
		
    <para role="small">
        <table border="1">

            <tbody valign="middle">
                <tr>
                    <th align="center"><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">Crop</emphasis></th>
                    <th align="center"><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">Type of method</emphasis></th>
                    <th align="center"><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">Target</emphasis></th>
                    <th align="center"><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">Equipment</emphasis></th>
                    <#--  <th align="center"><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">Water amount / spray volume</emphasis></th>--><#-- this is repeated from above section -->
                    <th align="center"><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">Other information</emphasis></th>
                </tr>
            
	            <#list gapList as gap>
	            
	        		<#local app=gap.PestDiseaseTreated.ApplicationDetails/>
	            	<tr>
	                    <td>${getCrop(gap)}</td>
		            	<td><@com.picklistMultiple app.ApplicationMethod/></td>
						<td><@com.picklist picklistValue=app.ApplicationTarget printDescription=false/></td>
			            <td><@com.picklistMultiple app.ApplicationEquipment/></td>    
			            <#--<td><@com.range app.WaterAmountPerTreatment/></td>-->
			            <td>
			            	<#if app.MaxSeedingRate?has_content>Max. seeding rate: <@com.text app.MaxSeedingRate/></#if>
			            	<#if app.PlantingDensity?has_content>
			            		<#if app.MaxSeedingRate?has_content><para></#if>
			            		Planting density: <@com.text app.PlantingDensity/>
			            		<#if app.MaxSeedingRate?has_content></para></#if>
			            	</#if>
			            </td>
	                </tr>
	            </#list>
            </tbody>
        </table>
    </para>

</#macro>

<#macro applicationNumberTable gapList>
		
    <para role="small">
        <table border="1">
        
        	<col width="18%" />
            <col width="10%" />
            <col width="15%" />
            <#-- <col width="10%" /> -->
            <col width="21%" />
            <col width="21%" />
            <col width="15%" />

            <tbody valign="middle">
                <tr>
                    <th rowspan="2" align="center"><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">Crop</emphasis></th>
                    <th rowspan="2" align="center"><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">No applications</emphasis></th>
                    <th rowspan="2" align="center"><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">Re-treatment interval (d) and treatment window for dispensers</emphasis></th>
                    <#-- <th rowspan="2" align="center"><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">Treatment window dispensers</emphasis></th> -->
                    <th colspan="3" align="center"><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">Growth stage of crop</emphasis></th>
                </tr>
                
                <tr>
                    <td align="center"><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">first application</emphasis></td>
                    <td align="center"><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">last application</emphasis></td>
                    <td align="center"><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">season</emphasis></td>
                </tr>
            
	            <#list gapList as gap>
	            
	        		<#local app=gap.PestDiseaseTreated.ApplicationDetails/>
					
					<#local growthSize = app.GrowthStageAndSeason?size/>
					<#if (growthSize>0)>
						<#local rowSize=growthSize/>
					<#else>
						<#local rowSize=1/>
					</#if>
					
					<#local usespan=true/>
					<#list 1..rowSize as i>
						<#--<#local rowSize = [1, growthSize]?max/>-->
		            	<tr>
		                    <#if usespan>
		                    	<td rowspan="${rowSize}" >${getCrop(gap)}</td>
			            		<td rowspan="${rowSize}"><@com.range app.ApplicationsRange/></td>
								<td rowspan="${rowSize}">
									<@com.range app.RetreatmentInterval/>
									<#if app.TreatmentWindowDispensers?has_content>
										<para>
											<#-- Dispenser treatment window:  -->
											<@com.text app.TreatmentWindowDispensers/>
										</para>
									</#if>
								</td>
			            		<#local usespan=false/>
			            	</#if>
			            	<td><#if app.GrowthStageAndSeason?has_content><@com.picklist app.GrowthStageAndSeason[i-1].GrowthStageCropFirst/></#if></td>
			            	<td><#if app.GrowthStageAndSeason?has_content><@com.picklist app.GrowthStageAndSeason[i-1].GrowthStageCropLast/></#if></td>
			            	<td><#if app.GrowthStageAndSeason?has_content><@com.picklistMultiple app.GrowthStageAndSeason[i-1].TreatmentSeason/></#if></td>
		                </tr>
		            </#list>
	            </#list>
            </tbody>
        </table>
    </para>

</#macro>

<#macro targetOrgsTable gapList>
		
    <para role="small">
        <table border="1">
        
        	<col width="20%" />
        	<col width="20%" />
            <col width="30%" />
            <col width="30%" />

			<tbody valign="middle">
                <tr>
                    <th align="center"><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">Crop</emphasis></th>
                    <th align="center"><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">Organism</emphasis></th>
                    <th align="center"><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">Development stage of target pest</emphasis></th>
                    <th align="center"><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">Development stage of target plant</emphasis></th>
                </tr>
            
	            <#list gapList as gap>
	            
	        		<#local tar=gap.PestDiseaseTreated.TargetOrganisms/>
					
					<#if tar?has_content>
						<#local rowSize = tar?size/>
						<#local usespan=true/>
						
						<#list tar as org>
		            		<tr>
			                    <#if usespan>
			                    	<td rowspan="${rowSize}" >${getCrop(gap)}</td>
				            		<#local usespan=false/>
				            	</#if>
				            	<td>
				            		<#if org.ScientificName?has_content><@com.picklist org.ScientificName/>
				            			<#if org.CommonName?has_content>(<@com.text org.CommonName/>)</#if>
				            		<#else>
				            			<@com.text org.CommonName/>
				            		</#if>
				            	</td>
				            	<td><@com.picklistMultiple org.DevelopmentStagePest/></td>
				            	<td><@com.picklistMultiple org.DevelopmentStagePlant/></td>
			                </tr>
		            	</#list>
		            	
		            </#if>
	            </#list>
            </tbody>
        </table>
    </para>

</#macro>

<#macro intendedUseTable gapList>
		
    <para role="small">
        <table border="1">
        	<col width="20%"/>
        	<col width="15%"/>
            <col width="25%"/>
            <col width="25%"/>
            <col width="15%"/>
            
            <tbody valign="middle">
                <tr>
                    <th align="center"><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">Crop</emphasis></th>
                    <th align="center"><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">Use and user</emphasis></th>
                    <#-- <th align="center"><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">Purpose</emphasis></th>-->
                    <th align="center"><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">Destination</emphasis></th>
                    <th align="center"><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">Location</emphasis></th>
                    <#--  <th align="center"><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">Major / minor use and user</emphasis></th>-->
                    <#--  <th align="center"><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">User</emphasis></th>-->
                    <th align="center"><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">Authorisation and MRL zone</emphasis></th>
                    <#-- <th align="center"><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">MRL zone</emphasis></th> -->
                    <#-- <th align="center"><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">Other information</emphasis></th>-->
                </tr>

            
	            <#list gapList as gap>
	            
					
	            	<tr>
	                    <td>${getCrop(gap)}</td>
	                    <td>${getPurpose(gap)}
	                    	<#if gap.PestDiseaseTreated.MajorMinorUse?has_content><para><@com.picklist gap.PestDiseaseTreated.MajorMinorUse/></para></#if>
	                		<#if gap.PestDiseaseTreated.ApplicationDetails.TypeOfUser?has_content>
	                			<para>user: <@com.picklistMultiple gap.PestDiseaseTreated.ApplicationDetails.TypeOfUser/></para>
	                		</#if>
	                    </td>
	                	<td><@com.picklistMultiple gap.KeyInformation.CropInformation.CropDestination/></td>  
	                	<td><@com.picklistMultiple gap.KeyInformation.CropInformation.CropLocation /></td>  
	                	<#-- <td>
	                		<@com.picklist gap.PestDiseaseTreated.MajorMinorUse/>
	                		<#if gap.PestDiseaseTreated.ApplicationDetails.TypeOfUser?has_content>
	                			<para>User: <@com.picklistMultiple gap.PestDiseaseTreated.ApplicationDetails.TypeOfUser/></para>
	                		</#if>
	                	</td>-->  
		            	<td>${getMScountry(gap)}</td>	
		            	<#-- <td><@com.richText gap.KeyInformation.field9074/></td>-->
	                </tr>
	            </#list>
            </tbody>
        </table>
    </para>

</#macro>

<#macro keyInfoTable gapList>
		
    <para role="small">
        <table border="1">
        	<col width="25%"/>
        	<col width="75%"/>
            
            <tbody valign="middle">
                <tr>
                    <th align="center"><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">Crop</emphasis></th>
                    <th align="center"><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">Key information</emphasis></th>
                </tr>

	            <#list gapList as gap>
	            	<#if gap.KeyInformation.field9074?has_content>	
		            	<tr>
		                    <td>${getCrop(gap)}</td>
			            	<td><@com.richText gap.KeyInformation.field9074/></td>
		                </tr>
		            </#if>
	            </#list>
            </tbody>
        </table>
    </para>

</#macro>

<#macro additionalInfoTable gapList>
		
    <para role="small">
        <table border="1">
        
        	<col width="25%"/>
        	<col width="75%"/>
        	
            <tbody valign="middle">
                <tr>
                    <th align="center"><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">Crop</emphasis></th>
                    <th align="center"><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">Additional information</emphasis></th>
                </tr>

	            <#list gapList as gap>
	            					
					<#if gap.AdditionalInformation.field7935?has_content>
		            	<tr>
		                    <td>${getCrop(gap)}</td>
			            	<td><@com.richText gap.AdditionalInformation.field7935/></td>
		                </tr>
		            </#if>
	            </#list>
            </tbody>
        </table>
    </para>

</#macro>
  
<#macro envisagedUse subject>
	
	<#local gapList = iuclid.getSectionDocumentsForParentKey(subject.documentKey, "FLEXIBLE_RECORD", "GAP") />
	<#local compList = iuclid.getSectionDocumentsForParentKey(subject.documentKey, "FLEXIBLE_RECORD", "MixtureComposition") />
	
	<#local mixName><@com.text subject.MixtureName/></#local>
	<#local asList = com.getComponents(subject, "active substance") />
    <#if asList?has_content>
         <#local actSub = asList[0]/>
    </#if>
    <#local destination = getCropDestination(gapList)/>
    <#local compHash=getCompHash(compList, actSub)/>
	<para><emphasis role="bold">${mixName}</emphasis> (
		<#list compHash as compName, compProps>
			<#if (compHash?keys?size > 1)>${compName}<#if compProps['type']?has_content>:</#if></#if> 
			${compProps['type']}
			<#if compName?has_next>/</#if>
		</#list>) 
		<#if actSub?has_content>contains the active substance <emphasis role="bold"><@com.text actSub.ChemicalName/></emphasis> (
			<#list compHash as compName, compProps>
				<#if (compHash?keys?size > 1)>${compName}<#if compProps['conc']?has_content>:</#if></#if> 
				${compProps['conc']}
				<#if compName?has_next>/</#if>
			</#list>)
		</#if>
		<#if destination?has_content>and is to be used for ${destination}.</#if>
	</para>
	<para>Details on the uses, the crops protected and the targeted organisms are provided in the sections below.</para>
</#macro>

<#function getCompHash compList actSub>
	<#local compHash={}/>
	
	<#list compList as comp>
		<#local compName><@com.text comp.GeneralInformation.Name/></#local>
		<#local compType><@com.picklistMultiple comp.GeneralInformation.FormulationType/></#local>
		<#list comp.Components.Components as co>
			<#local function><@com.picklist co.Function/></#local>
			<#if function=="active substance" && co.Reference?has_content && co.TypicalConcentration?has_content>
				<#local coAS = iuclid.getDocumentForKey(co.Reference)/>
				<#if coAS.hasElement("ChemicalName") && coAS.ChemicalName==actSub.ChemicalName>
					<#local conc><@com.range co.TypicalConcentration/></#local>
					 
					<#local compEntry = {'name': compName, 'type':compType, 'conc': conc}/>
					<#local compHash = compHash + {compName:compEntry}/> 
				</#if>
			</#if>
		</#list>
	</#list>
		
	<#return compHash/>
</#function>

<#function getCropDestination gapList>

	<#local destList=[]/>
	<#list gapList as gap>
		<#if gap.KeyInformation.CropInformation.CropDestination?has_content>
		
			<#list gap.KeyInformation.CropInformation.CropDestination as destPath>
				<#local destVal><@com.picklist picklistValue=destPath printDescription=true printRemarks=false/></#local>
				<#local destVal=destVal?replace("^grown for ", "", "r")/>
				<#if !destList?seq_contains(destVal)><#local destList = destList + [destVal]/></#if>
			</#list>
		</#if>
	</#list>

	<#return destList?join(", ")/>
</#function>

<#--Function to transform the GAP list into a hashMap of product compositions to gap documents e.g. {prod1:[gap1, gap2], prod2:[gap3,gap4]...}    -->
<#function getGapDhash gapList type="">

    <#local gapDhash={}/>

    <#list gapList as gap>

        <#if isDtype(gap, type)>

            <#--identify mixture composition-->
            <#if gap.AdministrativeDataSummary.Product?has_content>
                <#local product=iuclid.getDocumentForKey(gap.AdministrativeDataSummary.Product)/>
                <#local productId=product.documentKey.uuid/>

                <#--add to correspoding hashMap-->
                <#if gapDhash[productId]??>
                    <#local gapDProdList = gapDhash[productId] + [gap]/>
                <#else>
                    <#local gapDProdList=[gap]/>
                </#if>

                <#local gapDhash = gapDhash + {productId : gapDProdList}/>
            </#if>
        </#if>
    </#list>
    <#return gapDhash/>
</#function>


<#--Function to categorize D documents-->
<#function isDtype gap type="">

    <#if _subject.submissionType?matches(".*MAXIM.*", "i") || type=="">
        <#return true>

    <#else>

        <#local purpose><@com.picklistMultiple gap.KeyInformation.PurposeOfTheGAP.ActiveSubstanceMicroorganismBasicSubstanceApplications/></#local>

        <#if purpose?contains(type) || ((!purpose?has_content) && type=="D1")>
            <#return true>
        <#else>
        <#--<#if (!purpose?has_content) && type=="D1">
            <#return true>
        <#else>-->
            -           <#return false>
        <#--</#if>-->
        </#if>
    </#if>
</#function>

<#--Function to extract the doc url-->
<#function getDocUrl _subject doc>

    <#local docUrl=iuclid.webUrl.documentView(doc.documentKey) />

    <#return docUrl>
</#function>

<#function getCrop gap printGM=false>
	
	<#local gapUrl=getDocUrl(_subject, gap)/>
	
	<#local cropText>
		<#compress>
			<ulink url="${gapUrl}">
			<#if gap.KeyInformation.CropInformation.Crop?has_content>
				
		        <#escape x as x?html>
		            <#list gap.KeyInformation.CropInformation.Crop as crop>		                
		                <#local cropPhrase = iuclid.localizedPhraseDefinitionFor(crop.code, 'en') />
		                <#if cropPhrase.open && crop.otherText?has_content>
		                    <#local cropName><@com.text crop.otherText/></#local>
		                <#elseif cropPhrase.text=="other:">
		                	<#local cropName><@com.text crop.remarks/></#local>
		                <#else>
		                    <#local eppoMatch=cropPhrase.text?matches("^[0-9]*[A-Z]{4,6}")/>
		
		                    <#local cropName=cropPhrase.text?replace("^[0-9]*[A-Z]{4,6}( - )*", "", "r")?replace("( - )*[0-9,]{5,50}$", "", "r")/>
		
		                    <#if (cropName?starts_with(" (") || cropName?starts_with("(")) && (cropName?ends_with(") ") || cropName?ends_with(")"))>
		                        <#local cropName=cropName?replace("^( )*\\(", "", "r")?replace("\\)( )*$", "", "r")/>
		                    </#if>
		
		                    <#if eppoMatch?has_content><#local cropName=cropName + " (" + eppoMatch[0] + ")"/></#if>
		                </#if>
		                ${cropName}
		                <#if crop?has_next>;</#if>
		                <?linebreak?>
		            </#list>
		        </#escape>
		     </#if>
		     
		     <#if gap.KeyInformation.CropInformation.GeneticalModification?has_content>
                    <#if com.picklistValueMatchesPhrases(gap.KeyInformation.CropInformation.GeneticalModification, [".*yes.*"])>
                        <?linebreak?>
                        <#if printGM>
                        	genetically modified<#if gap.KeyInformation.CropInformation.GeneticalModification.remarks?has_content>: <@com.text gap.KeyInformation.CropInformation.GeneticalModification.remarks/></#if>
                        <#else>
                        	(genetically modified)
                        </#if>
                    </#if>
             </#if>
                
             </ulink>
		   </#compress>
	</#local>
	<#return cropText/>
</#function>

<#function getMScountry gap printMRL=true>

	<#local MScountryText><#compress>
		<#local addParenthesis=false/>
		<#if gap.KeyInformation.CropInformation.AuthorisationZone?has_content>
		    <@com.picklist gap.KeyInformation.CropInformation.AuthorisationZone/>
		    <#local addParenthesis=true/>
		</#if>
		<#if gap.KeyInformation.CropInformation.CountryOrTerritory?has_content>
		    <#escape x as x?html>
		        <#list gap.KeyInformation.CropInformation.CountryOrTerritory as country>
		            <#local countryPhrase = iuclid.localizedPhraseDefinitionFor(country.code, 'en') />
					
					<#if countryPhrase.description?has_content>
		            	<#local countryName=countryPhrase.description/>
		            <#elseif country.otherText?has_content>
		            	<#local countryName><@com.text country.otherText/></#local>
		            <#else>
		            	<#local countryName=countryPhrase.text/> 
		            </#if>
		            <#if addParenthesis && country_index==0>(</#if>${countryName}<#if country_has_next>;<#else><#if addParenthesis>)</#if></#if>
		        </#list>
		    </#escape>
		</#if>
		
		<#if gap.KeyInformation.CropInformation.MrlZone?has_content>
			<#if printMRL><para>[MRL zone: <@com.picklist gap.KeyInformation.CropInformation.MrlZone/>]</para></#if><#-- is this relevant? -->
		</#if>
	</#compress></#local>
	
	<#return MScountryText/>
</#function>

<#function getNTasRate gap>
	
	<#local NTasText><#compress>
		<#if gap.PestDiseaseTreated.ApplicationDetails.NonTargetAS?has_content>
			<para> Non-target a.s.:
		        <#list gap.PestDiseaseTreated.ApplicationDetails.NonTargetAS as ntasEntry>
		            <#local ntas = iuclid.getDocumentForKey(ntasEntry.NonTargetAS)/>
		            <@com.text ntas.ReferenceSubstanceName/>
		            <#if ntasEntry.ApplicationRatePerTreatmentForOtherASRange?has_content || ntasEntry.MaximumAnnualApplicationRateForOtherAS?has_content>
		                (
		                <#if ntasEntry.ApplicationRatePerTreatmentForOtherASRange?has_content>
		                    rate:<@com.range ntasEntry.ApplicationRatePerTreatmentForOtherASRange/>.
		                </#if>
		                <#if ntasEntry.MaximumAnnualApplicationRateForOtherAS?has_content>
		                    max. annual:<@com.range ntasEntry.MaximumAnnualApplicationRateForOtherAS/>.
		                </#if>
		                )
		            </#if>
		            <#if ntasEntry_has_next>;</#if>
		        </#list>
		    </para>
		</#if>
	</#compress></#local>
	
	<#return NTasText/>
	
    <#-- old -->
    <#--                
    <para>Application rate non target a.s.
		<#list app.NonTargetAS as ntas>
			<#local ntasubstance = iuclid.getDocumentForKey(ntas.NonTargetAS)/>
			
			<#if ntasubstance?has_content>
				<#if (app.NonTargetAS?size==1)>
					<@com.text ntasubstance.ReferenceSubstanceName/>: 
				<#else>
					<?linebreak?>- <@com.text ntasubstance.ReferenceSubstanceName/>:
				</#if>
				
				<@com.range ntas.ApplicationRatePerTreatmentForOtherASRange/>
				<#if ntas.MaximumAnnualApplicationRateForOtherAS?has_content>(max. annual: <@com.range ntas.MaximumAnnualApplicationRateForOtherAS/>)</#if>	
			</#if>
		</#list>
    </para>
    -->
</#function>

<#function getGrowthStage gap>

	<#local app=gap.PestDiseaseTreated.ApplicationDetails/>
	
	<#local growthStageText>
		<#compress>
			<#if app.GrowthStageAndSeason?has_content>
			    <#list app.GrowthStageAndSeason as growth>
			
			        <#local sfPhrase=iuclid.localizedPhraseDefinitionFor(growth.GrowthStageCropFirst.code, 'en')/>
			        <#local sfBBCH=false>
			        <#local stageFirst>
			            <#if sfPhrase?has_content>
			                <#if sfPhrase.open && growth.GrowthStageCropFirst.otherText?has_content>
			                    ${growth.GrowthStageCropFirst.otherText}<#t>
			                <#else>
			                    ${sfPhrase.text?replace(" - .*", "", "r")}<#t>
			                    <#if !(sfPhrase.text?matches(".*not applicable.*"))>
			                        <#local sfBBCH=true>
			                    </#if>
			                </#if>
			            </#if>
			        </#local>
			
			        <#local slPhrase=iuclid.localizedPhraseDefinitionFor(growth.GrowthStageCropLast.code, 'en')/>
			        <#local slBBCH=false>
			        <#local stageLast>
			            <#if slPhrase?has_content>
			                <#if slPhrase.open && growth.GrowthStageCropLast.otherText?has_content>
			                    ${growth.GrowthStageCropLast.otherText}<#t>
			                <#else>
			                    ${slPhrase.text?replace(" - .*", "", "r")}<#t>
			                    <#if !(slPhrase.text?matches(".*not applicable.*"))>
			                        <#local slBBCH=true>
			                    </#if>
			                </#if>
			            </#if>
			        </#local>
			
			        <para>
			            <#if stageFirst?has_content && sfBBCH>BBCH </#if>
			            ${stageFirst}
			            <#if stageLast?has_content && stageFirst?has_content> - </#if>
			            <#if (stageLast?has_content && slBBCH) && !(stageFirst?has_content && sfBBCH)>BBCH </#if>
			            ${stageLast}
			
			            <#if growth.TreatmentSeason?has_content> (<@com.picklistMultiple growth.TreatmentSeason/>)</#if>
			        </para>
	
			    </#list>
			</#if>
		</#compress>
	</#local>
	<#return growthStageText/>
</#function>

<#function getCropLocation gap>

	<#local cropLocation=[]/>
    <#if gap.KeyInformation.CropInformation.CropLocation?has_content>
        <#list gap.KeyInformation.CropInformation.CropLocation as cropLoc>
            <#local locPhrase = iuclid.localizedPhraseDefinitionFor(cropLoc.code, 'en') />
            <#if locPhrase?has_content>
                <#local locPhrase><#escape x as x?html>${locPhrase.text?substring(0,1)}</#escape></#local>
                <#if !cropLocation?seq_contains(locPhrase)>
                    <#local cropLocation = cropLocation + [locPhrase]/>
                </#if>
            </#if>
        </#list>
    </#if>
    
    <#return cropLocation?join(", ")>
</#function>

<#function getTargetOrgList gapList>

	<#local targetOrgDict = {}/>
	
	<#list gapList as gap>
	
		<#if gap.PestDiseaseTreated.TargetOrganisms?has_content>
			<#list gap.PestDiseaseTreated.TargetOrganisms as org>
			
				<#local sciName><@com.picklist picklistValue=org.ScientificName printRemarks=false/></#local>
				<#local comName><@com.text org.CommonName/></#local>
				<#local orgName>
					<#compress>
						<#if sciName?has_content>${sciName}
						<#elseif comName?has_content>${comName}
						</#if>
					</#compress>
				</#local>
				
				<#if orgName?has_content>
					
					<#local comNameList=[comName]/>
					 
					<#if targetOrgDict?keys?seq_contains(orgName) && orgName!=comName>
						
						<#if comName?has_content>
							
							<#local oldComNameList = targetOrgDict[orgName]/>
							
							<#if oldComNameList?has_content && (!oldComNameList?seq_contains(comName))>
								<#local comNameList = oldComNameList + [comName]/>
						  	</#if>
						</#if>
					</#if>
					 
					<#local newTarOrg = {orgName : comNameList}/>
					
					<#local targetOrgDict = targetOrgDict + newTarOrg/>
				
				</#if>
			</#list>
		</#if>
		
	</#list>
	
	<#local targetOrgs>
		<#compress>
			<#list targetOrgDict?keys as tarOrg>
				${tarOrg}
				<#local tarOrgComName = targetOrgDict[tarOrg]?join("; ")/>
				<#if tarOrgComName?has_content>(${tarOrgComName})</#if>
				<#if tarOrg?has_next>, </#if>
			</#list>
		</#compress>
	</#local>
	
	<#return targetOrgs>
</#function>

<#function getTargetOrgs gap>

	<#local targetOrgsText><#compress>
	
		<#list gap.PestDiseaseTreated.TargetOrganisms as targOrg>
	        <para>
		        <#local pestSci><@com.picklist targOrg.ScientificName/></#local>
		        <#local pestCom><@com.text targOrg.CommonName/></#local>
		
		        ${pestCom}
		        <#if pestCom?has_content && pestSci?has_content>(</#if>${pestSci}<#if pestCom?has_content && pestSci?has_content>)</#if>
	        </para>
	    </#list>
	</#compress></#local>
	<#return targetOrgsText>
</#function>

<#function getMethodTypeOnTarget gap>
	<#local app=gap.PestDiseaseTreated.ApplicationDetails/>

	<#local methodText><#compress>
        <#if app.ApplicationMethod?has_content>
            <#escape x as x?html>
                <#list app.ApplicationMethod as method>
                    <#local methodPhrase = iuclid.localizedPhraseDefinitionFor(method.code, 'en') />
                    <#if methodPhrase.open && method.otherText?has_content>
                        <#local methodName=method.otherText/>
                    <#elseif methodPhrase.text=="other:">
                    	<#local methodName=method.remarks/>
                    <#else>
                        <#local methodName=methodPhrase.text/>
                    </#if>
                    ${methodName}<#if method_has_next> / </#if>
                </#list>
            </#escape>
        </#if>

        <#if app.ApplicationTarget?has_content>
            <#local targetPhrase = iuclid.localizedPhraseDefinitionFor(app.ApplicationTarget.code, 'en') />
            <#if targetPhrase.open && app.ApplicationTarget.otherText?has_content>
                <#local targetName=app.ApplicationTarget.otherText/>
            <#elseif targetPhrase.text=="other:">
                <#local targetName=app.ApplicationTarget.remarks/>    
            <#else>
                <#local targetName=targetPhrase.text/>
            </#if>
            on ${targetName}
        </#if>
    </#compress></#local>
    
    <#return methodText/>
</#function>

<#function getPurpose gap>
	<#local fullPurpose><@com.picklistMultiple gap.KeyInformation.PurposeOfTheGAP.ActiveSubstanceMicroorganismBasicSubstanceApplications/></#local>
	<#local purposes=[]/>
	
	<#if fullPurpose?contains("D1")><#local purposes = purposes + ["intended use"]/></#if>
	<#if fullPurpose?contains("D2")><#local purposes = purposes + ["authorised use"]/></#if>
	<#if fullPurpose?contains("D3")><#local purposes = purposes + ["intended use (data to be provided)"]/></#if>

	<#return purposes?join(";")/>
</#function>

<#function hasKeyInfo gapList>
	<#list gapList as gap>
		<#if gap.KeyInformation.field9074?has_content>
			<#return true/>
		</#if>
	</#list>
	<#return false/>
</#function>

<#function hasAddInfo subject>
	<#local gapList = iuclid.getSectionDocumentsForParentKey(subject.documentKey, "FLEXIBLE_RECORD", "GAP") />
	<#list gapList as gap>
		<#if gap.hasElement("AdditionalInformation.field7935") && gap.AdditionalInformation.field7935?has_content>
			<#return true/>
		</#if>
	</#list>
	<#return false/>
</#function>


<#macro GAPsummary _subject selectedDoc="">

    <#local gapFullList = iuclid.getSectionDocumentsForParentKey(_subject.documentKey, "FLEXIBLE_RECORD", "GAP") />

    <#if gapFullList?has_content>
        <#--initialize hashMap with GAP data-->
        <#local gapDhash=getGapDhash(gapFullList, selectedDoc)/>
<#--        <@populateGapDhash gapFullList/>-->

<#--        <#list gapDhash?keys as docDtype>-->
<#--            <#if !(selectedDoc?has_content) || docDtype==selectedDoc>-->
<#--                <#if gapDhash[docDtype]?has_content>-->
        <#if gapDhash?has_content>

<#--            <#list gapDhash[docDtype]?keys as prodKey>-->
            <#list gapDhash?keys as prodKey>
                <section>

<#--                        <#local product=iuclid.getDocumentForKey(prodKey)/>-->
<#--                    <#assign gapList=gapDhash[docDtype][prodKey]/>-->
                    <#local gapList=gapDhash[prodKey]/>

                    <#local product=iuclid.getDocumentForKey(gapList[0].AdministrativeDataSummary.Product)/>
                    <#local docUrl=getDocUrl(_subject, product)/>

<#--                    <title>Product <#if (gapDhash[docDtype]?keys?size > 1 )>${prodKey_index+1}</#if>:-->
                    <title>Product <#if (gapDhash?keys?size > 1 )>${prodKey_index+1}</#if>:
                            <ulink url="${docUrl}"><@com.text product.GeneralInformation.Name/></ulink>
                    </title>

                    <#-- Get mixture composition, with safeners and synergists, if any-->
                    <@com.emptyLine/>

                    <para>
                        <emphasis role="bold">Characteristics of the mixture composition:</emphasis>
                        <para role="indent">
                            <@mixtureComposition _subject product/>
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

                            <thead align="center" valign="middle">

                            <tr>
                                <th rowspan="2"><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">Crop /<?linebreak?>situation</emphasis></th>
                                <th rowspan="2"><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">MS /<?linebreak?>country</emphasis></th>
                                <th rowspan="2"><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">F, G<?linebreak?>or I</emphasis></th>
                                <th rowspan="2"><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">Pests controlled</emphasis></th>
                                <th colspan="4"><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">Application</emphasis> </th>
                                <th colspan="3"><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">Application rate per treatment</emphasis></th>
                                <th rowspan="2"><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">PHI</emphasis></th>
                                <th rowspan="2"><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold">Remarks</emphasis></th>
                            </tr>

                            <tr>
                                <td><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold" >Method /<?linebreak?>kind </emphasis></td>
                                <td><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold" >Growth stage<?linebreak?>and season</emphasis></td>
                                <td><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold" >No</emphasis></td>
                                <td><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold" >Interval</emphasis></td>
                                <td><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold" >A.s.</emphasis></td>
                                <td><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold" >Water</emphasis></td>
                                <td><?dbfo bgcolor="#d3d3d3" ?><emphasis role="bold" >Conc. dilution</emphasis></td>

                            </tr>
                            </thead>

                            <tbody valign="middle">
                            <#-- Iterate over gap documents of this product and D document-->
<#--                            <#assign gapList=gapDhash[docDtype][prodKey]/>-->

                            <#list gapList as gap>
                                <@tableRow _subject gap/>
                            </#list>
                            </tbody>
                        </table>
                    </para>
                </section>
                <@com.emptyLine/>

            </#list>
        </#if>
    </#if>
</#macro>

<#macro tableRow _subject gap>
    <#compress>

        <tr>
            <#--Crop and/or situation, and link to document-->
            <td>
                <#local gapUrl=getDocUrl(_subject, gap)/>
                <ulink url="${gapUrl}">
<#--                     <@com.picklistMultiple gap.KeyInformation.CropInformation.Crop/>-->
                    <#if gap.KeyInformation.CropInformation.Crop?has_content>
                        <#escape x as x?html>
                            <#list gap.KeyInformation.CropInformation.Crop as crop>
                                <para>
                                <#local cropPhrase = iuclid.localizedPhraseDefinitionFor(crop.code, 'en') />
                                <#if cropPhrase.open && crop.otherText?has_content>
                                    <#local cropName=crop.otherText/>
                                <#else>
                                    <#--get EPPO code-->
                                    <#local eppoMatch=cropPhrase.text?matches("^[0-9]*[A-Z]{4,6}")/>

                                    <#--remove numeric and EPPO code-->
                                    <#local cropName=cropPhrase.text?replace("^[0-9]*[A-Z]{4,6}( - )*", "", "r")?replace("( - )*[0-9,]{5,50}$", "", "r")/>

                                    <#if (cropName?starts_with(" (") || cropName?starts_with("(")) && (cropName?ends_with(") ") || cropName?ends_with(")"))>
                                        <#local cropName=cropName?replace("^( )*\\(", "", "r")?replace("\\)( )*$", "", "r")/>
                                    </#if>

                                    <#--add EPPO-->
                                    <#if eppoMatch?has_content><#local cropName=cropName + " (" + eppoMatch[0] + ")"/></#if>
                                </#if>
                                ${cropName}
<#--                                    <#if crop_has_next>;</#if>-->
                                </para>
                            </#list>
                        </#escape>
                    </#if>
                </ulink>
                <#if gap.KeyInformation.CropInformation.GeneticalModification?has_content>
                    <#if com.picklistValueMatchesPhrases(gap.KeyInformation.CropInformation.GeneticalModification, [".*yes.*"])>
                        <para>genetic modification: ${gap.KeyInformation.CropInformation.GeneticalModification.remarks}</para>
                    </#if>
                </#if>

            </td>

            <#--Member State or Country-->
            <td>
                <#--<@com.picklistMultiple gap.KeyInformation.CropInformation.CountryOrTerritory/>-->
                <#local addParenthesis=false/>
                <#if gap.KeyInformation.CropInformation.AuthorisationZone?has_content>
                    <@com.picklist gap.KeyInformation.CropInformation.AuthorisationZone/>
                    <#local addParenthesis=true/>
                </#if>
                <#if gap.KeyInformation.CropInformation.CountryOrTerritory?has_content>
<#--                    <#if addParenthesis>(</#if>-->
                    <#escape x as x?html>
                        <#list gap.KeyInformation.CropInformation.CountryOrTerritory as country>
                            <#local countryPhrase = iuclid.localizedPhraseDefinitionFor(country.code, 'en') />

                            <#local countryName=countryPhrase.description>
                            <#if addParenthesis && country_index==0>(</#if>${countryName}<#if country_has_next>;<#else><#if addParenthesis>)</#if></#if>
                        </#list>
                    </#escape>
<#--                    <#if addParenthesis>)</#if>-->
                </#if>
            </td>

            <#-- F, G or I-->
            <td>
                <#--                        <@com.picklist gap.KeyInformation.CropInformation.CropLocation/>-->
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
                <#if cropLocation?has_content>${cropLocation?join(", ")}</#if>
            </td>

            <#--Pests or group of pests controlled-->
            <td>
                <#list gap.PestDiseaseTreated.TargetOrganisms as targOrg>
                    <para>
                    <#local pestSci><@com.picklist targOrg.ScientificName/></#local>
                <#--                                <#local pestSci=pestSci?replace(" \\([A-Z]{6}\\)", "", "r")/>-->
                    <#local pestCom><@com.text targOrg.CommonName/></#local>

                    ${pestCom}
                    <#if pestCom?has_content && pestSci?has_content>[</#if>
                    ${pestSci}
                    <#if pestCom?has_content && pestSci?has_content>]</#if>

<#--                    <#if targOrg_has_next>;<?linebreak?></#if>-->
                    </para>
                </#list>
            </td>

            <#-- Application-->
            <#local app=gap.PestDiseaseTreated.ApplicationDetails/>

            <#-- 1. method kind-->
            <td>
                <#--<@com.picklistMultiple app.ApplicationMethod/>-->
                <#if app.ApplicationMethod?has_content>
                    <#escape x as x?html>
                        <#list app.ApplicationMethod as method>
                            <#local methodPhrase = iuclid.localizedPhraseDefinitionFor(method.code, 'en') />
                            <#if methodPhrase.open && method.otherText?has_content>
                                <#local methodName=method.otherText/>
                            <#else>
                            <#--<#local methodName=methodPhrase.description/>-->
                                <#local methodName=methodPhrase.text/>
                            </#if>
                            ${methodName}<#if method_has_next> / </#if>
                        </#list>
                    </#escape>
                </#if>

                <#if app.ApplicationTarget?has_content>
                <#--on <@com.picklist app.ApplicationTarget/>-->
                    <#local targetPhrase = iuclid.localizedPhraseDefinitionFor(app.ApplicationTarget.code, 'en') />
                    <#if targetPhrase.open && app.ApplicationTarget.otherText?has_content>
                        <#local targetName=app.ApplicationTarget.otherText/>
                    <#else>
                        <#local targetName=targetPhrase.text/>
                    </#if>
                    on ${targetName}
                </#if>
            </td>

            <#-- 2. range of growth stages and seasons: repeatable block-->
            <td>
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
                        <#--                                <#local stageFirst><@com.picklist growth.GrowthStageCropFirst/></#local>-->
                        <#--                                <#local stageFirst=stageFirst?replace(" - .*", "", "r")/>-->

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
                        <#--                                <#local stageLast><@com.picklist growth.GrowthStageCropLast/></#local>-->
                        <#--                                <#local stageLast=stageLast?replace(" - .*", "", "r")/>-->

                        <para>
                            <#if stageFirst?has_content && sfBBCH>BBCH </#if>
                            ${stageFirst}
                            <#if stageLast?has_content && stageFirst?has_content> - </#if>
                            <#if (stageLast?has_content && slBBCH) && !(stageFirst?has_content && sfBBCH)>BBCH </#if>
                            ${stageLast}

                            <#if growth.TreatmentSeason?has_content> (<@com.picklistMultiple growth.TreatmentSeason/>)</#if>
                        </para>
                        <#--                            <para>between <@com.picklist growth.GrowthStageCropFirst/> and <@com.picklist growth.GrowthStageCropLast/><?linebreak?>-->
                        <#--                                season: <@com.picklistMultiple growth.TreatmentSeason/>-->
                        <#--                            </para>-->
                    </#list>
                </#if>
            </td>

            <#--3. numbermin-max: range-->
            <td>
                <@com.range app.ApplicationsRange/>
            </td>

            <#--4. Interval between application (min)-->
            <td>
                <#if app.RetreatmentInterval?has_content>
                    <@com.range app.RetreatmentInterval/> d
                </#if>
            </td>

            <#--Application rate per treatment-->
            <#--1. A.s. per ha-->
            <td>
                <@com.range app.ApplicationRateForTarget/>
            </td>

            <#--2. Water -->
            <td>
                <@com.range app.WaterAmountPerTreatment/>
            </td>

            <#--3. Concentration in dilution -->
            <td>
                <@com.range app.ConcentrationFormulationDilution/>
            </td>

            <#-- PHI -->
            <td>
                <@com.picklist app.PreharvestInterval/>
            </td>

            <#-- Remarks: rest of fields -->
            <td>
                <#if gap.KeyInformation.CropInformation.CropDestination?has_content>
                    <para>Crop destination: <@com.picklistMultiple gap.KeyInformation.CropInformation.CropDestination/></para>
                </#if>

                <#if app.ApplicationEquipment?has_content>
                    <para>App. equipment: <@com.picklistMultiple app.ApplicationEquipment/></para>
                </#if>

                <#if app.SafenerSynergistAdjuvant?has_content>
                    <para>Safener / synergist / adjuvant added: <@com.picklist app.SafenerSynergistAdjuvant/></para>
                </#if>

                <#if app.SeasonalAplication?has_content>
                    <para>Max. annual app. rate (a.s.): <@com.range app.SeasonalAplication/></para>
                </#if>

                <#if app.NonTargetAS?has_content>
                    <para> Non-target a.s.:
                        <#list app.NonTargetAS as ntasEntry>
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

                <#if app.TreatmentWindowDispensers?has_content>
                    <para>Treatment window: <@com.text app.TreatmentWindowDispensers/></para>
                </#if>

                <#if app.MaxSeedingRate?has_content>
                    <para>Max. seeding rate: <@com.range app.MaxSeedingRate/></para>
                </#if>

                <#if app.PlantingDensity?has_content>
                    <para>Planting density: <@com.text app.PlantingDensity/></para>
                </#if>

                <#if app.ReentryPeriod?has_content>
                    <para>Re-entry period: <@com.quantity app.ReentryPeriod/></para>
                </#if>

                <#if app.ReentryPeriodLivestock?has_content>
                    <para>Re-entry period livestock: <@com.quantity app.ReentryPeriodLivestock/></para>
                </#if>

                <#if app.WithholdingPeriod?has_content>
                    <para>Withholding period: <@com.quantity app.WithholdingPeriod/></para>
                </#if>

                <#if app.WaitingPeriod?has_content>
                    <para>Waiting period: <@com.quantity app.WaitingPeriod/></para>
                </#if>

                <#if app.PlantbackInterval?has_content>
                    <para>Plant-back interval: <@com.quantity app.PlantbackInterval/></para>
                </#if>

                <#if app.VentilationPractices?has_content>
                    <para>Ventilation practices: <@com.text app.VentilationPractices/></para>
                </#if>

                <#if app.Restrictions?has_content>
                    <para>Restrictions: <@com.text app.Restrictions/></para>
                </#if>

                <#local keyInfo><@com.richText gap.KeyInformation.field9074/></#local>
                <#if gap.AdditionalInformation.field7935?has_content || (gap.KeyInformation.field9074?has_content && keyInfo!="authorised use")>
                    <para>NOTE: more information in corresponding GAP document (key/additional information).</para>
                </#if>
            </td>

        </tr>

    </#compress>
</#macro>

<#macro populateGapDhash gapList>

    <#assign gapDhash={"D1":{}, "D2":{}, "D3":{}}/>

    <#list gapList as gap>

        <#--identfy D doc-->
        <#assign gapDtype=getDtype(gap)/>

        <#--identify mixture composition-->
        <#if gap.AdministrativeDataSummary.Product?has_content>
            <#assign product=iuclid.getDocumentForKey(gap.AdministrativeDataSummary.Product)/>
            <#assign productId=product.documentKey.uuid/>

            <#--add to correspoding hashMap-->
            <#if gapDhash[gapDtype][productId]??>
                <#assign gapDProdList = gapDhash[gapDtype][productId] + [gap]/>
            <#else>
                <#assign gapDProdList=[gap]/>
            </#if>

            <#assign entry = gapDhash[gapDtype] + {productId : gapDProdList}/>

            <#assign gapDhash = gapDhash + {gapDtype : entry}/>
        </#if>
    </#list>
</#macro>

<#macro mixtureComposition _subject product>
    <#compress>

<#--        <#local docUrl=getDocUrl(_subject, product)/>-->
<#--        <ulink url="${docUrl}"><@com.text product.GeneralInformation.Name/></ulink>-->

        <itemizedlist>
            <listitem>formulation type: <@com.picklistMultiple product.GeneralInformation.FormulationType/></listitem>


            <listitem>active substance: <@mixtureComponent product "active substance"/></listitem>

            <listitem>safeners:
                <#local safeners><@mixtureComponent product "safener"/></#local>
                <#if safeners?has_content>${safeners}<#else>none</#if>
            </listitem>

            <listitem>synergists:
                <#local synergists><@mixtureComponent product "synergist"/></#local>
                <#if synergists?has_content>${synergists}<#else>none</#if>
            </listitem>
        </itemizedlist>

    </#compress>
</#macro>

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

<#function isDtype gap type>
    <#local purpose><@com.picklistMultiple gap.KeyInformation.PurposeOfTheGAP.ActiveSubstanceMicroorganismBasicSubstanceApplications/></#local>
    <#if purpose?contains(type)>
        <#return true>
    <#else>
        <#if (!purpose?has_content) && type=="D1">
            <#return true>
        <#else>
            <#return false>
        </#if>
    </#if>
</#function>

<#--<#function getDtype gap>-->

<#--    &lt;#&ndash; get the type based on picklist; set D1 as default even if not selected. MRL types are not considered.&ndash;&gt;-->
<#--    <#local type><@com.picklistMultiple gap.KeyInformation.PurposeOfTheGAP.ActiveSubstanceMicroorganismBasicSubstanceApplications/></#local>-->
<#--    <#if type?contains("D2")>-->
<#--        <#return "D2">-->
<#--    <#elseif type?contains("D3")>-->
<#--        <#return "D3">-->
<#--    <#else>-->
<#--        <#return "D1">-->
<#--    </#if>-->

<#--&lt;#&ndash;    <#local keyInfo><@com.richText gap.KeyInformation.field9074/></#local>&ndash;&gt;-->
<#--&lt;#&ndash;    <#if keyInfo?matches(".*authori[sz]{1}ed use.*", "i")>&ndash;&gt;-->
<#--&lt;#&ndash;        <#return "D2">&ndash;&gt;-->
<#--&lt;#&ndash;    </#if>&ndash;&gt;-->
<#--&lt;#&ndash;    <#return "D1"/>&ndash;&gt;-->
<#--</#function>-->

<#function getDocUrl _subject doc>

    <#local docUrl=iuclid.webUrl.documentView(doc.documentKey) />

    <#return docUrl>
</#function>

<#function getGapDhash gapList type>

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

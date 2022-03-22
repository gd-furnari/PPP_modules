<#assign residuesContext = { "metabolismPlants" : [{"path": "AdministrativeData.Endpoint",
                                                        "val" : ["metabolism of residues in crops", "metabolism of residues in crops, other"],
                                                        "qual" : "eq",
                                                        "type" : "picklist"}],

                            "metabolismRotationalCrops" : [{"path": "AdministrativeData.Endpoint",
                                                        "val" : ["metabolism of residues in rotational crops"],
                                                        "qual" : "eq",
                                                        "type" : "picklist"}],

                            "magnitudePlants": [{"path": "AdministrativeData.Endpoint", "val" : ["residues in crops (field trials)"],
                                                    "qual" : "eq", "type" : "picklist"}],

                            "magnitudeRotationalCrops": [{"path": "AdministrativeData.Endpoint",
                                                            "val" : ["residues in rotational crops (limited field studies)"],
                                                            "qual" : "eq",
                                                            "type" : "picklist"}]
}/>

<#if workingContext=="CHEM">

    <@keyRes.residuesSummary _subject "ResiduesInFoodAndFeedingstuffs" />

    <sect1>
        <title role="HEAD-2">Storage stability of residues</title>
        <@keyRes.residuesSummary _subject "StabilityResiduesCommodities" />
        <@com.emptyLine/>
        <@keyAppendixE.appendixEstudies _subject "StabilityOfResiduesInStoredCommod" "" "storage stability of residues"/>
    </sect1>

    <?hard-pagebreak?>

    <sect1>
        <title role="HEAD-2">Metabolism, distribution and expression of residues</title>

        <sect2 xml:id="CA621">
            <title role="HEAD-3">Plants</title>
            <#-- <@keyRes.residuesSummary subject=_subject docSubType="MetabolismPlants" selection=["PrimaryCrops"]/> -->
            <#-- <@com.emptyLine/> -->
            <#-- <@keyAppendixE.appendixEstudies _subject "MetabolismInCrops" residuesContext["metabolismPlants"] "metabolism of residues in plants"/> -->
            <@keyRes.residuesSummary subject=_subject docSubType="MetabolismPlants"/>
            <sect3>
                <title role="HEAD-4">Primary crops</title>
                <@keyAppendixE.appendixEstudies _subject "MetabolismInCrops" residuesContext["metabolismPlants"] "metabolism of residues in primary crops" "" true/>
	        </sect3>
	
            <sect3  xml:id="CA6212">
                <title role="HEAD-4">Rotational crops</title>
                <@keyAppendixE.appendixEstudies _subject "MetabolismInCrops" residuesContext["metabolismRotationalCrops"] "metabolism of residues in rotational crops" "" true/>
            </sect3>
        </sect2>

        <sect2>
            <title role="HEAD-3">Livestock (poultry, lactating ruminants, pigs, fish)</title>
            <@keyRes.residuesSummary _subject "MetabolismInLivestock" />
            <@com.emptyLine/>
            <@keyAppendixE.appendixEstudies _subject "MetabolismInLivestock" "" "metabolism of residues in livestock including fish"/>
        </sect2>

    </sect1>

    <?hard-pagebreak?>

    <sect1 xml:id="CA63">
        <title role="HEAD-2">Magnitude of residue trials in plants</title>
            <#-- <@keyRes.residuesSummary subject=_subject docSubType="MagnitudeResiduesPlants" selection="residues in crops"/>
            <@com.emptyLine/>
            <@keyAppendixE.appendixEstudies _subject "ResiduesInRotationalCrops" residuesContext["magnitudePlants"] "magnitude of residues in plants"/> -->
            <@keyRes.residuesSummary subject=_subject docSubType="MagnitudeResiduesPlants"/>
			<sect2>
	             <title role="HEAD-4">Primary crops</title>
	             <@keyAppendixE.appendixEstudies _subject "ResiduesInRotationalCrops" residuesContext["magnitudePlants"] "magnitude of residues in primary crops" "" true _studies _waivers/>
	        </sect2>
	
            <sect2  xml:id="CA632">
                <title role="HEAD-4">Rotational crops</title>
                <@keyAppendixE.appendixEstudies _subject "ResiduesInRotationalCrops" residuesContext["magnitudeRotationalCrops"] "magnitude of residues in rotational crops" "" true _studies _waivers/>
            </sect2>
    </sect1>

    <?hard-pagebreak?>

    <sect1>
        <title role="HEAD-2">Feeding studies</title>
        <#--NOTE: new flexible summary in IUCLID 6.6-->
        <@keyRes.residuesSummary _subject "ResiduesInLivestock" />

        <sect2>
            <title role="HEAD-3">Livestock (poultry, ruminants, pigs, fish)</title>
            <@keyAppendixE.appendixEstudies _subject "ResiduesInLivestock" "" "residues in livestock including fish"/>
        </sect2>

    </sect1>

    <?hard-pagebreak?>

    <sect1>
        <title role="HEAD-2">Effects of processing</title>
        <@keyRes.residuesSummary _subject "NatureMagnitudeResiduesProcessedCommodities" />

        <sect2>
            <title role="HEAD-3">Nature of the residue</title>
            <@keyAppendixE.appendixEstudies _subject "NatureResiduesInProcessedCommod" "" "nature of the residues"/>
        </sect2>

        <sect2>
            <title role="HEAD-3">Distribution of the residue in inedible peel and pulp</title>
            <#-- Summary is repeated: ENDPOINT_SUMMARY.MagnitudeResiduesPlants -->
            <#--            <@keyAppendixE.appendixEstudies _subject "ResiduesInRotationalCrops" residuesContext["magnitudePeelPulp"] "residues in inedible peel and pulp"/>-->
            <#-- NOTE: this context is wrong (it's a repeatable block etc). Check if this is regardless of type of endpoint (crops vs rotational crops); if not then add and remove this condition from general case-->
           <@com.emptyLine/>
           <para>Studies on the distribution of residues in inedible peel and pulp are provided in <command  linkend="CA63">Section 6.3</command>.</para>
           <@com.emptyLine/>

        </sect2>

        <sect2>
            <title role="HEAD-3">Magnitude of residues in processed commodities</title>
            <@keyAppendixE.appendixEstudies _subject "MagnitudeResidInProcessedComm" "" "magnitude of residues in processed commodities"/>
        </sect2>
    </sect1>

    <?hard-pagebreak?>

    <sect1>
        <title role="HEAD-2">Residues in rotational crops</title>

        <sect2>
            <title role="HEAD-3">Metabolism in rotational crops</title>
            <@com.emptyLine/>
           	<para>Summaries and studies on the metabolism of residues in rotational crops are provided in <command  linkend="CA621">Section 6.2.1</command> and <command  linkend="CA6212">Section 6.2.1.2</command>, respectively.</para>
           	<@com.emptyLine/>
            <#--  
            <@keyRes.residuesSummary subject=_subject docSubType="MetabolismPlants" selection=["RotationalCrops"]/>
            <@com.emptyLine/>
            <@keyAppendixE.appendixEstudies _subject "MetabolismInCrops" residuesContext["metabolismRotationalCrops"] "metabolism of residues in rotational crops"/>
            -->
        </sect2>

        <sect2>
            <title role="HEAD-3">Magnitude of residues in rotational crops</title>
            <@com.emptyLine/>
           	<para>Summaries and studies on the magnitude of residues in rotational crops are provided in <command  linkend="CA63">Section 6.3</command> and <command  linkend="CA632">Section 6.3.2</command>, respectively.</para>
           	<@com.emptyLine/>
           	<#-- 
            <@keyRes.residuesSummary subject=_subject docSubType="MagnitudeResiduesPlants" selection="rotational crops"/>
            <@com.emptyLine/>
            <@keyAppendixE.appendixEstudies _subject "ResiduesInRotationalCrops" residuesContext["magnitudeRotationalCrops"]
                "magnitude of residues in rotational crops"/> -->
        </sect2>
    </sect1>

    <?hard-pagebreak?>

    <sect1>
        <title role="HEAD-2">Proposed residue definitions and maximum residue levels</title>

        <sect2>
            <title role="HEAD-3">Proposed residue definitions</title>
            <@keyRes.residuesSummary _subject "ResidueFood" />
        </sect2>

        <sect2 xml:id="CA672">
            <title role="HEAD-3">Proposed maximum residue levels (MRLs) and justification of the acceptability of the levels proposed</title>
            <@keyRes.residuesSummary _subject "MRLProposal" />
        </sect2>

        <sect2>
            <title role="HEAD-3">Proposed maximum residue levels (MRLs) and justification of the acceptability of the levels proposed for imported products (import tolerance)</title>
            <para>For proposed MRLs for imported products see <command  linkend="CA672">Section 6.7.2</command> above.</para>
        </sect2>
    </sect1>

    <?hard-pagebreak?>

    <sect1>
        <title role="HEAD-2">Proposed safety intervals</title>
        <para>For proposed safety intervals, please check documents D on the use of the plant protection product (GAP).</para>
    </sect1>

    <?hard-pagebreak?>

    <sect1>
        <title role="HEAD-2">Estimation of the potential and actual exposure through diet and other sources</title>
        <@keyRes.residuesSummary _subject "ExpectedExposure" />
		<#--        NOTE: out in IUCLID 6.6-->
		<#--        <@com.emptyLine/>-->
		<#--        <@keyAppendixE.appendixEstudies _subject "ExpectedExposureAndProposedAcceptableResidues"/>-->
    </sect1>

    <?hard-pagebreak?>

    <sect1>
        <title role="HEAD-2">Other studies</title>

        <sect2>
            <title role="HEAD-3">Residue level in pollen and bee products</title>
            <@keyRes.residuesSummary _subject "SupplementaryStudies" />
            <@com.emptyLine/>
            <@keyAppendixE.appendixEstudies _subject "ResiduesProcessedCommodities" "" "residue levels in pollen and bee products"/>
        </sect2>

		<#if keyAppendixE.containsDoc(_subject, ["ENDPOINT_SUMMARY.AdditionalInformationOnResiduesInFoodAndFeedingstuffs",
	        										"ENDPOINT_STUDY_RECORD.AdditionalInfoOnResiduesInFood"])>
            <sect2>
                <title role="HEAD-3">Additional information on residues in food and feedingstuffs</title>
                <@keyRes.residuesSummary _subject "AdditionalInformationOnResiduesInFoodAndFeedingstuffs" />
	            <@com.emptyLine/>
	            <@keyAppendixE.appendixEstudies _subject "AdditionalInfoOnResiduesInFood"/>
            </sect2>
         </#if>
    </sect1>

<#elseif workingContext=="MICRO">

    <sect1>
        <title role="HEAD-2">Persistence and likelihood of multiplication in or on crops, feedingstuffs or foodstuffs</title>
        <@keyRes.residuesSummary _subject "MigrationOfResiduesIntoAndTheirBehaviourOnFoodOrFeedingstuffs" />
        <@com.emptyLine/>
        <@keyAppendixE.appendixEstudies _subject "MigrationOfResidues"/>

    </sect1>

    <?hard-pagebreak?>

    <sect1>
        <title role="HEAD-2">Further information required</title>

        <sect2>
            <title role="HEAD-3">Viable and non-viable residues</title>
            <#-- NOTE: this section cannot be split as of now between viable and non-viable; but can be split between residues and magnitude-->
            
            <sect3>
            	 <title role="HEAD-3">Magnitude of residues in plants</title>
        		<@keyRes.residuesSummary _subject "MagnitudeResiduesPlants"/>
	            <@com.emptyLine/>
	            <@keyAppendixE.appendixEstudies subject=_subject docSubTypes="ResiduesInRotationalCrops" name="magnitude of viable and non-viable residues in plants" />
            </sect3>
            
            <sect3>
            	 <title role="HEAD-3">Magnitude of residues in processed commodities</title>
        		<@keyRes.residuesSummary _subject "NatureMagnitudeResiduesProcessedCommodities"/>
	            <@com.emptyLine/>
	            <@keyAppendixE.appendixEstudies subject=_subject docSubTypes="MagnitudeResidInProcessedComm" name="magnitude of viable and non-viable residues in processed commodities" />
            </sect3>
        </sect2>

        <#--        <sect2>-->
        <#--            <title role="HEAD-3">Non-viable residues</title>-->
        <#--        </sect2>-->

        <#--        <sect2>-->
        <#--            <title role="HEAD-3">Viable residues</title>-->
        <#--        </sect2>-->

		<#if keyAppendixE.containsDoc(_subject, ["ENDPOINT_SUMMARY.AdditionalInformationOnResiduesInFoodAndFeedingstuffs",
	        										"ENDPOINT_STUDY_RECORD.AdditionalInfoOnResiduesInFood"])>
            <sect2>
                <title role="HEAD-3">Additional information on residues in food and feedingstuffs</title>
                <@keyRes.residuesSummary _subject "AdditionalInformationOnResiduesInFoodAndFeedingstuffs" />
	            <@com.emptyLine/>
	            <@keyAppendixE.appendixEstudies _subject "AdditionalInfoOnResiduesInFood"/>
            </sect2>
        </#if>

    </sect1>

    <?hard-pagebreak?>

    <sect1>
        <title role="HEAD-2">Summary and evaluation of residue behaviour resulting from data submitted under points 6.1 and 6.2</title>
        <@keyRes.residuesSummary _subject "ResiduesInFoodAndFeedingstuffs"/>

    </sect1>
</#if>
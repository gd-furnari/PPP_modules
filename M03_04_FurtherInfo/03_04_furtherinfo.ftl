<#assign effContext = { "effects" : [{"path": "AdministrativeData.Endpoint",
                                                "val" : ["effects on harmful"],"qual" : "lk", "type" : "picklist"}],
                        "resistance" : [{"path": "AdministrativeData.Endpoint",
                                                "val" : ["occurrence of resistance"],"qual" : "lk", "type" : "picklist"}],
                        "function" : [{"path": "AdministrativeData.Endpoint",
                                            "val" : ["function"],"qual" : "lk", "type" : "picklist"}],
                        "moa" : [{"path": "AdministrativeData.Endpoint",
                                            "val" : ["mode of action"],"qual" : "lk", "type" : "picklist"}]
}/>

<#if _subject.documentType=="MIXTURE">

    <#if workingContext=="MICRO">

        <sect1>
            <title role="HEAD-2">Packaging and compatibility of the preparation with proposed packaging materials</title>
            <@keyAdm.packaging _subject/>
        </sect1>

        <?hard-pagebreak?>

        <sect1 label="MP 4.2, 4.4 - 4.6">
            <title role="HEAD-2">Recommended methods, precautions, emergency measures and procedures for cleaning application equipment and destruction or decontamination of the plant protection product and its packaging</title>
            <@keyAdm.protectionMeasures _subject/>
        </sect1>

        <?hard-pagebreak?>

        <sect1 label="MP 4.3">
            <title role="HEAD-2">Re-entry periods, necessary waiting periods or other precautions to protect man, livestock and the environment</title>
            <#-- <para>For details on re-entry and waiting periods and other precautions, please refer to Documents D.</para> -->
            <@keyGap.GAPpart _subject 'safety'/>
        </sect1>


    <#else>
        <sect1>
            <title role="HEAD-2">Safety intervals and other precautions to protect humans, animals and the environment</title>
            <#-- <para>For details on safety intervals and other precautions, please refer to Documents D.</para> -->
            
            <#-- 
            	Where relevant, pre-harvest intervals, re-entry periods or withholding periods necessary to minimise the presence of residues in or on crops, plants and plant products, or in treated areas or spaces, with a view 
				to protecting humans, animals and the environment, shall be specified, such as:
				(a) pre-harvest interval (in days) for each relevant crop;-> PestDiseaseTreated.ApplicationDetails.PreharvestInterval
				(b) re-entry period (in days) for livestock, to areas to be grazed; -> PestDiseaseTreated.ApplicationDetails.ReentryPeriodLivestock
				(c) re-entry period (in hours or days) for humans to crops, buildings or spaces treated; -> PestDiseaseTreated.ApplicationDetails.ReentryPeriod
				(d) withholding period (in days) for animal feeding stuffs and for post-harvest uses; -> PestDiseaseTreated.ApplicationDetails.WithholdingPeriod
				(e) waiting period (in days), between application and handling treated products; -> PestDiseaseTreated.ApplicationDetails.WaitingPeriod
				(f) waiting period (in days), between last application and sowing or planting succeeding crops. -> PestDiseaseTreated.ApplicationDetails.PlantbackInterval ??
				Where necessary in the light of the test results, information on any specific agricultural, plant health or environmental conditions under which the plant protection product may or may not be used shall be provided. 
             	-> PestDiseaseTreated.ApplicationDetails.Restrictions
             -->
             <@keyGap.GAPpart _subject 'safety'/>
        </sect1>

        <?hard-pagebreak?>

        <sect1 label="CP 4.2, 4.3, 4.5">
            <title role="HEAD-2">Recommended methods, precautions, emergency measures and procedures for destruction or decontamination of the plant protection product and its packaging</title>
            <@keyAdm.protectionMeasures _subject/>
        </sect1>

        <?hard-pagebreak?>

        <sect1 label="CP 4.4">
            <title role="HEAD-2">Packaging, compatibility of the plant protection product with proposed packaging materials</title>
            <@keyAdm.packaging _subject/>
        </sect1>
    </#if>


<#elseif _subject.documentType=="SUBSTANCE">

    <#if workingContext=="MICRO">
		
        <sect1 xml:id="MA31">
            <title role="HEAD-2">Function (incl. target organisms, mode of action and possible resistance)</title>
            <#-- <@keyAppendixE.appendixEstudies subject=_subject docSubTypes="EffectivenessAgainstTargetOrganisms" context=effContext["function"] name="function" includeMetabolites=false/>-->
            <#-- NOTE: included here instead of section 2 (to be changed in next ToC) -->
            <@keyBioPropMicro.effectivenessTargetOrgSummary subject=_subject includeMetabolites=false/>
            <@com.emptyLine/>
            <@keyAppendixE.appendixEstudies subject=_subject docSubTypes="EffectivenessAgainstTargetOrganisms" includeMetabolites=false/>
        </sect1>

        <?hard-pagebreak?>

        <sect1 label="MA 3.2 - 3.3">
            <title role="HEAD-2">Field of use envisaged and crops or products protected or treated</title>
            <para>For details on uses of the active substance, field of use envisaged, and crops or products protected or treated, please refer to <command  linkend="MA31">section 3.1</command> above 
            and to Documents D.</para>

        </sect1>

        <?hard-pagebreak?>

        <sect1 label="MA 3.4" xml:id="MA34">
            <title role="HEAD-2">Method of production and quality control</title>
            <@keyAdm.manufacturer _subject/>
        </sect1>

        <?hard-pagebreak?>

        <sect1 label="MA 3.5">
            <title role="HEAD-2">Information on the (possible) occurrence of resistance development and appropriate management strategies</title>
            <para>For information on the occurrence or possible occurence of the development of resistance of the target organism(s) see <command  linkend="MA31">section 3.1</command> above.</para>
        </sect1>
        
        <?hard-pagebreak?>

        <sect1 label="MA 3.6">
            <title role="HEAD-2">Methods to prevent loss of virulence of seed stock of the microorganism</title>
            <para>For methods to prevent loss of virulence of seed stock of the microorganism, please see MMA Section 2 (Biological properties of the micro-organism) and <command  linkend="MA34">section 3.4</command> above.</para>
        </sect1>

        <?hard-pagebreak?>

        <sect1 label="MA 3.7 - 3.9">
            <title role="HEAD-2">Methods and precautions for handling, storage, transport or fire, procedures for destruction or decontamination, and emergency measures</title>
            <@keyAdm.protectionMeasures _subject/>
        </sect1>

    <#else>
		<#-- This summary should probably be under 3.2 -->
        <@keyBioPropMicro.effectivenessTargetOrgSummary subject=_subject includeMetabolites=false/>

        <?hard-pagebreak?>
  
        <sect1 label="${docNameCode} 3.1">
            <title role="HEAD-2">Use of the active substance</title>
            <para>For details on uses of the active substance, please refer to MCP Section 3 (Application) and Documents D (GAP)</para>

        </sect1>
		
		<?hard-pagebreak?>
		
        <sect1 label="${docNameCode} 3.2 - 3.7">
            <title role="HEAD-2">Effects on harmful organisms, function, mode of action and possible resistance</title>
            <@keyAppendixE.appendixEstudies subject=_subject docSubTypes="EffectivenessAgainstTargetOrganisms" name="effects on harmful organisms, function, mode of action and possible resistance" includeMetabolites=false/>
        </sect1>

        <?hard-pagebreak?>

        <sect1 label="${docNameCode} 3.8 - 3.9">
            <title role="HEAD-2">Methods and precautions for handling, storage, transport or fire, procedures for destruction or decontamination, and emergency measures</title>
            <@keyAdm.protectionMeasures _subject/>
        </sect1>

    </#if>
</#if>
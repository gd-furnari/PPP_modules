<sect1>
    <title role="HEAD-2">Field of use envisaged</title>
    
    <#-- 3.1. Field of use envisaged
	The fields of use, existing and proposed, shall be specified from among the following:
	(a) field use, such as agriculture, horticulture, forestry and viticulture, protected crops, amenity, weed control 
	on non-cultivated areas;
	(b) home gardening;
	(c) house plants;
	(d) plant products storage practice;
	(e) other (shall be specified by the applicant). -->
	<@keyGap.envisagedUse _subject/>
</sect1>

<?hard-pagebreak?>

<sect1>
    <title role="HEAD-2" ><#if workingContext=="MICRO">Mode of action (effectiveness against target organisms)<#else>Effects on harmful organisms</#if></title>
    
    <@keyBioPropMicro.effectivenessTargetOrgSummary subject=_subject includeMetabolites=false/>
    <@com.emptyLine/>
    <@keyAppendixE.appendixEstudies subject=_subject docSubTypes="EffectivenessAgainstTargetOrganisms" name="effects on harmful organisms" includeMetabolites=false/>
    
</sect1>

<?hard-pagebreak?>

<sect1>
    <title role="HEAD-2">Details of intended use</title>
    
    <#-- 3.3. Details of intended use
		Details of the intended use shall be provided including, where relevant, the following information:
		� effects achieved for example sprout suppression, retardation of ripening, reduction in stem length, 
		enhanced fertilisation,
		� types of harmful organisms controlled,
		� plants or plant products to be protected-->
		
    <@keyGap.GAPpart _subject "intended use"/>
</sect1>

<?hard-pagebreak?>

<#if workingContext=="MICRO"><sect1 label="MP 3.4 - 3.5"><#else><sect1></#if>
	<title role="HEAD-2" ><#if workingContext=="MICRO">Application rate and content of micro-organism<#else>Application rate and concentration of the active substance</#if></title>
    
    <#-- 3.4. Application rate and concentration of the active substance
		For each method of application and each use, the rate of application per unit (ha, m2, m3) treated, for plant 
		protection product in g, kg, mL or L and active substance in g or kg shall be provided.
		Application rates shall be expressed, as appropriate, in one of the following units:
		� g, kg, mL or L per ha,
		� kg or L per m3,
		� g, kg, mL or L per tonne.
		For protected crops and home gardening use rates shall be expressed in:
		� g, kg, mL or L per 100 m2, or
		� g, kg, mL or L per m3.
		The content of active substance shall be expressed, as appropriate, in:
		� g or mL per L, or
		� g or mL per kg.-->
		
    <@keyGap.GAPpart _subject "application rate"/>
    
</sect1>

<?hard-pagebreak?>

<#if workingContext=="MICRO"><sect1 label="MP 3.6"><#else><sect1></#if>
    <title role="HEAD-2">Method of application</title>
    
    <#--3.5. Method of application
	The method of application proposed shall be described fully, indicating the type of equipment to be used, if 
	any, as well as the type and volume of diluent to be used per unit of area or volume.-->
	
    <@keyGap.GAPpart _subject "application method"/>
</sect1>

<?hard-pagebreak?>

<#if workingContext=="MICRO"><sect1 label="MP 3.7"><#else><sect1></#if>

    <title role="HEAD-2">Number and timing of applications and duration of protection</title>
    
    <#--3.6. Number and timing of applications and duration of protection
		The maximum number of applications to be used and their timing shall be reported. Where relevant, the 
		growth stages of the crop or plants to be protected and the development stages of the harmful organisms 
		shall be indicated. Where possible, the interval between applications in days shall be stated.
		The duration of protection afforded both by each application and by the maximum number of applications to 
		be used, shall be indicated.-->
		
    <@keyGap.GAPpart _subject "application number"/>
    
</sect1>

<?hard-pagebreak?>

<#if workingContext=="MICRO"><sect1 label="MP 3.8"><#else><sect1></#if>

    <title role="HEAD-2">Necessary waiting periods or other precautions to avoid phytotoxic effects on succeeding crops</title>
    
    <#--3.7. Necessary waiting periods or other precautions to avoid phytotoxic effects on succeeding crops
	Where relevant, minimum waiting periods between last application and sowing or planting of succeeding 
	crops, which are necessary to avoid phytotoxic effects on succeeding crops, shall be stated, and follow from 
	the data provided in accordance with point 6.5.1.
	Limitations on choice of succeeding crops, if any, shall be stated.  -->
	<#-- NOTE: the only field applicable could be the plant-back interval, so better to just point o 4.1 -->
	
    <para>Details on waiting periods can be found in <#if workingContext=="MICRO">MMP Section 4 (Further information on plant protection product), sub-section 4.3<#else>MCP Section 4(Further information on plant protection product), sub-section4.1</#if></para> 
    <#if keyGap.hasAddInfo(_subject)>
    	<para>Additional information on the uses of the plant protection product is present in <command  linkend="CP39">section <#if workingContext=="MICRO">3.10<#else>3.9</#if></command> below.</para>
 	</#if>
 	
</sect1>
	
<?hard-pagebreak?>

<#if workingContext=="MICRO"><sect1 label="MP 3.9"><#else><sect1></#if>

    <title role="HEAD-2">Proposed instructions for use</title>
    
    <#--3.8. Proposed instructions for use
	The proposed instructions for use of the plant protection product, to be printed on labels and leaflets, shall be 
	provided.-->
	
    <para>Details on the instructions for use of the plant protection product are provided in the sections above, the Documents D and in Document C.</para>
    
</sect1>

<?hard-pagebreak?>

<#if keyGap.hasAddInfo(_subject)>
	<#if workingContext=="MICRO"><sect1 label="MP 3.10" xml:id="CP39"><#else><sect1 xml:id="CP39"></#if>

	    <title role="HEAD-2">Additional information on uses of the plant protection product</title>
	    <@keyGap.GAPpart _subject "additional info"/>
	</sect1>
</#if>


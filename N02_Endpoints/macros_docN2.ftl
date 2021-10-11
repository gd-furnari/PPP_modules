<#--macros for the list of endpoints-->

<#macro valueForCSA summary propertyData>
    <#compress>
        <#if propertyData["values"]?has_content>
            <#list propertyData["values"] as value>

                <#local valuePath = "summary." + propertyData["path"] + "." + value["field"] />
                <#local val = valuePath?eval />
                <#if val?has_content>
                    <para>
                        <#-- preText -->
                        ${value["preText"]!}

                        <#-- value
                        NOTE: the "type" field in the hashMap could be omitted and just use node_type for each case
                        e.g. picklist_single, picklist_multi...-->
                        <#if value["type"]=='listValue'>
                            <@com.picklist val />
                        <#elseif value["type"]=='mListValue'>
                            <@com.picklistMultiple  val />
                        <#elseif value["type"]=='value'>
                            <#if (val?node_type)=="decimal">
                                <@com.number val />
                            <#elseif (val?node_type)=="quantity">
                                <@com.quantity val />
                            <#elseif (val?node_type)=="range">
                                <@com.range val />
                            </#if>
                        </#if>

                        <#-- postText -->
                        ${value["postText"]!}

                        <#-- atValuePath -->
                        <#if value["atField"]?has_content>
                            <#local atValuePath = "summary." + propertyData["path"] + "." + value["atField"] />
                            <#local atVal = atValuePath?eval />
                            <#if atVal?has_content>
                                at <@com.quantity atVal />
                            </#if>
                        </#if>
                    </para>
                </#if>
            <#--				<#if value_has_next>-->
            <#--					<?linebreak?>-->
            <#--				</#if>-->
            </#list>
        </#if>
    </#compress>
</#macro>

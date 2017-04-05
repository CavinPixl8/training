<cfscript>
	inputName      = args.name           ?: "";
	inputId        = args.id             ?: "";
	inputClass     = args.class          ?: "";
	seatsAvailable = args.seatsAvailable ?: "";
	label          = LCase(args.label);
</cfscript>
<cfoutput>
	<cfif len( seatsAvailable )>
		<select class="#inputClass#" name="#inputName#" id="#inputId#">
			<option value="">Please select #label#</option>
			<cfloop from="1" to="#seatsAvailable#" index="index">
				<option value="#index#"> #index# </option>
			</cfloop>
		</select>
	<cfelse>
		<input type ="number" class="#inputClass#" name="#inputName#" id="#inputId#" placeholder="#label#"/>
	</cfif>
</cfoutput>
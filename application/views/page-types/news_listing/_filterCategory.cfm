<cf_presideparam name="args.id"         field="news_category.id"        editable="false" />
<cf_presideparam name="args.label"         field="news_category.label"        editable="false" />

<cfoutput>
<option value="#args.id#">#args.label#</option>
</cfoutput>
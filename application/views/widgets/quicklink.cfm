<!---
	This view file has been automatically created by the preside dev tools
	scaffolder. Please fill with meaningful content and remove this comment
--->
<cfparam name="args.title" default="" />
<cfparam name="args.links" default="" />

<cfoutput>
	<h3>#args.title#</h3>
	<ol>
		<cfloop list="#args.links#" index="link">
			<li>#renderLink(link)#</li>
		</cfloop>
	</ol>
</cfoutput>
	
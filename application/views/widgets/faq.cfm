<!---
	This view file has been automatically created by the preside dev tools
	scaffolder. Please fill with meaningful content and remove this comment
--->
<cfparam name="args.title" default="" />
<cfparam name="args.faqs" default="" />
<cfif ListLen(args.faqs)>
		
	<cfoutput>
		<h3>#args.title#</h3>
		#renderView( 
				  view="widgets/_faqItem"
				, presideObject = "faq" 
				, filter={ id=listToArray( args.faqs ) } 
				, orderBy       = "FIELD( id, #listQualify( args.faqs, "'" )#)"
		)#
<!---
		<cfloop list="#args.faqs#" index="faq">
			#renderView( 
				  view="widgets/_faqItem"
				, presideObject = "faq" 
				, id = faq
		)#			


		</cfloop>
		--->
	</cfoutput> 

</cfif>


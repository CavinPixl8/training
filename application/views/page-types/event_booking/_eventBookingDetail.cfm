<cfscript>
	bookingList = args.bookingList ?: queryNew('');
</cfscript>

<cfoutput>
#html.table( data=bookingList, class="table table-striped" )#
</cfoutput>
<cfscript>
	args.programs = args.programs ?: queryNew('');
</cfscript>
<h3>Event Programs</h3>
<cfoutput query="args.programs">
	<h5>
		#args.programs.program_label#
	</h5>
	<h6>
		#DateTimeFormat(args.programs.start_time, "yyyy.MM.dd 'starts at' HH:nn:ss z")#
	</h6>
	<hr />
</cfoutput>
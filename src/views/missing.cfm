<cfsilent>

	<cfset missing = event.getValue("missing")/>

</cfsilent>
<cfoutput>

	<h2>Hmm... We can't find that.</h2>

	<p>The page <span class="text-error">#missing#</span> is not found.</p>

</cfoutput>
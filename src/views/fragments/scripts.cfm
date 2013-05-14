<cfsilent>
	<cfset reslease = getSetting("release")/>
	<cfset environment = getSetting("environment")/>
</cfsilent>
<cfoutput>
	<cfif environment eq "development">
		<script src="/js/jquery-1.9.1.js"></script>
		<script src="/js/bootstrap-2.3.1.js"></script>
		<script src="/js/app.js?v=#release#"></script>
	<cfelse>
		<script src="/js/jquery-1.9.1.min.js"></script>
		<script src="/js/bootstrap-2.3.1.min.js"></script>
		<script src="/js/app.min.js?v=#release#"></script>
	</cfif>
</cfoutput>
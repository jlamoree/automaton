<cfsilent>
	<cfset setBaseURL("/")/>
	<cfset setUniqueURLs(false)/>

	<cfset addRoute(pattern="/Status/hang/:timeout?", handler="Status", action="hang")/>
	<cfset addRoute(pattern="/:handler/:action?")/>
</cfsilent>
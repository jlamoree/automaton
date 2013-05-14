<cfcomponent extends="coldbox.system.EventHandler" output="false">

	<cffunction name="onException" access="public" returntype="void" output="false">
		<cfargument name="event" type="coldbox.system.web.context.RequestContext" required="true"/>

		<cfset arguments.event.setValue("pageTitle", "Shoot! An error occurred")/>
		<cfset arguments.event.setView("error")/>
		
		<!--- TODO: Log and alert --->
		
	</cffunction>

	<cffunction name="onInvalidEvent" access="public" returntype="void" output="false">
		<cfargument name="event" type="coldbox.system.web.context.RequestContext" required="true"/>

		<cfset var missing = arguments.event.getCurrentRoutedURL()/>

		<cfset arguments.event.setValue("pageTitle", "Hmm... We can't find that")/>
		<cfset arguments.event.setView("missing")/>
		
		<cfif not find("/", missing) eq 1>
			<cfset missing = "/" & missing/>
		</cfif>
		<cfset arguments.event.setValue("missing", missing)/>
	</cffunction>

</cfcomponent>

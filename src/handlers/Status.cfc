<cfcomponent extends="coldbox.system.EventHandler" output="false">


	<cffunction name="index" returntype="void" access="public" output="false">
		<cfargument name="event" type="coldbox.system.web.context.RequestContext" required="true"/>

		<cfset arguments.event.setValue("pageTitle", "Status")/>
		<cfset arguments.event.setLayout("main")>
		<cfset arguments.event.setView("status/index")/>
	</cffunction>

	<cffunction name="hang" returntype="void" access="public" output="false">
		<cfargument name="event" type="coldbox.system.web.context.RequestContext" required="true"/>

		<cfset var _event = arguments.event/>
		<cfset var timeout = val(_event.getValue("timeout", 30))/>
		<cfset var waited = 0/>

		<cfif timeout>
			<cfset waited = getTickCount()/>
			<cfset sleep(timeout * 1000)/>
			<cfset waited = getTickCount() - waited/>
		</cfif>
		<cfset event.setValue("waited", waited)/>
		<cfset arguments.event.setValue("pageTitle", "Hang")/>
		<cfset arguments.event.setLayout("main")>
		<cfset arguments.event.setView("status/hang")/>
	</cffunction>

</cfcomponent>

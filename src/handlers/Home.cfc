<cfcomponent extends="coldbox.system.EventHandler" output="false">

	<cffunction name="index" access="public" returntype="void" output="false">
		<cfargument name="event" type="coldbox.system.web.context.RequestContext" required="true"/>

		<cfset arguments.event.setValue("pageTitle", "Welcome")/>
		<cfset arguments.event.setValue("pageId", "home")/>
		<cfset arguments.event.setLayout("main")>
		<cfset arguments.event.setView("home/index")/>
	</cffunction>

	<cffunction name="about" access="public" returntype="void" output="false">
		<cfargument name="event" type="coldbox.system.web.context.RequestContext" required="true"/>

		<cfset arguments.event.setValue("pageTitle", "About")/>
		<cfset arguments.event.setValue("pageId", "about")/>
		<cfset arguments.event.setLayout("main")>
		<cfset arguments.event.setView("home/about")/>
	</cffunction>

</cfcomponent>

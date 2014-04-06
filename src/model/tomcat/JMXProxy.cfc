<cfcomponent output="false">

	<cfproperty name="jmxConfig" inject="coldbox:setting:jmxConfig"/>
	<cfproperty name="log" inject="logbox:logger:{this}"/>

	<cffunction name="init" returntype="JMXProxy" access="public" output="false">
		<cfargument name="jmxConfig" type="struct" required="false"/>

		<cfif structKeyExists(arguments, "jmxConfig")>
			<cfset variables.jmxConfig = arguments.jmxConfig/>
		</cfif>
		<cfreturn this/>
	</cffunction>

	<cffunction name="getSessionDetails" returntype="struct" access="public" output="false">
		<cfargument name="sessionId" type="string" required="true"/>

		<cfset var result = structNew()/>
		<cfset var response = "null"/>
		<cfset var requestUrl = ""/>
		<cfset var cf = variables.jmxConfig/>
		
		<cfset result["created"] = 0/>
		<cfset result["lastAccess"] = 0/>

		<cftry>
			<cfset requestUrl = cf.baseUrl & "?invoke=#urlEncodedFormat(cf.managerBean)#&op=getCreationTimestamp&ps=#arguments.sessionId#"/>
			<cfhttp method="GET" url="#requestUrl#" username="#cf.username#" password="#cf.password#" result="response"/>
			<cfset result["created"] = val(reReplaceNoCase(response.fileContent, "[^0-9]", "", "all"))/>
			<cfcatch>
				<cfset variables.log.error("Could not fetch session last access timestamp via JMXProxy. #cfcatch.message#")/>
			</cfcatch>
		</cftry>
		<cftry>
			<cfset requestUrl = cf.baseUrl & "?invoke=#urlEncodedFormat(cf.managerBean)#&op=getLastAccessedTimestamp&ps=#arguments.sessionId#"/>
			<cfhttp method="GET" url="#requestUrl#" username="#cf.username#" password="#cf.password#" result="response"/>
			<cfset result["lastAccess"] = val(reReplaceNoCase(response.fileContent, "[^0-9]", "", "all"))/>
			<cfcatch>
				<cfset variables.log.error("Could not fetch session last access timestamp via JMXProxy. #cfcatch.message#")/>
			</cfcatch>
		</cftry>
		
		<cfreturn result/>
	</cffunction>

</cfcomponent>
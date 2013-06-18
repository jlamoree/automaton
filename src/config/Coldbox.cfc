<cfcomponent output="false">

	<cffunction name="configure" returntype="void" access="public" output="false">
		<cfscript>
			variables.coldbox = {
				appName = "Automaton",
				debugMode = false,
				defaultEvent = "Home.index",
				exceptionHandler = "Error.onException",
				onInvalidEvent = "Error.onInvalidEvent"
			};

			variables.interceptors = [
				{class="coldbox.system.interceptors.Autowire", properties={}},
				{class="coldbox.system.interceptors.SES"},
				{class="interceptors.Headers"},
				{class="interceptors.AuthSession"}
			];

			variables.wirebox = {
				singletonReload = false
			};

			variables.settings = {
				version = "@VERSION@",
				release = "@RELEASE@",
				nodeName = "@NODE_NAME@",
				site = {
					title = "The Automaton App"
				}
			};

			variables.flash = {
				scope = "session",
				properties = {},
				inflateToRC = true,
				autoPurge = true,
				autoSave = true
			};

			variables.logbox = {
				appenders = {
					console = { class="coldbox.system.logging.appenders.ConsoleAppender" }
				},
				root = {levelMin="FATAL", levelMax="INFO", appenders="*"},
				categories = {
					"coldbox.system" = {levelMax="WARN", appenders="console"},
					"interceptors.AuthSession" = {levelMax="INFO", appenders="console"},
					"interceptors.Headers" = {levelMax="DEBUG", appenders="console"},
					"handlers.Auth" = {levelMax="INFO", appenders="console"}
				}
			};

			variables.mailSettings = {server = "@MAIL_SERVER@"};

			variables.layoutSettings = {
				defaultLayout = "main.cfm",
				defaultView = ""
			};
		</cfscript>
	</cffunction>
	
	<cffunction name="detectEnvironment" returntype="string" access="public" output="false">
		<cfset var environment = "@ENVIRONMENT@"/>

		<cfif len(environment) and find("@", environment) eq 0>
			<cfreturn environment/>
		</cfif>
		<cfreturn "development"/>
	</cffunction>

	<cffunction name="production" returntype="void" access="public" output="false">
		<cfset variables.coldbox.reinitPassword = "@REINIT_PASSWORD@"/>
		<cfset variables.coldbox.handlersIndexAutoReload = false/>
		<cfset variables.coldbox.configAutoReload = false/>
	</cffunction>

	<cffunction name="development" returntype="void" access="public" output="false">
		<cfset variables.coldbox.reinitPassword = ""/>
		<cfset variables.coldbox.handlerCaching = false/>
		<cfset variables.coldbox.eventCaching = false/>
		<cfset variables.coldbox.handlersIndexAutoReload = true/>
		<cfset variables.coldbox.configAutoReload = true/>
	</cffunction>

</cfcomponent>
<cfcomponent extends="coldbox.system.ioc.config.Binder" output="false">

	<cffunction name="configure" returntype="void" access="public" output="false">
		<cfscript>

			variables.wireBox = {
				scopeRegistration = {
					enabled = true,
					scope = "application",
					key = "wireBox"
				}
			};

			map("userService").to("model.user.UserService");
			
		</cfscript>
	</cffunction>

</cfcomponent>
<cfsilent>
	
	<cfset user = event.getValue(name="user", private=true, defaultValue="")/>
	<cfset result = event.getValue("result", "")/>

</cfsilent>
<cfoutput>
	<div class="well well-large">
		<cfif isStruct(result) and result.status eq "failure">
			<span class="text-error">#result.message#</span>
		<cfelse>
			Please enter your username and password.
		</cfif>
	</div>
	<form id="loginForm" class="form-horizontal" action="/Auth/processLogin" method="POST">
		<fieldset>
			<div class="control-group">
				<label class="control-label" for="username">Username:</label>
				<div class="controls">
					<input type="text" id="username" name="username" placeholder="" class="input-xlarge"/>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="password">Password:</label>
				<div class="controls">
					<input type="password" id="password" name="password" placeholder="" autocomplete="off" class="input-xlarge"/>
				</div>
			</div>
			<div class="control-group">
				<div class="controls">
					<button class="btn">Login</button>
				</div>
			</div>
		</fieldset>
	</form>
</cfoutput>
<cfparam name="userRole" default="">

<cfif IsUserInAnyRole("admin")>
    <cfset userRole = "admin" />
<cfelseif IsUserInAnyRole("log")> 
    <cfset userRole = "Log" />
<cfelseif IsUserInAnyRole("Guest")>
    <cfset userRole = "guest" />
<cfelse>
	<cfset  userRole = #GetUserRoles()#>
</cfif>
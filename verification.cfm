<cfparam name="userRole" default="">

<cfif IsUserInAnyRole("admin")>
    <cfset userRole = "admin" />1
<cfelseif IsUserInAnyRole("log")> 
    <cfset userRole = "Log" />2
<cfelseif IsUserInAnyRole("Guest")>
    <cfset userRole = "guest" />3
<cfelse>
	<cfset userRole = #GetUserRoles()#>
</cfif>
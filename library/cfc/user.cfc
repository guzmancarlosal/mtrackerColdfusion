<cfcomponent hint="Add/Edit/Delete user information" output="false">

    <cfset this.odbc = "">
    
    <!--- ************************************************************************************************************************************************************** --->

    <cffunction name="init" access="public" output="true">
    	<cfargument name="odbc" type="string" required="yes">
        <cfset this.odbc = arguments.odbc>
        <cfreturn this />
    </cffunction>
    

    <cffunction access="public" name="addUser" output="false" returntype="boolean">
    	<cfargument name="username" type="string" required="yes">
    	<cfargument name="password" type="string" required="yes">
    	<cfargument name="type" type="string" required="yes">
    	<cfargument name="status" type="string" required="no" default="1">
		<cfquery name="qAddUser" datasource="#this.odbc#">
            Insert into user (username, password, type, status)
            vales ('#arguments.username#','#arguments.password#','#arguments.type#','#arguments.status#')
        </cfquery>
        <cfreturn true />
    </cffunction>
</cfcomponent>

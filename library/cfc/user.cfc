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
        <cfargument name="locList" type="string" required="no" default="">
        <cfargument name="machineList" type="string" required="no" default="">

		<cfquery name="qAddUser" datasource="#this.odbc#">
            Insert into [user] (username, password, type, status)
            values ('#arguments.username#','#arguments.password#','#arguments.type#','#arguments.status#');
        </cfquery>
        <cfquery name="qGetUser" datasource="#this.odbc#">
            SELECT id FROM [user] with (nolock) WHERE username=N'#arguments.username#' and password = N'#arguments.password#'
        </cfquery>
        <cfloop list="#locList#" index="i">
            <cfquery name="qAddUserLoc" datasource="#this.odbc#">
                Insert into [user_loc] (idUser, idLoc)
                values ('#qGetUser.id#','#i#')
            </cfquery>
        </cfloop>
        <cfloop list="#machineList#" index="i">
            <cfquery name="qAddUserLoc" datasource="#this.odbc#">
                Insert into [user_machine] (userID, machineID)
                values ('#qGetUser.id#','#i#')
            </cfquery>
        </cfloop>
        <cfreturn true />
    </cffunction>
    <cffunction access="public" name="getUser" output="false" returntype="query">
        <cfargument name="id" type="string" required="yes">
        <cfquery name="qGetUser" datasource="#this.odbc#">
            Select top 1 * 
            from [user] with (nolock)
            where id=N'#arguments.id#'
        </cfquery>
        <cfreturn qGetUser />
    </cffunction>
    <cffunction access="public" name="getAllUsers" output="false" returntype="query">
        <cfquery name="qGetOrg" datasource="#this.odbc#">
            Select * 
            from [user] with (nolock)
        </cfquery>
        <cfreturn qGetOrg />
    </cffunction>
    <cffunction access="public" name="updateLoc" output="false" returntype="boolean">
        <cfargument name="id" type="string" required="yes">
        <cfargument name="username" type="string" required="yes">
        <cfargument name="status" type="string" required="no" default="1">
        <cfargument name="password" type="string" required="yes">
        <cfargument name="type" type="string" required="yes">
        <cfquery name="qUpdateOrg" datasource="#this.odbc#">
           Update [user]
           set  username=N'#arguments.username#',
                status=N'#arguments.status#',
                password=N'#arguments.password#',
                type=N'#arguments.type#'
            where id = N'#arguments.id#'
        </cfquery>
        <cfreturn true />
    </cffunction>
    <cffunction access="public" name="updateUser" output="false" returntype="boolean">
        <cfargument name="userID" type="string" required="yes">
        <cfargument name="username" type="string" required="yes">
        <cfargument name="password" type="string" required="yes">
        <cfargument name="type" type="string" required="yes">
        <cfargument name="status" type="string" required="no" default="1">
        <cfargument name="locList" type="string" required="no" default="">
        <cfargument name="machineList" type="string" required="no" default="">
        <cfquery name="qUpdateUser" datasource="#this.odbc#">
            Update [user] 
            set username='#arguments.username#', password='#arguments.password#', type='#arguments.type#', status='#arguments.status#'
            where id='#arguments.userID#'
        </cfquery>
        <cfquery name="qDeleteUserLoc" datasource="#this.odbc#">
            Delete FROM [user_machine] where userID = '#arguments.userID#'
            Delete FROM [user_loc] where idUser = '#arguments.userID#'
        </cfquery>
        <cfloop list="#locList#" index="i">
            <cfquery name="qAddUserLoc" datasource="#this.odbc#">
                Insert into [user_loc] (idUser, idLoc)
                values ('#arguments.userID#','#i#')
            </cfquery>
        </cfloop>
        <cfloop list="#machineList#" index="i">
            <cfquery name="qAddUserLoc" datasource="#this.odbc#">
                Insert into [user_machine] (userID, machineID)
                values ('#arguments.userID#','#i#')
            </cfquery>
        </cfloop>
        <cfreturn true />
    </cffunction>
</cfcomponent>

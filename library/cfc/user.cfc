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
        <cftransaction>
    		<cfquery name="qAddUser" datasource="#this.odbc#">
                Insert into [user] (username, password, type, status)
                values (<cfqueryparam value = arguments.username cfsqltype="cf_sql_varchar">,
                        <cfqueryparam value = arguments.password cfsqltype="cf_sql_varchar">,
                        <cfqueryparam value = arguments.type cfsqltype="cf_sql_varchar">,
                        <cfqueryparam value = arguments.status cfsqltype="cf_sql_varchar">);
            </cfquery>
            <cfquery name="qGetUser" datasource="#this.odbc#">
                SELECT id FROM [user] with (nolock) WHERE username=<cfqueryparam value = arguments.username cfsqltype="cf_sql_varchar"> 
                and password = <cfqueryparam value = arguments.password cfsqltype="cf_sql_varchar">
            </cfquery>
            <cfloop list="#locList#" index="i">
                <cfquery name="qAddUserLoc" datasource="#this.odbc#">
                    Insert into [user_loc] (idUser, idLoc)
                    values (<cfqueryparam value = qGetUser.id cfsqltype="cf_sql_varchar">,'#i#')
                </cfquery>
            </cfloop>
            <cfloop list="#machineList#" index="i">
                <cfquery name="qAddUserLoc" datasource="#this.odbc#">
                    Insert into [user_machine] (userID, machineID)
                    values (<cfqueryparam value = qGetUser.id cfsqltype="cf_sql_varchar">,'#i#')
                </cfquery>
            </cfloop>
         </cftransaction>
        <cfreturn true />
    </cffunction>
    <cffunction access="public" name="getUser" output="false" returntype="query">
        <cfargument name="id" type="string" required="yes">
        <cfquery name="qGetUser" datasource="#this.odbc#">
            Select top 1 * 
            from [user] with (nolock)
            where id=<cfqueryparam value = arguments.id cfsqltype="cf_sql_varchar">
        </cfquery>
        <cfreturn qGetUser />
    </cffunction>
    <cffunction access="public" name="getAllUsers" output="false" returntype="query">
        <cfargument name="userRole" type="string" required="no">
        <cfquery name="qGetOrg" datasource="#this.odbc#">
            Select * 
            from [user] with (nolock)
            where type <> 4
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
           set  username=<cfqueryparam value = arguments.username cfsqltype="cf_sql_varchar">,
                status=<cfqueryparam value = arguments.status cfsqltype="cf_sql_varchar">,
                password=<cfqueryparam value = arguments.password cfsqltype="cf_sql_varchar">,
                type=<cfqueryparam value = arguments.type cfsqltype="cf_sql_varchar">
            where id = <cfqueryparam value = arguments.id cfsqltype="cf_sql_varchar">
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
        <cftransaction>
            <cfquery name="qUpdateUser" datasource="#this.odbc#">
                Update [user] 
                set username=   <cfqueryparam value = arguments.username cfsqltype="cf_sql_varchar">, 
                    password=   <cfqueryparam value = arguments.password cfsqltype="cf_sql_varchar">,
                    type=       <cfqueryparam value = arguments.type cfsqltype="cf_sql_varchar">, 
                    status=     <cfqueryparam value = arguments.status cfsqltype="cf_sql_varchar">
                where id=      <cfqueryparam value = arguments.userID cfsqltype="cf_sql_varchar">
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
        </cftransaction>
        <cfreturn true />
    </cffunction>
   
    <cffunction access="public" name="getSiteUserRoleList" output="false" returntype="query">
        <cfargument name="id" type="string" required="yes">
        <cfargument name="role" type="string" required="yes">
        <cfquery name="qGetOrg" datasource="#this.odbc#">
            Select distinct u.username, u.email
            from [user] u with (nolock)
            INNER JOIN [role] r on u.[type]=r.[id] and r.[type]='#arguments.role#'
            INNER JOIN user_machine um on u.id = um.userID
            INNER JOIN machine m on um.machineid = m.id
            where m.id='#arguments.id#'
        </cfquery>
        <cfreturn qGetOrg />
    </cffunction>
</cfcomponent>

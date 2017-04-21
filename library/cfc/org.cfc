<cfcomponent hint="Add/Edit/Delete org information" output="false">

    <cfset this.odbc = "">
    
    <!--- ************************************************************************************************************************************************************** --->

    <cffunction name="init" access="public" output="true">
    	<cfargument name="odbc" type="string" required="yes">
        <cfset this.odbc = arguments.odbc>
        <cfreturn this />
    </cffunction>
    

    <cffunction access="public" name="addOrg" output="false" returntype="boolean">
    	<cfargument name="name" type="string" required="yes">
    	<cfargument name="type" type="string" required="yes">
    	<cfargument name="status" type="string" required="no" default="1">
		<cfquery name="qAddOrg" datasource="#this.odbc#">
            Insert into org (name, status,datecreated)
            vales ('#arguments.username#','#arguments.status#','#now()#')
        </cfquery>
        <cfreturn true />
    </cffunction>
    <cffunction access="public" name="getOrg" output="false" returntype="string">
        <cfargument name="id" type="string" required="yes">
        <cfquery name="qGetOrg" datasource="#this.odbc#">
            Select id 
            from org with (nolock)
            where id=N'#arguments.id#'
        </cfquery>
        <cfreturn qGetOrg.id />
    </cffunction>
    <cffunction access="public" name="getAllOrgs" output="false" returntype="query">
        <cfquery name="qGetOrg" datasource="#this.odbc#">
            Select * 
            from org with (nolock)
        </cfquery>
        <cfreturn qGetOrg />
    </cffunction>
    <cffunction access="public" name="updateOrg" output="false" returntype="boolean">
        <cfargument name="name" type="string" required="yes">
        <cfargument name="status" type="string" required="yes">
        <cfargument name="orgID" type="string" required="yes">
        <cfquery name="qUpdateOrg" datasource="#this.odbc#">
           Update org
           set  name=N'#arguments.name#',
                status=N'#arguments.status#'
            where id = N'#arguments.orgID#'
        </cfquery>
        <cfreturn qGetOrg />
    </cffunction>
</cfcomponent>

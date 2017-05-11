<cfcomponent hint="Add/Edit/Delete Site information" output="false">

    <cfset this.odbc = "">
    
    <!--- ************************************************************************************************************************************************************** --->

    <cffunction name="init" access="public" output="true">
    	<cfargument name="odbc" type="string" required="yes">
        <cfset this.odbc = arguments.odbc>
        <cfreturn this />
    </cffunction>
    

    <cffunction access="public" name="addLoc" output="false" returntype="boolean">
    	<cfargument name="name" type="string" required="yes">
    	<cfargument name="status" type="string" required="no" default="1">
        <cfargument name="orgid" type="string" required="yes">
        <cfargument name="country" type="string" required="yes">
		<cfquery name="qAddOrg" datasource="#this.odbc#">
            Insert into loc (name, status,datecreated,orgID, country)
            values (N'#arguments.name#',N'#arguments.status#',N'#dateFormat(now(),"yyyy-mm-dd")#',N'#arguments.orgid#',N'#arguments.country#')
        </cfquery>
        <cfreturn true />
    </cffunction>
    <cffunction access="public" name="getLoc" output="false" returntype="query">
        <cfargument name="id" type="string" required="yes">
        <cfquery name="qGetOrg" datasource="#this.odbc#">
            Select top 1 * 
            from loc with (nolock)
            where id=N'#arguments.id#'
        </cfquery>
        <cfreturn qGetOrg />
    </cffunction>
    <cffunction access="public" name="getAllLocs" output="false" returntype="query">
        <cfquery name="qGetOrg" datasource="#this.odbc#">
            Select * 
            from loc with (nolock)
        </cfquery>
        <cfreturn qGetOrg />
    </cffunction>
     <cffunction access="public" name="getAllActiveLocs" output="false" returntype="query">
        <cfquery name="qGetOrg" datasource="#this.odbc#">
            Select id, name
            from loc with (nolock)
            where status = 1
        </cfquery>
        <cfreturn qGetOrg />
    </cffunction>
    <cffunction access="public" name="updateLoc" output="false" returntype="boolean">
        <cfargument name="siteid" type="string" required="yes">
        <cfargument name="name" type="string" required="yes">
        <cfargument name="status" type="string" required="no" default="1">
        <cfargument name="orgid" type="string" required="yes">
        <cfargument name="country" type="string" required="yes">
        <cfquery name="qUpdateOrg" datasource="#this.odbc#">
           Update loc
           set  name=N'#arguments.name#',
                status=N'#arguments.status#',
                country=N'#arguments.country#',
                orgid=N'#arguments.orgid#'
            where id = N'#arguments.siteid#'
        </cfquery>
        <cfreturn true />
    </cffunction>
</cfcomponent>

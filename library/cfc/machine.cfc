<cfcomponent hint="Add/Edit/Delete Machine information" output="false">

    <cfset this.odbc = "">
    
    <!--- ************************************************************************************************************************************************************** --->

    <cffunction name="init" access="public" output="true">
    	<cfargument name="odbc" type="string" required="yes">
        <cfset this.odbc = arguments.odbc>
        <cfreturn this />
    </cffunction>
    

    <cffunction access="public" name="addM" output="false" returntype="boolean">
    	<cfargument name="name" type="string" required="yes">
    	<cfargument name="status" type="string" required="no" default="1">
        <cfargument name="idLoc" type="string" required="yes">
        <cfargument name="type" type="string" required="yes">
        <cfargument name="capacity" type="string" required="no">
		<cfquery name="qAddOrg" datasource="#this.odbc#">
            Insert into machine (name, status,idLoc, type,capacity)
            values (N'#arguments.name#',N'#arguments.status#',N'#arguments.idLoc#',N'#arguments.type#',N'#arguments.capacity#')
        </cfquery>
        <cfreturn true />
    </cffunction>
    <cffunction access="public" name="getM" output="false" returntype="query">
        <cfargument name="id" type="string" required="yes">
        <cfquery name="qGetOrg" datasource="#this.odbc#">
            Select top 1 * 
            from machine with (nolock)
            where id=N'#arguments.id#'
        </cfquery>
        <cfreturn qGetOrg />
    </cffunction>
    <cffunction access="public" name="getAllM" output="false" returntype="query">
        <cfquery name="qGetOrg" datasource="#this.odbc#">
            Select machine.id, machine.name, machine.type, machine.status, loc.name as loc, machine.capacity
            from machine with (nolock)
            INNER JOIN loc on machine.idLoc = loc.id
        </cfquery>
        <cfreturn qGetOrg />
    </cffunction>
     <cffunction access="public" name="getAllActiveM" output="false" returntype="query">
        <cfquery name="qGetOrg" datasource="#this.odbc#">
            Select machine.id, machine.name, machine.type, machine.status, loc.name as loc, machine.capacity
            from machine with (nolock)
            INNER JOIN loc on machine.idLoc = loc.id
            where machine.status = 1;
        </cfquery>
        <cfreturn qGetOrg />
    </cffunction>
    <cffunction access="public" name="updatem" output="false" returntype="boolean">
        <cfargument name="machineID" type="string" required="yes">
        <cfargument name="name" type="string" required="yes">
        <cfargument name="status" type="string" required="no" default="1">
        <cfargument name="idLoc" type="string" required="yes">
        <cfargument name="capacity" type="string" required="yes">
        <cfargument name="type" type="string" required="yes">
        <cfquery name="qUpdateOrg" datasource="#this.odbc#">
           Update machine
           set  name=N'#arguments.name#',
                status=N'#arguments.status#',
                type=N'#arguments.type#',
                idLoc=N'#arguments.idLoc#',
                capacity =N'#arguments.capacity#'
            where id = N'#arguments.machineID#'
        </cfquery>
        <cfreturn true />
    </cffunction>
</cfcomponent>

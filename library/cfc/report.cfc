<cfcomponent hint="Add / get report information" output="false">

    <cfset this.odbc = "">
    
    <!--- ************************************************************************************************************************************************************** --->

    <cffunction name="init" access="public" output="true">
    	<cfargument name="odbc" type="string" required="yes">
        <cfset this.odbc = arguments.odbc>
        <cfreturn this />
    </cffunction>
    

    <cffunction access="public" name="addLog" output="false" returntype="boolean">
    	<cfargument name="machineStatus" type="string" required="yes">
    	<cfargument name="date" type="date" required="yes">
        <cfargument name="pie1" type="string" required="no">
        <cfargument name="pie2" type="string" required="no">
        <cfargument name="idMachine" type="string" required="no">
        <cfargument name="comments" type="string" required="no" default="">
        <cfargument name="userID" type="string" required="no">
        <cfparam name="local.idDescription" default="">
        <cftransaction>
            <cfif arguments.comments neq "">               
                <cfquery name="qAddDesc" datasource="#this.odbc#">
                    Insert into description (description)
                    values (<cfqueryparam value = arguments.comments cfsqltype="cf_sql_varchar">)
                </cfquery>
                <cfquery name="qGetID" datasource="#this.odbc#">
                    SELECT max(id) as id from description with (nolock) where description like '#left(arguments.comments, 5)#%'
                </cfquery>
                <cfset local.idDescription = qGetID.id>
            </cfif>
    		<cfquery name="qAddlog" datasource="#this.odbc#">
                Insert into log (idusuario, idMachine,time, status, idDescription, itemsproduced, gooditems)
                values (<cfqueryparam value = "#arguments.userID#" cfsqltype="cf_sql_varchar">,<cfqueryparam value = "#arguments.idMachine#" cfsqltype="cf_sql_varchar">,#arguments.date#,'#machineStatus#','#local.idDescription#',
                    <cfqueryparam value = "#pie1#" cfsqltype="cf_sql_varchar">, <cfqueryparam value = "#pie2#" cfsqltype="cf_sql_varchar">)
            </cfquery>
        </cftransaction>
        <cfreturn true />
    </cffunction>
    <cffunction access="public" name="getLastLog" output="false" returntype="query">
        <cfargument name="id" type="string" required="yes">
        <cfquery name="qGetLog" datasource="#this.odbc#">
            Select top 1 time 
            from [log] with (nolock)
            where idMachine=N'#arguments.id#'
            order by time desc
        </cfquery>
        <cfreturn qGetLog />
    </cffunction>
    <cffunction access="public" name="getLast24logs" output="false" returntype="query">
        <cfargument name="id" type="string" required="no" default="">
        <cfquery name="qGetLog" datasource="#this.odbc#">
        select * 
            from( 
            Select itemsproduced, machine.name,datepart(hour,[time]) as hour
            from [log] with (nolock)
            Inner join machine on [log].idmachine = machine.id
            where 1=1 and [log].status=1
            <cfif arguments.id neq "">
               and  idMachine=N'#arguments.id#'
            </cfif>
                and (cast([time] as date) = '#dateformat(now(),"yyyy-mm-dd")#' or cast([time] as date) = '#dateformat(DateAdd('d', -1, now()),"yyyy-mm-dd")#')
            ) as d
            pivot (avg(itemsproduced) for [hour] in (<cfloop from=0 to="22" index="i">[#i#],</cfloop>[23])) as test
        </cfquery>
        <cfreturn qGetLog />
    </cffunction>
</cfcomponent>

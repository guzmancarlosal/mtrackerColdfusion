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
                    values (N'#arguments.comments#')
                </cfquery>
                <cfquery name="qGetID" datasource="#this.odbc#">
                    SELECT max(id) as id from description with (nolock) where description like '#left(arguments.comments, 5)#%'
                </cfquery>
                <cfset local.idDescription = qGetID.id>
            </cfif>
    		<cfquery name="qAddlog" datasource="#this.odbc#">
                Insert into log (idusuario, idMachine,time, status, idDescription, itemsproduced, gooditems)
                values (N'#arguments.userID#',N'#arguments.idMachine#',#now()#,'#machineStatus#','#local.idDescription#','#pie1#', '#pie2#')
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
</cfcomponent>

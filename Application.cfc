<cfcomponent> 
<cfset This.name = "Orders"> 
<cfset This.Sessionmanagement="True"> 
<cfset This.loginstorage="session"> 
 
<cffunction name="OnRequestStart"> 
    <cfargument name = "request" required="true"/> 
    <cfif IsDefined("Form.logout")> 
        <cflogout> 
    </cfif> 
 
    <cflogin> 
        <cfif NOT IsDefined("cflogin")> 
            <cfinclude template="loginform.cfm"> 
            <cfabort> 
        <cfelse> 
            <cfif cflogin.name IS "" OR cflogin.password IS ""> 
                <cfoutput> 
                    <h2>You must enter text in both the User Name and Password fields. 
                    </h2> 
                </cfoutput> 
                <cfinclude template="loginform.cfm"> 
                <cfabort> 
            <cfelse> 

                <cfquery name="loginQuery" dataSource="cc_mtracker"> 
                    SELECT id, username, type, status 
                    FROM [User] 
                    WHERE 
                        username = '#cflogin.name#' 
                        AND password = '#cflogin.password#' 
                </cfquery>

                
                <cfif loginQuery.recordcount>
                    <cfif loginQuery.status neq 0>
                        <cfloginuser name="#cflogin.name#" Password = "#cflogin.password#" roles="#loginQuery.type#">
                    <cfelse>
                        <cfset errormsj ="User <cfoutput><b>"&cflogin.name&"</b> been deactivated. Please Contact your Administrator">
                        <cfinclude template="loginform.cfm"> 
                        <cfabort> 
                    </cfif>
                <cfelse>

                    <cfoutput> 
                       <cfset errormsj ="Your UserName and password are not valid, please try again">
                    </cfoutput>     
                    <cfinclude template="loginform.cfm"> 
                    <cfabort> 
                </cfif> 
            </cfif>     
        </cfif> 
    </cflogin> 
 
    <cfif GetAuthUser() NEQ ""> 
        <cfoutput> 
            <form action="security.cfm" method="Post"> 
                <input type="submit" Name="Logout" value="Logout"> 
            </form> 
        </cfoutput> 
    </cfif> 
 
</cffunction> 
<cffunction name="onError"> 
    <cfargument name="Exception" required=true/> 
    <cfargument type="String" name="EventName" required=true/> 
    <!--- Log all errors. ---> 
    <cflog file="#This.Name#" type="error"  
            text="Event Name: #Arguments.Eventname#" > 
    <cflog file="#This.Name#" type="error"  
            text="Message: #Arguments.Exception.message#"> 
    <cflog file="#This.Name#" type="error"  
        text="Root Cause Message: #Arguments.Exception.rootcause.message#"> 
    <!--- Display an error message if there is a page context. ---> 
    <cfif NOT (Arguments.EventName IS "onSessionEnd") OR  
            (Arguments.EventName IS "onApplicationEnd")> 
        <cfoutput> 
            <h2>An unexpected error occurred.</h2> 
            <p>Please provide the following information to technical support:</p> 
            <p>Error Event: #Arguments.EventName#</p> 
            <p>Error details:<br> 
            <cfdump var=#Arguments.Exception#></p> 
        </cfoutput> 
    </cfif> 
</cffunction>
</cfcomponent>
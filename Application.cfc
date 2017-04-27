<cfcomponent> 
<cfset This.name = "MTracker"> 
<cfset This.Sessionmanagement="True"> 
<cfset This.loginstorage="session"> 
 
<cffunction name="OnRequestStart"> 
    <cfargument name = "request" required="true"/> 
    <cfif IsDefined("form.logout")> 
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
                       WHERE username=<cfqueryparam value='#cflogin.name#' CFSQLTYPE="CF_SQL_VARCHAR">
                    AND password=<cfqueryparam value='#cflogin.password#' CFSQLTYPE='CF_SQL_VARCHAR'>
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
            <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/css/bootstrap.min.css">
            <script src="js/jquery-3.2.1.min.js" ></script>
            <script src="https://cdnjs.cloudflare.com/ajax/libs/tether/1.4.0/js/tether.min.js"></script>
            <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/js/bootstrap.min.js" ></script>
            <cfinclude template="verification.cfm">
            <style>

                .bg-inverse {
                    background-color: ##005e85 !important;
                }
                body {
                    padding-top: 0px !important;
                }
            </style>
            <nav class="navbar navbar-toggleable-md navbar-inverse bg-inverse" style="">

              <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="##navbarsExampleDefault" aria-controls="navbarsExampleDefault" aria-expanded="false" aria-label="Toggle navigation">
                 
                <span class="navbar-toggler-icon"></span>
              </button>
              <a class="navbar-brand" href="index.cfm"><img src="img/mTrackericonsmal.png"> MTracker</a>

              <div class="collapse navbar-collapse" id="navbarsExampleDefault">
                <ul class="navbar-nav mr-auto">
                    <cfif trim(userRole) eq "admin">
                        <li class="nav-item active">
                            <a class="nav-link" href="admin.cfm">Administrador <span class="sr-only">(current)</span></a>
                        </li>
                    </cfif>
                    <cfif trim(userRole) eq "admin" or trim(userRole) eq "report">
                        <li class="nav-item active">
                            <a class="nav-link" href="reports.cfm" >Reporte <span class="sr-only">(current)</span></a>
                        </li>
                    </cfif>
                </ul>
                <a class="nav-link" style="color:white"><b>#GetAuthUser()#</b></a>
           
                <form class="form-inline my-2 my-md-0" id="logoutForm" name="logoutForm" action="index.cfm" method="Post">
                    <input type="hidden" id="logout" name="logout">
                    <button class="btn btn-default" type="submit" onClick="logoutForm.submit();">Salir</button>
                </form>  
              </div>
            </nav>
        </cfoutput>
    </cfif> 
</cffunction> 
<!---<cffunction name="onError"> 
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
</cffunction>--->
</cfcomponent>
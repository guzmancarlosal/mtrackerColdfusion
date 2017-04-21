<cfquery name="qGetMachine" datasource="cc_mtracker">
  SELECT * from machine
  WHERE status = 1
</cfquery>
<cfoutput>
  <!DOCTYPE html>
  <html>
    <head>
      <cfprocessingdirective pageencoding = "utf-8">
      <title>MTracker</title>
      <link href="css/justified-nav.css" rel="stylesheet">
    </head>
    <body>
      <div class="container">
      <!-- Jumbotron -->
      <div class="jumbotron">
        <h1>Bienvenido a #application.applicationname#</h1>
        <p class="lead">Selecciona la máquina para iniciar la operación!</p>
        <select id="machineid" name="machineid" class="form-control">
          <cfloop query="#qGetMachine#">
            <option value="#qGetMachine.id#">#qGetMachine.name#
          </cfloop>
        </select><br>
        <p><a class="btn btn-lg btn-success" href="addLog.cfm?machineid=1" role="button" id="startBtn">Empezar</a></p>        
      </div>
      <!-- Site footer -->
      <footer class="footer">
        <p>&copy; Xikma Apps #year(now())#</p>
      </footer>
      </div> <!-- /container -->
      <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
      <script src="js/ie10-viewport-bug-workaround.js"></script>
    </body>
  </html>
</cfoutput>

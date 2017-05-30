<cfparam name="request.ODBC" default="cc_mtracker">
<cfquery name="qGetMachine" datasource="#request.ODBC#">
  select machine.id as mid, machine.name, u.id as uid, l.name as locationname
  From machine with (nolock)
  inner join loc l on machine.idLoc = l.id
  inner join user_machine with (nolock) on machine.id = user_machine.machineID
  inner join [user] u  with (nolock) on u.id=user_machine.userid
  where u.username='#GetAuthUser()#'
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
        <cfif qGetMachine.recordcount>
          <select id="machineid" name="machineid" class="form-control">
            <cfloop query="#qGetMachine#">
              <option value="#qGetMachine.mid#">#qGetMachine.name#
            </cfloop>
          </select><br>
           <p><a class="btn btn-lg btn-success" href="##" role="button" id="startBtn">Empezar</a></p>
        <cfelse>
          <br>
          <div style="color:red">No has sido asignado a ninguna Operación, contacta al administrador.</div>
          <br>
        </cfif>
               
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
<script>
  $(document).ready(function(){
    $("#startBtn").click(function(){
      $(window).attr('location','addLog.cfm?machineid='+$('#machineid').val()+'&userid=<cfoutput>#qGetMachine.uid#</cfoutput>')
    });
  });
</script>

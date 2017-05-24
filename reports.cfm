<Cfif #GetUserRoles()#  neq 4 and #GetUserRoles()#  neq 1>
    <cfinclude template="deny.cfm">
    <cfabort>
</Cfif>
<cfoutput>

  <!DOCTYPE html>
  <html>
    <head>

      <title>MTracker</title>
      <link href="css/justified-nav.css" rel="stylesheet">
      <style>
       button { 
          width: 100%;
        }
      </style>
    </head>
    <body>
        <div class="container">
            <!-- Jumbotron -->
            
            <div class="jumbotron">
                <h1><i class="fa fa-bar-chart" aria-hidden="true"></i> #application.applicationname# Reportes</h1>
                <p class="lead">Selecciona el Reporte</p>
            </div>
            <div class="row">
                <div class="col-sm-6 text-center">
                    <p><a class="btn btn-lg btn-success btn-block" href="userReport.cfm" role="button" id="startBtn"><i class="fa fa-cog" aria-hidden="true"></i>Producción Máquina por hora</a></p>
                </div>
                <div class="col-sm-6 text-center">
                    <p><a class="btn btn-lg btn-success btn-block" href="machineReport.cfm" role="button" id="startBtn"><i class="fa fa-area-chart" aria-hidden="true"></i> Reporte de defectos</a></p>
                </div>
                
            </div>
            <div class="row">
                <div class="col-sm-6 text-center">
                    <p><a class="btn btn-lg btn-success btn-block" href="orgReport.cfm" role="button" id="startBtn"><i class="fa fa-bar-chart" aria-hidden="true"></i> Métricas por sitio</a></p>
                </div>
                <div class="col-sm-6 text-center">
                    <p><a class="btn btn-lg btn-success btn-block" href="orgReport.cfm" role="button" id="startBtn"><i class="fa fa-check-square" aria-hidden="true"></i> Reporte OEE por Máquina</a></p>
                </div>
                <!---<div class="col-sm-3 text-center">
                    <p><a class="btn btn-lg btn-success" href="siteReport.cfm" role="button" id="startBtn"><i class="fa fa-area-chart" aria-hidden="true"></i> Sitio</a></p>
                </div>
                <div class="col-sm-3 text-center">
                    <p>Agregar, modificar, eliminar datos de Sitios</p>--->
                </div>
            </div>
            
        </div>
        <div class="container">
            <div class="col-sm-4 text-center">&nbsp;</div>
        </div>
        <div class="container">
            <div class="col-sm-4 text-center">&nbsp;</div>
        </div>
        <div class="container">
            <div class="col-sm-4 text-center">&nbsp;</div>
        </div>
        <div class="container">
            <div class="col-sm-4 text-center">&nbsp;</div>
        </div>
        <div class="container">
            <footer class="footer">
                <p>&copy; Xikma Apps #year(now())#</p>
            </footer>
        </div>
    
          <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
          <script src="js/ie10-viewport-bug-workaround.js"></script>
    </body>
  </html>
</cfoutput>

<cfparam name="url.orgID" default="">
<cfparam name="variables.name" default="">
<cfparam name="variables.active" default="">
<cfparam name="variables.orgName" default="Agregar Organizacion">
<cfparam name="request.ODBC" default="cc_mtracker">

<!DOCTYPE html>

<html>
<head>
  <cfprocessingdirective pageencoding = "utf-8">
  <link rel="icon" href="../../favicon.ico">

  <title>Org</title>
	<script>
	 $("#sbmBtn").click(function(){
        $("#myModal").modal();
    });
	</script>

</head>
<cfif url.orgID neq "">
	<cfset orgObj = createObject("component","library.cfc.org").init(odbc=request.ODBC)>
	<cfset qOrgs = orgObj.getOrg(id=url.orgID)>
	<cfset variables.orgName = qOrgs.name>
</cfif>

<body >
	<cfoutput>
	<div class="container">
		<!---<form name="addLog" id="addLog" class="form-horizontal">--->
			<h1 class="text-center">#variables.orgName#</h1>
		
			<div class="form-group form-group-lg">
				<input class="form-control input-lg" id="name" placeholder="Nombre de la Organización" type="text" value ="#variables.name#">
			</div>
			<div class="form-group form-group-lg">
				<select class="form-control input-lg" id="active" placeholder="Status">
					<option value="" selected disabled <cfif variables.active eq "">selected</cfif>>Selecciona el estatus de la Organización</option>
					<option value="1" <cfif variables.active eq "1">selected</cfif>>Activo</option>
					<option value="0" <cfif variables.active eq "0">selected</cfif>>Inactivo</option>
				</select>
			</div>
			<div class="form-group form-group-lg text-center">
				<button class="btn btn-success" data-toggle="modal" id="sbmBtn">
					Actualizar
				</button>
			</div>
		<!---</form>--->
		</div>
		<!-- Modal content-->
		<div class="modal fade" id="myModal" role="dialog">
			<div class="modal-dialog">
			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
					Alerta
				</div>
				<div class="modal-body">
					<p>La información ha sido guardad exitosamente.</p>
				</div>

				<div class="modal-footer ">
					<button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
				</div>
			</div>

		</div>
	</div>
	</cfoutput>
	<script src="js/ie10-viewport-bug-workaround.js"></script>
</body>
</html>

<Cfif #GetUserRoles()#  neq 4 and #GetUserRoles()#  neq 1>
	<cfinclude template="deny.cfm">
	<cfabort>
</Cfif>
<cfparam name="url.userId" default="">
<cfparam name="variables.name" default="">
<cfparam name="variables.active" default="">
<cfparam name="variables.userName" default="Agregar un Usuario">
<cfparam name="variables.siteIDList" default="">
<cfparam name="variables.machineIDList" default="">
<cfparam name="variables.password" default="">
<cfparam name="variables.type" default="">
<cfparam name="request.ODBC" default="cc_mtracker">

<!DOCTYPE html>

<html>
<head>
  <cfprocessingdirective pageencoding = "utf-8">
  <link rel="icon" href="img/mTrackericonsmal.png">

  <title>Usuario</title>

	<script>
	$(document).ready(function(){
		$("#sbmBtn").click(function(){
			if(validateForm()){
	        	$.ajax({
		           type: "POST",
		           url: "action.cfm",
		           data:  { 
                    	username : $('#username').val(), 
                    	password: $('#password').val(), 
                    	type : $('#type').val(), 
                    	status : $('#status').val(), 
                    	locList : $('#siteID').val().toString(), 
                    	machineList : $('#machine').val().toString(), 
                    	userID : $('#userID').val(),
                    	mode: "userAction"
                   },
		           success: function(data)
		           {
		               $("#myModal").modal();
		           }
		        });
	        }
	    });
	    $('#backBtn').click(function(){
	    	$(location).attr('href', 'userReport.cfm');
	    });
	      $('#closeBtn').click(function(){
	    	$(location).attr('href', 'userReport.cfm');
	    });
	});
	function validateForm() {
		if(!$('#username').val()) {
			alert('El campo NOMBRE DEL USURIO es requerido');
			$('#username').focus(function() {
  				
			});
			return false;	
		}
		if(!$('#password').val() || !$('#password2').val()) {
			alert('Debes Confirmar la Contraseña');
			$('#password').focus(function() {
  				
			});
			return false;	
		}
		if($('#password').val() != $('#password2').val()) {
			alert('Las contraseñas no coinciden');
			$('#password').focus(function() {
  				
			});
			return false;	
		}
		if(!$('#machine').val()) {
			alert('Debes seleccionar al menos una MAQUINA');
			$('#machine').focus(function() {
  				
			});
			return false;	
		}

		if(!$('#siteID').val()) {
			alert('El campo SITIO es requerido');
			$('#siteID').focus(function() {
  				
			});
			return false;	
		}
		var r = confirm("ATENCIÓN! Los cambios que estas apunto de guardar tendrán gran efecto en sus reportes. Si usted no sabe lo que esta haciendo precione Cancel y consulte a su administrador.");
		if (r == true) {
		    return true;
		} else {
		    return false;
		}
	}
	</script>

</head>
<cfif url.userID neq "" and isnumeric(url.userID)>
	<cfset userObj = createObject("component","library.cfc.user").init(odbc=request.ODBC)>
	<cfset qLoc = userObj.getUser(id=url.userID)>
	<cfquery name="qUserMachine" datasource="#request.odbc#">
		Select * from user_machine where userid='#url.userID#'
	</cfquery>
	<cfset variables.machineIDList = valueList(qUserMachine.machineid)>
	<cfquery name="qUserLoc" datasource="#request.odbc#">
		Select * from user_loc where idUser='#url.userID#'
	</cfquery>
	<cfset variables.siteIDList = valueList(qUserLoc.idloc)>
	<cfset variables.userName = qLoc.username>
	<cfset variables.password = qLoc.password>
	<cfset variables.type = qLoc.type>
	<cfset variables.status = qLoc.status>
</cfif>
<cfset locObj = createObject("component","library.cfc.loc").init(odbc=request.ODBC)>
<cfset qLocs = locObj.getAllActiveLocs()>
<cfset mObj = createObject("component","library.cfc.machine").init(odbc=request.ODBC)>
<cfset qMach = mObj.getAllActiveM()>
<cfquery name="qRole" datasource="#request.odbc#">
	Select * from role where status=1 and id<>'4'
</cfquery>


<body >
	<cfoutput>
	<div class="container">
		<form name="addLog" id="addLog" class="form-horizontal">
			<h1 class="text-center"><i class="fa fa-users" aria-hidden="true"></i> #variables.userName#</h1>
		
			<div class="form-group form-group-lg">
				<input class="form-control input-lg" id="username" placeholder="Nombre del Usuario" type="text" value ="#variables.userName#" required>
			</div>
			
			<div class="form-group form-group-lg">
			<input class="form-control input-lg" id="password" placeholder="Contraseña" type="password" value ="#variables.password#" required>
			</div>
			<div class="form-group form-group-lg">
				<input class="form-control input-lg" id="password2" placeholder="Confirmar Contraseña" type="password" value ="#variables.password#" required>
			</div>

			<div class="form-group form-group-lg">
				<b>Tipo de Usuario</b>
				<select class="form-control input-lg" id="type" placeholder="Tipo" required >
					<option value="" selected disabled <cfif variables.type eq "">selected</cfif>></option>
					<cfloop query="qRole">
						<option value="#qRole.id#" <cfif variables.type eq qRole.id>selected</cfif>>#qRole.name#</option>
					</cfloop>
					
				</select>
			</div>
			<div class="form-group form-group-lg">
				<b>Sitios</b>
				<select class="form-control input-lg" id="siteID" placeholder="Sitio" required multiple>
					<cfloop query="qLocs">
						<option value="#qLocs.id#"  <cfif listfind(variables.siteIDList,qLocs.id) >selected</cfif>>#qLocs.name#</option>
					</cfloop>
					
				</select>
			</div>
			<div class="form-group form-group-lg">
				<b>Máquinas</b>
				<select class="form-control input-lg" id="machine" placeholder="Máquinas" required multiple>
					<cfloop query="qMach">
						<option value="#qMach.id#" <cfif listfind(variables.machineIDList,qMach.id) >selected</cfif>>#qMach.name#</option>
					</cfloop>
					
				</select>
			</div>
			<div class="form-group form-group-lg">
				<b>Estatus</b>
				<select class="form-control input-lg" id="status" placeholder="Status" required>
					<option value="1" <cfif variables.active eq "1">selected</cfif>>Activo</option>
					<option value="0" <cfif variables.active eq "0">selected</cfif>>Inactivo</option>
				</select>
			</div>
			<div class="form-group form-group-lg text-center">
				<input type="hidden" value="#url.userID#" id="userID">
				<input type="button" class="btn btn-success" id="sbmBtn" value="<cfif url.userID neq "">Actualizar<cfelse>Agregar</cfif>"/>
				<button class="btn btn-danger" id="backBtn">
					Regresar
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
					<p>El sitio ha sido guardado exitosamente.</p>
				</div>

				<div class="modal-footer ">
					<button type="button" class="btn btn-default" data-dismiss="modal" id="closeBtn">Cerrar</button>
				</div>
			</div>

		</div>
	</div>
	</cfoutput>
	<script src="js/ie10-viewport-bug-workaround.js"></script>
</body>
</html>

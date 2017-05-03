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

  <title>Sitio</title>
	<script>
	$(document).ready(function(){
		$("#sbmBtn").click(function(){
			if(validateForm()){
	        	$.ajax({
		           type: "POST",
		           url: "action.cfm",
		           data:  { 
                    	name : $('#name').val(), 
                    	userID : $('#userID').val(), 
                    	orgID : $('#orgID').val(), 
                    	country : $('#country').val(), 
                    	active : $('#active').val(), 
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
	    	$(location).attr('href', 'siteReport.cfm');
	    });
	      $('#closeBtn').click(function(){
	    	$(location).attr('href', 'siteReport.cfm');
	    });
	});
	function validateForm() {
		if(!$('#name').val()) {
			alert('El campo NOMBRE DEL USURIO es requerido');
			$('#name').focus(function() {
  				
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
	<cfset siteObj = createObject("component","library.cfc.loc").init(odbc=request.ODBC)>
	<cfset qLoc = siteObj.getLoc(id=url.userID)>
	<cfdump var="#qLoc#">
	<cfset variables.userName = qLoc.name>
	<cfset variables.name = qLoc.name>
	<cfset variables.active = qLoc.status>
	<cfset variables.country = qLoc.country>
	<cfset variables.orgID = qLoc.orgID>
</cfif>
<cfset locObj = createObject("component","library.cfc.loc").init(odbc=request.ODBC)>
<cfset qLocs = locObj.getAllActiveLocs()>
<cfset mObj = createObject("component","library.cfc.machine").init(odbc=request.ODBC)>
<cfset qMach = mObj.getAllActiveM()>

<body >
	<cfoutput>
	<div class="container">
		<form name="addLog" id="addLog" class="form-horizontal">
			<h1 class="text-center">#variables.userName#</h1>
		
			<div class="form-group form-group-lg">
				<input class="form-control input-lg" id="name" placeholder="Nombre del Usuario" type="text" value ="#variables.name#" required>
			</div>
			
			<div class="form-group form-group-lg">
			<input class="form-control input-lg" id="password" placeholder="Contraseña" type="password" value ="#variables.password#" required>
			</div>
			<div class="form-group form-group-lg">
				<input class="form-control input-lg" id="password2" placeholder="Confirmar Contraseña" type="password" value ="#variables.password#" required>
			</div>
			<div class="form-group form-group-lg">
				<select class="form-control input-lg" id="siteID" placeholder="Sitio" required multiple>
					<option value="" selected disabled <cfif variables.siteIDList eq "">selected</cfif>>Sitio</option>
					<cfloop query="qLocs">
						<option value="#qLocs.id#" <cfif variables.siteIDList eq qLocs.id>selected</cfif>>#qLocs.name#</option>
					</cfloop>
					
				</select>
			</div>
			<div class="form-group form-group-lg">
				<select class="form-control input-lg" id="machine" placeholder="Máquinas" required multiple>
					<option value="" selected disabled <cfif variables.machineIDList eq "">selected</cfif>>Sitio</option>
					<cfloop query="qMach">
						<option value="#qMach.id#" <cfif variables.machineIDList eq qMach.id>selected</cfif>>#qMach.name#</option>
					</cfloop>
					
				</select>
			</div>
			<div class="form-group form-group-lg">
				<select class="form-control input-lg" id="active" placeholder="Status" required>
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

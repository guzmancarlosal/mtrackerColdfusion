<cfparam name="url.orgID" default="">
<cfparam name="variables.name" default="">
<cfparam name="variables.active" default="">
<cfparam name="variables.orgName" default="Agregar Organización">
<cfparam name="request.ODBC" default="cc_mtracker">

<!DOCTYPE html>

<html>
<head>
  <cfprocessingdirective pageencoding = "utf-8">
  <link rel="icon" href="img/mTrackericonsmal.png">

  <title>Org</title>
	<script>
	$(document).ready(function(){
		$("#sbmBtn").click(function(){
			if(validateForm()){
	        	$.ajax({
		           type: "POST",
		           url: "action.cfm",
		           data:  { 
                    	name : $('#name').val(), 
                    	orgID : $('#orgID').val(), 
                    	active : $('#active').val(), 
                    	mode: "orgAction"
                   },
		           success: function(data)
		           {
		               $("#myModal").modal();
		           }
		        });
	        }
	    });
	    $('#backBtn').click(function(){
	    	$(location).attr('href', 'orgReport.cfm');
	    });
	      $('#closeBtn').click(function(){
	    	$(location).attr('href', 'orgReport.cfm');
	    });
	});
	function validateForm() {
		if($('#name').val()=="") {
			alert('El campo NOMBRE DE LA ORGANIZACIÓN es requerido');
			$('#name').focus(function() {
  				
			});
			return false;	
		}
		if($('#active').val()=="") {
			alert('El campo ESTATUS DE LA ORANIZACIÓN es requerido');
			$('#name').focus(function() {
  				
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
<cfif url.orgID neq "" and isnumeric(url.orgID)>
	<cfset orgObj = createObject("component","library.cfc.org").init(odbc=request.ODBC)>
	<cfset qOrgs = orgObj.getOrg(id=url.orgID)>


	<cfset variables.orgName = qOrgs.name>
	<cfset variables.name = qOrgs.name>
	<cfset variables.active = qOrgs.status>
</cfif>

<body >
	<cfoutput>
	<div class="container">
		<form name="addLog" id="addLog" class="form-horizontal">
			<h1 class="text-center">#variables.orgName#</h1>
		
			<div class="form-group form-group-lg">
				<input class="form-control input-lg" id="name" placeholder="Nombre de la Organización" type="text" value ="#variables.name#" required>
			</div>
			<div class="form-group form-group-lg">
				<select class="form-control input-lg" id="active" placeholder="Status" required>
					<option value="" selected disabled <cfif variables.active eq "">selected</cfif>>Selecciona el estatus de la Organización</option>
					<option value="1" <cfif variables.active eq "1">selected</cfif>>Activo</option>
					<option value="0" <cfif variables.active eq "0">selected</cfif>>Inactivo</option>
				</select>
			</div>
			<div class="form-group form-group-lg text-center">
				<input type="hidden" value="#url.orgID#" id="orgID">
				<input type="button" class="btn btn-success" id="sbmBtn" value="<cfif url.orgID neq "">Actualizar<cfelse>Agregar</cfif>"/>
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
					<p>La Organizacion ha sido guardada exitosamente.</p>
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

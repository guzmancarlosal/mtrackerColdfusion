  <cfoutput>
  <html>
  <head>
  	<title>MTracker</title>
  	<cfprocessingdirective pageencoding = "utf-8">
  	<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/v/dt/dt-1.10.13/datatables.min.css"/>
	<script type="text/javascript" src="https://cdn.datatables.net/v/dt/dt-1.10.13/datatables.min.js"></script>
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script src="//code.jquery.com/jquery-1.12.4.js"></script>
	<script src="https://cdn.datatables.net/1.10.13/js/jquery.dataTables.min.js"></script>
	<script src="https://cdn.datatables.net/1.10.13/js/dataTables.bootstrap.min.js"></script>
	<script src="https://cdn.datatables.net/buttons/1.2.4/js/dataTables.buttons.min.js"></script>
	<script src="https://cdn.datatables.net/buttons/1.2.4/js/buttons.bootstrap.min.js"></script>
	<script src="//cdnjs.cloudflare.com/ajax/libs/jszip/2.5.0/jszip.min.js"></script>
	<script src="//cdn.rawgit.com/bpampuch/pdfmake/0.1.24/build/pdfmake.min.js"></script>
	<script src="//cdn.rawgit.com/bpampuch/pdfmake/0.1.24/build/vfs_fonts.js"></script>
	<script src="//cdn.datatables.net/buttons/1.2.4/js/buttons.html5.min.js"></script>
	<script src="//cdn.datatables.net/buttons/1.2.4/js/buttons.print.min.js"></script>
	<script src="//cdn.datatables.net/buttons/1.2.4/js/buttons.colVis.min.js"></script>
    <script type="text/javascript">
      google.charts.load('current', {'packages':['corechart']});
      google.charts.setOnLoadCallback(drawChart);

      function drawChart() {
        var data = google.visualization.arrayToDataTable([
          ['Hora', 'Máquina1', 'Máquina2',	'Máquina3'],
          <cfloop from="00" to="22" index="i">
          	['#i#', #randRange(800, 1000)#,	#randRange(200, 500)#,	#randRange(0, 80)#],
          </cfloop>
		  ['23',  880,       70, 	10 ]
        ]);

        var options = {
          title: 'Producción por Máquina en las últimas 24 horas',
          curveType: 'function',
          legend: { position: 'bottom' }
        };

        var chart = new google.visualization.LineChart(document.getElementById('curve_chart'));

        chart.draw(data, options);

     //starting png





      var data1 = google.visualization.arrayToDataTable([
        ['Element', 'Density', { role: 'style' }],
        ['Copper', 8.94, '##b87333', ],
        ['Silver', 10.49, 'silver'],
        ['Gold', 19.30, 'gold'],
        ['Platinum', 21.45, 'color: ##e5e4e2' ]
      ]);

     

 	}
 	$(document).ready(function() {
	    var table = $('##example').DataTable( {
	        lengthChange: false,
	        buttons: [ 'copy', 'excel', 'pdf', 'colvis' ]
	    } );
	 
	    table.buttons().container()
	        .appendTo( '##example_wrapper .col-sm-6:eq(0)' );
	} );
    </script>
  </head>
  <body>
	<div class="container">
		<div class="row">
			<div class="col-sm-12 text-center">
	    		<div id="curve_chart" style="height:400px" ></div>
	    	</div>
			
	    </div>
	    <div class="row">
		    <div class="col-sm-12 text-center">
				<p><a class="btn btn-success" href="##" role="button" id="startBtn">Descarga PDF</a></p>
			</div>
		</div>
		<p class="lead">Reporte de Mermas</p>

		<table id="example" class="table table-striped table-bordered" cellspacing="0" width="100%">
	        <thead>
	            <tr>
	                <th>Maquina</th>
	                <th>Tipo</th>
	                <th>Mermas</th>
	            </tr>
	        </thead>
	        <tfoot>
	            <tr>
	               	<th>Maquina</th>
	                <th>Tipo</th>
	                <th>Mermas</th>
	            </tr>
	        </tfoot>
	        <tbody>
	        	<cfloop from="1" to="20" index="i">
	        		<tr>
	        			<td>i-X-#i#</td>
	        			<td>Tuercas</td>
	        			<td>#randRange(0, 20)#</td>
	        		<tr>
	        	</cfloop>
	        <tbody>
	    <table>
    </div>
  </body>
</html>
</cfoutput>

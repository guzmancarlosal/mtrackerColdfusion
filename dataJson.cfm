<cfparam name="url.machineid" default="">
<cfparam name="url.mode" default="">
<cfparam name="request.ODBC" default="cc_mtracker">
<cfparam name="url.mode" default="">

<cfcontent reset="true">

<cfset local.responseJson=[]>
<cfprocessingdirective pageEncoding="utf-8">

<cfif url.mode eq "getMachineByHour">
	

	<cfset lObj = createObject("component","library.cfc.report").init(odbc=request.ODBC)>
	<cfset local.qgetLastLog =lObj.getLast24logs(id=url.machineid)>
	<cfset local.obj = 0>
	<cfif url.machineid neq "">
		<cfquery name="qGetObje" datasource="#request.odbc#">
			Select capacity from machine with (nolock) where id='#url.machineid#'
		</cfquery>
		<cfset local.obj = qGetObje.capacity>
	</cfif>
	
	<cfif local.qgetLastLog.recordcount>
		<cfset local.thisArrData =[]>
		<cfscript>
			local.headersarr =['Hora','Objetivo'];
			listOfColumnValues = ValueList( local.qgetLastLog.name );
			tagsArray = createObject("java", "java.util.HashSet").init(ListToArray(trim(listOfColumnValues))).toArray();
			ArrayAppend(local.headersarr, tagsArray,"true");
		</cfscript>
		<cfset local.getcurrentHour = hour(now())>		
		<cfloop from="1" to="24" index="i">
			<cfset  local.thisArrData[i] = "0">
			<cfif local.qgetLastLog["#i-1#"][1] neq "">
				<cfset  local.thisArrData[i] = local.qgetLastLog["#i-1#"][1]>
			</cfif>
		</cfloop>

		<cfsavecontent variable="output">
			<cfoutput>
				<cfset local.todayAndYesterday = day(now())>
				<cfset local.yearYesterday = year(now())>
				<cfset local.monthYesterday = month(now())-1>
				#serializeJSON(local.headersarr)#,
				<cfloop from="23" to="0" index="i" step="-1">
					[new Date(#local.yearYesterday#,  #local.monthYesterday# ,#local.todayAndYesterday# ,#local.getcurrentHour#), #local.obj#,#local.thisArrData[local.getcurrentHour+1]#] <cfif i neq 0>,</cfif>
					<cfif local.getcurrentHour eq 0>
						<cfset local.getcurrentHour = 23>
						<cfset local.todayAndYesterday = day(DateAdd('d', -1, now()))>
						<cfset local.yearYesterday = year(DateAdd('d', -1, now()))>
						<cfset local.monthYesterday = month(DateAdd('d', -1, now()))-1>
					<cfelse>
						<cfset local.getcurrentHour -->
					</cfif>
				</cfloop>
			</cfoutput>
		</cfsavecontent>
		
		<cfoutput>[#trim(output)#]</cfoutput>
	<cfelse>
		[]
	</cfif>
<cfelseif url.mode eq "getMachineByHourall">
	<cfset lObj = createObject("component","library.cfc.report").init(odbc=request.ODBC)>
	<cfset local.qgetLastLog =lObj.getLast24logs()>
	<cfif local.qgetLastLog.recordcount>
		<cfscript>
			local.headersarr =['Hora'];
			listOfColumnValues = ValueList( local.qgetLastLog.name );
			tagsArray = createObject("java", "java.util.HashSet").init(ListToArray(trim(listOfColumnValues))).toArray();
			ArrayAppend(local.headersarr, tagsArray,"true");
		</cfscript>
		<cfset local.getcurrentHour = hour(now())>
		<cfloop query="#local.qgetLastLog#">
			<cfloop from="1" to="24" index="i">
				<cfoutput>#local.qgetLastLog.currentrow#</cfoutput>
				<!---<cfset  local.thisArrData[i] = "0">
				<cfif local.qgetLastLog["#i-1#"][#local.qgetLastLog.currentrow#] neq "">
					<cfset  local.thisArrData[i][#local.qgetLastLog.currentrow#] = local.qgetLastLog["#i-1#"][#local.qgetLastLog.currentrow#]>
				</cfif>--->
			</cfloop><br>
		</cfloop>
		<Cfdump var="#local.thisArrData#">
		<cfsavecontent variable="output">
			<cfoutput>
				#serializeJSON(local.headersarr)#,
				<cfloop from="23" to="0" index="i" step="-1">
					[new Date(#local.yearYesterday#,  #local.monthYesterday# ,#local.todayAndYesterday# ,#local.getcurrentHour#), #local.obj#,#local.thisArrData[local.getcurrentHour+1]#] <cfif i neq 0>,</cfif>
					<cfif local.getcurrentHour eq 0>
						<cfset local.getcurrentHour = 23>
						<cfset local.todayAndYesterday = day(DateAdd('d', -1, now()))>
						<cfset local.yearYesterday = year(DateAdd('d', -1, now()))>
						<cfset local.monthYesterday = month(DateAdd('d', -1, now()))-1>
					<cfelse>
						<cfset local.getcurrentHour -->
					</cfif>
				</cfloop>
			</cfoutput>
		</cfsavecontent>
		
		<cfoutput>[#trim(output)#]</cfoutput>
	</cfif>
<cfelse>
	[]
</cfif>



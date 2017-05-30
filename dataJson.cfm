<cfparam name="url.machineid" default="">
<cfparam name="url.mode" default="">
<cfparam name="request.ODBC" default="cc_mtracker">
<cfparam name="url.mode" default="">

<cfcontent reset="true">

<cfset local.responseJson=[]>
<cfprocessingdirective pageEncoding="utf-8">
<cfheader charset="utf-8" name="Content-Type" value="application/json">
<cfif url.mode eq "getMachineByHour">
	

	<cfset lObj = createObject("component","library.cfc.report").init(odbc=request.ODBC)>
	<cfset local.qgetLastLog =lObj.getLast24logs(id=url.machineid)>
	<cfif local.qgetLastLog.recordcount>
		<cfset local.thisArrData =[]>
		<cfscript>
			local.headersarr =['Hora'];
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
		<!---[<cfoutput>#serializeJSON(local.headersarr)#,--->
		<!---<cfoutput>#serializeJSON(local.thisArrData)#</cfoutput>
		]--->
		<cfsavecontent variable="output">
			<cfoutput>
				#serializeJSON(local.headersarr)#,
				<cfloop from="23" to="0" index="i" step="-1">
					[#local.getcurrentHour#, #local.thisArrData[i+1]#] <cfif i neq 0>,</cfif>
					<cfif local.getcurrentHour eq 0>
						<cfset local.getcurrentHour = 23>
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
<cfelse>
	[]
</cfif>



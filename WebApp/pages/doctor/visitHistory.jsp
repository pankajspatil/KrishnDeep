<%@page import="com.org.krishnadeep.generic.ConnectionsUtil"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.org.krishnadeep.modules.Visit"%>
<%@page import="com.org.krishnadeep.generic.Utils"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ include file="/pages/common/validateSession.jsp"%>
<%@ include file="/pages/common/header.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="<%=contextPath %>/resources/css/visit.css"></link>
<script type="text/javascript" src="<%=contextPath %>/resources/js/visit.js"></script>
<script type="text/javascript">
$(document).ready(function() {
    $('#visitData').DataTable({    
    	"aoColumnDefs": [{ "bSortable": false, "aTargets": [ 0 ] }],
    	"order": [[ 2, "desc" ]],
    	"iDisplayLength": 5,
    	"lengthMenu":[5, 10, 25, 50, 100]
    });
} );

</script>
</head>
<body>
<%
	String patientId = Utils.getString(request.getParameter("patientId"));
	//System.out.println("patientId====>" + patientId);
	Visit visit = new Visit();
	
	ResultSet dataRS = visit.getVisitDetail(patientId, null, null);
	
%>
<form name="visitHistory" id="visitHistory">
<h1 class="moduleHeader" style="text-align: center;"> Visit History</h1>
<table border="" align="center" id="visitData" class="display" cellspacing="0" width="100%">
<thead>
	<tr class="headerTR">
		<td>Visit ID</td>
		<td>Patient Name</td>
		<td>Visit Date</td>
		<td>Visit Summary</td>
	</tr>
</thead>
<tbody>
<%
if(dataRS != null){

while(dataRS.next()){
	String visitId = dataRS.getString("user_visit_id");
	String summary = Utils.getString(dataRS.getString("summary"));
	String toolTipText = !summary.equals("") ? "class='clickableToolTip'" : "";
	
	%><tr>	
		<td><div class="clickableLink" onclick="openVisitDetailsPage(<%=visitId%>)"><%=visitId%></div></td>
		<td><%=dataRS.getString("first_name") + " " + dataRS.getString("last_name") %></td>
		<td><div class="clickableLink" onclick="openVisitDetailsPage(<%=visitId%>)"><%=dataRS.getString("created_on") %></div></td>
		<td>
			<div id="<%=visitId %>" <%=toolTipText %>>Summary</div>
			<script type="text/javascript">
			$('#<%=visitId%>').on({
				  "click": function() {
				    $(this).tooltip({ items: "#<%=visitId%>", content: "<%=summary%>"});
				    $(this).tooltip("open");
				  } ,
				  "mouseout": function() {
					  if($(this).tooltip( "instance" ) !== undefined){
						  $(this).tooltip("disable");
					  } 
				  }
				});
			</script>
		</td>
	</tr><%
} 
}
ConnectionsUtil.closeRes(dataRS);
%>
</tbody>
</table>

</form>

</body>
</html>
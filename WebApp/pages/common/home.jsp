<%@page import="com.org.krishnadeep.modules.Visit"%>
<%@page import="com.org.krishnadeep.models.UserVisit"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="java.util.LinkedHashMap"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ include file="/pages/common/header.jsp"%>
    <%@ include file="/pages/common/validateSession.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="<%=contextPath%>/resources/css/home.css">
<link rel="stylesheet" type="text/css" href="<%=contextPath%>/resources/css/materialize.css">
<link rel="stylesheet" type="text/css" href="<%=contextPath%>/resources/css/visit.css"> 
<style>
.col-1 {
    /* background: blue; */
}

.col-2 {
    /* background: gray; */
}

.col-3 {
    /* background: red; */
}

.col-4 {
    /* background: green; */
}

html, body, .container {
    height: 100%;
}

.container {
    position: relative;
    height: 70%;
    width: 100%;
}
.container .blockDiv {
    height: 50%;
    width: 49.8%;
    float: left;
    position: relative;
    /* border: 1px solid gray; */
    max-height: 50%;
}
</style>
<script src="<%=contextPath%>/resources/js/visit.js" type="text/javascript"></script>
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

String pattern = "yyyy-MM-dd"; 
SimpleDateFormat simpleDateFormat = new SimpleDateFormat(pattern); 
String date = simpleDateFormat.format(new Date());
String fromDate = date;
String toDate = date;

Visit visit = new Visit();

List<UserVisit> userVisitList = visit.getUserVisitList(null, fromDate, toDate);
%>
<center><h4>Home</h4></center>
<div class="container">
<div class="col-1 scroll blockDiv">
<center style="font-size: larger;font-weight: bolder;">Today's Visits</center>
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
if(userVisitList.size() > 0){

for(UserVisit userVisit : userVisitList){
	Integer visitId = userVisit.getUserVisitId();
	String summary = Utils.getString(userVisit.getSummary());
	String toolTipText = !summary.equals("") ? "class='clickableToolTip'" : "";
	
	%><tr>	
		<td><div class="clickableLink" onclick="openVisitDetailsPage(<%=visitId%>)"><%=visitId%></div></td>
		<td><%=userVisit.getPatient().getFirstName() + " " + userVisit.getPatient().getLastName() %></td>
		<td><div class="clickableLink" onclick="openVisitDetailsPage(<%=visitId%>)"><%=userVisit.getCreatedOn() %></div></td>
		<td>
			<div id="<%=visitId %>" <%=toolTipText %>>Summary</div>
			<script type="text/javascript">
			$('#<%=visitId%>').on({
				  "click": function() {
					  var summary = '<%=summary.replaceAll("\n|\r", "<br/>")%>';
					    $(this).tooltip({ items: "#<%=visitId%>", content: summary});
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
%>
</tbody>
</table>
    </div>
    <div class="col-2 scroll blockDiv">
    </div>
    <div class="col-3 scroll blockDiv">
    </div>
    <div class="col-4 scroll blockDiv">
    </div>
</div>

</body>
<%@ include file="/pages/common/footer.jsp" %>
</html>

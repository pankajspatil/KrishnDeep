<%@page import="com.org.krishnadeep.models.UserVisit"%>
<%@page import="com.org.krishnadeep.modules.Visit"%>
<%@page import="java.util.List"%>
<%@page import="com.org.krishnadeep.generic.EnglishNumberToWords"%>
<%@page import="java.util.Date"%>
<%@page import="com.org.krishnadeep.generic.Utils"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ include file="/pages/common/validateSession.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="/Krishnadeep/resources/css/print.css" media="print">
<style type="text/css" media="print">
@page {
    size: auto;   /* auto is the initial value */
    margin: 0;  /* this affects the margin in the printer settings */
}
</style>
</head>
<body>
<%
Integer visitId = Utils.getInt(request.getParameter("visitId"));
//out.println("VisitId === >" + visitId);
Visit visit = new Visit();

List<UserVisit> userVisitList = visit.getUserVisitList(visitId, null, null);
UserVisit userVisit = null;
if(userVisitList.size() > 0 ){
	userVisit = userVisitList.get(0);
}

if(userVisit != null){
	
	String patientName =  userVisit.getPatient().getFirstName().toUpperCase() + " " + userVisit.getPatient().getLastName().toUpperCase();
	String doctorName =  userVisit.getDoctor().getFirstName().toUpperCase() + " " + userVisit.getDoctor().getLastName().toUpperCase();
%>
<center>
	<div style="font-size: xx-large; font-weight: bolder;">KRISHNADEEP HOSPITAL</div>
	<div style="font-size: larger; font-weight: bold;">MATERNITY &amp; EYE CARE CENTER</div>
	<span>Kini Arcade, C Wing, 2<sup>nd</sup> Floor, Near Stella Petrol Pump, Stella, Vasai(W).<br/> Mobile : 9960509773 / 7507119030</span><br/>
	
</center>
<!-- <hr/> --> <br />
<%-- <table width="100%" border="0" align="center">
	<tr>
		<td width="10%" align="right">No : </td>
		<td align="left" width="30%">1</td>
		<td width="15%" align="right">Date : </td>
		<td width="35%" align="left"><%=new Date() %></td>
	</tr>
	<tr align="left">
		<td colspan="4">Doctor Name : Kiran Kadav</td>
	</tr>
	<tr align="left">
		<td colspan="4">Patient Name : Kiran Kadav</td>
	</tr>
	<tr align="left">
		<td colspan="4">Fees : 40</td>
	</tr>
	<tr align="left">
		<td colspan="4">Visit Type : Consultation</td>
	</tr>
	<tr align="left">
		<td colspan="4">Diagnosis : Fever</td>
	</tr>
</table> --%>

<table width="100%" border="1" style="border: 1px solid gray; border-collapse: collapse;">
	<tr style="background-color: #D3D3D3; -webkit-print-color-adjust: exact;text-align: center;">
		<td colspan="4" style="font-weight: bold;font-size: large; ">Patient Details</td>
	</tr>
	<tr>
		<th width="15%">Visit No.</th>
		<td width="35%" style="padding-left: 1%"><%=userVisit.getUserVisitId() %></td>
		<th width="15%">Bill Date / Time</th>
		<td width="35%" style="padding-left: 1%"><%=userVisit.getCreatedOn() %></td>
	</tr>
	<tr>
		<th>Patient Name</th>
		<td style="padding-left: 1%"><%=patientName %></td>
		<th>Doctor Name</th>
		<td style="padding-left: 1%"><%=doctorName %></td>
	</tr>
	<tr>
		<th>Age</th>
		<td style="padding-left: 1%"><%=userVisit.getAge() %></td>
		<th>Gender</th>
		<td style="padding-left: 1%"><%=userVisit.getPatient().getSex() %></td>
	</tr>
	<tr>
		<th>Visit Type</th>
		<td style="padding-left: 1%"><%=userVisit.getVisitType().getVisitType() %></td>
		<th>Fees</th>
		<td style="padding-left: 1%"><%=userVisit.getFees() %></td>
	</tr>
	<tr>
		<th>Remarks</th>
		<td colspan="3" style="padding-left: 1%"><%=userVisit.getSummary() %></td>
	</tr>
</table>


<script type="text/javascript">
var w = window.print();
//debugger;
//this.close();

/* window.onbeforeprint = function() {
    alert('This will be called before the user prints.');
};
window.onafterprint = function() {
	alert('This will be called after the user prints');   
}; */
</script>
<%} %>
</body>
</html>
<%@page import="com.org.krishnadeep.generic.EnglishNumberToWords"%>
<%@page import="java.util.Date"%>
<%@page import="com.org.krishnadeep.generic.Utils"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<!-- <link rel="stylesheet" type="text/css" href="/Krishnadeep/resources/css/print.css" media="print"> -->
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
out.println("VisitId === >" + visitId);
%>
<center>
	<h1>KRISHNADEEP HOSPITAL</h1>
	<h2>MATERNITY &amp; EYE CARE CENTER</h2>
	<span>Kini Arcade, C Wing, 2<sup>nd</sup> Floor, Near Stella Petrol Pump, Stella, Vasai(W). Mobile : 9960509773 / 7507119030</span><br/>
	
</center>
<hr/>
<table width="100%" border="0" align="center">
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
</table>

<script type="text/javascript">
//var w = window.print();
//debugger;
//this.close();

/* window.onbeforeprint = function() {
    alert('This will be called before the user prints.');
};
window.onafterprint = function() {
	alert('This will be called after the user prints');   
}; */
</script>
</body>
</html>
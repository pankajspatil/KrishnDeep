<%@page import="java.util.LinkedHashMap"%>
<%@page import="com.org.krishnadeep.generic.Constants"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ include file="/pages/common/header.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="/ResourcePlan/resources/css/generic.css">
<script type="text/javascript" src="/ResourcePlan/resources/js/login.js"></script>
</head>
<body>
<%

if(request.getParameter("page1") != null){
	String userDispensaryId = request.getParameter("userDispensaryId");
	
	//System.out.println("userDispensaryId===>" + userDispensaryId);
	
	session.setAttribute(Constants.USER_ID, userDispensaryId.split("##")[0]);
	session.setAttribute(Constants.DISPENSARY_ID, userDispensaryId.split("##")[1]);
	%><script>
	callHomePage();
	</script><%
	//response.sendRedirect(request.getContextPath()+"/pages/home/home.jsp");	
}

if(session.getAttribute(Constants.USER_DISPENSARY_DETAILS) != null){
	%>
	<form method="post"><h1 style="margin-top: 30px; margin-bottom:10px;text-align: center;">Dispensary Selection</h1>
	<table align="center" border="1" width="30%">
		<tr class="headerTR">
			<td>Please Select Your Dispensary</td>
		</tr>
		<tr>
			<td>
			<select name="userDispensaryId" id="userDispensaryId" style="width: 100%">
			<option value="-1" style="text-align: center;">Select Dispensary</option>
	<%
	LinkedHashMap<String, String> userDispensaryMap = (LinkedHashMap<String, String>)session.getAttribute(Constants.USER_DISPENSARY_DETAILS);
	String dispensaryDetails = "";
	String[] dispensaryArray = new String[0];
	for(String key : userDispensaryMap.keySet()){
		dispensaryDetails = userDispensaryMap.get(key);
		dispensaryArray = dispensaryDetails.split("##");
		%><option value='<%=key + "##" + dispensaryArray[0] %>'><%=dispensaryArray[1] %></option><%
	}
	%></select>
	</td>
		</tr>
	<tr align="center">
		<td><input type="submit" name="page1" id="page1" value="Submit" class="wrapper-dropdown" style="background-color: #2d97af;color: white;"/></td>
	</tr>	
	</table>
	</form><%
	session.removeAttribute(Constants.USER_DISPENSARY_DETAILS);
}
%>


</body>
<%@ include file="/pages/common/footer.jsp" %>
</html>
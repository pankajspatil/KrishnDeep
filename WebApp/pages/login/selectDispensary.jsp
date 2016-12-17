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
	String userTeamId = request.getParameter("userTeamId");
	
	//System.out.println("userTeamId===>" + userTeamId);
	
	session.setAttribute(Constants.USER_ID, userTeamId.split("##")[0]);
	session.setAttribute(Constants.TEAM_ID, userTeamId.split("##")[1]);
	%><script>
	callHomePage();
	</script><%
	//response.sendRedirect(request.getContextPath()+"/pages/home/home.jsp");	
}

if(session.getAttribute(Constants.USER_TEAM_DETAILS) != null){
	%>
	<form method="post"><h1 style="margin-top: 30px; margin-bottom:10px;text-align: center;">Team Selection</h1>
	<table align="center" border="1" width="30%">
		<tr class="headerTR">
			<td>Please Select Your Team</td>
		</tr>
		<tr>
			<td>
			<select name="userTeamId" id="userTeamId" style="width: 100%">
			<option value="-1" style="text-align: center;">Select Team</option>
	<%
	LinkedHashMap<String, String> userTeamMap = (LinkedHashMap<String, String>)session.getAttribute(Constants.USER_TEAM_DETAILS);
	String teamDetails = "";
	String[] teamArray = new String[0];
	for(String key : userTeamMap.keySet()){
		teamDetails = userTeamMap.get(key);
		teamArray = teamDetails.split("##");
		%><option value='<%=key + "##" + teamArray[0] %>'><%=teamArray[1] %></option><%
	}
	%></select>
	</td>
		</tr>
	<tr align="center">
		<td><input type="submit" name="page1" id="page1" value="Submit" class="wrapper-dropdown" style="background-color: #2d97af;color: white;"/></td>
	</tr>	
	</table>
	</form><%
	session.removeAttribute(Constants.USER_TEAM_DETAILS);
}
%>


</body>
<%@ include file="/pages/common/footer.jsp" %>
</html>
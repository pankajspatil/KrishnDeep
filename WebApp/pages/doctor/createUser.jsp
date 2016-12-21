<%-- <%@page import="com.org.krishnadeep.login.Login"%>
<%@page import="com.org.krishnadeep.generic.Utils"%>
<%@page import="com.org.krishnadeep.models.Patient"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ include file="/pages/common/header.jsp"%>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Patient Registration</title>
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/css/style.css">
</head>
<body>
	<%
		Patient patient = new Patient();
		user.setFirstName(Utils.getString(request.getParameter("firstName")));
		user.setMiddleName(Utils.getString(request
				.getParameter("middleName")));
		user.setLastName(Utils.getString(request.getParameter("lastName")));
		user.setDob(Utils.getString(request.getParameter("dob")));
		user.setUid(Utils.getString(request.getParameter("uid")));
		user.setPhone(Utils.getString(request.getParameter("phone")));
		user.setLocality(Utils.getString(request.getParameter("locality")));
		user.setGender(Utils.getString(request.getParameter("gender")));
		user.setPinCode(Utils.getString(request.getParameter("pinCode")));
		user.setStreet(Utils.getString(request.getParameter("street")));
		user.setCity(Utils.getString(request.getParameter("city")));
		
		String page1 = request.getParameter("page1");

		Boolean userCreated = false;

		Login login = new Login();
		Boolean userExist = login.verifyUser(user.getFirstName());
		if (page1 != null) {

			if (!userExist) {
				userCreated = login.createNewUser(user);
				if (userCreated) {
	%>
	<script type="text/javascript">
		alert('New User Created');
		location.href = <%= request.getContextPath() %>+"/pages/home/home.jsp";
	</script>
	<%
		}
			} else {
	%>
	<script type="text/javascript">
		alert('User Already exist');
	</script>
	<%
		}
		}

		if (!userCreated) {
	%>
	<form action="" method="post">
		<section class="container">

		<h5 class="moduleHeader" align="center">New Patient Creation</h5>
		<table class="mainTable">
			<tr class="mainTR">
				<td>First Name</td>
				<td><input class="fullText" type="text" id="firstName"
					name="firstName" value="<%=user.getFirstName()%>"></td>
			</tr>
			<tr class="mainTR">
				<td>Middle Name</td>
				<td><input class="fullText" type="text" id="middleName"
					name="middleName" value="<%=user.getMiddleName()%>"></td>
			</tr>
			<tr class="mainTR">
				<td>Last Name</td>
				<td><input class="fullText" type="text" id="lastName"
					name="lastName" value="<%=user.getLastName()%>"></td>
			</tr>
			<tr class="mainTR">
				<td>UID</td>
				<td><input class="fullText" type="text" id="uid" name="uid"
					value="<%=user.getUid()%>"></td>
			</tr>
			<!-- 	<tr class="mainTR"> -->
			<!-- 		<td>Password</td> -->
			<!-- 		<td><input class="fullText" type="password" id="password" name="password" ></td> -->
			<!-- 	</tr> -->
			<tr class="mainTR">
				<td>Phone</td>
				<td><input class="fullText" type="text" id="Phone"
					name="Phone" value="<%=user.getPhone()%>"></td>
			</tr>
			<tr class="mainTR">
				<td>Birth Date (MM/DD/YYYY)</td>
				<td><input class="fullText" type="text" id="dob" name="dob"
					value="<%=user.getDob()%>"></td>
			</tr>
			<tr class="mainTR">
				<td>UserName -UID</td>
				<td><input class="fullText" type="text" id="uid" name="uid"
					value="<%=user.getUid()%>"></td>
			</tr>
			<tr class="mainTR">
				<td>Locality</td>
				<td><textarea class="fullText" id="locality" name="locality"
						size="40" rows="5" cols="30"></textarea></td>
			</tr>
			<tr class="mainTR">
				<td>Street</td>
				<td><input class="fullText" type="text" id="street" name="street" value="<%=user.getStreet()%>"></textarea></td>
			</tr>
			<tr class="mainTR">
				<td>City</td>
				<td><input class="fullText" type="text" id="city" name="city" value="<%=user.getCity()%>"></textarea></td>
			</tr>
			<tr class="mainTR">
				<td>Gender</td>
				<td><input class="fullText" type="text" id="gender"
					name="gender" value="<%=user.getGender()%>"></td>
			</tr>
			<tr class="mainTR">
				<td>Pin Code</td>
				<td><input class="fullText" type="text" id="pinCode"
					name="pinCode" value="<%=user.getPinCode()%>"></td>
			</tr>
			<tr class="mainTR">
				<td colspan="2" align="center"><input type="submit" value="Create"
					name="page1" id="createUser"></td>

			</tr>
		</table>
		</section>
	</form>
	<%

} %>
</body>
</html> --%>
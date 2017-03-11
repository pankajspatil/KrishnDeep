<%@page import="com.google.gson.Gson"%>
<%@page import="com.google.gson.JsonObject"%>
<%@page import="java.util.List"%>
<%@page import="com.mysql.jdbc.Util"%>
<%@page import="com.org.krishnadeep.models.Patient"%>
<%@page import="com.org.krishnadeep.modules.Search"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ include file="/pages/common/validateSession.jsp"%>
<%@ include file="/pages/common/header.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
</head>
<body>
<%
String firstName = Utils.getString(request.getParameter("firstName"));
String middleName = Utils.getString(request.getParameter("middleName"));
String lastName = Utils.getString(request.getParameter("lastName"));
String gender = Utils.getString(request.getParameter("gender"));
String dob = Utils.getString(request.getParameter("dob"));
String bloodGroup = Utils.getString(request.getParameter("bloodGroup"));
String contact = Utils.getString(request.getParameter("contact"));
String email = Utils.getString(request.getParameter("email"));
String address = Utils.getString(request.getParameter("address"));
Integer userId = Utils.getInt(session.getAttribute(Constants.USER_ID));
Integer patientId = Utils.getInt(request.getParameter("patientId"));
Boolean isActive = Boolean.parseBoolean(Utils.getString(request.getParameter("isActive")));

String page1 = Utils.getString(request.getParameter("page1"));

//System.out.println("page1==>" + page1 + "patientId==>" + patientId);

String btnText = "add";

Search search = new Search();
Patient patient = new Patient();

if(patientId != 0 && page1.equals("")){
	List<Patient> patientList = search.searchPatient(Constants.SINGLE_PATIENT, patientId.toString(),sessionModel);
	if(patientList.size() > 0){
		patient = patientList.get(0);
		
		firstName = patient.getFirstName();
		middleName = patient.getMiddleName();
		lastName = patient.getLastName();
		dob = patient.getDob();
		gender = patient.getSex();
		contact = patient.getContactNo();
		bloodGroup = patient.getBloodGroup();
		email = patient.getEmail();
		address = patient.getAddress();
		isActive = patient.getIsActive();
		
		//System.out.println("Before==>" + patient);
		
		btnText = "update";
	}
}

if(!page1.equals("")){
	
	patient.setPatientId(patientId);
	patient.setFirstName(firstName);
	patient.setMiddleName(middleName);
	patient.setLastName(lastName);
	patient.setDob(dob);
	patient.setSex(gender);
	patient.setContactNo(contact);
	patient.setBloodGroup(bloodGroup);
	patient.setEmail(email);
	patient.setAddress(address);
	patient.setCreatedBy(userId);
	patient.setIsActive(isActive);
	
	System.out.println(patient);
	search.createUpdatePatient(patient);
	%><script type="text/javascript">
	var msg = "Patient added successfully.";
	var patientId = <%=patientId%>;
	console.log("patientId==>" + patientId);
	
	if(patientId !== '' && patientId !== 0){
		msg = "Patient updated successfully.";
	}
	
	Lobibox.alert("success",{
		msg : msg,
		beforeClose: function(lobibox){
        	parent.location.reload();
        }
	});
	</script><%
}

String[][] genderArray = new String[3][2];

genderArray[0][0] = "M";
genderArray[0][1] = "Male";

genderArray[1][0] = "F";
genderArray[1][1] = "Female";

genderArray[2][0] = "O";
genderArray[2][1] = "Others";

%>

<form name="createPatient" id="createPatient" method="post">
<h1 align="center">New Patient</h1>
<table class="mainTable" align="center" width="60%" border="1" style="border: 0px solid">

	<tr>
		<th class="headerTR">First Name *</th>
		<td><input type="text" name="firstName" id="firstName" value="<%=firstName %>" autocomplete="off" class="fullRowElement"> </td>
	</tr>
	<tr>
		<th class="headerTR">Middle Name </th>
		<td><input type="text" name="middleName" id="middleName" value="<%=middleName %>" autocomplete="off" class="fullRowElement"> </td>
	</tr>
	<tr>
		<th class="headerTR">Last Name *</th>
		<td><input type="text" name="lastName" id="lastName" value="<%=lastName %>" autocomplete="off" class="fullRowElement"> </td>
	</tr>
	<tr>
		<th class="headerTR">Gender *</th>
		<td>
			<select name="gender" id="gender" class="fullRowElement">
				<option value="-1">Please Select</option>
				<%
				String selected = "";
				for(String[] genders : genderArray){
					selected = "";
					if(genders[0].equals(gender)){
						selected = "selected";
					}
					%><option <%=selected %> value="<%=genders[0]%>"><%=genders[1]%></option><%
				}%>
				<!-- <option value="M">Male</option>
				<option value="F">Female</option>
				<option value="O">Others</option> -->
			</select>
		</td>
	</tr>
	<tr>
		<th class="headerTR">DOB(YYYY/MM/DD) *</th>
		<td><input type="text" name="dob" id="dob" value="<%=dob %>" autocomplete="off" class="fullRowElement"> </td>
	</tr>
	<tr>
		<th class="headerTR">Blood Group</th>
		<td><input type="text" name="bloodGroup" id="bloodGroup" value="<%=bloodGroup %>" autocomplete="off" class="fullRowElement"> </td>
	</tr>
	<tr>
		<th class="headerTR">Contact *</th>
		<td><input type="text" name="contact" id="contact" value="<%=contact %>" autocomplete="off" class="fullRowElement"> </td>
	</tr>
	<tr>
		<th class="headerTR">Email</th>
		<td><input type="text" name="email" id="email" value="<%=email %>" autocomplete="off" class="fullRowElement"> </td>
	</tr>
	<tr>
		<th class="headerTR">Address *</th>
		<td>
			<textarea rows="4" cols="" name="address" id="address" class="fullRowElement"><%=address %></textarea>
		</td>
	</tr>
	<tr>
		<th class="headerTR">Active</th>
		<td>
			<input type="checkbox" name="isActive" id="isActive" value="true" <%=(btnText.equals("add")||isActive) ? "checked=checked" : "" %>
			autocomplete="off" class="fullRowElement" style="width: 10%">
		</td>
	</tr>
	<tr style="border: none;">
		<td colspan="2" class="searchBtn" align="center">
			<input type="submit" name="page1" id="patientBtn" value="<%=btnText %>" class="btn btn-main btn-2g" onclick="return validateCreatePatientForm()" />
		</td>
	</tr>
</table>
<input type="hidden" name="patientId" id="patientId" value="<%=patientId %>" />
</form>
<% Gson gson = new Gson(); %>
<script type="text/javascript" src="<%=contextPath%>/resources/js/search.js"></script>
<script type="text/javascript">
var patientObj = <%=gson.toJson(patient)%>;
</script>
</body>
</html>
<%@page import="com.org.krishnadeep.models.Patient"%>
<%@page import="java.util.List"%>
<%@page import="com.org.krishnadeep.generic.ConnectionsUtil"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.org.krishnadeep.modules.Search"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ include file="/pages/common/validateSession.jsp"%>
<%@ include file="/pages/common/header.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<script type="text/javascript" src="<%=contextPath%>/resources/js/search.js"></script>

<script type="text/javascript">
$(document).ready(function() {
    $('#patientData').DataTable({    
    	"aoColumnDefs": [{ "bSortable": false, "aTargets": [ 0 ] }],
    	"order": [[ 1, "asc" ]]
    });
} );

</script>
</head>
<body>

<form action="searchPatient.jsp" name="f1" id="f1" method="post">
<h1 class="moduleHeader" style="text-align: center;"> Search Patient</h1>
<table class="mainTable" align="center" width="40%" border="1" style="border: 0px solid">
	<tr>
		<th class="headerTR" width="50%">Search By</th>
		<td>
			<select name="searchKey" id="searchKey" onchange="searchKeySelect(this)" style="height: 100%;width: 100%">
				<option value="-1">Please Select</option>
				<option value="1">Name</option>
				<option value="2">Mobile No</option>
				<option value="3">DOB</option>
				<option value="4">Adhar No</option>
			</select>
		</td>
	</tr>
	<tr>
		<th class="headerTR">Value</th>
		<td><input type="text" name="searchValue" id="searchValue" value="" autocomplete="off" style="height: 100%;width: 100%"> </td>
	</tr>
	
	<tr style="border: none;">
		<td colspan="2" class="searchBtn" align="center"><input type="submit" name="searchBtn" id="searchBtn" value="search" class="btn btn-main btn-2g" /></td>
	</tr>
</table>

<%
	if(request.getParameter("searchBtn") != null){
		%>
		<div style="float: right; padding-right: 11%">
			<input type="button" class="btn btn-main btn-2g" name="newPatient" id="newPatient" 
			value="Add Patient" onclick="openPatientFancyBox(0, 'newPatient', this)">
		</div>
		<table border="" align="center" id="patientData" class="display" cellspacing="0" width="100%">
				<thead>
					<tr class="headerTR">
						<th>First Name</th>
						<th>Middle Name</th>
						<th>Last Name</th>
						<th>Phone</th>
						<th>DOB</th>
						<th>Operations</th>
					</tr>
				</thead>
				<tbody>
		<%
	Search searchPatient = new Search();
	Integer searchKey = Integer.parseInt(request.getParameter("searchKey"));
	String searchValue = request.getParameter("searchValue");
	List<Patient> patientList = searchPatient.searchPatient(searchKey, searchValue);
	if(patientList.size() != 0){
		for(Patient patient : patientList){
			%><tr>
			<th><%=patient.getFirstName() %></th>
			<th><%=patient.getMiddleName() %></th>
			<th><%=patient.getLastName() %></th>
			<th><%=patient.getContactNo() %></th>
			<th><%=patient.getDob() %></th>
			<th>
			
			<img style="margin-left: 40%" height="22%" src="/Krishnadeep/resources/images/edit.png" 
									id="editPatient_<%=patient.getPatientId()%>" name="editPatient" 
									onclick="openPatientFancyBox(<%=patient.getPatientId()%>, 'updatePatient', this)">
			
				<!-- <input type="button" name="Edit" value="E" class="editImg" onclick="" /> -->
				<%-- <input type="button" name="Delete" value="D" onclick="openPage('delete','<%=patient.getPatientId() %>')" /> --%>
				<input type="button" name="NewVisit" value="NV" onclick="openPage('vNew','<%=patient.getPatientId() %>')" />
				<%-- <input type="button" name="visitHistory" value="VH" onclick="openPage('vHistory','<%=patient.getPatientId() %>')" /> --%>
				<input type="button" name="visitHistory" value="VH" onclick="openPatientFancyBox(<%=patient.getPatientId()%>, 'visitHistory', this)" />
			</th>
		</tr><%}
	}	
	%></tbody>
				
			</table><%
	}// end of request
%>

</form>

</body>
</html>
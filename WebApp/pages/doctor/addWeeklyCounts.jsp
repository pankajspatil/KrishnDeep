<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="/pages/common/validateSession.jsp"%>
<%@ include file="/pages/common/header.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
</head>
<body>
<h1 align="center">Add Weekly Patient Data</h1>
<table border="0" width="70%" align="center">
	<tr align="center">
		<td width="50%" valign="top">
			<h3>No. of patient's seen</h3>
			<table width="100%" border="1" class="mainTable" border="1" style="border: 0px solid">
				<tr>
					<th class="headerTR">No of patients : </th>
					<td><input class="fullRowElement" type="text" name="patientNumber" id="patientNumber" value=""> </td>
				</tr>
				<tr>
					<th class="headerTR">Amount</th>
					<td><input class="fullRowElement" type="text" name="patientAmount" id="patientAmount" value=""> </td>
				</tr>
			</table>
		</td>
		<td valign="top">
			<h3>No. of operations</h3>
			<div class="bwl_acc_container scroll accordionDiv" id="accordion_1" style="width: 98%; /* border:1px solid black; */">
					<section>
					<h2 class="acc_title_bar">
						<a href="#">Medical Claims</a>
					</h2>
					<div class="acc_container">
						<table width="100%" border="1" class="mainTable" border="1" style="border: 0px solid">
							<tr>
								<th class="headerTR">No of patients : </th>
								<td><input class="fullRowElement" type="text" name="patientNumber" id="patientNumber" value=""> </td>
							</tr>
							<tr>
								<th class="headerTR">Amount</th>
								<td><input class="fullRowElement" type="text" name="patientAmount" id="patientAmount" value=""> </td>
							</tr>
						</table>
					</div>
					</section>
					<section>
					<h2 class="acc_title_bar">
						<a href="#">Non Medical Claims</a>
					</h2>
					<div class="acc_container">
						<table width="100%" border="1" class="mainTable" border="1" style="border: 0px solid">
							<tr>
								<th class="headerTR">No of patients : </th>
								<td><input class="fullRowElement" type="text" name="patientNumber" id="patientNumber" value=""> </td>
							</tr>
							<tr>
								<th class="headerTR">Amount</th>
								<td><input class="fullRowElement" type="text" name="patientAmount" id="patientAmount" value=""> </td>
							</tr>
						</table>
					</div>
					</section>

				</div>
		</td>
	</tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr align="center">
		<td colspan="2"><input type="submit" value="submit" class="btn btn-main btn-2g"></td>
	</tr>
</table>
<script type="text/javascript" src="<%=contextPath %>/resources/js/weeklyData.js"></script>
</body>
</html>
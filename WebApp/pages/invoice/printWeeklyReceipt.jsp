<%@page import="com.org.krishnadeep.models.WeeklyData"%>
<%@page import="com.org.krishnadeep.masters.Masters"%>
<%@page import="com.org.krishnadeep.models.ExpenseModel"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="com.org.krishnadeep.generic.Utils"%>
<%@page import="com.org.krishnadeep.modules.Expense"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ include file="/pages/common/validateSession.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head><meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
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
		SessionModel sessionModel = null;
		sessionModel = (SessionModel) session
				.getAttribute(Constants.SESSION_MODEL);

		String fromDate = Utils.getString(request.getParameter("fromdate"));
		String toDate = Utils.getString(request.getParameter("toDate"));
		
	Masters master = new Masters();
		List<WeeklyData> weeklyDataList = master
				.getConsolidatedWeeklyCountsPrintData(0, false, null,fromDate,toDate); 

		Integer totalPatientCount = 0, totalPatientsCalim = 0, totalPatientsNonCalim = 0;
		Double totalPatientAmount = 0.0, totalAmountPatientsCalim = 0.0, totalAmountPatientsNonCalim = 0.0;
	%>  
	<div>
	Consolidated Weekly report from <%=fromDate %> to <%=toDate %>
	</div>

	<table border="1" align="center" width="60%" id="weeklyDataTable">
		<thead><br><br>
		<tr><th colspan=4>No of Patient Visited</th></tr>

		</thead>
		<tbody>
			<%
				for (WeeklyData weeklyData : weeklyDataList) {
			%>
			<tr class="headerTR">
				<th width="15%" >Doctor Name</th><td colspan=2><%=weeklyData.getDoctorName()%></td>
			</tr>
			<tr><th width="30%">No of Patients</th><td><%=weeklyData.getPatientCount()%></td></tr>
				<tr><th width="30%">Amount</th><td><%=weeklyData.getPatientAmount()%></td></tr>
				<%
						totalPatientCount += weeklyData.getPatientCount();
						totalPatientAmount += weeklyData.getPatientAmount();
				%>
			</tr>
			<%
				}
			%>


		</tbody>
	</table>
	<table border="1" align="center" class="mainTable" width="50%">
		<tr><br><br>
			<th width="15%">Total Patient</th>
			<th width="15%">Total Amount</th>
	</tr>
		<tr>
			<td><%=totalPatientCount%></td>
			<td><%=totalPatientAmount%></td>
		</tr>
	</table>
	<table border="1" align="center" width="60%" id="weeklyDataTable2">
		<thead><br><br>
		<tr><th colspan=4>No of Patient Operated</th></tr>

		</thead>
		<tbody>
			<%totalPatientCount = 0;
			totalPatientAmount = 0.0;
			int totalPatientNonCount = 0;
			double totalPatientNonAmount = 0.0;
				for (WeeklyData weeklyData : weeklyDataList) {
			%>
			<tr class="headerTR">
				<th width="15%" >Doctor Name</th><td colspan=2><%=weeklyData.getDoctorName()%></td>
			</tr>
			<tr><th width="30%">Patients-Claim</th><td><%=weeklyData.getPatientCountClaim() %></td></tr>
			<tr><th width="30%">Amount-Claim</th><td><%=weeklyData.getPatientAmountClaim() %></td></tr>
			<tr><th width="30%">Patients- Non Claim</th><td><%=weeklyData.getPatientCountNonClaim()%></td></tr>
			<tr><th width="30%">Amount-Non Claim</th><td><%=weeklyData.getPatientAmountNonClaim()%></td></tr>
				<%
						totalPatientCount += weeklyData.getPatientCountClaim();
						totalPatientAmount += weeklyData.getPatientAmount();
						totalPatientNonCount += weeklyData.getPatientCountNonClaim();
						totalPatientNonAmount += weeklyData.getPatientAmountNonClaim();
				%>
			
			<%
				}
			%>


		</tbody>
	</table>
	<table border="1" align="center" class="mainTable" width="60%">
		<tr><br><br>
			<th width="30%">Total Claim  Patient</th>
			<th width="30%">Total Claim Amount</th>
			<th width="30%">Total Non Claim Patient</th>
			<th width="30%">Total Non Claim Amount</th>
	</tr>
		<tr>
			<td><%=totalPatientCount%></td>
			<td><%=totalPatientAmount%></td>
			<td><%=totalPatientNonCount%></td>
			<td><%=totalPatientNonAmount%></td>
		</tr>
	</table>
	<script type="text/javascript">
		var w = window.print();
		
	</script>
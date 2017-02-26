<%@page import="com.org.krishnadeep.models.WeeklyData"%>
<%@page import="com.org.krishnadeep.masters.Masters"%>
<%@page import="com.org.krishnadeep.models.ExpenseModel"%>
<%@page import="java.util.List"%>
<%@page import="com.org.krishnadeep.modules.Expense"%>
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
Masters master = new Masters();
List<WeeklyData> weeklyDataList = master.getWeeklyCountsData(0, false);

%>

<h1 align="center">Add Weekly Counts</h1>
<div style="float: right;padding-right: 11%">
	<!-- <input type="button" name="newExpense" id="newExpense" value=""> -->
	<button class="btn btn-main btn-2g" name="newWeeklyData" id="newWeeklyData" onclick="openWeeklyDataFancyBox(0, 'newWeeklyData', this);">Add Data</button>
</div>
<table border="1" class="mainTable" width="100%" id="weeklyDataTable">
<thead>
	<tr class="headerTR">
		<th>weekYear</th>
		<th width="10%">Week</th>
		<th width="15%">Patients</th>
		<th width="15%">Amount</th>
		<th width="15%">Patients-Claim</th>
		<th width="15%">Amount-Claim</th>
		<th width="15%">Patients-NonClaim</th>
		<th width="15%">Amount-NonClaim</th>
		<th width="10%">Action</th>
	</tr>
</thead>
<tbody>
	<%
	for(WeeklyData weeklyData : weeklyDataList){
	%>
		<tr>
			<td><%=weeklyData.getWeekYearNo() %></td>
			<td align="center"><%=Utils.getFormattedDate(Utils.parseDate(weeklyData.getWeekStartDate(), "yy-MM-dd"), "") %></td>
			<td><%=weeklyData.getPatientCount() %></td>
			<td><%=weeklyData.getPatientAmount() %></td>
			<td><%=weeklyData.getPatientCountClaim() %></td>
			<td><%=weeklyData.getPatientAmountClaim() %></td>
			<td><%=weeklyData.getPatientCountNonClaim() %></td>
			<td><%=weeklyData.getPatientAmountNonClaim() %></td>
			<td>
				<img style="margin-left: 40%" height="22%" src="<%=contextPath%>/resources/images/edit.png" 
				id="<%=weeklyData.getWeeklyDataId()%>" name="editWeeklyCounts" onclick="updateWeeklyCounts(this)">
			</td>
		</tr>
	<%}%>
</tbody>
</table>
<script type="text/javascript" src="<%=contextPath%>/resources/js/weeklyData.js"></script>
</body>
</html>
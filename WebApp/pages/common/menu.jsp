<%@page import="com.org.krishnadeep.generic.Constants"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.Connection,java.util.ArrayList"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
</head>
<% String Contextpath = request.getContextPath();
    	ArrayList<String> menulist = session.getAttribute("menu") != null ? (ArrayList<String>) session.getAttribute("menu") : new ArrayList<String>();
    	
    	//System.out.println("menulist===>" + menulist);
	%>
<body>
	<input type="hidden" id="contextPath"
		value="<%=Contextpath %>" />
	<div id='cssmenu'>
		<ul>
			<%
				if (menulist.contains("Home")) {
			%>
			<li><a
				href='<%=Contextpath%>/pages/common/home.jsp'><span>Home</span></a>
			</li>
			<%}%>
			<%
				if (menulist.contains("Search")) {
			%>
			<li><a
				href='<%=Contextpath %>/pages/doctor/searchPatient.jsp'><span>Search</span></a>
			</li>
			<%
				}
			%>
			<%
				if (menulist.contains("Expense")) {
			%>
			<li class='has-sub'><a href='#'><span>Expenses</span></a>
				<ul>
					<li class='first-child'><a
						href='<%=Contextpath %>/pages/doctor/addExpense.jsp'><span>Add
								Expense</span></a></li>
					<li class='first-child'><a
						href='<%=Contextpath %>/pages/invoice/addVendorInvoice.jsp'><span>Add
								Invoice</span></a></li>
				</ul> <%
				}
			%>
				<%
				if (menulist.contains("Report")) {
			%>
			<li class='has-sub'><a href='#'><span>Reports</span></a>
				<ul>
					<li class='first-child'><a
						href='<%=Contextpath %>/pages/reports/visitRevenue.jsp'><span>Revenue</span></a>
					</li>
					<%-- <li><a
						href='<%=Contextpath %>/pages/reports/orderStatus.jsp'><span>Order
								Status</span></a></li>--%>
				</ul></li> 
			<% } %>

			<li style="float: right; padding-right: 10px;"><a href='#'><span>Account</span></a>
				<ul>
					<li><a
						href='<%=Contextpath %>/pages/login/changePassword.jsp'>Change
							Password</a></li>
					<%
						if (session.getAttribute(Constants.USER_ID) != null) {
					%><li onclick="logout()"><a href='#'><span>Logout</span></a></li>
					<%
						}
					%>
				</ul></li>

		</ul>
	</div>
</body>
</html>
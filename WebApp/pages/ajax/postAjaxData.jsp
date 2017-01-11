<%@page import="com.org.krishnadeep.modules.Expense"%>
<%@page import="com.org.krishnadeep.models.ExpenseModel"%>
<%@page import="com.org.krishnadeep.modules.Invoice"%>
<%@page import="java.util.List"%>
<%@page import="com.org.krishnadeep.generic.Constants"%>
<%@page import="com.org.krishnadeep.generic.Utils"%>
<%@page import="com.google.gson.JsonParser"%>
<%@page import="com.google.gson.JsonObject"%>
<%@page import="com.google.gson.Gson"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@page import="java.util.LinkedHashMap"%>

<%
String action = null;
try{
	
	response.setCharacterEncoding("UTF-8");
	
	action = Utils.getString(request.getParameter("action"));
	String userId = Utils.getString(session.getAttribute(Constants.USER_ID));
	String data = Utils.getString(request.getParameter("data"));
	
	Invoice invoice = new Invoice();
	Integer returnValue = new Integer(0);
	Expense expense = new Expense();
	
	if(action.equals("fetchExpenseByVendor")){
			List<ExpenseModel> expenseList = invoice.getExpenseListByVendor(data);
			Gson gson = new Gson();
			String returnStr = gson.toJson(expenseList);
			out.println(returnStr);
	}
	
}catch (Exception ex){
	System.out.println("Error while processing data for "+action);
	ex.printStackTrace();
	response.setStatus(503);
}

%>
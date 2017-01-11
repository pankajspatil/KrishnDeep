package com.org.krishnadeep.modules;

import java.sql.SQLException;
import java.util.List;

import com.google.gson.JsonObject;
import com.org.krishnadeep.generic.Utils;
import com.org.krishnadeep.models.ExpenseModel;

public class Invoice {

	public List<ExpenseModel> getExpenseListByVendor(String data) throws SQLException{

		Expense expense = new Expense();
		
		JsonObject jsonObject  = Utils.getJSONObjectFromString(data);
		
		Integer vendorId = jsonObject.get("vendorId").getAsInt();

		List<ExpenseModel> expenseList = expense.getExpenseList(vendorId);
		
		return expenseList;
	}
	
}

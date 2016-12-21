package com.org.krishnadeep.modules;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.LinkedHashMap;

import com.org.krishnadeep.generic.ConnectionsUtil;
import com.org.krishnadeep.generic.Constants;
import com.org.krishnadeep.generic.Utils;
import com.org.krishnadeep.models.ExpenseModel;

public class Expense {
	
	static Connection conn = null;
	static ResultSet rs = null;
	static ConnectionsUtil connectionsUtil = null;
	
	public static void addExpense(ExpenseModel expenseModel) {

		try {
			connectionsUtil = new ConnectionsUtil();
			conn = connectionsUtil.getConnection();

			String query = "insert into expenses "
					+ "(expense_desc,vendor_id,expense_qty,expense_amount, expense_invoice_no,expense_vat,"
					+ "account_id,expenses_item_id)"
					+ " VALUES  (?,?,?,?,?,?,?,?)";

			PreparedStatement preparedStatement = conn.prepareStatement(query);
			preparedStatement.setString(1,
					Utils.getString(expenseModel.getExpense_desc()));
			preparedStatement.setInt(2,expenseModel.getVendor_id());
			preparedStatement.setInt(3,expenseModel.getExpense_qty());
			preparedStatement.setDouble(4,expenseModel.getExpense_amount());
			preparedStatement.setString(5,
					Utils.getString(expenseModel.getExpense_invoice_no()));
			preparedStatement.setFloat(6,expenseModel.getExpense_vat());	
			
			preparedStatement.setInt(7,expenseModel.getAccount_id());
			
			preparedStatement.setInt(8,expenseModel.getExpenses_item_id());
			
			//preparedStatement.setTimestamp(4,
					//expenseModel.getExpense_created_date());
			//preparedStatement.setString(5,
					//expenseModel.getExpense_created_by());
			

			preparedStatement.executeUpdate();
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			try {
				if (conn != null) {
					conn.close();
				}

			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

		rs = null;
		conn = null;
	}
	
	public static ArrayList<LinkedHashMap<String, String>> getExpenseList(){
		ArrayList<LinkedHashMap<String, String>> expenseList = new ArrayList<LinkedHashMap<String, String>>();

		try {
			connectionsUtil = new ConnectionsUtil();
			conn = connectionsUtil.getConnection();

			String query = "SELECT * FROM expenses ex ";				
					
			PreparedStatement preparedStatement = conn.prepareStatement(query);
			rs = preparedStatement.executeQuery();

			LinkedHashMap<String, String> expenseModel = null;
			while (rs.next()) {
				expenseModel = new LinkedHashMap<String, String>();
				expenseModel.put(Constants.EXPENSE_ID,rs.getString("expenses_id"));
				expenseModel.put(Constants.EXPENSE_DESC,rs.getString("expense_desc"));
				expenseModel.put(Constants.EXPENSE_AMOUNT,rs.getString("expense_amount"));
				expenseList.add(expenseModel);
			}

		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			try {
				if (conn != null) {
					conn.close();
				}

			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

		rs = null;
		conn = null;

		return expenseList;

	}

}

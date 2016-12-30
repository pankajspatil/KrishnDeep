package com.org.krishnadeep.modules;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;

import com.org.krishnadeep.generic.ConnectionsUtil;
import com.org.krishnadeep.generic.Constants;
import com.org.krishnadeep.generic.Utils;
import com.org.krishnadeep.models.ExpenseItem;
import com.org.krishnadeep.models.ExpenseModel;
import com.org.krishnadeep.models.ExpenseModel_old;
import com.org.krishnadeep.models.Vendor;

public class Expense {
	
	static Connection conn = null;
	static ResultSet dataRS = null;
	static ConnectionsUtil connectionsUtil = null;
	
	public static void addExpense(ExpenseModel_old expenseModel) {

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

		dataRS = null;
		conn = null;
	}
	
	public List<ExpenseModel> getExpenseList() throws SQLException{
			
		
			connectionsUtil = new ConnectionsUtil();
			conn = connectionsUtil.getConnection();

			String query = "SELECT e.expense_id, e.expense_item_id, ei.expense_item_name, v.vendor_id, v.vendor_name, " +
							"e.expense_qty, e.expense_amount, ie.paidAmt, e.expense_remark FROM expenses e "+
							"inner join expense_item_master ei on e.expense_item_id = ei.expense_item_id "+
							"inner join vendor_master v on e.vendor_id = v.vendor_id "+
							"left join (select expense_id, sum(amount) as paidAmt from invoice_expense_map ie "+ 
							"where is_active = 1 group by expense_id) ie on e.expense_id = ie.expense_id";
					
			PreparedStatement preparedStatement = conn.prepareStatement(query);
			dataRS = preparedStatement.executeQuery();

			List<ExpenseModel> expenseList = new ArrayList<ExpenseModel>();
			ExpenseModel expenseModel = null;
			ExpenseItem expenseItem = null;
			Vendor vendor = null;
			
			while (dataRS.next()) {
				
				expenseModel = new ExpenseModel();
				
				expenseItem = new ExpenseItem();
				expenseItem.setExpenseItemName(dataRS.getString("expense_item_name"));
				
				vendor = new Vendor();
				vendor.setVendorName(dataRS.getString("vendor_name"));
				
				expenseModel.setExpenseId(dataRS.getInt("expense_id"));
				expenseModel.setExpenseItem(expenseItem);
				expenseModel.setExpenseQty(dataRS.getInt("expense_qty"));
				expenseModel.setExpenseAmt(dataRS.getDouble("expense_amount"));
				expenseModel.setPaidAmt(dataRS.getDouble("paidAmt"));
				expenseModel.setExpenseRemark(dataRS.getString("expense_remark"));
				
				expenseList.add(expenseModel);
			}

			connectionsUtil.closeConnection(conn);
		
		return expenseList;

	}

}

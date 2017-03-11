package com.org.krishnadeep.modules;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.google.gson.JsonObject;
import com.org.krishnadeep.generic.ConnectionsUtil;
import com.org.krishnadeep.generic.Utils;
import com.org.krishnadeep.models.ExpenseItem;
import com.org.krishnadeep.models.ExpenseModel;
import com.org.krishnadeep.models.InvoiceModel;
import com.org.krishnadeep.models.SessionModel;
import com.org.krishnadeep.models.Vendor;

public class Invoice {

	public List<ExpenseModel> getExpenseListByVendor(String data,SessionModel sessionModel) throws SQLException{

		Expense expense = new Expense();
		
		JsonObject jsonObject  = Utils.getJSONObjectFromString(data);
		
		Integer vendorId = jsonObject.get("vendorId").getAsInt();

		List<ExpenseModel> expenseList = expense.getExpenseList(vendorId, true,sessionModel);
		
		return expenseList;
	}

	public void addInvoice(InvoiceModel invoiceModel) throws SQLException {

		ConnectionsUtil connectionsUtil = new ConnectionsUtil();
		Connection conn = connectionsUtil.getConnection();

		String query = "INSERT INTO `invoice_master`(`vendor_id`,`expense_exist`,`amount`,`comments`,`created_by`) "+
						"VALUES(?,?,?,?,?)";

		PreparedStatement psmt = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
		
		psmt.setInt(1, invoiceModel.getVendor().getVendorId());
		psmt.setBoolean(2, invoiceModel.getExpenseExist());
		psmt.setDouble(3, invoiceModel.getAmount());
		psmt.setString(4, invoiceModel.getComments());
		psmt.setInt(5, invoiceModel.getCreatedBy());

		psmt.executeUpdate();
		
		ResultSet dataRS = psmt.getGeneratedKeys();
		Integer invoiceId = 0;
		if(dataRS.next()){
			invoiceId = dataRS.getInt(1);
		}
		
		if(invoiceModel.getExpenseList().size() > 0){
			String query1 = "insert into invoice_expense_map (invoice_id, expense_id, amount, created_by) values(?,?,?,?)";
			psmt = conn.prepareStatement(query1);
			for(ExpenseModel expenseModel : invoiceModel.getExpenseList()){
				psmt.setInt(1, invoiceId);
				psmt.setInt(2, expenseModel.getExpenseId());
				psmt.setDouble(3, expenseModel.getPaidAmt());
				psmt.setInt(4, invoiceModel.getCreatedBy());
				
				psmt.addBatch();
			}
			psmt.executeBatch();
			
		}
		connectionsUtil.closeConnection(conn);
		
}

	public List<InvoiceModel> getInvoiceList(SessionModel sessionModel) throws SQLException{
		
		ConnectionsUtil connectionsUtil = new ConnectionsUtil();
		Connection conn = connectionsUtil.getConnection();
		
		String query = "select i.invoice_id, ifnull(expAmount,amount) as amount,vendor_name, v.vendor_id, comments, "
					+ "expense_exist from invoice_master i "
					+ "inner join vendor_master v on i.vendor_id = v.vendor_id "
					+ " inner join user_master u on u.user_id = i.created_by and u.user_id ="+ sessionModel.getSessionUserId()+" "
					+ "left join (select invoice_id, sum(ifnull(amount,0)) as expAmount from invoice_expense_map ie "
					+ "where is_active = 1 group by invoice_id) ie on i.invoice_id = ie.invoice_id order by i.invoice_id desc";
		
		ResultSet dataRS = conn.createStatement().executeQuery(query);
		List<InvoiceModel> invoiceList = new ArrayList<InvoiceModel>();
		InvoiceModel invoiceModel;
		Vendor vendor;
		
		while(dataRS.next()){
			invoiceModel = new InvoiceModel();
			vendor = new Vendor();
			
			invoiceModel.setInvoiceId(dataRS.getInt("invoice_id"));
			invoiceModel.setExpenseExist(dataRS.getBoolean("expense_exist"));
			invoiceModel.setAmount(dataRS.getDouble("amount"));
			invoiceModel.setComments(dataRS.getString("comments"));
			
			vendor.setVendorId(dataRS.getInt("vendor_id"));
			vendor.setVendorName(dataRS.getString("vendor_name"));
			invoiceModel.setVendor(vendor);
			
			invoiceList.add(invoiceModel);
		}
		
		connectionsUtil.closeConnection(conn);
		
		return invoiceList;
	}

	public InvoiceModel getInvoice(Integer invoiceId) throws SQLException{
		
		InvoiceModel invoiceModel = null;
		Vendor vendor;
		ConnectionsUtil connectionsUtil = new ConnectionsUtil();
		Connection conn = connectionsUtil.getConnection();
		
		String query = "select i.invoice_id, v.vendor_id, expense_exist, comments, e.expense_id, "+ 
						"expense_item_name, vendor_name, expense_qty, i.amount as tAmount, ie.amount as eAmount, i.created_on from invoice_master i "+
						"inner join vendor_master v on i.vendor_id = v.vendor_id and i.invoice_id = ? "+
						"inner join invoice_expense_map ie on i.invoice_id = ie.invoice_id "+
						"inner join expenses e on ie.expense_id = e.expense_id "+
						"inner join expense_item_master ei on e.expense_item_id = ei.expense_item_id";
		
		PreparedStatement psmt = conn.prepareStatement(query);
		
		psmt.setInt(1, invoiceId);
		
		ResultSet dataRS = psmt.executeQuery();
		ExpenseModel expenseModel;
		ExpenseItem expenseItem;
		
		List<ExpenseModel> expenseList = new ArrayList<ExpenseModel>();
		
		int count = 0;
		
		while(dataRS.next()){
			
			vendor = new Vendor();
			vendor.setVendorId(dataRS.getInt("vendor_id"));
			vendor.setVendorName(dataRS.getString("vendor_name"));
			
			if(count == 0){
				invoiceModel = new InvoiceModel();
				invoiceModel.setInvoiceId(dataRS.getInt("invoice_id"));
				invoiceModel.setAmount(dataRS.getDouble("tAmount"));
				invoiceModel.setVendor(vendor);
				invoiceModel.setExpenseExist(dataRS.getBoolean("expense_exist"));
				invoiceModel.setCreatedOn(dataRS.getString("created_on"));
			}
			
			expenseItem = new ExpenseItem();
			expenseItem.setExpenseItemName(dataRS.getString("expense_item_name"));
			
			expenseModel = new ExpenseModel();
			expenseModel.setExpenseId(dataRS.getInt("expense_id"));
			expenseModel.setExpenseItem(expenseItem);
			expenseModel.setVendor(vendor);
			expenseModel.setExpenseQty(dataRS.getInt("expense_qty"));
			expenseModel.setPaidAmt(dataRS.getDouble("eAmount"));
			
			expenseList.add(expenseModel);
			
			count++;
		}
		
		if(invoiceModel != null){
			invoiceModel.setExpenseList(expenseList);
		}
		
		connectionsUtil.closeConnection(conn);
		
		return invoiceModel;
	}
}


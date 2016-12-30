package com.org.krishnadeep.masters;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.org.krishnadeep.generic.ConnectionsUtil;
import com.org.krishnadeep.models.ExpenseItem;
import com.org.krishnadeep.models.Vendor;
import com.org.krishnadeep.models.VisitType;

public class Masters {

	public List<VisitType> getAllVisitTypes(Boolean isActive) throws SQLException{
		
		ConnectionsUtil connectionsUtil = new ConnectionsUtil();
		Connection conn = connectionsUtil.getConnection();
		
		String query = "select * from visit_type";
		if(isActive){
			query += " where is_active = 1";
		}
		
		ResultSet dataRS = conn.createStatement().executeQuery(query);
		List<VisitType> visitTypeList = new ArrayList<VisitType>();
		VisitType visitType;
		
		while(dataRS.next()){
			visitType = new VisitType();
			
			visitType.setVisitTypeId(dataRS.getInt("visit_type_id"));
			visitType.setVisitType(dataRS.getString("visit_type"));
			visitType.setIsActive(dataRS.getBoolean("is_active"));
			
			visitTypeList.add(visitType);
		}
		
		connectionsUtil.closeConnection(conn);
		
		return visitTypeList;
	}
	
public List<ExpenseItem> getAllExpenseItems(Boolean isActive) throws SQLException{
		
		ConnectionsUtil connectionsUtil = new ConnectionsUtil();
		Connection conn = connectionsUtil.getConnection();
		
		String query = "select * from expense_item_master";
		if(isActive){
			query += " where is_active = 1";
		}
		
		ResultSet dataRS = conn.createStatement().executeQuery(query);
		List<ExpenseItem> itemList = new ArrayList<ExpenseItem>();
		ExpenseItem item;
		
		while(dataRS.next()){
			item = new ExpenseItem();
			
			item.setExpenseItemId(dataRS.getInt("expense_item_id"));
			item.setExpenseItemName(dataRS.getString("expense_item_name"));
			item.setIsActive(dataRS.getBoolean("is_active"));
			
			itemList.add(item);
		}
		
		connectionsUtil.closeConnection(conn);
		
		return itemList;
}

public List<Vendor> getAllVendors(Boolean isActive) throws SQLException{
	
	ConnectionsUtil connectionsUtil = new ConnectionsUtil();
	Connection conn = connectionsUtil.getConnection();
	
	String query = "select * from vendor_master";
	if(isActive){
		query += " where is_active = 1";
	}
	
	ResultSet dataRS = conn.createStatement().executeQuery(query);
	List<Vendor> vendorList = new ArrayList<Vendor>();
	Vendor vendor;
	
	while(dataRS.next()){
		vendor = new Vendor();
		
		vendor.setVendorId(dataRS.getInt("vendor_id"));
		vendor.setVendorName(dataRS.getString("vendor_name"));
		vendor.setIsActive(dataRS.getBoolean("is_active"));
		
		vendorList.add(vendor);
	}
	
	connectionsUtil.closeConnection(conn);
	
	return vendorList;
}
}

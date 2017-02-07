package com.org.krishnadeep.masters;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
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

/*public List<Vendor> getAllVendors(Boolean isActive) throws SQLException{
	
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
}*/

public List<Vendor> getAllVendors(Boolean isActive, Integer vendorId) throws SQLException{

ConnectionsUtil connectionsUtil = new ConnectionsUtil();
Connection conn = connectionsUtil.getConnection();

String query = "select * from vendor_master";
if(isActive && vendorId != 0){
	query += " where is_active = 1 and vendor_id = "+ vendorId;
}else if(isActive){
	query += " where is_active = 1";
}else if(vendorId != 0){
	query += " where vendor_id = "+ vendorId;
}

ResultSet dataRS = conn.createStatement().executeQuery(query);
List<Vendor> vendorList = new ArrayList<Vendor>();
Vendor vendor;

while(dataRS.next()){
	vendor = new Vendor();
	
	vendor.setVendorId(dataRS.getInt("vendor_id"));
	vendor.setVendorName(dataRS.getString("vendor_name"));
	vendor.setIsActive(dataRS.getBoolean("is_active"));
	vendor.setVendorAddress(dataRS.getString("address"));
	vendor.setCreatedBy(dataRS.getInt("created_by"));
	vendor.setCreatedOn(dataRS.getString("created_on"));
	vendor.setContactNo(dataRS.getString("contact_no"));
	
	vendorList.add(vendor);
}

connectionsUtil.closeConnection(conn);

return vendorList;
}

public Vendor insertVendor(Vendor vendor, String userId) throws SQLException{
	ConnectionsUtil connectionsUtil = new ConnectionsUtil();
	Connection conn = connectionsUtil.getConnection();
	
	String query = "insert into vendor_master(vendor_name, contact_no, address, is_active, created_by) values(?,?,?,?,?)";
	
	PreparedStatement psmt = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
	
	
	psmt.setString(1, vendor.getVendorName());
	psmt.setString(2, vendor.getContactNo());
	psmt.setString(3, vendor.getVendorAddress());
	psmt.setBoolean(4, vendor.getIsActive());
	psmt.setString(5, userId);
	
	psmt.executeUpdate();
	
	ResultSet dataRS = psmt.getGeneratedKeys();
	if(dataRS.next()){
		vendor.setVendorId(dataRS.getInt(1));
	}
	
	connectionsUtil.closeConnection(dataRS);
	
	return vendor;
}

public Vendor updateVendor(Vendor vendor, String userId) throws SQLException{
	ConnectionsUtil connectionsUtil = new ConnectionsUtil();
	Connection conn = connectionsUtil.getConnection();
	
	String query = "update vendor_master set vendor_name = ?, contact_no = ?, address = ?, is_active = ?, created_by = ? where vendor_id = ?";
	
	PreparedStatement psmt = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
	
	
	psmt.setString(1, vendor.getVendorName());
	psmt.setString(2, vendor.getContactNo());
	psmt.setString(3, vendor.getVendorAddress());
	psmt.setBoolean(4, vendor.getIsActive());
	psmt.setString(5, userId);
	psmt.setInt(6, vendor.getVendorId());
	
	psmt.executeUpdate();
	
	connectionsUtil.closeConnection(conn);
	
	return vendor;
}

}

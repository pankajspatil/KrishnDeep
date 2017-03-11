package com.org.krishnadeep.masters;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.org.krishnadeep.generic.ConnectionsUtil;
import com.org.krishnadeep.generic.Utils;
import com.org.krishnadeep.models.ExpenseItem;
import com.org.krishnadeep.models.ExpenseModel;
import com.org.krishnadeep.models.ItemCategory;
import com.org.krishnadeep.models.SessionModel;
import com.org.krishnadeep.models.Vendor;
import com.org.krishnadeep.models.VisitType;
import com.org.krishnadeep.models.WeeklyData;

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
	
public List<ExpenseItem> getAllExpenseItems(Boolean isActive, Integer expenseItemId) throws SQLException{
		
		ConnectionsUtil connectionsUtil = new ConnectionsUtil();
		Connection conn = connectionsUtil.getConnection();
		
		String query = "select * from expense_item_master i inner join item_category ic on i.item_category_id = ic.item_category_id ";
		
		if(isActive && expenseItemId != 0){
			query += " where i.is_active = 1 and expense_item_id = "+ expenseItemId;
		}else if(isActive){
			query += " where i.is_active = 1";
		}else if(expenseItemId != 0){
			query += " where expense_item_id = "+ expenseItemId;
		}
		
		ResultSet dataRS = conn.createStatement().executeQuery(query);
		List<ExpenseItem> itemList = new ArrayList<ExpenseItem>();
		ExpenseItem item;
		ItemCategory itemCategory;
		
		while(dataRS.next()){
			item = new ExpenseItem();
			itemCategory = new ItemCategory();
			
			itemCategory.setItemCategoryId(dataRS.getInt("ic.item_category_id"));
			itemCategory.setItemCategoryName(Utils.getString(dataRS.getString("item_category_name")));
			
			item.setExpenseItemId(dataRS.getInt("expense_item_id"));
			item.setExpenseItemName(Utils.getString(dataRS.getString("expense_item_name")));
			item.setExpenseItemDescription(Utils.getString(dataRS.getString("expense_item_description")));
			item.setIsActive(dataRS.getBoolean("i.is_active"));
			item.setCreatedBy(dataRS.getInt("created_by"));
			item.setCreatedOn(dataRS.getString("created_on"));
			item.setItemCategory(itemCategory);
			
			itemList.add(item);
		}
		
		connectionsUtil.closeConnection(conn);
		
		return itemList;
}

public List<ItemCategory> getAllItemCategories(Boolean isActive, Integer itemCategoryId) throws SQLException{
	
	ConnectionsUtil connectionsUtil = new ConnectionsUtil();
	Connection conn = connectionsUtil.getConnection();
	
	String query = "select * from item_category";
	
	if(isActive && itemCategoryId != 0){
		query += " where is_active = 1 and item_category_id = "+ itemCategoryId;
	}else if(isActive){
		query += " where is_active = 1";
	}else if(itemCategoryId != 0){
		query += " where item_category_id = "+ itemCategoryId;
	}
	
	ResultSet dataRS = conn.createStatement().executeQuery(query);
	List<ItemCategory> itemCategoryList = new ArrayList<ItemCategory>();
	ItemCategory itemCategory;
	
	while(dataRS.next()){
		itemCategory = new ItemCategory();
		
		itemCategory.setItemCategoryId(dataRS.getInt("item_category_id"));
		itemCategory.setItemCategoryName(Utils.getString(dataRS.getString("item_category_name")));
		itemCategory.setItemCategoryDescription(Utils.getString(dataRS.getString("item_category_description")));
		itemCategory.setIsActive(dataRS.getBoolean("is_active"));
		itemCategory.setCreatedBy(dataRS.getInt("created_by"));
		itemCategory.setCreatedOn(dataRS.getString("created_on"));
		
		itemCategoryList.add(itemCategory);
	}
	
	connectionsUtil.closeConnection(conn);
	
	return itemCategoryList;
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

/**
 * Methods to add item categories
 * */

public ItemCategory insertItemCategory(ItemCategory itemCategory, String userId) throws SQLException{
	ConnectionsUtil connectionsUtil = new ConnectionsUtil();
	Connection conn = connectionsUtil.getConnection();
	
	String query = "insert into item_category(item_category_name, item_category_description, is_active, created_by) values(?,?,?,?)";
	
	PreparedStatement psmt = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
	
	
	psmt.setString(1, itemCategory.getItemCategoryName());
	psmt.setString(2, itemCategory.getItemCategoryDescription());
	psmt.setBoolean(3, itemCategory.getIsActive());
	psmt.setString(4, userId);
	
	psmt.executeUpdate();
	
	ResultSet dataRS = psmt.getGeneratedKeys();
	if(dataRS.next()){
		itemCategory.setItemCategoryId(dataRS.getInt(1));
	}
	
	connectionsUtil.closeConnection(dataRS);
	
	return itemCategory;
}

public ItemCategory updateItemCategory(ItemCategory itemCategory, String userId) throws SQLException{
	ConnectionsUtil connectionsUtil = new ConnectionsUtil();
	Connection conn = connectionsUtil.getConnection();
	
	String query = "update item_category set item_category_name = ?, item_category_description = ?, is_active = ?, created_by = ? where item_category_id = ?";
	
	PreparedStatement psmt = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
	
	
	psmt.setString(1, itemCategory.getItemCategoryName());
	psmt.setString(2, itemCategory.getItemCategoryDescription());
	psmt.setBoolean(3, itemCategory.getIsActive());
	psmt.setString(4, userId);
	psmt.setInt(5, itemCategory.getItemCategoryId());
	
	psmt.executeUpdate();
	
	connectionsUtil.closeConnection(conn);
	
	return itemCategory;
}

/**
 * Methods to add Expense items
 * */

public ExpenseItem insertExpenseItem(ExpenseItem expenseItem, String userId) throws SQLException{
	ConnectionsUtil connectionsUtil = new ConnectionsUtil();
	Connection conn = connectionsUtil.getConnection();
	
	String query = "insert into expense_item_master(expense_item_name, expense_item_description, item_category_id, is_active, created_by) values(?,?,?,?,?)";
	
	PreparedStatement psmt = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
	
	
	psmt.setString(1, expenseItem.getExpenseItemName());
	psmt.setString(2, expenseItem.getExpenseItemDescription());
	psmt.setInt(3, expenseItem.getItemCategory().getItemCategoryId());
	psmt.setBoolean(4, expenseItem.getIsActive());
	psmt.setString(5, userId);
	
	psmt.executeUpdate();
	
	ResultSet dataRS = psmt.getGeneratedKeys();
	if(dataRS.next()){
		expenseItem.setExpenseItemId(dataRS.getInt(1));
	}
	
	connectionsUtil.closeConnection(dataRS);
	
	return expenseItem;
}

public ExpenseItem updateExpenseItem(ExpenseItem expenseItem, String userId) throws SQLException{
	ConnectionsUtil connectionsUtil = new ConnectionsUtil();
	Connection conn = connectionsUtil.getConnection();
	
	String query = "update expense_item_master set expense_item_name = ?, expense_item_description = ?, item_category_id = ?, is_active = ?, created_by = ? where expense_item_id = ?";
	
	PreparedStatement psmt = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
	
	
	psmt.setString(1, expenseItem.getExpenseItemName());
	psmt.setString(2, expenseItem.getExpenseItemDescription());
	psmt.setInt(3, expenseItem.getItemCategory().getItemCategoryId());
	psmt.setBoolean(4, expenseItem.getIsActive());
	psmt.setString(5, userId);
	psmt.setInt(6, expenseItem.getExpenseItemId());
	
	psmt.executeUpdate();
	
	connectionsUtil.closeConnection(conn);
	
	return expenseItem;
}

/******Methods to add weekly data******/

public List<WeeklyData> getWeeklyCountsData(Integer weeklyCountsId, boolean isActive,SessionModel sessionModel) throws SQLException{
	
	
	ConnectionsUtil connectionsUtil = new ConnectionsUtil();
	Connection conn = connectionsUtil.getConnection();

	String query = "select * from weekly_counts w "
			+ "inner join user_master um inner join dispensary_user_map dm  "
			+ "where um.user_id=dm.user_id and um.user_id=w.created_by and ";
	
	query+= "  um.user_id = " + sessionModel.getSessionUserId();
	query+= " and dm.dispensary_id = " + sessionModel.getSessionDipensaryId();
	
	if(isActive && weeklyCountsId != 0){
		query += " and w.is_active = 1 and weekly_counts_id = "+ weeklyCountsId;
	}else if(isActive){
		query += " and w.is_active = 1";
	}else if(weeklyCountsId != 0){
		query += " and weekly_counts_id = "+ weeklyCountsId;
	}
	
	
			
	PreparedStatement preparedStatement = conn.prepareStatement(query);
	ResultSet dataRS = preparedStatement.executeQuery();

	List<WeeklyData> weeklyDataList = new ArrayList<WeeklyData>();
	WeeklyData weeklyData;
	
	while (dataRS.next()) {
		
		weeklyData = new WeeklyData();
		
		weeklyData.setWeeklyDataId(dataRS.getInt("weekly_counts_id"));
		weeklyData.setWeekYearNo(dataRS.getInt("week_year_no"));
		weeklyData.setPatientCount(Utils.getInt(dataRS.getInt("patient_count")));
		weeklyData.setPatientAmount(Utils.getDouble(dataRS.getInt("patient_amount")));
		weeklyData.setPatientCountClaim(Utils.getInt(dataRS.getInt("patient_count_claim")));
		weeklyData.setPatientAmountClaim(Utils.getDouble(dataRS.getInt("patient_amount_claim")));
		weeklyData.setPatientCountNonClaim(Utils.getInt(dataRS.getInt("patient_count_non_claim")));
		weeklyData.setPatientAmountNonClaim(Utils.getDouble(dataRS.getInt("patient_amount_non_claim")));
		weeklyData.setWeekStartDate(Utils.getString(dataRS.getString("week_start_date")));
		
		weeklyDataList.add(weeklyData);
	}

	connectionsUtil.closeConnection(conn);

return weeklyDataList;

}

public WeeklyData insertWeeklyData(WeeklyData weeklyData) throws SQLException{
	ConnectionsUtil connectionsUtil = new ConnectionsUtil();
	Connection conn = connectionsUtil.getConnection();
	
	String query = "insert into weekly_counts(week_year_no, created_by, patient_count, patient_amount, patient_count_claim, "+
				"patient_amount_claim, patient_count_non_claim, patient_amount_non_claim, week_start_date ) values(?,?,?,?,?,?,?,?,?)";
	
	PreparedStatement psmt = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
	
	psmt.setInt(1, weeklyData.getWeekYearNo());
	psmt.setInt(2, weeklyData.getCreatedBy());
	psmt.setInt(3, weeklyData.getPatientCount());
	psmt.setDouble(4, weeklyData.getPatientAmount());
	psmt.setInt(5, weeklyData.getPatientCountClaim());
	psmt.setDouble(6, weeklyData.getPatientAmountClaim());
	psmt.setInt(7, weeklyData.getPatientCountNonClaim());
	psmt.setDouble(8, weeklyData.getPatientAmountNonClaim());
	psmt.setString(9, weeklyData.getWeekStartDate());
	//psmt.setBoolean(9, weeklyData.getIsActive());
	
	psmt.executeUpdate();
	
	ResultSet dataRS = psmt.getGeneratedKeys();
	if(dataRS.next()){
		weeklyData.setWeeklyDataId(dataRS.getInt(1));
	}
	
	connectionsUtil.closeConnection(dataRS);
	
	return weeklyData;
}

public WeeklyData updateWeeklyData(WeeklyData weeklyData) throws SQLException{
	ConnectionsUtil connectionsUtil = new ConnectionsUtil();
	Connection conn = connectionsUtil.getConnection();
	
	String query = "update weekly_counts set week_year_no = ?, created_by = ?, patient_count = ?, patient_amount = ?, patient_count_claim = ?, "+
					"patient_amount_claim = ?, patient_count_non_claim = ?, patient_amount_non_claim = ?, week_start_date = ? " + 
					"where weekly_counts_id = ?";
	
	PreparedStatement psmt = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
	
	psmt.setInt(1, weeklyData.getWeekYearNo());
	psmt.setInt(2, weeklyData.getCreatedBy());
	psmt.setInt(3, weeklyData.getPatientCount());
	psmt.setDouble(4, weeklyData.getPatientAmount());
	psmt.setInt(5, weeklyData.getPatientCountClaim());
	psmt.setDouble(6, weeklyData.getPatientAmountClaim());
	psmt.setInt(7, weeklyData.getPatientCountNonClaim());
	psmt.setDouble(8, weeklyData.getPatientAmountNonClaim());
	psmt.setString(9, weeklyData.getWeekStartDate());
	//psmt.setBoolean(9, weeklyData.getIsActive());
	psmt.setInt(10, weeklyData.getWeeklyDataId());
	
	psmt.executeUpdate();
	
	connectionsUtil.closeConnection(conn);
	
	return weeklyData;
}

public List<WeeklyData> getConsolidatedWeeklyCountsData(Integer weeklyCountsId, boolean isActive,SessionModel sessionModel,String fromDate, String toDate) throws SQLException{
	
	
	ConnectionsUtil connectionsUtil = new ConnectionsUtil();
	Connection conn = connectionsUtil.getConnection();

	String query = "select * from weekly_counts w "
			+ "inner join user_master um inner join dispensary_user_map dm  "
			+ "where um.user_id=dm.user_id and um.user_id=w.created_by  ";
	
	if (sessionModel != null){
		query+= " and um.user_id = " + sessionModel.getSessionUserId();
		query+= " and dm.dispensary_id = " + sessionModel.getSessionDipensaryId();
	}
	
	
	 if(isActive){
		query += " and w.is_active = 1";
	}
	
			
	PreparedStatement preparedStatement = conn.prepareStatement(query);
	ResultSet dataRS = preparedStatement.executeQuery();

	List<WeeklyData> weeklyDataList = new ArrayList<WeeklyData>();
	WeeklyData weeklyData;
	
	while (dataRS.next()) {
		
		weeklyData = new WeeklyData();
		
		weeklyData.setWeeklyDataId(dataRS.getInt("weekly_counts_id"));
		weeklyData.setDoctorName(dataRS.getString("first_name") + " " + dataRS.getString("last_name"));
		weeklyData.setWeekYearNo(dataRS.getInt("week_year_no"));
		weeklyData.setPatientCount(Utils.getInt(dataRS.getInt("patient_count")));
		weeklyData.setPatientAmount(Utils.getDouble(dataRS.getInt("patient_amount")));
		weeklyData.setPatientCountClaim(Utils.getInt(dataRS.getInt("patient_count_claim")));
		weeklyData.setPatientAmountClaim(Utils.getDouble(dataRS.getInt("patient_amount_claim")));
		weeklyData.setPatientCountNonClaim(Utils.getInt(dataRS.getInt("patient_count_non_claim")));
		weeklyData.setPatientAmountNonClaim(Utils.getDouble(dataRS.getInt("patient_amount_non_claim")));
		weeklyData.setWeekStartDate(Utils.getString(dataRS.getString("week_start_date")));
		
		weeklyDataList.add(weeklyData);
	}

	connectionsUtil.closeConnection(conn);

return weeklyDataList;

}

}

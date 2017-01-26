package com.org.krishnadeep.reports;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedHashMap;

import com.org.krishnadeep.generic.ConnectionsUtil;

public class Reports {

	
	public LinkedHashMap<String, LinkedHashMap<String, String>> getVisitRevenueData(String fromDate, String toDate, String reportType) throws SQLException{
		
		ConnectionsUtil connectionsUtil = new ConnectionsUtil();
		Connection conn = connectionsUtil.getConnection();
		
		String format = reportType.equalsIgnoreCase("month") ? "%b-%y" : "%d-%b-%y";
		String orderByFormat = reportType.equalsIgnoreCase("month") ? "%Y-%m" : "%Y-%m-%d";
		
		String query = "select v.visit_type_id, sum(ifnull(fees,0)) as amount, "
				+ "date_format(uv.created_on, '"+ format +"') as reportKey "
				+ "from user_visit uv inner join visit_type v on uv.visit_type_id = v.visit_type_id and v.is_active = 1 "
				+ "and uv.created_on between ? AND ? group by reportKey "
				+ "order by date_format(uv.created_on, '"+orderByFormat+"') desc";
		
		PreparedStatement psmt = conn.prepareStatement(query);
		psmt.setString(1, fromDate + " 00:00:00");
		psmt.setString(2, toDate + " 23:59:59");
		
		ResultSet dataRS = psmt.executeQuery();
		String previousKey = "", currentKey = "";
		LinkedHashMap<String, LinkedHashMap<String, String>> dateMap = new LinkedHashMap<String, LinkedHashMap<String,String>>();
		LinkedHashMap<String, String> statusMap = new LinkedHashMap<String, String>();
		
		while(dataRS.next()){
			currentKey = dataRS.getString("reportKey");
			if(!previousKey.equals("") && !previousKey.equals(currentKey)){
				dateMap.put(previousKey, statusMap);				
				statusMap = new LinkedHashMap<String, String>();
			}
			statusMap.put(dataRS.getString("visit_type_id"), dataRS.getString("amount"));			
			previousKey = currentKey;
		}
		dateMap.put(previousKey, statusMap);
		
		connectionsUtil.closeConnection(conn);
		
		return dateMap;
	}
	
public LinkedHashMap<String, String> getRevenueData(String fromDate, String toDate, String reportType) throws SQLException{
		
		ConnectionsUtil connectionsUtil = new ConnectionsUtil();
		Connection conn = connectionsUtil.getConnection();
		
		String format = reportType.equalsIgnoreCase("month") ? "%b-%y" : "%d-%b-%y";
		String orderByFormat = reportType.equalsIgnoreCase("month") ? "%Y-%m" : "%Y-%m-%d";
		
		String query = "select s.status_id, sum(ifnull(order_price,0)) - sum(ifnull(discount_amt,0)) as amount, "
					+ "date_format(o.created_on, '"+ format +"') as reportKey "
					+ "from order_master o inner join status_master s on o.status_id = s.status_id "
					+ "inner join order_menu_map om on om.order_id = o.order_id and om.is_active = 1 "
					+ "and o.created_on between ? AND ? and status_code = 'COMPLETED'group by reportKey "
					+ "order by date_format(o.created_on, '"+orderByFormat+"') desc";
		
		PreparedStatement psmt = conn.prepareStatement(query);
		psmt.setString(1, fromDate + " 00:00:00");
		psmt.setString(2, toDate + " 23:59:59");
		
		ResultSet dataRS = psmt.executeQuery();
		LinkedHashMap<String, String> revenueMap = new LinkedHashMap<String, String>();
		
		while(dataRS.next()){

			revenueMap.put(dataRS.getString("reportKey"), dataRS.getString("amount"));
			
		}

		connectionsUtil.closeConnection(conn);
		return revenueMap;
	}

public LinkedHashMap<String, String> getActiveVisitTypes() throws SQLException{
	
	LinkedHashMap<String, String> visitTypeMap = new LinkedHashMap<String, String>();
	
	ConnectionsUtil connectionsUtil = new ConnectionsUtil();
	Connection conn = connectionsUtil.getConnection();
	
	String query = "select * from visit_type where is_active = 1 order by visit_type_id desc";
	ResultSet dataRS = conn.createStatement().executeQuery(query);
	while(dataRS.next()){
		visitTypeMap.put(dataRS.getString("visit_type_id"), dataRS.getString("visit_type"));
	}
	
	connectionsUtil.closeConnection(conn);
	dataRS = null; conn = null; query = null;
	
	return visitTypeMap;
}

}

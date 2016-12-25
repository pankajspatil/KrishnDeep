package com.org.krishnadeep.masters;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.org.krishnadeep.generic.ConnectionsUtil;
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
}

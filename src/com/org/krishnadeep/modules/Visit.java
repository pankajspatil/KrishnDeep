package com.org.krishnadeep.modules;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;

import com.org.krishnadeep.generic.ConnectionsUtil;
import com.org.krishnadeep.generic.Constants;
import com.org.krishnadeep.models.Patient;
import com.org.krishnadeep.models.UserVisit;
import com.org.krishnadeep.models.VisitType;

public class Visit {

public LinkedHashMap<String, Object> createNewVisit( LinkedHashMap<String, String> paramMap){
	ConnectionsUtil connectionsUtil = new ConnectionsUtil();
	LinkedHashMap<String, Object> returnMap = new LinkedHashMap<String, Object>();
	try{
		
		Connection conn = connectionsUtil.getConnection();
		
		
		String query = "INSERT INTO `user_visit` (`patient_id`,`weight`,`height`,"
				+ "`bp`,`bmi`,`gfr`,`hbv`,`hiv`,`g6pd`,`ahb`, "+
				"`allergy`,`summary`,`prescription_data`,`created_by`,`medical_test_ids`,`visit_type_id`,`fees`) " +
				"values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
		
		PreparedStatement psmt = conn.prepareStatement(query);
		
		psmt.setString(1, paramMap.get(Constants.PATIENT_ID));
		psmt.setString(2, paramMap.get(Constants.WEIGHT));
		psmt.setString(3, paramMap.get(Constants.HEIGHT));
		psmt.setString(4, paramMap.get(Constants.BP));
		psmt.setString(5, paramMap.get(Constants.BMI));
		psmt.setString(6, paramMap.get(Constants.GFR));
		psmt.setString(7, paramMap.get(Constants.HBV));
		psmt.setString(8, paramMap.get(Constants.HIV));
		psmt.setString(9, paramMap.get(Constants.G6PD));
		psmt.setString(10, paramMap.get(Constants.ABNORMAL_HB));
		psmt.setString(11, paramMap.get(Constants.ALLERGY));
		psmt.setString(12, paramMap.get(Constants.VISIT_SUMMARY));
		psmt.setString(13, paramMap.get(Constants.PRESCRIPTION_DATA));
		psmt.setString(14, paramMap.get(Constants.USER_ID));
		psmt.setString(15, paramMap.get(Constants.MEDICAL_TEST_IDS));
		psmt.setString(16, paramMap.get(Constants.VISIT_TYPE_ID));
		psmt.setString(17, paramMap.get(Constants.VISIT_FEES));
		
		psmt.executeUpdate();
		
		ResultSet dataRS = psmt.getGeneratedKeys();
		if(dataRS != null && dataRS.next()){
			returnMap.put(Constants.VISIT_ID, dataRS.getString(1));
			//returnMap.put(Constants.VISIT_DATE, dataRS.getDate("created_on"));
		}
		
		if(paramMap.get(Constants.APPOINTMENT_ID) != null && !paramMap.get(Constants.APPOINTMENT_ID).equals("")){
			query = "update appointment_master set appointment_status = (select status_id from status_master where status_code = 'CONFIRMED') "
					+ "where appointment_id = " + paramMap.get(Constants.APPOINTMENT_ID);
			conn.createStatement().executeUpdate(query);
		}
		
		
		connectionsUtil.closeConnection(psmt);
		
		returnMap.put(Constants.RETURN_STATUS, 0);
		
	}catch(Exception ex){
		ex.printStackTrace();
		returnMap.put(Constants.RETURN_STATUS, 0);
	}
	
	return returnMap;
}
	
public ResultSet getVisitDetail(String patientId, String doctorId, String visitId){

	ResultSet dataRS = null;
	
	try{
		ConnectionsUtil connectionsUtil = new ConnectionsUtil();
		Connection conn = connectionsUtil.getConnection();
		
		String query = "SELECT * FROM user_visit uv "+
					"inner join patient_master um on uv.patient_id = um.patient_id";
		if(patientId != null){
			query += " where uv.patient_id = " + patientId;
		}
		
		if(doctorId != null){
			if(patientId != null){
				query += " and uv.created_by = " + doctorId;
			}else{
			query += " where uv.created_by = " + doctorId;
			}
		}
		
		if(visitId != null){
			query += " where uv.user_visit_id = " + visitId;
		}
		
		System.out.println("visitQuery ==>" + query);
		
		Statement stmt = conn.createStatement();
		dataRS = stmt.executeQuery(query);
		
		
	}catch(Exception ex){
		ex.printStackTrace();
	}
	
	return dataRS;

}

public LinkedHashMap<String, Object> getMedicalTests(){
	
	ConnectionsUtil connectionsUtil = new ConnectionsUtil();
	Connection conn = connectionsUtil.getConnection();
	
	LinkedHashMap<String, Object> returnMap = new LinkedHashMap<String, Object>();
	Integer numberOfRows = 0;
	try{
		
		String query = "select m.*, mt.Medical_Test_Master_label as parent_label from medical_test_master m " +
				"left join medical_test_master mt on m.parent_id = mt.medical_test_master_id " +
				"where m.parent_id is not null order by m.parent_id;";
		
		ResultSet dataRS = conn.createStatement().executeQuery(query);
		String oldParentTestId = "", oldParentLabel = "", parentId = "", parentLabel = "";
		LinkedHashMap<String, String> childMap = new LinkedHashMap<String, String>();
		
		
		while(dataRS.next()){
			
			parentId = dataRS.getString("parent_id");
			parentLabel = dataRS.getString("parent_label");
			
			if(!oldParentTestId.equals("") && !oldParentTestId.equals(parentId)){
				returnMap.put(oldParentTestId + "##" + oldParentLabel, childMap);				
				childMap = new LinkedHashMap<String, String>();
			}
			
			childMap.put(dataRS.getString("medical_test_master_id"), dataRS.getString("Medical_Test_Master_label"));
			oldParentTestId = parentId;
			oldParentLabel = parentLabel;
			numberOfRows ++;
		}
		if(!parentId.equals("")){
			returnMap.put(parentId + "##" + parentLabel, childMap);
		}		
		
	}catch(Exception ex){
		ex.printStackTrace();
	}
	try {
		conn.close();
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	returnMap.put(Constants.NUMBER_OF_ROWS, numberOfRows);
	return returnMap;
}

public List<UserVisit> getUserVisitList(Integer visitId, String fromDate, String toDate) throws SQLException{
	
	ConnectionsUtil connectionsUtil = new ConnectionsUtil();
	Connection conn = connectionsUtil.getConnection();
	
	String query = "select uv.user_visit_id, p.first_name as pFirstName, p.last_name pLastName, "+
			"u.first_name as dFirstName, u.last_name as dLastName, "+ 
			"uv.created_on, p.dob, CONCAT(TIMESTAMPDIFF( YEAR, dob, now() ),' Years,', "+
			"TIMESTAMPDIFF( MONTH, dob, now() ) % 12,' Months,', "+
			"FLOOR( TIMESTAMPDIFF( DAY, dob, now() ) % 30.4375 ),' Days') as age, p.sex, visit_type, fees, summary from user_visit uv "+
			"inner join patient_master p on uv.patient_id = p.patient_id ";
	
			if(visitId != null){
				query += " and user_visit_id = " + visitId;
			}
			
			if(fromDate != null && toDate != null){
				query += " and uv.created_on between '"+fromDate+" 00:00:00' and '"+toDate+" 23:59:59'";
			}
	
			query += " inner join user_master u on u.user_id = uv.created_by "+
			"inner join visit_type vt on uv.visit_type_id = vt.visit_type_id";
	
	
	ResultSet dataRS = conn.createStatement().executeQuery(query);
	List<UserVisit> userVisitList = new ArrayList<UserVisit>();
	UserVisit userVisit;
	Patient patient;
	Patient doctor;
	VisitType visitType; 
	
	while(dataRS.next()){
		userVisit = new UserVisit();
		patient = new Patient();
		doctor = new Patient();
		visitType = new VisitType();
		
		userVisit.setUserVisitId(dataRS.getInt("user_visit_id"));
		userVisit.setFees(dataRS.getDouble("fees"));
		userVisit.setSummary(dataRS.getString("summary"));
		userVisit.setCreatedOn(dataRS.getString("created_on"));
		userVisit.setAge(dataRS.getString("age"));
		
		patient.setFirstName(dataRS.getString("pFirstName"));
		patient.setLastName(dataRS.getString("pLastName"));
		patient.setSex(dataRS.getString("sex"));
		userVisit.setPatient(patient);
		
		visitType.setVisitType(dataRS.getString("visit_type"));
		userVisit.setVisitType(visitType);
		
		doctor.setFirstName(dataRS.getString("dFirstName"));
		doctor.setLastName(dataRS.getString("dLastName"));
		userVisit.setDoctor(doctor);
		
		userVisitList.add(userVisit);
	}
	
	
	return userVisitList;
}

}

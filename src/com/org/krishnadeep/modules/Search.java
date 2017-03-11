package com.org.krishnadeep.modules;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.org.krishnadeep.generic.ConnectionsUtil;
import com.org.krishnadeep.generic.Utils;
import com.org.krishnadeep.models.Patient;
import com.org.krishnadeep.models.SessionModel;

public class Search {

	Connection conn = null;
	ResultSet rs = null;
	ConnectionsUtil connectionsUtil = null;

	public List<Patient> searchPatient(Integer searchKey, String searchValue,SessionModel sessionModel) throws SQLException {

		ResultSet dataRS = null;
		List<Patient> patientList = new ArrayList<Patient>();
		
		switch (searchKey) {
		case 1:
			dataRS = getPatientByName(searchValue,sessionModel);
			break;
		case 2:
			dataRS = getPatientByMobileNo(searchValue,sessionModel);
			break;
		case 4:
			dataRS = getPatientByDOB(searchValue,sessionModel);
			break;
		case 5:
			dataRS = getPatientByID(searchValue,sessionModel);
			break;
		default:
			dataRS = getAllPatients(false); 
			
		}
		
		Patient patient = null;
		while(dataRS.next()){
			patient = new Patient();
			
			patient.setPatientId(dataRS.getInt("patient_id"));
			patient.setFirstName(Utils.getString(dataRS.getString("first_name")));
			patient.setMiddleName(Utils.getString(dataRS.getString("middle_name")));
			patient.setLastName(Utils.getString(dataRS.getString("last_name")));
			patient.setEmail(Utils.getString(dataRS.getString("email")));
			patient.setContactNo(Utils.getString(dataRS.getString("contact_no")));
			patient.setSex(Utils.getString(dataRS.getString("sex")));
			patient.setBloodGroup(Utils.getString(dataRS.getString("bloodGroup")));
			patient.setAddress(Utils.getString(dataRS.getString("address")));
			patient.setDob(Utils.getString(dataRS.getString("dob")));
			patient.setIsActive(dataRS.getBoolean("is_active"));
			
			patientList.add(patient);
		}
		
		if(dataRS != null){
			ConnectionsUtil.closeRes(dataRS);
		}

		return patientList;
	}

	private ResultSet getPatientByDOB(String dob,SessionModel sessionModel) {

		ResultSet dataRS = null;
		
		try{
			connectionsUtil = new ConnectionsUtil();		
			conn = connectionsUtil.getConnection();
			String query = "select * from patient_master pm inner join user_master um inner join dispensary_user_map dm "
					+ "where um.user_id=dm.user_id and um.user_id=pm.created_by "
					+ "and pm.created_by = ? and dm.dispensary_id = ? and dob  = ?";
			PreparedStatement pst = conn.prepareStatement(query);
			
			pst.setInt(1, sessionModel.getSessionUserId());
			pst.setInt(2, sessionModel.getSessionDipensaryId());
			pst.setString(3, dob);
			
			dataRS = pst.executeQuery();
			
			query = null;connectionsUtil = null;			
		}catch(Exception ex){
			ex.printStackTrace();
		}
		return dataRS;
	}
	
	private ResultSet getAllPatients(Boolean isActive) {

		ResultSet dataRS = null;
		
		try{
			connectionsUtil = new ConnectionsUtil();		
			conn = connectionsUtil.getConnection();
			String query = "select * from patient_master  ";
			if(isActive){
				query += "where is_active = 1";
			}
			PreparedStatement pst = conn.prepareStatement(query);
			dataRS = pst.executeQuery();
			
			query = null;connectionsUtil = null;			
		}catch(Exception ex){
			ex.printStackTrace();
		}
		return dataRS;
	}

	public ResultSet getPatientByName(String searchValue,SessionModel sessionModel) {
		
		ResultSet dataRS = null;
		
		try{
			connectionsUtil = new ConnectionsUtil();		
			conn = connectionsUtil.getConnection();
			String query = "select * from patient_master pm "
					+ "inner join user_master um inner join dispensary_user_map dm  "
					+ "where um.user_id=dm.user_id and um.user_id=pm.created_by and "
					+ "pm.created_by = ? and dispensary_id = ? first_name like '%"+searchValue+"%' or"
							+ " last_name like '%"+searchValue+"%'";
			
			PreparedStatement pst = conn.prepareStatement(query);
			pst.setInt(1, sessionModel.getSessionUserId());
			pst.setInt(2, sessionModel.getSessionDipensaryId());
			
			dataRS = pst.executeQuery();
			
		}catch(Exception ex){
			ex.printStackTrace();
		}
		return dataRS;
	}

	public ResultSet getPatientByMobileNo(String phone,SessionModel sessionModel) {

		ResultSet dataRS = null;
		try{
			connectionsUtil = new ConnectionsUtil();		
			conn = connectionsUtil.getConnection();
			String query = "select * from patient_master pm  "
					+ "inner join user_master um inner join dispensary_user_map dm  "
					+ "where um.user_id=dm.user_id and um.user_id=pm.created_by and "
					+ "pm.created_by = ? and dispensary_id = ? and contact_no = ?";
			
			PreparedStatement pst = conn.prepareStatement(query);
			pst.setInt(1, sessionModel.getSessionUserId());
			pst.setInt(2, sessionModel.getSessionDipensaryId());
			pst.setString(3, phone);
			dataRS = pst.executeQuery();
			
			query = null;connectionsUtil = null;
			
		}catch(Exception ex){
			ex.printStackTrace();
		}
		
		return dataRS;
	}
	
	public ResultSet getPatientByID(String patientId,SessionModel sessionModel){
	
		ResultSet dataRS = null;
		try{		
			connectionsUtil= new ConnectionsUtil();
			conn = connectionsUtil.getConnection();
			
			String query = "select * from patient_master pm "
					+ "inner join user_master um inner join dispensary_user_map dm  "
					+ "where um.user_id=dm.user_id and um.user_id=pm.created_by and "
					+ "pm.created_by = ? and dispensary_id = ? and patient_id = ?";
			
			PreparedStatement pst = conn.prepareStatement(query);
			pst.setInt(1, sessionModel.getSessionUserId());
			pst.setInt(2, sessionModel.getSessionDipensaryId());
			pst.setString(3, patientId);
			
			dataRS = pst.executeQuery();
			}catch(Exception ex){
				ex.printStackTrace();
			}
			
		return dataRS;
	}
	
	public ResultSet getAllPrescriptions(){
	ResultSet dataRS = null;
		
		try{		
			connectionsUtil= new ConnectionsUtil();
			conn = connectionsUtil.getConnection();
			
			String query = "select * from medicine_master";
			
			PreparedStatement psm = conn.prepareStatement(query);
			
			dataRS = psm.executeQuery();
			}catch(Exception ex){
				ex.printStackTrace();
			}
			
		return dataRS;
	}

	public ResultSet getPatientByAdharNo() {

		return null;
	}
	
	public void createUpdatePatient(Patient patient) throws SQLException{

		connectionsUtil = new ConnectionsUtil();
		conn = connectionsUtil.getConnection();
		
		String query = "";
		
		query = "INSERT INTO `patient_master`(`first_name`,`middle_name`,`last_name`,`email`,"
					+ "`contact_no`,`sex`,`bloodGroup`,`address`,`dob`,`created_by`,`is_active`) VALUES(?,?,?,?,?,?,?,?,?,?,?)";
		
		if(patient.getPatientId() != null && patient.getPatientId() != 0){
			query = "UPDATE `patient_master` SET `first_name` = ?,`middle_name` = ?,"
					+ "`last_name` = ?,`email` = ?,`contact_no` = ?,`sex` = ?,`bloodGroup` = ?,`address` = ?,"
					+ "`dob` = ?,`created_by` = ?,`is_active` = ? WHERE `patient_id` = ?;";
		}
		
		PreparedStatement psmt = conn.prepareStatement(query);
		
		psmt.setString(1, patient.getFirstName());
		psmt.setString(2, patient.getMiddleName());
		psmt.setString(3, patient.getLastName());
		psmt.setString(4, patient.getEmail());
		psmt.setString(5, patient.getContactNo());
		psmt.setString(6, patient.getSex());
		psmt.setString(7, patient.getBloodGroup());
		psmt.setString(8, patient.getAddress());
		psmt.setString(9, patient.getDob());
		psmt.setInt(10, patient.getCreatedBy());
		psmt.setBoolean(11, patient.getIsActive());
		
		if(patient.getPatientId() != null && patient.getPatientId() != 0){
			psmt.setInt(12, patient.getPatientId());
		}
		psmt.executeUpdate();
	}
	

}

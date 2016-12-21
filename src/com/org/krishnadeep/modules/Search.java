package com.org.krishnadeep.modules;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.org.krishnadeep.generic.ConnectionsUtil;
import com.org.krishnadeep.models.Patient;

public class Search {

	Connection conn = null;
	ResultSet rs = null;
	ConnectionsUtil connectionsUtil = null;

	public List<Patient> searchPatient(Integer searchKey, String searchValue) throws SQLException {

		ResultSet dataRS = null;
		List<Patient> patientList = new ArrayList<Patient>();
		
		switch (searchKey) {
		case 1:
			dataRS = getPatientByName(searchValue);
			break;
		case 2:
			dataRS = getPatientByMobileNo(searchValue);
			break;
		case 4:
			dataRS = getPatientByDOB(searchValue);
			break;
		default:
			dataRS = getAllPatients();
			
		}
		
		Patient patient = null;
		while(dataRS.next()){
			patient = new Patient();
			
			patient.setPatientId(dataRS.getInt("patient_id"));
			patient.setFirstName(dataRS.getString("first_name"));
			patient.setMiddleName(dataRS.getString("middle_name"));
			patient.setLastName(dataRS.getString("last_name"));
			patient.setFirstName(dataRS.getString("first_name"));
			patient.setEmail(dataRS.getString("email"));
			patient.setContactNo(dataRS.getString("contact_no"));
			patient.setSex(dataRS.getString("sex"));
			patient.setBloodGroup(dataRS.getString("bloodGroup"));
			patient.setAddress(dataRS.getString("address"));
			patient.setDob(dataRS.getString("dob"));
			patient.setIsActive(dataRS.getBoolean("is_active"));
			
			patientList.add(patient);
		}

		return patientList;
	}

	private ResultSet getPatientByDOB(String dob) {

		ResultSet dataRS = null;
		
		try{
			connectionsUtil = new ConnectionsUtil();		
			conn = connectionsUtil.getConnection();
			String query = "select * from patient_master where dob  = ?";
			PreparedStatement pst = conn.prepareStatement(query);
			
			pst.setString(1, dob);
			
			dataRS = pst.executeQuery();
			
			query = null;connectionsUtil = null;			
		}catch(Exception ex){
			ex.printStackTrace();
		}
		return dataRS;
	}
	
	private ResultSet getAllPatients() {

		ResultSet dataRS = null;
		
		try{
			connectionsUtil = new ConnectionsUtil();		
			conn = connectionsUtil.getConnection();
			String query = "select * from patient_master where is_active = 1";
			PreparedStatement pst = conn.prepareStatement(query);
			dataRS = pst.executeQuery();
			
			query = null;connectionsUtil = null;			
		}catch(Exception ex){
			ex.printStackTrace();
		}
		return dataRS;
	}

	public ResultSet getPatientByName(String searchValue) {
		
		ResultSet dataRS = null;
		
		try{
			connectionsUtil = new ConnectionsUtil();		
			conn = connectionsUtil.getConnection();
			String query = "select * from patient_master where first_name like '%"+searchValue+"%' or last_name like '%"+searchValue+"%'";
			dataRS = conn.createStatement().executeQuery(query);
			
		}catch(Exception ex){
			ex.printStackTrace();
		}
		return dataRS;
	}

	public ResultSet getPatientByMobileNo(String phone) {

		ResultSet dataRS = null;
		try{
			connectionsUtil = new ConnectionsUtil();		
			conn = connectionsUtil.getConnection();
			String query = "select * from patient_master where contact_no = ?";
			PreparedStatement pst = conn.prepareStatement(query);
			pst.setString(1, phone);
			dataRS = pst.executeQuery();
			
			query = null;connectionsUtil = null;
			
		}catch(Exception ex){
			ex.printStackTrace();
		}
		
		return dataRS;
	}
	
	public ResultSet getUser(String userId){
	
		ResultSet dataRS = null;
		try{		
			connectionsUtil= new ConnectionsUtil();
			conn = connectionsUtil.getConnection();
			
			String query = "select * from usermaster where userId = ?";
			
			PreparedStatement psm = conn.prepareStatement(query);
			psm.setString(1, userId);
			
			dataRS = psm.executeQuery();
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
	
	

}

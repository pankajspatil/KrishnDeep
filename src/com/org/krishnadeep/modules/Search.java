package com.org.krishnadeep.modules;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.org.krishnadeep.generic.ConnectionsUtil;

public class Search {

	Connection conn = null;
	ResultSet rs = null;
	ConnectionsUtil connectionsUtil = null;

	public ResultSet searchPatient(Integer searchKey, String searchValue) {

		ResultSet dataRS = null;
		
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

		}

		return dataRS;
	}

	private ResultSet getPatientByDOB(String dob) {

		ResultSet dataRS = null;
		
		try{
			connectionsUtil = new ConnectionsUtil();		
			conn = connectionsUtil.getConnection();
			String query = "select * from userMaster where dob  = ?";
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
			String query = "select * from userMaster where firstName like '%"+searchValue+"%' or lastName like '%"+searchValue+"%'";
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
			String query = "select * from userMaster where phone = ?";
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

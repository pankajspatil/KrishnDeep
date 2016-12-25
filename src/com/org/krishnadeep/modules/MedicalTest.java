package com.org.krishnadeep.modules;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;

import com.org.krishnadeep.generic.ConnectionsUtil;


public class MedicalTest {

	
	public LinkedHashMap<String,  HashMap<String,String>> getMedicalTest(){
		ConnectionsUtil connectionsUtil = new ConnectionsUtil();
				
		Connection conn = connectionsUtil.getConnection();
		String query = "SELECT * FROM citybazz_doctoronline.medical_test_master mtm,"
				+ "medical_test mt "
				+ "where mtm.Medical_Test_Master_id=mt.Medical_Test_Master_id "
				+ "and mtm.is_active ='1' and mt.isactive='1'";
		
		LinkedHashMap<String, HashMap<String,String>> returnMap = new LinkedHashMap<String, HashMap<String,String>>();
		try{
		
			PreparedStatement pst = conn.prepareStatement(query);
			ResultSet dataRS = pst.executeQuery();
			
			LinkedHashMap<String, String> medicalTestModel = null;
			ArrayList<String> medicalTest = null;
			String oldmedical_Test_Master_id = "";
			while (dataRS.next()) {
				medicalTestModel = new LinkedHashMap<String, String>();
				String medicalMasterLabel =  dataRS.getString("Medical_Test_Master_label");
				String medical_Test_Master_id =  dataRS.getString("Medical_Test_Master_id");
				String medical_test_id =  dataRS.getString("medical_test_id");
				String medical_test_label =  dataRS.getString("medical_test_label");
				
				medicalTestModel.put(medical_Test_Master_id, medicalMasterLabel);
				medicalTestModel.put(medical_test_id, medical_test_id);
				medicalTestModel.put(medical_test_label, medical_test_label);
				
				if (!oldmedical_Test_Master_id.equalsIgnoreCase(medical_Test_Master_id)){
					returnMap.put(medical_Test_Master_id,medicalTestModel);
					oldmedical_Test_Master_id =medical_Test_Master_id;
				}
			}

				
			
		}catch(Exception ex){
			ex.printStackTrace();
			return null;
		}
		
		return returnMap;
	}
}

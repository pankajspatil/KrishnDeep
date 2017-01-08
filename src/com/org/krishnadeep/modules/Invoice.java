package com.org.krishnadeep.modules;

import java.sql.Connection;
import java.util.List;

import com.org.krishnadeep.generic.ConnectionsUtil;
import com.org.krishnadeep.models.InvoiceModel;

public class Invoice {

	public List<InvoiceModel> getInvoiceList(){
		
		ConnectionsUtil connectionsUtil = new ConnectionsUtil();
		Connection conn = connectionsUtil.getConnection();
		
		String query = "";
		
		return null;
	}
	
}

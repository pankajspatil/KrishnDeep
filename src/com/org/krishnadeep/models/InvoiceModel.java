package com.org.krishnadeep.models;

import java.util.List;


public class InvoiceModel {

	private Integer invoiceId;
	
	private Vendor vendor;
	
	private Double amount;
	
	private Boolean expenseExist;
	
	private List<ExpenseModel> expenseList;
	
	private Integer createdBy;
	
	private String comments;
	
	private String createdOn;

	public Integer getInvoiceId() {
		return invoiceId;
	}

	public void setInvoiceId(Integer invoiceId) {
		this.invoiceId = invoiceId;
	}

	public Vendor getVendor() {
		return vendor;
	}

	public void setVendor(Vendor vendor) {
		this.vendor = vendor;
	}

	public Double getAmount() {
		return amount;
	}

	public void setAmount(Double amount) {
		this.amount = amount;
	}

	public Boolean getExpenseExist() {
		return expenseExist;
	}

	public void setExpenseExist(Boolean expenseExist) {
		this.expenseExist = expenseExist;
	}

	public List<ExpenseModel> getExpenseList() {
		return expenseList;
	}

	public void setExpenseList(List<ExpenseModel> expenseList) {
		this.expenseList = expenseList;
	}

	public Integer getCreatedBy() {
		return createdBy;
	}

	public void setCreatedBy(Integer createdBy) {
		this.createdBy = createdBy;
	}

	public String getComments() {
		return comments;
	}

	public void setComments(String comments) {
		this.comments = comments;
	}

	public String getCreatedOn() {
		return createdOn;
	}

	public void setCreatedOn(String createdOn) {
		this.createdOn = createdOn;
	}

	@Override
	public String toString() {
		return "InvoiceModel [invoiceId=" + invoiceId + ", vendor=" + vendor
				+ ", amount=" + amount + ", expenseExist=" + expenseExist
				+ ", expenseList=" + expenseList + ", createdBy=" + createdBy
				+ ", comments=" + comments + ", createdOn=" + createdOn + "]";
	}
}

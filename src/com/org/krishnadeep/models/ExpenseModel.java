package com.org.krishnadeep.models;

public class ExpenseModel {

	private Integer expenseId;
	
	private Vendor vendor;
	
	private ExpenseItem expenseItem;
	
	private Integer expenseQty;
	
	private String expenseRemark;
	
	private String expenseVat;
	
	private Boolean isActive;
	
	private Double expenseAmt;
	
	private Double paidAmt;

	public Integer getExpenseId() {
		return expenseId;
	}

	public void setExpenseId(Integer expenseId) {
		this.expenseId = expenseId;
	}

	public Vendor getVendor() {
		return vendor;
	}

	public void setVendor(Vendor vendor) {
		this.vendor = vendor;
	}

	public ExpenseItem getExpenseItem() {
		return expenseItem;
	}

	public void setExpenseItem(ExpenseItem expenseItem) {
		this.expenseItem = expenseItem;
	}

	public Integer getExpenseQty() {
		return expenseQty;
	}

	public void setExpenseQty(Integer expenseQty) {
		this.expenseQty = expenseQty;
	}

	public String getExpenseRemark() {
		return expenseRemark;
	}

	public void setExpenseRemark(String expenseRemark) {
		this.expenseRemark = expenseRemark;
	}

	public String getExpenseVat() {
		return expenseVat;
	}

	public void setExpenseVat(String expenseVat) {
		this.expenseVat = expenseVat;
	}

	public Boolean getIsActive() {
		return isActive;
	}

	public void setIsActive(Boolean isActive) {
		this.isActive = isActive;
	}

	public Double getExpenseAmt() {
		return expenseAmt;
	}

	public void setExpenseAmt(Double expenseAmt) {
		this.expenseAmt = expenseAmt;
	}

	public Double getPaidAmt() {
		return paidAmt;
	}

	public void setPaidAmt(Double paidAmt) {
		this.paidAmt = paidAmt;
	}

	@Override
	public String toString() {
		return "ExpenseModel [expenseId=" + expenseId + ", vendor=" + vendor
				+ ", expenseItem=" + expenseItem + ", expenseQty=" + expenseQty
				+ ", expenseRemark=" + expenseRemark + ", expenseVat="
				+ expenseVat + ", isActive=" + isActive + ", expenseAmt="
				+ expenseAmt + ", paidAmt=" + paidAmt + "]";
	}
}

package com.org.krishnadeep.models;


public class InvoiceModel {

	private Integer invoiceId;
	
	private Vendor vendor;
	
	private Double amount;
	
	private Boolean expenseExist;
	
	private ExpenseModel expenseModel;

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

	public ExpenseModel getExpenseModel() {
		return expenseModel;
	}

	public void setExpenseModel(ExpenseModel expenseModel) {
		this.expenseModel = expenseModel;
	}

	@Override
	public String toString() {
		return "Invoice [invoiceId=" + invoiceId + ", vendor=" + vendor
				+ ", amount=" + amount + ", expenseExist=" + expenseExist
				+ ", expenseModel=" + expenseModel + "]";
	}
}

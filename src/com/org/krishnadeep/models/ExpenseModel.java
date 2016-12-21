package com.org.krishnadeep.models;

import java.sql.Timestamp;

public class ExpenseModel {

	private String expense_desc;
	private int vendor_id;
	private int expense_qty;
	private String expense_invoice_no;
	private float expense_vat;
	private int account_id;
	private int expenses_item_id;
	private double expense_amount;
	private int user_id;
	private Timestamp expense_created_date;
	private String expense_created_by;

	public String getExpense_desc() {
		return expense_desc;
	}

	public void setExpense_desc(String expense_desc) {
		this.expense_desc = expense_desc;
	}

	public int getUser_id() {
		return user_id;
	}

	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}

	public Timestamp getExpense_created_date() {
		return expense_created_date;
	}

	public void setExpense_created_date(Timestamp expense_created_date) {
		this.expense_created_date = expense_created_date;
	}

	public String getExpense_created_by() {
		return expense_created_by;
	}

	public void setExpense_created_by(String expense_created_by) {
		this.expense_created_by = expense_created_by;
	}

	public int getVendor_id() {
		return vendor_id;
	}

	public void setVendor_id(int vendor_id) {
		this.vendor_id = vendor_id;
	}

	public int getExpense_qty() {
		return expense_qty;
	}

	public void setExpense_qty(int expense_qty) {
		this.expense_qty = expense_qty;
	}

	public String getExpense_invoice_no() {
		return expense_invoice_no;
	}

	public void setExpense_invoice_no(String expense_invoice_no) {
		this.expense_invoice_no = expense_invoice_no;
	}

	public float getExpense_vat() {
		return expense_vat;
	}

	public void setExpense_vat(float expense_vat) {
		this.expense_vat = expense_vat;
	}

	public int getAccount_id() {
		return account_id;
	}

	public void setAccount_id(int account_id) {
		this.account_id = account_id;
	}

	public int getExpenses_item_id() {
		return expenses_item_id;
	}

	public void setExpenses_item_id(int expenses_item_id) {
		this.expenses_item_id = expenses_item_id;
	}

	public double getExpense_amount() {
		return expense_amount;
	}

	public void setExpense_amount(double expense_amount) {
		this.expense_amount = expense_amount;
	}
}

package com.org.krishnadeep.models;

public class WeeklyData {
	
	Integer weeklyDataId;
	
	Integer weekYearNo;

	Integer patientCount;
	
	Integer patientCountClaim;
	
	Integer patientCountNonClaim;
	
	Double patientAmount;
	
	Double patientAmountClaim;
	
	Double patientAmountNonClaim;
	
	Integer createdBy;
	
	String createdOn;
	
	Boolean isActive;
	
	String weekStartDate;
	
	String doctorName;
	
	public String getDoctorName() {
		return doctorName;
	}

	public void setDoctorName(String doctorName) {
		this.doctorName = doctorName;
	}

	public Integer getWeeklyDataId() {
		return weeklyDataId;
	}

	public void setWeeklyDataId(Integer weeklyDataId) {
		this.weeklyDataId = weeklyDataId;
	}

	public Integer getWeekYearNo() {
		return weekYearNo;
	}

	public void setWeekYearNo(Integer weekYearNo) {
		this.weekYearNo = weekYearNo;
	}

	public String getWeekStartDate() {
		return weekStartDate;
	}

	public void setWeekStartDate(String weekStartDate) {
		this.weekStartDate = weekStartDate;
	}

	public Integer getPatientCount() {
		return patientCount;
	}

	public void setPatientCount(Integer patientCount) {
		this.patientCount = patientCount;
	}

	public Integer getPatientCountClaim() {
		return patientCountClaim;
	}

	public void setPatientCountClaim(Integer patientCountClaim) {
		this.patientCountClaim = patientCountClaim;
	}

	public Integer getPatientCountNonClaim() {
		return patientCountNonClaim;
	}

	public void setPatientCountNonClaim(Integer patientCountNonClaim) {
		this.patientCountNonClaim = patientCountNonClaim;
	}

	public Double getPatientAmount() {
		return patientAmount;
	}

	public void setPatientAmount(Double patientAmount) {
		this.patientAmount = patientAmount;
	}

	public Double getPatientAmountClaim() {
		return patientAmountClaim;
	}

	public void setPatientAmountClaim(Double patientAmountClaim) {
		this.patientAmountClaim = patientAmountClaim;
	}

	public Double getPatientAmountNonClaim() {
		return patientAmountNonClaim;
	}

	public void setPatientAmountNonClaim(Double patientAmountNonClaim) {
		this.patientAmountNonClaim = patientAmountNonClaim;
	}

	public Integer getCreatedBy() {
		return createdBy;
	}

	public void setCreatedBy(Integer createdBy) {
		this.createdBy = createdBy;
	}

	public String getCreatedOn() {
		return createdOn;
	}

	public void setCreatedOn(String createdOn) {
		this.createdOn = createdOn;
	}

	public Boolean getIsActive() {
		return isActive;
	}

	public void setIsActive(Boolean isActive) {
		this.isActive = isActive;
	}

	@Override
	public String toString() {
		return "WeeklyData [weeklyDataId=" + weeklyDataId + ", weekYearNo="
				+ weekYearNo + ", patientCount=" + patientCount
				+ ", patientCountClaim=" + patientCountClaim
				+ ", patientCountNonClaim=" + patientCountNonClaim
				+ ", patientAmount=" + patientAmount + ", patientAmountClaim="
				+ patientAmountClaim + ", patientAmountNonClaim="
				+ patientAmountNonClaim + ", createdBy=" + createdBy
				+ ", createdOn=" + createdOn + ", isActive=" + isActive
				+ ", weekStartDate=" + weekStartDate + "]";
	}
	
}

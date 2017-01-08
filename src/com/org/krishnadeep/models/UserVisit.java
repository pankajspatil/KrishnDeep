package com.org.krishnadeep.models;

public class UserVisit {

	private Integer userVisitId;
	
	private Patient patient;
	
	private String summary;
	
	private VisitType visitType;
	
	private Double fees;
	
	private Patient doctor;
	
	private String createdOn;
	
	private String age;
	
	public Integer getUserVisitId() {
		return userVisitId;
	}

	public void setUserVisitId(Integer userVisitId) {
		this.userVisitId = userVisitId;
	}

	public Patient getPatient() {
		return patient;
	}

	public void setPatient(Patient patient) {
		this.patient = patient;
	}

	public String getSummary() {
		return summary;
	}

	public void setSummary(String summary) {
		this.summary = summary;
	}

	public VisitType getVisitType() {
		return visitType;
	}

	public void setVisitType(VisitType visitType) {
		this.visitType = visitType;
	}

	public Double getFees() {
		return fees;
	}

	public void setFees(Double fees) {
		this.fees = fees;
	}

	public Patient getDoctor() {
		return doctor;
	}

	public void setDoctor(Patient doctor) {
		this.doctor = doctor;
	}
	
	public String getCreatedOn() {
		return createdOn;
	}

	public void setCreatedOn(String createdOn) {
		this.createdOn = createdOn;
	}

	public String getAge() {
		return age;
	}

	public void setAge(String age) {
		this.age = age;
	}

	@Override
	public String toString() {
		return "UserVisit [userVisitId=" + userVisitId + ", patient=" + patient
				+ ", summary=" + summary + ", visitType=" + visitType
				+ ", fees=" + fees + ", doctor=" + doctor + ", createdOn="
				+ createdOn + ", age=" + age + "]";
	}
}

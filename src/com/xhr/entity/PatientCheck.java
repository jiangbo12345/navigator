package com.xhr.entity;

import javax.persistence.Column;
import javax.persistence.DiscriminatorValue;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

import com.xhr.entity.user.Patient;
@Entity
@DiscriminatorValue("patientcheck")
public class PatientCheck {
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Integer id;
	
	@Column
    @Enumerated(EnumType.STRING)
    private ProgramType checkType;
	
	@Column(length = 200)
	private String filePath;
	
	@Column(length = 50)
	private String fileName;
	
	@Column(length = 20)
    private String checkDate;
	
	@Column
	@Enumerated(EnumType.STRING)
    private CheckResult result;
	
	@Column
	private String remarks;
	
	@Column
	@Enumerated(EnumType.STRING)
	private Display display;
	
	@ManyToOne
    @JoinColumn(name = "patient_id")
	private Patient patient;
	
	public Display getDisplay() {
		return display;
	}

	public void setDisplay(Display display) {
		this.display = display;
	}

	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getFilePath() {
		return filePath;
	}

	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public ProgramType getCheckType() {
		return checkType;
	}

	public void setCheckType(ProgramType checkType) {
		this.checkType = checkType;
	}

	public String getCheckDate() {
		return checkDate;
	}

	public void setCheckDate(String checkDate) {
		this.checkDate = checkDate;
	}

	public CheckResult getResult() {
		return result;
	}

	public void setResult(CheckResult result) {
		this.result = result;
	}

	public Patient getPatient() {
		return patient;
	}

	public void setPatient(Patient patient) {
		this.patient = patient;
	}
	
}

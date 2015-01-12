package com.xhr.entity;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.Embedded;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;

import org.codehaus.jackson.annotate.JsonIgnoreProperties;

import com.xhr.entity.user.Address;
import com.xhr.entity.user.Doctor;

@Entity
@JsonIgnoreProperties(value={"doctors"})
public class Hospital {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Integer id;

	@Column(length = 50)
	private String hospitalDesignation;

	@Embedded
	private Address address;

	@ManyToOne
	@JoinColumn(name = "cdcorganization_id")
	private CdcOrganization cdcOrganization;
	
	@OneToMany(mappedBy = "hospital")
	private List<Doctor> doctors;

	public List<Doctor> getDoctors() {
		return doctors;
	}

	public void setDoctors(List<Doctor> doctors) {
		this.doctors = doctors;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getHospitalDesignation() {
		return hospitalDesignation;
	}

	public void setHospitalDesignation(String hospitalDesignation) {
		this.hospitalDesignation = hospitalDesignation;
	}

	public Address getAddress() {
		return address;
	}

	public void setAddress(Address address) {
		this.address = address;
	}

	public CdcOrganization getCdcOrganization() {
		return cdcOrganization;
	}

	public void setCdcOrganization(CdcOrganization cdcOrganization) {
		this.cdcOrganization = cdcOrganization;
	}

}

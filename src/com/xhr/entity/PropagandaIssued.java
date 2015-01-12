package com.xhr.entity;

import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Embedded;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;

import org.codehaus.jackson.annotate.JsonIgnoreProperties;

import com.xhr.entity.user.Address;
import com.xhr.entity.user.Cdc;
import com.xhr.entity.user.Patient;

@Entity
@JsonIgnoreProperties(value={"patients"}) 
public class PropagandaIssued {

	@Id
	@GeneratedValue
	private Integer propIssuedID;

	@ManyToOne
	@JoinColumn(name = "from_cdc")
	private Cdc cdc;

	@Embedded
	private Address address;

	@Column
	@Enumerated(EnumType.STRING)
	private PropagandaLanguage language;

	@ManyToOne
	@JoinColumn(name = "from_propDatum")
	private PropagandaDatum propDatum;
	
	@ManyToMany(cascade = CascadeType.ALL )
	private List<Patient> patients;

	@Column
	private String comments;

	@Column
	private String issuedDate;

	@Column
    private boolean notified = false;;
	
	public boolean isNotified() {
		return notified;
	}

	public void setNotified(boolean notified) {
		this.notified = notified;
	}

	public List<Patient> getPatients() {
		return patients;
	}

	public void setPatients(List<Patient> patients) {
		this.patients = patients;
	}

	public Integer getPropIssuedID() {
		return propIssuedID;
	}

	public void setPropIssuedID(Integer propIssuedID) {
		this.propIssuedID = propIssuedID;
	}

	public Cdc getCdc() {
		return cdc;
	}

	public void setCdc(Cdc cdc) {
		this.cdc = cdc;
	}

	public Address getAddress() {
		return address;
	}

	public void setAddress(Address address) {
		this.address = address;
	}

	public PropagandaLanguage getLanguage() {
		return language;
	}

	public void setLanguage(PropagandaLanguage language) {
		this.language = language;
	}

	public PropagandaDatum getPropDatum() {
		return propDatum;
	}

	public void setPropDatum(PropagandaDatum propDatum) {
		this.propDatum = propDatum;
	}

	public String getComments() {
		return comments;
	}

	public void setComments(String comments) {
		this.comments = comments;
	}

	public String getIssuedDate() {
		return issuedDate;
	}

	public void setIssuedDate(String issuedDate) {
		this.issuedDate = issuedDate;
	}

}

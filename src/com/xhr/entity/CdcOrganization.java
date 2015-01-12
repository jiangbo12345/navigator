package com.xhr.entity;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.Embedded;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;

import org.codehaus.jackson.annotate.JsonIgnoreProperties;

import com.xhr.entity.user.Address;
import com.xhr.entity.user.Cdc;

@Entity
@JsonIgnoreProperties(value={"hospital","cdcs","propDatum"})
public class CdcOrganization {
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Integer id;

	@Column(length = 50)
	private String cdcOrgDesignation;

	@Embedded
	private Address address;

	@OneToMany(mappedBy = "cdcOrganization")
	private List<Hospital> hospital;
	
	@OneToMany(mappedBy = "cdcOrg")
	private List<Cdc> cdcs;

	@OneToMany(mappedBy = "organ")
	private List<PropagandaDatum> propDatum;
	
	public List<Cdc> getCdcs() {
		return cdcs;
	}

	public void setCdcs(List<Cdc> cdcs) {
		this.cdcs = cdcs;
	}

	public List<PropagandaDatum> getPropDatum() {
		return propDatum;
	}

	public void setPropDatum(List<PropagandaDatum> propDatum) {
		this.propDatum = propDatum;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getCdcOrgDesignation() {
		return cdcOrgDesignation;
	}

	public void setCdcOrgDesignation(String cdcOrgDesignation) {
		this.cdcOrgDesignation = cdcOrgDesignation;
	}

	public Address getAddress() {
		return address;
	}

	public void setAddress(Address address) {
		this.address = address;
	}

	public List<Hospital> getHospital() {
		return hospital;
	}

	public void setHospital(List<Hospital> hospital) {
		this.hospital = hospital;
	}
}

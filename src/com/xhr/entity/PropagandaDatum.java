package com.xhr.entity;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;

import org.codehaus.jackson.annotate.JsonIgnoreProperties;

@Entity
@JsonIgnoreProperties(value={"propIssueds"}) 
public class PropagandaDatum {
	
	@Id
    @GeneratedValue
	private Integer propDatumID;
	
	@Column
	private String title;
	
	@Column
	private String datum;
	
	@Column
	private String datumName;
	
	@Column
    @Enumerated(EnumType.STRING)
	private PropagandaLanguage language;
	
	@ManyToOne
    @JoinColumn(name = "from_organ")
	private CdcOrganization organ;
	
	@OneToMany(mappedBy = "propDatum")
	private List<PropagandaIssued>  propIssueds;
	
	@Column
	private String uploadDate;
	
	@Column
	private String remarks;

	public List<PropagandaIssued> getPropIssueds() {
		return propIssueds;
	}

	public void setPropIssueds(List<PropagandaIssued> propIssueds) {
		this.propIssueds = propIssueds;
	}

	public String getDatumName() {
		return datumName;
	}

	public void setDatumName(String datumName) {
		this.datumName = datumName;
	}

	public CdcOrganization getOrgan() {
		return organ;
	}

	public void setOrgan(CdcOrganization organ) {
		this.organ = organ;
	}

	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public Integer getPropDatumID() {
		return propDatumID;
	}

	public void setPropDatumID(Integer propDatumID) {
		this.propDatumID = propDatumID;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getDatum() {
		return datum;
	}

	public void setDatum(String datum) {
		this.datum = datum;
	}

	public PropagandaLanguage getLanguage() {
		return language;
	}

	public void setLanguage(PropagandaLanguage language) {
		this.language = language;
	}

	public String getUploadDate() {
		return uploadDate;
	}

	public void setUploadDate(String uploadDate) {
		this.uploadDate = uploadDate;
	}
}

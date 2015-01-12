
package com.xhr.entity.user;

import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.DiscriminatorValue;
import javax.persistence.Embedded;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.PrimaryKeyJoinColumn;

import org.codehaus.jackson.annotate.JsonIgnoreProperties;

import com.xhr.entity.ExecuteRecord;
import com.xhr.entity.PatientCheck;
import com.xhr.entity.PillBox;
import com.xhr.entity.Program;
import com.xhr.entity.PropagandaIssued;
import com.xhr.entity.PropagandaLanguage;

@Entity
@DiscriminatorValue("patient")
@PrimaryKeyJoinColumn(name = "user_id")
@JsonIgnoreProperties(value={"programs","doctors","propissueds","patientChecks","records"}) 
public class Patient extends User {

    @Column(length = 32, unique = true)
    private String identifier;

    @Column(length = 2)
    private String sex;

    @Column
    private String nation; // 民族

    @Column(length = 20, unique = true)
    private String phone;

    @Column(length = 256)
    private String photo;

    @Column(length = 20)
    private String birthDay;
    
    @Column(length = 20)
    private String treatNo;
    
    @Column
    @Enumerated(EnumType.STRING)
    private PropagandaLanguage language;

    @Column(length = 20, nullable = false)
    private String registrationDate; // 就诊日期

    @Column
    private String firstTakeDate; // 开始服药日期

    @ManyToMany(cascade = CascadeType.ALL)
    private List<Program> programs;

    @Embedded
    private Address address;

    @ManyToMany(cascade = CascadeType.ALL)
    private List<Doctor> doctors;
    
    @ManyToMany(mappedBy = "patients")
    private List<PropagandaIssued> propissueds;
    
    @OneToOne
    @JoinColumn(name = "pillbox_id")
    private PillBox pillBox;

    @OneToMany(mappedBy = "patient")
    private List<PatientCheck> patientChecks;

    @OneToMany(mappedBy = "executor")
    private List<ExecuteRecord> records;

	public List<PropagandaIssued> getPropissueds() {
		return propissueds;
	}

	public void setPropissueds(List<PropagandaIssued> propissueds) {
		this.propissueds = propissueds;
	}

	public PropagandaLanguage getLanguage() {
		return language;
	}

	public void setLanguage(PropagandaLanguage language) {
		this.language = language;
	}

	public String getTreatNo() {
		return treatNo;
	}

	public void setTreatNo(String treatNo) {
		this.treatNo = treatNo;
	}

	public String getRegistrationDate() {
        return registrationDate;
    }

    public void setRegistrationDate(String registrationDate) {
        this.registrationDate = registrationDate;
    }

    public String getIdentifier() {
        return identifier;
    }

    public void setIdentifier(String identifier) {
        this.identifier = identifier;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getPhoto() {
        return photo;
    }

    public void setPhoto(String photo) {
        this.photo = photo;
    }

    public String getBirthDay() {
        return birthDay;
    }

    public void setBirthDay(String birthDay) {
        this.birthDay = birthDay;
    }

    public List<Program> getPrograms() {
        return programs;
    }

    public void setPrograms(List<Program> programs) {
        this.programs = programs;
    }

    public Address getAddress() {
        return address;
    }

    public void setAddress(Address address) {
        this.address = address;
    }

    public List<Doctor> getDoctors() {
        return doctors;
    }

    public void setDoctors(List<Doctor> doctors) {
        this.doctors = doctors;
    }

    public PillBox getPillBox() {
        return pillBox;
    }

    public void setPillBox(PillBox pillBox) {
        this.pillBox = pillBox;
    }

    public List<PatientCheck> getPatientChecks() {
        return patientChecks;
    }

    public void setPatientChecks(List<PatientCheck> patientChecks) {
        this.patientChecks = patientChecks;
    }

    public List<ExecuteRecord> getRecords() {
        return records;
    }

    public void setRecords(List<ExecuteRecord> records) {
        this.records = records;
    }

    public String getNation() {
        return nation;
    }

    public void setNation(String nation) {
        this.nation = nation;
    }

    public String getFirstTakeDate() {
        return firstTakeDate;
    }

    public void setFirstTakeDate(String firstTakeDate) {
        this.firstTakeDate = firstTakeDate;
    }

}

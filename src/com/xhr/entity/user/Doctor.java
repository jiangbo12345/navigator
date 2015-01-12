
package com.xhr.entity.user;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.DiscriminatorValue;
import javax.persistence.Embedded;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.PrimaryKeyJoinColumn;

import org.codehaus.jackson.annotate.JsonIgnoreProperties;

import com.xhr.entity.Hospital;

@Entity
@DiscriminatorValue("doctor")
@PrimaryKeyJoinColumn(name = "user_id")
@JsonIgnoreProperties(value={"patients"})
public class Doctor extends User {

	@ManyToOne
    @JoinColumn(name = "hospital_id")
    private Hospital hospital;
    
    @Column(length = 100)
    private String departments;
    
    @Column(length = 20, unique = true)
    private String phone;

    @Column(length = 256)
    private String photo;
    
    @Column(length = 2)
    private String sex;
    
    @Embedded
    private Address address;
    
    @ManyToMany(mappedBy = "doctors")
    private List<Patient> patients;

	public String getDepartments() {
		return departments;
	}

	public void setDepartments(String departments) {
		this.departments = departments;
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

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public Address getAddress() {
		return address;
	}

	public void setAddress(Address address) {
		this.address = address;
	}

	public List<Patient> getPatients() {
		return patients;
	}

	public void setPatients(List<Patient> patients) {
		this.patients = patients;
	}

	public Hospital getHospital() {
		return hospital;
	}

	public void setHospital(Hospital hospital) {
		this.hospital = hospital;
	}

}

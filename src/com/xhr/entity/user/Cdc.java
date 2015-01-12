
package com.xhr.entity.user;

import javax.persistence.Column;
import javax.persistence.DiscriminatorValue;
import javax.persistence.Embedded;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.PrimaryKeyJoinColumn;

import com.xhr.entity.CdcOrganization;

@Entity
@DiscriminatorValue("cdc")
@PrimaryKeyJoinColumn(name = "user_id")
public class Cdc extends User{
	
	@Column(length = 20)
    private String phone;

    @Column(length = 256)
    private String photo;
    
    @Embedded
    private Address address;
    
    @Column(length = 2)
    private String sex;
    
    @ManyToOne
    @JoinColumn(name = "cdcOrg_id")
    private CdcOrganization cdcOrg;
    
	public CdcOrganization getCdcOrg() {
		return cdcOrg;
	}

	public void setCdcOrg(CdcOrganization cdcOrg) {
		this.cdcOrg = cdcOrg;
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

	public Address getAddress() {
		return address;
	}

	public void setAddress(Address address) {
		this.address = address;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

}

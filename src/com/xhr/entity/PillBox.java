package com.xhr.entity;

import javax.persistence.Column;
import javax.persistence.DiscriminatorValue;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.Id;
import javax.persistence.OneToOne;

import com.xhr.entity.user.Patient;

@Entity
@DiscriminatorValue("pillbox")
public class PillBox {
	@Id
	@Column(length = 32, unique = true)
	private String identifier;
	
	@Column
    @Enumerated(EnumType.STRING)
    private State state;
	
	@Column(length = 32)
	private String version;

	@Column(length = 32)
	private String serverAddress;

	@Column(length = 32)
	private String serverPort;

	@Column(length = 32)
	private String serverAPN;

	@OneToOne(mappedBy = "pillBox")
	private Patient patient;

	public State getState() {
		return state;
	}

	public void setState(State state) {
		this.state = state;
	}

	public String getIdentifier() {
		return identifier;
	}

	public void setIdentifier(String identifier) {
		this.identifier = identifier;
	}

	public String getVersion() {
		return version;
	}

	public void setVersion(String version) {
		this.version = version;
	}

	public String getServerAddress() {
		return serverAddress;
	}

	public void setServerAddress(String serverAddress) {
		this.serverAddress = serverAddress;
	}

	public String getServerPort() {
		return serverPort;
	}

	public void setServerPort(String serverPort) {
		this.serverPort = serverPort;
	}

	public String getServerAPN() {
		return serverAPN;
	}

	public void setServerAPN(String serverAPN) {
		this.serverAPN = serverAPN;
	}

	public Patient getPatient() {
		return patient;
	}

	public void setPatient(Patient patient) {
		this.patient = patient;
	}

}

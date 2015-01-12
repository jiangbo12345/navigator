
package com.xhr.model;

public class PatientInfo {

    private Integer patientId;
    private String patientName;
    private String phone;
    private String followUpPeriod;
    private boolean takenMedToday;
    private String photo;
    
    public String getPhoto() {
		return photo;
	}

	public void setPhoto(String photo) {
		this.photo = photo;
	}

	public Integer getPatientId() {
        return patientId;
    }

    public void setPatientId(Integer patientId) {
        this.patientId = patientId;
    }

    public String getPatientName() {
        return patientName;
    }

    public void setPatientName(String patientName) {
        this.patientName = patientName;
    }

    public String getFollowUpPeriod() {
        return followUpPeriod;
    }

    public void setFollowUpPeriod(String followUpPeriod) {
        this.followUpPeriod = followUpPeriod;
    }

    public boolean isTakenMedToday() {
        return takenMedToday;
    }

    public void setTakenMedToday(boolean takenMedToday) {
        this.takenMedToday = takenMedToday;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

}


package com.xhr.model;

import com.xhr.entity.SuggestionReason;

public class Suggestion {

    private String patientName;
    private String doctorName;
    private SuggestionReason reason;

    public String getPatientName() {
        return patientName;
    }

    public void setPatientName(String patientName) {
        this.patientName = patientName;
    }

    public String getDoctorName() {
        return doctorName;
    }

    public void setDoctorName(String doctorName) {
        this.doctorName = doctorName;
    }

    public SuggestionReason getReason() {
        return reason;
    }

    public void setReason(SuggestionReason reason) {
        this.reason = reason;
    }

}

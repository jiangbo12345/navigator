
package com.xhr.service;

import java.util.Date;
import java.util.List;

import com.xhr.entity.ExecuteRecord;
import com.xhr.entity.Plan;
import com.xhr.entity.ProgramType;
import com.xhr.entity.user.Doctor;
import com.xhr.entity.user.Patient;

public interface IExecuteService extends IGenericService<ExecuteRecord> {

    List<Patient> getFollowUpPatients(Doctor doctor, String date);

    List<ExecuteRecord> getFollowupMonthly(Patient patient, String year, String month);

    List<Patient> getFollowUpPatientsByWeek(Doctor doctor, Date time);

    public List<ExecuteRecord> getRecordMonthly(Patient patient, String year, String month);

    public String getTakedPatientIdListStr(String patientIds, String takeDate, ProgramType medicine);

    public List<ExecuteRecord> getRecordByDates(Patient patient, List<String> dates);
    
    public boolean isExecuted(Plan plan);

}

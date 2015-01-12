
package com.xhr.service.impl;

import java.text.SimpleDateFormat;
import java.util.*;

import javax.persistence.Query;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.xhr.dao.orm.commons.GenericDao;
import com.xhr.entity.ExecuteRecord;
import com.xhr.entity.Period;
import com.xhr.entity.Plan;
import com.xhr.entity.ProgramType;
import com.xhr.entity.user.Doctor;
import com.xhr.entity.user.Patient;
import com.xhr.entity.user.User;
import com.xhr.service.IExecuteService;
import com.xhr.service.IUserService;

@Component
public class ExecuteService extends GenericService<ExecuteRecord> implements IExecuteService {

    @Autowired
    GenericDao<ExecuteRecord> executeDao;

    @Autowired
    IUserService userService;

    @Override
    GenericDao<ExecuteRecord> getDao() {
        return executeDao;
    }

    @Override
    public List<Patient> getFollowUpPatients(Doctor doctor, String date) {
        List<String> names = new ArrayList<String>();
        names.add("executor.id");
        names.add("executeDate");
        names.add("type");
        List<Object> values = new ArrayList<Object>();
        values.add(doctor.getId());
        values.add(date);
        values.add(ProgramType.Followup);
        List<ExecuteRecord> followUps = executeDao.getBy(names, values);
        if (followUps != null && followUps.size() > 0) {
            List<Patient> patients = new ArrayList<Patient>();
            for (ExecuteRecord followup : followUps) {
                patients.add(userService.getPatientById(followup.getAimUser().getId()));
            }
            System.out.println("patients+++patients.size()===="+patients.size());
            return patients;
        }
        return new ArrayList<Patient>();
    }

    @Override
    public List<ExecuteRecord> getFollowupMonthly(Patient patient, String year, String month) {
        if (month.length() < 2) {
            month = "0" + month;
        }
        String hql = "from ExecuteRecord where type='Followup' and aimUser=? and executeDate like ?";
        Object[] params = new Object[2];
        params[0] = patient;
        params[1] = year + "-" + month + "%";
        executeDao.getEntityManager().clear();
        return executeDao.find(hql, params, -1, -1);
    }

    @Override
    public List<Patient> getFollowUpPatientsByWeek(Doctor doctor, Date time) {
        List<Patient> followed = new ArrayList<Patient>();
        Calendar cal = Calendar.getInstance();
        cal.setTime(time);
        int weekDay = cal.get(Calendar.DAY_OF_WEEK) - 1;
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        for (int i = 0; i < weekDay; i++) {
            followed.addAll(getFollowUpPatients(doctor, format.format(cal.getTime())));
            cal.add(Calendar.DATE, -1);
        }
        return followed;
    }

    public List<ExecuteRecord> getRecordMonthly(Patient patient, String year, String month) {
        if (month.length() < 2) {
            month = "0" + month;
        }
        String hql = "from ExecuteRecord where type='Medicine' and executor=? and executeDate like ?";
        Object[] params = new Object[2];
        params[0] = patient;
        params[1] = year + "-" + month + "%";
        executeDao.getEntityManager().clear();
        return executeDao.find(hql, params, -1, -1);
    }

    @Override
    @SuppressWarnings("unchecked")
    public String getTakedPatientIdListStr(String patientIds, String takeDate,ProgramType type) {
       if (patientIds == null ||patientIds.length()==0) {
    	   patientIds = "0";
       }
    	String sql = "select * from ExecuteRecord where executor_id in (" + patientIds + ") and executeDate='" + takeDate + "' and type ='"+type+"'";
        Query query = executeDao.getEntityManager().createNativeQuery(sql, ExecuteRecord.class);
        List<ExecuteRecord> records = query.getResultList();
        StringBuilder builder = new StringBuilder(",");
        for (ExecuteRecord record : records) {
            builder.append(record.getExecutor().getId());
            builder.append(",");
            System.out.println("isNotified=========="+record.isNotified());
        }
        return builder.toString();
    }

    @Override
    @SuppressWarnings("unchecked")
    public List<ExecuteRecord> getRecordByDates(Patient patient, List<String> dates) {
        StringBuilder takeDates = new StringBuilder();
        for (String date : dates) {
            if (takeDates.length() > 0) {
                takeDates.append(",");
            }
            takeDates.append("'");
            takeDates.append(date);
            takeDates.append("'");
        }
        String sql = "select * from ExecuteRecord where executor_id =" + patient.getId() + " and executeDate in (" + takeDates.toString() + ")";
        executeDao.getEntityManager().clear();
        Query query = executeDao.getEntityManager().createNativeQuery(sql, ExecuteRecord.class);
        List<ExecuteRecord> records = query.getResultList();
        return records;
    }

    @SuppressWarnings("unchecked")
    public List<ExecuteRecord> getRecordByDates(User fromUser, User toUser, List<String> dates) {
        StringBuilder takeDates = new StringBuilder();
        for (String date : dates) {
            if (takeDates.length() > 0) {
                takeDates.append(",");
            }
            takeDates.append("'");
            takeDates.append(date);
            takeDates.append("'");
        }
        String sql = "select * from ExecuteRecord where executor_id =" + toUser.getId() + " and aim_id =" + fromUser.getId() + " and executeDate in ("
                + takeDates.toString() + ")";
        System.out.println("sql========="+sql);
        executeDao.getEntityManager().clear();
        Query query = executeDao.getEntityManager().createNativeQuery(sql, ExecuteRecord.class);
        List<ExecuteRecord> records = query.getResultList();
        return records;
    }

    @Override
    public boolean isExecuted(Plan plan) {
        List<ExecuteRecord> records;
        if (ProgramType.Followup.equals(plan.getType())) {
            for (Period period : plan.getPeriods()) {
                if (Period.WEEK.equals(period)) {
                    records = getRecordByDates(plan.getFromUser(), plan.getToUser(), weekDays());
                    if (records != null && records.size() > 0) {
                        return true;
                    }
                }
            }
        }
        return false;
    }

    private List<String> weekDays() {
        Calendar cal = Calendar.getInstance();
        int weekDay = cal.get(Calendar.DAY_OF_WEEK);
        if (weekDay == 1) {
            weekDay = 6;
        } else {
            weekDay = weekDay - 1;
        }
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        List<String> weekDays = new ArrayList<String>();
        for (int i = 0; i < weekDay; i++) {
            weekDays.add(format.format(cal.getTime()));
            cal.add(Calendar.DATE, -1);
        }
        return weekDays;
    }

}

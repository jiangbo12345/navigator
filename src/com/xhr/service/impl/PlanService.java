
package com.xhr.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.xhr.dao.orm.commons.GenericDao;
import com.xhr.entity.ExecuteRecord;
import com.xhr.entity.Plan;
import com.xhr.entity.Period;
import com.xhr.entity.user.Doctor;
import com.xhr.entity.user.Patient;
import com.xhr.entity.user.User;
import com.xhr.service.IExecuteService;
import com.xhr.service.IPlanService;
import com.xhr.service.IUserService;

@Component
public class PlanService extends GenericService<Plan> implements IPlanService {

    @Autowired
    GenericDao<Plan> planDao;

    @Autowired
    IUserService userService;

    @Autowired
    IExecuteService executeService;

    @Override
    GenericDao<Plan> getDao() {
        return planDao;
    }

    @Override
    public List<Plan> getPlans(User fromUser) {
        List<String> names = new ArrayList<String>();
        names.add("toUser.id");
        List<Object> values = new ArrayList<Object>();
        values.add(fromUser.getId());
        List<Plan> plans = planDao.getBy(names, values);
        if (plans != null && plans.size() > 0) {
            return plans;
        }
        return new ArrayList<Plan>();
    }

    @Override
    public Plan getPlan(User fromUser, User toUser) {
        List<String> names = new ArrayList<String>();
        names.add("fromUser.id");
        names.add("toUser.id");
        List<Object> values = new ArrayList<Object>();
        values.add(fromUser.getId());
        values.add(toUser.getId());
        List<Plan> plans = planDao.getBy(names, values);
        if (plans != null && plans.size() > 0) {
            return plans.get(0);
        }
        return null;
    }

    @Override
    public List<Patient> getNeedFollowUpPatients(Doctor doctor, String date) {
        List<Patient> patients = userService.getPatientsByDoctor(doctor);
        List<Patient> needFollowupPatients = new ArrayList<Patient>();
        Plan plan;
        for (Patient patient : patients) {
            plan = getPlan(doctor, patient);
            if (Period.WEEK.equals(plan.getPeriods().get(0))) {
                needFollowupPatients.add(patient);
            } else {
                List<ExecuteRecord> followups = executeService.getFollowupMonthly(patient, date.substring(0, 4), date.substring(6, 8));
                if (followups == null) {
                    needFollowupPatients.add(patient);
                }
            }
        }
        return needFollowupPatients;
    }

	@Override
	public List<Plan> getPlansByPatient(User patient) {
		List<String> names = new ArrayList<String>();
        names.add("toUser.id");
        List<Object> values = new ArrayList<Object>();
        values.add(patient.getId());
        List<Plan> plans = planDao.getBy(names, values);
        if (plans != null && plans.size() > 0) {
            return plans;
        }
        return new ArrayList<Plan>();
	}

	@Override
	public List<Plan> getPlansByDoctor(Doctor doctor) {
		List<String> names = new ArrayList<String>();
        names.add("fromUser.id");
        List<Object> values = new ArrayList<Object>();
        values.add(doctor.getId());
        List<Plan> plans = planDao.getBy(names, values);
        if (plans != null && plans.size() > 0) {
            return plans;
        }
        return new ArrayList<Plan>();
	}

}

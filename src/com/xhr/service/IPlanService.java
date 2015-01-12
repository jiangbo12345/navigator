
package com.xhr.service;

import java.util.List;

import com.xhr.entity.Plan;
import com.xhr.entity.user.Doctor;
import com.xhr.entity.user.Patient;
import com.xhr.entity.user.User;

public interface IPlanService extends IGenericService<Plan> {

    Plan getPlan(User fromUser, User toUser);

    List<Plan> getPlans(User fromUser);

    List<Patient> getNeedFollowUpPatients(Doctor doctor, String date);

	List<Plan> getPlansByPatient(User patient);

	List<Plan> getPlansByDoctor(Doctor doctor);

}

package com.xhr.service;

import java.util.List;

import com.xhr.entity.PatientCheck;
import com.xhr.entity.ProgramType;
import com.xhr.entity.user.User;

public interface IPatientCheckService extends IGenericService<PatientCheck> {
	List<PatientCheck> getCheckList(User user);

	String getAbnormalByPatientIDListStr(String string, ProgramType chestxray);

	List<PatientCheck> getCheckList(User user, ProgramType chestxray);

}

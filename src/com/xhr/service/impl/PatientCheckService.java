package com.xhr.service.impl;

import java.util.List;

import javax.persistence.Query;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.xhr.dao.orm.commons.GenericDao;
import com.xhr.entity.CheckResult;
import com.xhr.entity.ExecuteRecord;
import com.xhr.entity.PatientCheck;
import com.xhr.entity.ProgramType;
import com.xhr.entity.user.User;
import com.xhr.service.IPatientCheckService;
@Component
public class PatientCheckService extends GenericService<PatientCheck>  implements IPatientCheckService {

	@Autowired
    GenericDao<PatientCheck> patientCheckDao;
	
	@Autowired
    GenericDao<ExecuteRecord> executeDao;
	
	@Override
	public List<PatientCheck> getCheckList(User user) {
		return patientCheckDao.getBy("patient.id", user.getId());
	}

	@Override
	GenericDao<PatientCheck> getDao() {
		return patientCheckDao;
	}
	
	@Override
	public String getAbnormalByPatientIDListStr(String patientIds, ProgramType chestxray) {
		if (patientIds == null || patientIds.length()==0) {
			patientIds = "0";
		}
		String sql = "select * from PatientCheck where patient_id in (" + patientIds + ")  and checkType ='"+chestxray+"' and display ='Show'";
        Query query = patientCheckDao.getEntityManager().createNativeQuery(sql, PatientCheck.class);
        List<PatientCheck> records = query.getResultList();
        StringBuilder builder = new StringBuilder(",");
        for (PatientCheck record : records) {
            builder.append(record.getPatient().getId());
            builder.append(",");
        }
        System.out.println("builder.toString()"+builder.toString());
        return builder.toString();
	}

	@Override
	public List<PatientCheck> getCheckList(User user, ProgramType chestxray) {
		String sql = "from PatientCheck where patient.id = "+user.getId()+" and checkType = '"+chestxray+"' ";
		List<PatientCheck> list =patientCheckDao.find(sql, null, null);
		return list;
	}

}


package com.xhr.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.xhr.dao.orm.commons.GenericDao;
import com.xhr.entity.PillBox;
import com.xhr.entity.PropagandaLanguage;
import com.xhr.entity.user.*;
import com.xhr.service.IUserService;

@Component
public class UserService implements IUserService {

    @Autowired
    GenericDao<Patient> patientDao;

    @Autowired
    GenericDao<Admin> adminDao;
    @Autowired
    GenericDao<User> userDao;
    @Autowired
    GenericDao<Doctor> doctorDao;
    @Autowired
    GenericDao<Cdc> cdcDao;

    @Override
    public User getUser(String name) {
        User user = userDao.getFirstRecord("loginName", name);
        if (user != null) {
            if (user.getRole() == Role.DOCTOR) {
                return doctorDao.getFirstRecord("loginName", name);
            } else if (user.getRole() == Role.ADMIN) {
                return adminDao.getFirstRecord("loginName", name);
            } else if (user.getRole() == Role.PATIENT) {
                return patientDao.getFirstRecord("loginName", name);
            } else if (user.getRole() == Role.CDC) {
                return cdcDao.getFirstRecord("loginName", name);
            }
        }
        return null;
    }

    @Override
    public User getUserByID(int parseInt) {
        User user = userDao.findById(parseInt);
        if (user.getRole() == Role.DOCTOR) {
            return doctorDao.getFirstRecord("id", parseInt);
        } else if (user.getRole() == Role.ADMIN) {
            return adminDao.getFirstRecord("id", parseInt);
        } else if (user.getRole() == Role.PATIENT) {
            return patientDao.getFirstRecord("id", parseInt);
        } else if (user.getRole() == Role.CDC) {
            return cdcDao.getFirstRecord("id", parseInt);
        }
        return user;
    }

    @Override
    public boolean update(User user) {
        if (user.getRole() == Role.DOCTOR) {
            return doctorDao.update((Doctor) user);
        } else if (user.getRole() == Role.ADMIN) {
            return adminDao.update((Admin) user);
        } else if (user.getRole() == Role.PATIENT) {
            return patientDao.update((Patient) user);
        } else if (user.getRole() == Role.CDC) {
            return cdcDao.update((Cdc) user);
        }
        return userDao.update(user);
    }

    @Override
    public List<Patient> getPatientsByDoctor(Doctor doctor) {
        String hql = "select pat from Patient pat left join pat.doctors doc where doc = ?";
        Object[] para = new Object[1];
        para[0] = doctor;
        return patientDao.find(hql, para, -1, -1);
    }

    @Override
    public Patient getPatientByPillBox(PillBox pillBox) {
        List<Patient> list = patientDao.getBy("pillBox.identifier", pillBox.getIdentifier());
        System.out.println("list  size  ==== " + list.size());
        if (list.size() > 0) {
            return list.get(0);
        }
        return null;
    }

    @Override
    public Patient getPatientByIdentifier(String identifier) {
        return patientDao.getFirstRecord("identifier", identifier);
    }

    @Override
    public boolean regist(User user) {
        if (user.getRole() == Role.DOCTOR) {
            return doctorDao.save((Doctor) user);
        } else if (user.getRole() == Role.ADMIN) {
            return adminDao.save((Admin) user);
        } else if (user.getRole() == Role.PATIENT) {
            System.out.println("jiangbo  =====  ");
            return patientDao.save((Patient) user);
        } else if (user.getRole() == Role.CDC) {
            return cdcDao.save((Cdc) user);
        }
        return userDao.save(user);
    }

    @Override
    @SuppressWarnings("rawtypes")
    public List getAll(Role role) {
        if (role == Role.DOCTOR) {
            return doctorDao.findAll();
        } else if (role == Role.ADMIN) {
            return adminDao.findAll();
        } else if (role == Role.PATIENT) {
            return patientDao.findAll();
        } else if (role == Role.CDC) {
            return cdcDao.findAll();
        }
        return null;
    }

    @Override
    public Patient getPatientById(Integer patientId) {
        return patientDao.getFirstRecord("id", patientId);
    }

    @Override
    public List<Patient> getPatientsByParameters(String patientName, String doctorName, String ishava) {
        StringBuffer hql = new StringBuffer();
        hql.append("select distinct pat from Patient pat ");
        Object[] paramete = null;
        if (!patientName.equals("") && !doctorName.equals("")) {
            hql.append("right join pat.doctors doc where pat.userName LIKE ? and doc.id in "
                    + "(select doctor.id from Doctor doctor where doctor.userName like ?)");
            paramete = new Object[2];
            paramete[0] = "%" + patientName + "%";
            paramete[1] = "%" + doctorName + "%";
        } else if (!patientName.equals("") && doctorName.equals("")) {
            if (ishava.equals("have")) {
                hql.append("right join pat.doctors doc where pat.userName LIKE ?");
            } else {
                hql.append("where  pat.id not in (select patient.id from Patient patient right join patient.doctors doctor) and pat.userName LIKE ? ");
            }
            paramete = new Object[1];
            paramete[0] = "%" + patientName + "%";
        } else if (patientName.equals("") && !doctorName.equals("")) {
            hql.append("right join pat.doctors doctor where  doctor.id in " + "(select doc.id from Doctor doc where doc.userName like ?)");
            paramete = new Object[1];
            paramete[0] = "%" + doctorName + "%";
        } else {
            if (ishava.equals("have")) {
                hql.append("right join pat.doctors doctor");
            } else {
                hql.append("where  pat.id not in (select patient.id from Patient patient right join patient.doctors doctor)");
            }
        }
        return patientDao.find(hql.toString(), paramete, -1, -1);
    }

    @Override
    public List<Doctor> getDoctorsByParameters(String doctorName, String hospitalName, String ishava) {
        StringBuffer hql = new StringBuffer();
        Object[] paramete = null;
        hql.append("from Doctor u ");
        if (!doctorName.equals("") && !hospitalName.equals("")) {
            hql.append("where u.userName LIKE ? and u.hospitalName LIKE ? ");
            paramete = new Object[2];
            paramete[0] = "%" + doctorName + "%";
            paramete[1] = "%" + hospitalName + "%";
            return doctorDao.find(hql.toString(), paramete, -1, -1);
        } else if (!doctorName.equals("") && hospitalName.equals("")) {
            if (ishava.equals("have")) {
                hql.append("where u.userName LIKE ? and  u.hospitalName !=''");
            } else {
                hql.append("where u.userName LIKE ? and  u.hospitalName =''");
            }
            paramete = new Object[1];
            paramete[0] = "%" + doctorName + "%";
            return doctorDao.find(hql.toString(), paramete, -1, -1);
        } else if (doctorName.equals("") && !hospitalName.equals("")) {
            hql.append("where u.hospitalName LIKE ? and  u.hospitalName !='' ");
            paramete = new Object[1];
            paramete[0] = "%" + hospitalName + "%";
            return doctorDao.find(hql.toString(), paramete, -1, -1);
        } else {
            if (ishava.equals("have")) {
                hql.append("where u.hospitalName !=''");
            } else {
                hql.append("where u.hospitalName =''");
            }
            return doctorDao.find(hql.toString(), paramete, -1, -1);
        }
    }

    @Override
    public List<Cdc> getCDCsByParameters(String userName, String city, String district) {
        StringBuffer hql = new StringBuffer();
        Object[] paramete = new Object[6];
        hql.append("from Cdc u where  (? is null or u.userName like ?) and  (? is null or u.address.city = ?)" + " and  (? is null or u.address.district = ?)");
        paramete[0] = userName;
        paramete[1] = "%" + userName + "%";
        paramete[2] = city;
        paramete[3] = city;
        paramete[4] = district;
        paramete[5] = district;
        return cdcDao.find(hql.toString(), paramete, -1, -1);
    }

    @Override
    public List<Patient> getPatientsByRegisterDate(String registerDate) {
        return patientDao.getBy("registrationDate", registerDate);
    }

	@Override
	public List<Patient> getPatientByAddress(Address address,PropagandaLanguage lange) {
		String sql = "from Patient u where (? is null or u.address.provience = ?) and  (? is null or u.address.city = ?)  and  (? is null or u.address.district = ?)  and  (? is null or u.address.street = ?) and u.language = ?";
		Object[] paramete = new Object[9];
		paramete[0] = address.getProvience();
        paramete[1] = address.getProvience();
        paramete[2] = address.getCity();
        paramete[3] = address.getCity();
        paramete[4] = address.getDistrict();
        paramete[5] = address.getDistrict();
        paramete[6] = address.getStreet();
        paramete[7] = address.getStreet();
        paramete[8] = lange;
        return patientDao.find(sql, paramete, -1, -1);
	}

	@Override
	public List<Cdc> getCdcByAddress(String str, String org) {
		StringBuffer hql = new StringBuffer();
		hql.append("select cdc from Cdc cdc right join cdc.cdcOrg org ");
		if (str.equals("district")) {
			hql.append("where org.id in (select cdcOrg.id from CdcOrganization cdcOrg where "
					+ "cdcOrg.address.district='"+org+"')");
		}else if(str.equals("city")){
			hql.append("where org.id in (select cdcOrg.id from CdcOrganization cdcOrg where "
					+ "cdcOrg.address.city='"+org+"' and cdcOrg.address.district is null)");
		}else if (str.equals("provience")) {
			hql.append("where org.id in (select cdcOrg.id from CdcOrganization cdcOrg where "
					+ "cdcOrg.address.provience='"+org+"' and cdcOrg.address.city is null and cdcOrg.address.district is null)");
		}
		System.out.println("hql.toString()===="+hql.toString());
        return cdcDao.find(hql.toString(), null, -1, -1);
	}
}

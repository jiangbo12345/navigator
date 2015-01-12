
package com.xhr.service;

import java.util.List;

import com.xhr.entity.PillBox;
import com.xhr.entity.PropagandaLanguage;
import com.xhr.entity.user.Address;
import com.xhr.entity.user.Cdc;
import com.xhr.entity.user.Doctor;
import com.xhr.entity.user.Patient;
import com.xhr.entity.user.Role;
import com.xhr.entity.user.User;

public interface IUserService {
    User getUser(String name);

    boolean update(User user);

    List<Patient> getPatientsByDoctor(Doctor doctor);

    Patient getPatientByPillBox(PillBox pillBox);

    Patient getPatientByIdentifier(String identifier);

    boolean regist(User user);

    List getAll(Role patient);

    User getUserByID(int parseInt);

    Patient getPatientById(Integer patientId);

    List<Patient> getPatientsByParameters(String patientName, String doctorName, String ishava);

    List<Patient> getPatientsByRegisterDate(String registerDate);

    java.util.List<Doctor> getDoctorsByParameters(String doctorName, String hospitalName, String ishava);

    java.util.List<Cdc> getCDCsByParameters(String userName, String city, String district);

	List<Patient> getPatientByAddress(Address address, PropagandaLanguage propagandaLanguage);

	List<Cdc> getCdcByAddress(String string, String district);

}

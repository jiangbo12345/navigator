
package com.xhr.dao.orm.commons;

import org.springframework.context.annotation.*;

import com.xhr.entity.*;
import com.xhr.entity.user.Admin;
import com.xhr.entity.user.Cdc;
import com.xhr.entity.user.Doctor;
import com.xhr.entity.user.Patient;
import com.xhr.entity.user.User;

@Configuration
public class GenericDaoConfig {

    @Bean
    public GenericDao<Patient> getPatientDao() {
        return new GenericDaoSupport<Patient>(Patient.class);
    }
    
    @Bean
    public GenericDao<Article> getArticleDao() {
        return new GenericDaoSupport<Article>(Article.class);
    }
    
    @Bean
    public GenericDao<Notice> getNoticeDao() {
        return new GenericDaoSupport<Notice>(Notice.class);
    }
    
    @Bean
    public GenericDao<PropagandaIssued> getPropagandaIssuedDao() {
        return new GenericDaoSupport<PropagandaIssued>(PropagandaIssued.class);
    }
    
    @Bean
    public GenericDao<PropagandaDatum> getPropagandaDatumDao() {
        return new GenericDaoSupport<PropagandaDatum>(PropagandaDatum.class);
    }

    @Bean
    public GenericDao<CdcOrganization> getCdcOrganizationDao() {
        return new GenericDaoSupport<CdcOrganization>(CdcOrganization.class);
    }

    @Bean
    public GenericDao<Nation> getEthnicDao() {
        return new GenericDaoSupport<Nation>(Nation.class);
    }

    @Bean
    public GenericDao<Hospital> getHospitalDao() {
        return new GenericDaoSupport<Hospital>(Hospital.class);
    }

    @Bean
    public GenericDao<BaseGeographic> getBasicsGeographicDao() {
        return new GenericDaoSupport<BaseGeographic>(BaseGeographic.class);
    }

    @Bean
    public GenericDao<BaseStation> getBaseStationDao() {
        return new GenericDaoSupport<BaseStation>(BaseStation.class);
    }

    @Bean
    public GenericDao<PatientCheck> getPatientCheckDao() {
        return new GenericDaoSupport<PatientCheck>(PatientCheck.class);
    }

    @Bean
    public GenericDao<Doctor> getDoctorDao() {
        return new GenericDaoSupport<Doctor>(Doctor.class);
    }

    @Bean
    public GenericDao<Cdc> getCdcDao() {
        return new GenericDaoSupport<Cdc>(Cdc.class);
    }

    @Bean
    public GenericDao<User> getUserDao() {
        return new GenericDaoSupport<User>(User.class);
    }

    @Bean
    public GenericDao<PillBox> getPillBoxDao() {
        return new GenericDaoSupport<PillBox>(PillBox.class);
    }

    @Bean
    public GenericDao<Admin> getAdminDao() {
        return new GenericDaoSupport<Admin>(Admin.class);
    }

    @Bean
    public GenericDao<ExecuteRecord> getExecuteRecordDao() {
        return new GenericDaoSupport<ExecuteRecord>(ExecuteRecord.class);
    }

    @Bean
    public GenericDao<Plan> getPlanDao() {
        return new GenericDaoSupport<Plan>(Plan.class);
    }

    @Bean
    public GenericDao<FollowUpSuggestion> getFollowUpSuggestionDao() {
        return new GenericDaoSupport<FollowUpSuggestion>(FollowUpSuggestion.class);
    }

}

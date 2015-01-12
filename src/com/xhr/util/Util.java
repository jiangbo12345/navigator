package com.xhr.util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

import com.xhr.entity.user.Doctor;

public class Util {
	
	private static final Logger LOG = Logger.getLogger(Util.class);
	
	public static Map<String,Map<String,List<Doctor>>> getArrayByDoctors(List<Doctor> doctors) {
    	Map<String,Map<String,List<Doctor>>> doctorsMap = new HashMap<String, Map<String,List<Doctor>>>();
    	Map<String, List<Doctor>> map = getArrayDoctor(doctors);
    	List<Doctor> deps = null;
    	Map<String,List<Doctor>> mapDoctor = null;
    	for (String key : map.keySet()) {
    		LOG.info("getHospitalName ========= "+key);
    		List<Doctor> doctorList = map.get(key);
    		mapDoctor = new HashMap<String, List<Doctor>>();
    		LOG.info("doctorList.size ========= "+doctorList.size());
    		for (int i = 0; i < doctorList.size(); i++) {
    			if ((i+1)<doctorList.size()) {
    				if (doctorList.get(i).getDepartments().equals(doctorList.get(i+1).getDepartments())) {
						if (i==0) {
							deps = new ArrayList<Doctor>();
						}
						deps.add(doctorList.get(i));
					}else{
						if (i==0) {
							deps = new ArrayList<Doctor>();
						}
						deps.add(doctorList.get(i));
						mapDoctor.put(doctorList.get(i).getDepartments(), deps);
						deps = new ArrayList<Doctor>();
					}
    			}else{
    				if (i-1<0) {
    					deps = new ArrayList<Doctor>();
    					deps.add(doctorList.get(i));
    					mapDoctor.put(doctorList.get(i).getDepartments(), deps);
					}else{
	    				if (doctorList.get(i).getDepartments().equals(doctorList.get(i-1).getDepartments())) {
	    					deps.add(doctorList.get(i));
	    					mapDoctor.put(doctorList.get(i).getDepartments(), deps);
	    				}else{
	    					deps = new ArrayList<Doctor>();
	    					deps.add(doctorList.get(i));
	    					mapDoctor.put(doctorList.get(i).getDepartments(), deps);
						}
					}
    			}
			}
			doctorsMap.put(key, mapDoctor);
		}
		return doctorsMap;
	}
    private static Map<String, List<Doctor>> getArrayDoctor(List<Doctor> doctors){
    	List<Doctor> list = null;
    	Map<String,List<Doctor>> map = new HashMap<String, List<Doctor>>();
    	if (doctors != null && doctors.size()>0) {
        	LOG.info("doctor  size  ====="+doctors.size());
			for (int i = 0; i < doctors.size(); i++) {
				if ((i+1)<doctors.size()) {
					if (doctors.get(i).getHospital() !=null) {
						if (doctors.get(i).getHospital().getHospitalDesignation().equals(doctors.get(i+1).getHospital().getHospitalDesignation())) {
							if (i==0) {
								list = new ArrayList<Doctor>();
							}
							list.add(doctors.get(i));
						}else{
							if (i==0) {
								list = new ArrayList<Doctor>();
							}
							list.add(doctors.get(i));
							LOG.info("doctors.get(i).getHospitalName()  ====="+doctors.get(i).getHospital().getHospitalDesignation());
							map.put(doctors.get(i).getHospital().getHospitalDesignation(), list);
							list = new ArrayList<Doctor>();
						}
					}
				} else {
					if (i-1<0) {
						list = new ArrayList<Doctor>();
						list.add(doctors.get(i));
						if (doctors.get(i).getHospital() !=null) {
							LOG.info("doctors.get(i).getHospitalName()  ====="+doctors.get(i).getHospital().getHospitalDesignation());
							map.put(doctors.get(i).getHospital().getHospitalDesignation(), list);
						}
					}else{
						if (doctors.get(i).getHospital() !=null) {
							if (doctors.get(i).getHospital().getHospitalDesignation().equals(doctors.get(i-1).getHospital().getHospitalDesignation())) {
								list.add(doctors.get(i));
								LOG.info("doctors.get(i).getHospitalName()  ====="+doctors.get(i).getHospital().getHospitalDesignation());
								map.put(doctors.get(i).getHospital().getHospitalDesignation(), list);
							}else{
								list = new ArrayList<Doctor>();
								list.add(doctors.get(i));
								LOG.info("doctors.get(i).getHospitalName()  ====="+doctors.get(i).getHospital().getHospitalDesignation());
								map.put(doctors.get(i).getHospital().getHospitalDesignation(), list);
							}
						}
					}
				}
			}
		}
    	return map;
    }
}

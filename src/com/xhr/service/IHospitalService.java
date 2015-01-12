package com.xhr.service;

import java.util.List;

import com.xhr.entity.Hospital;

public interface IHospitalService extends IGenericService<Hospital>{
	
	List<Hospital> getAll();
}

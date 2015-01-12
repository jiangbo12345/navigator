package com.xhr.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.xhr.dao.orm.commons.GenericDao;
import com.xhr.entity.Hospital;
import com.xhr.service.IHospitalService;

@Component
public class HospitalService extends GenericService<Hospital> implements
		IHospitalService {
	@Autowired
	GenericDao<Hospital> hospitalDao;

	@Override
	public List<Hospital> getAll() {
		return hospitalDao.findAll();
	}

	@Override
	GenericDao<Hospital> getDao() {
		return hospitalDao;
	}

}

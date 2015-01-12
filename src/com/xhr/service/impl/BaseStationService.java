package com.xhr.service.impl;

import java.util.List;

import javax.persistence.EntityTransaction;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.xhr.dao.orm.commons.GenericDao;
import com.xhr.entity.BaseStation;
import com.xhr.service.IBaseStationService;

@Component
public class BaseStationService extends GenericService<BaseStation> implements
		IBaseStationService {
	@Autowired
	GenericDao<BaseStation> baseStationDao;

	@Override
	public List<BaseStation> getAll() {
		return baseStationDao.findAll();
	}

	@Override
	GenericDao<BaseStation> getDao() {
		return baseStationDao;
	}
}

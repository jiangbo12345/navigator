package com.xhr.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.xhr.dao.orm.commons.GenericDao;
import com.xhr.entity.PropagandaDatum;
import com.xhr.service.IPropagandaDatumService;
@Component
public class PropagandaDatumService extends GenericService<PropagandaDatum> implements IPropagandaDatumService{

	@Autowired
    GenericDao<PropagandaDatum> propagandaDatumDao;
	
	@Override
	GenericDao<PropagandaDatum> getDao() {
		return propagandaDatumDao;
	}

	@Override
	public List<PropagandaDatum> getAll() {
		return propagandaDatumDao.findAll();
	}

}

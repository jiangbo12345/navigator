package com.xhr.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.xhr.dao.orm.commons.GenericDao;
import com.xhr.entity.PropagandaIssued;
import com.xhr.service.IPropagandaIssuedService;

@Component
public class PropagandaIssuedService extends GenericService<PropagandaIssued>
		implements IPropagandaIssuedService {

	@Autowired
	GenericDao<PropagandaIssued> propagandaIssuedDao;

	@Override
	public List<PropagandaIssued> getAll() {
		return propagandaIssuedDao.findAll();
	}

	@Override
	GenericDao<PropagandaIssued> getDao() {
		return propagandaIssuedDao;
	}

}

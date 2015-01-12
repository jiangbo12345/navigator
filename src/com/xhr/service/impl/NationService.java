package com.xhr.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.xhr.dao.orm.commons.GenericDao;
import com.xhr.entity.Nation;
import com.xhr.service.INationService;

@Component
public class NationService extends GenericService<Nation> implements
		INationService {
	@Autowired
	GenericDao<Nation> nationDao;

	@Override
	public List<Nation> getAll() {
		return nationDao.findAll();
	}

	@Override
	GenericDao<Nation> getDao() {
		return nationDao;
	}
}

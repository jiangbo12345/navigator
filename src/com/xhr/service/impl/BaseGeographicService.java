package com.xhr.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.xhr.dao.orm.commons.GenericDao;
import com.xhr.entity.BaseGeographic;
import com.xhr.service.IBaseGeographicService;
@Component
public class BaseGeographicService  extends GenericService<BaseGeographic> implements IBaseGeographicService {

	@Autowired
    GenericDao<BaseGeographic> baseGeographicDao;
	
	@Override
	public List<BaseGeographic> getBasicsGeographicNodes() {
		return baseGeographicDao.findAll();
	}

	@Override
	GenericDao<BaseGeographic> getDao() {
		return baseGeographicDao;
	}

	@Override
	public BaseGeographic getBaseGeographicByID(String provience) {
		if (provience.equals("-1")) {
			return new BaseGeographic();
		}
		Integer id = Integer.parseInt(provience);
		return baseGeographicDao.findById(id);
	}

	@Override
	public List<BaseGeographic> getParentByID(int district) {
		return baseGeographicDao.getBy("parentNode", district);
	}

}

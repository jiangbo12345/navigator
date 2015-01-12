package com.xhr.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.xhr.dao.orm.commons.GenericDao;
import com.xhr.entity.CdcOrganization;
import com.xhr.service.ICdcOrganizationService;

@Component
public class CdcOrganizationService extends GenericService<CdcOrganization>
		implements ICdcOrganizationService {
	@Autowired
	GenericDao<CdcOrganization> cdcOrganizationDao;

	@Override
	public List<CdcOrganization> getAll() {
		return cdcOrganizationDao.findAll();
	}

	@Override
	GenericDao<CdcOrganization> getDao() {
		return cdcOrganizationDao;
	}

	@Override
	public CdcOrganization getCdcOrgByID(int parseInt) {
		return cdcOrganizationDao.findById(parseInt);
	}

}

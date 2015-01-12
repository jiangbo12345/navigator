package com.xhr.service;

import java.util.List;

import com.xhr.entity.CdcOrganization;

public interface ICdcOrganizationService extends IGenericService<CdcOrganization>{

	List<CdcOrganization> getAll();

	CdcOrganization getCdcOrgByID(int parseInt);
}

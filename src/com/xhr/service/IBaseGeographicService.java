package com.xhr.service;

import java.util.List;

import com.xhr.entity.BaseGeographic;

public interface IBaseGeographicService  extends IGenericService<BaseGeographic>{

	List<BaseGeographic> getBasicsGeographicNodes();

	BaseGeographic getBaseGeographicByID(String provience);

	List<BaseGeographic> getParentByID(int district);
}

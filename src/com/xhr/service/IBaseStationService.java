package com.xhr.service;

import java.util.List;

import com.xhr.entity.BaseStation;

public interface IBaseStationService   extends IGenericService<BaseStation>{

	List<BaseStation> getAll();
}

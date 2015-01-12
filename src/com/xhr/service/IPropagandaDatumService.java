package com.xhr.service;

import java.util.List;

import com.xhr.entity.PropagandaDatum;

public interface IPropagandaDatumService extends IGenericService<PropagandaDatum>{

	List<PropagandaDatum> getAll();

}

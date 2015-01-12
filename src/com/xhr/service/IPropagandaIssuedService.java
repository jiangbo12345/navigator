package com.xhr.service;

import java.util.List;

import com.xhr.entity.PropagandaIssued;

public interface IPropagandaIssuedService  extends IGenericService<PropagandaIssued>{

	List<PropagandaIssued> getAll();
}

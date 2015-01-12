package com.xhr.service;

import java.util.List;

import com.xhr.entity.PillBox;
import com.xhr.entity.State;

public interface IPillBoxService extends IGenericService<PillBox>{

	List<PillBox> getAll();

	List<PillBox> getListByIdentAndState(String identifier, State state);
}

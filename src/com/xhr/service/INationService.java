package com.xhr.service;

import java.util.List;

import com.xhr.entity.Nation;

public interface INationService   extends IGenericService<Nation>{

	List<Nation> getAll();
}

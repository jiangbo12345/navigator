
package com.xhr.service.impl;

import com.xhr.dao.orm.commons.GenericDao;
import com.xhr.service.IGenericService;

public abstract class GenericService<T> implements IGenericService<T> {

    @Override
    public T save(T t) {
        getDao().save(t);

        return t;
    }

    @Override
    public Boolean delete(Integer id) {
        return getDao().deleteById(id);
    }

    @Override
    public T update(T t) {
        getDao().update(t);
        return t;
    }

    @Override
    public T findById(Object id) {
        return getDao().findById(id);
    }

    abstract GenericDao<T> getDao();
}

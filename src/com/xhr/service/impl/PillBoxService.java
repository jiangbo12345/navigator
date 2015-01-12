
package com.xhr.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.xhr.dao.orm.commons.GenericDao;
import com.xhr.entity.PillBox;
import com.xhr.entity.State;
import com.xhr.service.IPillBoxService;

@Component
public class PillBoxService extends GenericService<PillBox> implements IPillBoxService {

    @Autowired
    GenericDao<PillBox> pillBoxDao;

    @Override
    public List<PillBox> getAll() {
        return pillBoxDao.findAll();
    }

    @Override
    public List<PillBox> getListByIdentAndState(String identifier, State state) {
        StringBuffer hql = new StringBuffer();
        hql.append("from PillBox  ");
        Object[] object = null;
        if (state != null  && !identifier.equals("")) {
            hql.append("where  identifier like ? and state = ?");
            object = new Object[2];
            object[0] = "%" + identifier + "%";
            object[1] = state;
        } else if (state == null && !identifier.equals("")) {
            hql.append("where  identifier like ? ");
            object = new Object[1];
            object[0] = "%" + identifier + "%";
        } else if (state != null && identifier.equals("")) {
            hql.append("where  state = ? ");
            object = new Object[1];
            object[0] = state;
        }
        return pillBoxDao.find(hql.toString(), object, -1, -1);
    }

    @Override
    GenericDao<PillBox> getDao() {
        return pillBoxDao;
    }
}

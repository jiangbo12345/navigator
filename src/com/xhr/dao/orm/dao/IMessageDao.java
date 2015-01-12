
package com.xhr.dao.orm.dao;

import com.xhr.dao.orm.commons.GenericDao;
import com.xhr.entity.Message;

public interface IMessageDao extends GenericDao<Message> {

    public int batchDelete(String ids);

}


package com.xhr.service.impl;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.Query;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.xhr.dao.orm.commons.GenericDao;
import com.xhr.dao.orm.dao.IMessageDao;
import com.xhr.entity.Message;
import com.xhr.entity.user.User;
import com.xhr.service.IMessageService;

@Component
public class MessageService extends GenericService<Message> implements IMessageService {

    private static final Logger LOG = Logger.getLogger(MessageService.class);

    @Autowired
    IMessageDao messageDao;

    @Override
    public List<Message> getToDoList(User user) {
        List<String> keys = new ArrayList<String>();
        keys.add("sendTo");
        keys.add("showInIndex");
        List<Object> values = new ArrayList<Object>();
        values.add(user.getId());
        values.add("1");
        return messageDao.getBy(keys, values);
    }

    @Override
    GenericDao<Message> getDao() {
        return messageDao;
    }

    @Override
    public List<Message> getSystemMessage(String createBy) {
        return messageDao.getBy("createBy", createBy);
    }

    @Override
    public int batchDelete(String ids) {
        return messageDao.batchDelete(ids);
    }
}

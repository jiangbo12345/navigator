
package com.xhr.dao.orm.dao;

import javax.persistence.Query;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.xhr.dao.orm.commons.GenericDaoSupport;
import com.xhr.entity.Message;
import com.xhr.service.impl.MessageService;

@Component
public class MessageDao extends GenericDaoSupport<Message> implements IMessageDao {

    private static final Logger LOG = Logger.getLogger(MessageService.class);

    public MessageDao(Class<Message> clazz) {
        super(clazz);
    }

    public MessageDao() {
        super(Message.class);
    }

    @Override
    @Transactional
    public int batchDelete(String ids) {
        String sql = "delete from message where id in (" + ids + ")";
        LOG.info("batch delete message sal = " + sql);
        try {
            if (!em.getTransaction().isActive()) {
                em.getTransaction().begin();
            }
            Query query = em.createNativeQuery(sql);
            em.getTransaction().commit();
            return query.executeUpdate();
        } catch (Exception e) {
            em.getTransaction().rollback();
            e.printStackTrace();
        }
        return 0;
    }

}

package com.xhr.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.xhr.dao.orm.commons.GenericDao;
import com.xhr.entity.Notice;
import com.xhr.entity.user.User;
import com.xhr.service.INoticeService;

@Component
public class NoticeService extends GenericService<Notice> implements INoticeService {

	@Autowired
	GenericDao<Notice> noticeDao;

	@Override
	public List<Notice> getAll() {
		return noticeDao.findAll();
	}

	@Override
	GenericDao<Notice> getDao() {
		return noticeDao;
	}

	@Override
	public List<Notice> getNoticeByDoc(User user) {
		String sql = "from Notice where touser LIKE ?";
		 Object[] paramete = new Object[1];
       paramete[0] = "%," + user.getId() + ",%";
		return noticeDao.find(sql, paramete, -1,-1);
	}

}

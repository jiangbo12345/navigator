package com.xhr.service;

import java.util.List;

import com.xhr.entity.Notice;
import com.xhr.entity.user.User;

public interface INoticeService extends IGenericService<Notice>{

	List<Notice> getAll();

	List<Notice> getNoticeByDoc(User user);

}

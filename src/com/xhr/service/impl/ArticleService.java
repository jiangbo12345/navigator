package com.xhr.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.xhr.dao.orm.commons.GenericDao;
import com.xhr.entity.Article;
import com.xhr.service.IArticleService;
@Component
public class ArticleService  extends GenericService<Article> implements IArticleService{

	@Autowired
    GenericDao<Article> articleDao;
	
	@Override
	public List<Article> getAll() {
		return articleDao.findAll();
	}

	@Override
	GenericDao<Article> getDao() {
		return articleDao;
	}

	@Override
	public List<Article> getNoticeId(Integer noticeId) {
		return articleDao.getBy("notice.noticeId", noticeId);
	}

}

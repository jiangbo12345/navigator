package com.xhr.service;

import java.util.List;

import com.xhr.entity.Article;

public interface IArticleService extends IGenericService<Article>{

	List<Article> getAll();

	List<Article> getNoticeId(Integer noticeId);
}

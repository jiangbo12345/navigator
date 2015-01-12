
package com.xhr.entity;

import java.util.List;

import javax.persistence.*;

@Entity
public class Notice {

    @Id
    @GeneratedValue
    private Integer noticeId;

    @Column
    private String touser;

    @Column
    private String toparty;

    @Column
    private String totag;

    @Column
    @Enumerated(EnumType.STRING)
    private NoticeType noticeType;

    @Column
    private String agentid;

    @Column
    private String content;
    
    @Column
    private String path;

    @OneToMany(mappedBy = "notice")
    private List<Article> articles;
    
    @Column
    private boolean toWeChat;
    
    @Column
    private boolean isSend = false;
    
    @Column
    private String noticeDate;
    
    public String getNoticeDate() {
		return noticeDate;
	}

	public void setNoticeDate(String noticeDate) {
		this.noticeDate = noticeDate;
	}

	public boolean isToWeChat() {
		return toWeChat;
	}

	public void setToWeChat(boolean toWeChat) {
		this.toWeChat = toWeChat;
	}

	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
	}

	public Integer getNoticeId() {
        return noticeId;
    }

    public void setNoticeId(Integer noticeId) {
        this.noticeId = noticeId;
    }

    public String getTouser() {
        return touser;
    }

    public void setTouser(String touser) {
        this.touser = touser;
    }

    public String getToparty() {
        return toparty;
    }

    public void setToparty(String toparty) {
        this.toparty = toparty;
    }

    public String getTotag() {
        return totag;
    }

    public void setTotag(String totag) {
        this.totag = totag;
    }

    public NoticeType getNoticeType() {
        return noticeType;
    }

    public void setNoticeType(NoticeType noticeType) {
        this.noticeType = noticeType;
    }

    public String getAgentid() {
        return agentid;
    }

    public void setAgentid(String agentid) {
        this.agentid = agentid;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public List<Article> getArticles() {
        return articles;
    }

    public void setArticles(List<Article> articles) {
        this.articles = articles;
    }

}

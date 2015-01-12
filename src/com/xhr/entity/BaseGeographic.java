package com.xhr.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class BaseGeographic {

	@Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Integer id;
	
	@Column
	private Integer  parentNode;
	
	@Column
	private Integer  nodeRank;
	
	@Column(length = 50)
    private String  geogDesignation;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getParentNode() {
		return parentNode;
	}

	public void setParentNode(Integer parentNode) {
		this.parentNode = parentNode;
	}

	public Integer getNodeRank() {
		return nodeRank;
	}

	public void setNodeRank(Integer nodeRank) {
		this.nodeRank = nodeRank;
	}

	public String getGeogDesignation() {
		return geogDesignation;
	}

	public void setGeogDesignation(String geogDesignation) {
		this.geogDesignation = geogDesignation;
	}
	
}

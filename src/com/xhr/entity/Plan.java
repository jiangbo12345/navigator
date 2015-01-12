
package com.xhr.entity;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.CollectionTable;
import javax.persistence.Column;
import javax.persistence.ElementCollection;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

import com.xhr.entity.user.User;

//计划
@Entity
public class Plan extends RecordInfo {

    @Id
    @GeneratedValue
    private Integer id;

    @Column
    @Enumerated(EnumType.STRING)
    private ProgramType type;

    @Column
    private String title;

    @ElementCollection
    @Column(name = "period")
    @Enumerated(EnumType.STRING)
    @CollectionTable(name = "plan_period")
    private List<Period> periods = new ArrayList<Period>();

    @Column
    private Integer numberPerPeriod;

    @Column
    private String fromDate;

    @Column
    private String toDate;

    @Column
    private String nodifiedDate;

    @ElementCollection
    @Column(name = "time")
    @CollectionTable(name = "plan_time")
    private List<String> times = new ArrayList<String>();

    @ElementCollection
    @Column(name = "advtime")
    @CollectionTable(name = "plan_advtime")
    private List<String> advtime = new ArrayList<String>();

    @Column
    private String comments;

    @ManyToOne
    @JoinColumn(name = "from_user")
    private User fromUser;

    @ManyToOne
    @JoinColumn(name = "to_user")
    private User toUser;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public ProgramType getType() {
        return type;
    }

    public void setType(ProgramType type) {
        this.type = type;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getFromDate() {
        return fromDate;
    }

    public void setFromDate(String fromDate) {
        this.fromDate = fromDate;
    }

    public String getToDate() {
        return toDate;
    }

    public void setToDate(String toDate) {
        this.toDate = toDate;
    }

    public List<Period> getPeriods() {
        return periods;
    }

    public void setPeriods(List<Period> periods) {
        this.periods = periods;
    }

    public void addPeriod(Period period) {
        periods.add(period);
    }

    public List<String> getTimes() {
        return times;
    }

    public void setTimes(List<String> times) {
        this.times = times;
    }

    public void addTime(String time) {
        times.add(time);
    }

    public void addAdvtime(String time) {
        advtime.add(time);
    }

    public User getFromUser() {
        return fromUser;
    }

    public void setFromUser(User fromUser) {
        this.fromUser = fromUser;
    }

    public User getToUser() {
        return toUser;
    }

    public void setToUser(User toUser) {
        this.toUser = toUser;
    }

    public Integer getNumberPerPeriod() {
        return numberPerPeriod;
    }

    public void setNumberPerPeriod(Integer numberPerPeriod) {
        this.numberPerPeriod = numberPerPeriod;
    }

    public List<String> getAdvtime() {
        return advtime;
    }

    public void setAdvtime(List<String> advtime) {
        this.advtime = advtime;
    }

    public String getComments() {
        return comments;
    }

    public void setComments(String comments) {
        this.comments = comments;
    }

    public String getNodifiedDate() {
        return nodifiedDate;
    }

    public void setNodifiedDate(String nodifiedDate) {
        this.nodifiedDate = nodifiedDate;
    }

}

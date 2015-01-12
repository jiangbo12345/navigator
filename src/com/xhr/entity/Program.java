
package com.xhr.entity;

import java.util.List;

import javax.persistence.*;

import org.codehaus.jackson.annotate.JsonIgnoreProperties;

import com.xhr.entity.user.Patient;

@Entity
@JsonIgnoreProperties(value={"patients"})
public class Program {

    @Id
    @GeneratedValue
    private Integer id;

    @Column(length = 32)
    private String name;

    @Column
    @Enumerated(EnumType.STRING)
    private ProgramType type;

    @ManyToMany(mappedBy = "programs")
    List<Patient> patients;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public List<Patient> getPatients() {
        return patients;
    }

    public void setPatients(List<Patient> patients) {
        this.patients = patients;
    }

    public ProgramType getType() {
        return type;
    }

    public void setType(ProgramType type) {
        this.type = type;
    }

}

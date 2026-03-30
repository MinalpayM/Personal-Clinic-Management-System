package com.clinic.model;

import java.util.Date;

public class Patient {
    private Integer patientId;
    private String name;
    private String gender;
    private Date birthDate;
    private String phone;
    private String address;
    private String idCard;
    private Date createTime;
    private Integer doctorId;
    
    // 构造方法
    public Patient() {}
    
    // Getter和Setter方法
    public Integer getPatientId() {
        return patientId;
    }
    
    public void setPatientId(Integer patientId) {
        this.patientId = patientId;
    }
    
    public String getName() {
        return name;
    }
    
    public void setName(String name) {
        this.name = name;
    }
    
    public String getGender() {
        return gender;
    }
    
    public void setGender(String gender) {
        this.gender = gender;
    }
    
    public Date getBirthDate() {
        return birthDate;
    }
    
    public void setBirthDate(Date birthDate) {
        this.birthDate = birthDate;
    }
    
    public String getPhone() {
        return phone;
    }
    
    public void setPhone(String phone) {
        this.phone = phone;
    }
    
    public String getAddress() {
        return address;
    }
    
    public void setAddress(String address) {
        this.address = address;
    }
    
    public String getIdCard() {
        return idCard;
    }
    
    public void setIdCard(String idCard) {
        this.idCard = idCard;
    }
    
    public Date getCreateTime() {
        return createTime;
    }
    
    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }
    
    public Integer getDoctorId() {
        return doctorId;
    }
    
    public void setDoctorId(Integer doctorId) {
        this.doctorId = doctorId;
    }
}
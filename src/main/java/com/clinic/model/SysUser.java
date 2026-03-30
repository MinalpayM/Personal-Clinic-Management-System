package com.clinic.model;

import java.util.Date;

public class SysUser {
    private int userId;
    private String username;
    private String password;
    private String role;
    private Integer doctorId;
    private int status;
    private Date createTime; 

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }
 
    public void setPassword(String password) {
        this.password = password;
    }

    public String getRole() {
        return role;
    }
 
    public void setRole(String role) {
        this.role = role;
    }

    public Integer getDoctorId() {
        return doctorId;
    }
 
    public void setDoctorId(Integer doctorId) {
        this.doctorId = doctorId;
    }

    public int getStatus() {
        return status;
    }
 
    public void setStatus(int status) {
        this.status = status;
    }
    
    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }
}
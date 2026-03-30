package com.clinic.model;

import java.util.Date;

import java.time.LocalDate;
import java.time.ZoneId;

public class Doctor {
    private int doctorId;
    private String name;
    private String gender;
    private Date birthDate;
    private String title;
    private double salary;
    private String phone;
    private String address;
    private String idCard;
    private Date createTime;
    private String avatar;

    public int getDoctorId() { return doctorId; }
    public void setDoctorId(int doctorId) { this.doctorId = doctorId; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getGender() { return gender; }
    public void setGender(String gender) { this.gender = gender; }

    public Date getBirthDate() { return birthDate; }
    public void setBirthDate(Date birthDate) { this.birthDate = birthDate; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public double getSalary() { return salary; }
    public void setSalary(double salary) { this.salary = salary; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public String getIdCard() { return idCard; }
    public void setIdCard(String idCard) { this.idCard = idCard; }

    public Date getCreateTime() { return createTime; }
    public void setCreateTime(Date createTime) { this.createTime = createTime; }

    public String getAvatar() { return avatar; }
    public void setAvatar(String avatar) { this.avatar = avatar; } 
   
    public int getAge() {
        if (birthDate == null) return 0;
        LocalDate birth = new java.sql.Date(birthDate.getTime()).toLocalDate();
        LocalDate now = LocalDate.now();
        int age = now.getYear() - birth.getYear();
        if (now.getMonthValue() < birth.getMonthValue() ||
            (now.getMonthValue() == birth.getMonthValue() && now.getDayOfMonth() < birth.getDayOfMonth())) {
            age--; // 如果生日还没到，减一岁
        }
        return age;
    }

}

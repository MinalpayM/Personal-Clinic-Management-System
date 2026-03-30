package com.clinic.model;

import java.util.Date;

public class Prescription {
    private Integer id;
    private Integer caseId;
    private Integer medicineId;
    private String medicineName; // 药品名称（用于显示）
    private String description; // 药品描述
    private Integer quantity;
    private Double price;
    
    // 构造方法
    public Prescription() {}
    
    // Getter和Setter方法
    public Integer getId() {
        return id;
    }
    
    public void setId(Integer id) {
        this.id = id;
    }
    
    public Integer getCaseId() {
        return caseId;
    }
    
    public void setCaseId(Integer caseId) {
        this.caseId = caseId;
    }
    
    public Integer getMedicineId() {
        return medicineId;
    }
    
    public void setMedicineId(Integer medicineId) {
        this.medicineId = medicineId;
    }
    
    public String getMedicineName() {
        return medicineName;
    }
    
    public void setMedicineName(String medicineName) {
        this.medicineName = medicineName;
    }
    
    public Integer getQuantity() {
        return quantity;
    }
    
    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }
    
    public Double getPrice() {
        return price;
    }
    
    public void setPrice(Double price) {
        this.price = price;
    }
    
    // 计算小计
    public Double getSubtotal() {
        if (quantity != null && price != null) {
            return quantity * price;
        }
        return 0.0;
    }
    
    public String getDosage() {
        return ""; 
    }

    public String getNotes() {
        return ""; 
    }
    
    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}
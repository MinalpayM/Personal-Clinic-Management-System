// PrescriptionDetail.java
package com.clinic.model;

import java.util.List;

public class PrescriptionDetail {
    private MedicalCase medicalCase;
    private Patient patient;
    private List<Prescription> prescriptions;

    // 构造方法
    public PrescriptionDetail() {}

    // Getter 和 Setter
    public MedicalCase getMedicalCase() {
        return medicalCase;
    }

    public void setMedicalCase(MedicalCase medicalCase) {
        this.medicalCase = medicalCase;
    }

    public Patient getPatient() {
        return patient;
    }

    public void setPatient(Patient patient) {
        this.patient = patient;
    }

    public List<Prescription> getPrescriptions() {
        return prescriptions;
    }

    public void setPrescriptions(List<Prescription> prescriptions) {
        this.prescriptions = prescriptions;
    }
}
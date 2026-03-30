package com.clinic.dao;

import com.clinic.model.Patient;
import com.clinic.util.DBUtil;
import org.springframework.stereotype.Repository;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@Repository
public class PatientDao {
    
    // 查询医生下的所有病人
    public List<Patient> findByDoctorId(int doctorId) {
        List<Patient> list = new ArrayList<>();
        String sql = "SELECT * FROM patient WHERE doctor_id = ? ORDER BY patient_id DESC";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, doctorId);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                list.add(mapRow(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    // 根据ID查询病人
    public Patient findById(int patientId) {
        String sql = "SELECT * FROM patient WHERE patient_id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, patientId);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                return mapRow(rs);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    
    // 添加病人
    public boolean addPatient(Patient patient) {
        String sql = "INSERT INTO patient (name, gender, birth_date, phone, address, id_card, doctor_id, create_time) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?, NOW())";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, patient.getName());
            ps.setString(2, patient.getGender());
            ps.setDate(3, new java.sql.Date(patient.getBirthDate().getTime()));
            ps.setString(4, patient.getPhone());
            ps.setString(5, patient.getAddress());
            ps.setString(6, patient.getIdCard());
            ps.setInt(7, patient.getDoctorId());
            
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // 更新病人信息
    public boolean updatePatient(Patient patient) {
        String sql = "UPDATE patient SET name = ?, gender = ?, birth_date = ?, " +
                    "phone = ?, address = ?, id_card = ? WHERE patient_id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, patient.getName());
            ps.setString(2, patient.getGender());
            ps.setDate(3, new java.sql.Date(patient.getBirthDate().getTime()));
            ps.setString(4, patient.getPhone());
            ps.setString(5, patient.getAddress());
            ps.setString(6, patient.getIdCard());
            ps.setInt(7, patient.getPatientId());
            
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // 删除病人
    public boolean deletePatient(int patientId) {
        String sql = "DELETE FROM patient WHERE patient_id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, patientId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // 搜索医生下的病人
    public List<Patient> searchPatients(int doctorId, String keyword) {
        List<Patient> list = new ArrayList<>();
        String sql = "SELECT * FROM patient WHERE doctor_id = ? AND " +
                    "(name LIKE ? OR phone LIKE ? OR id_card LIKE ?) " +
                    "ORDER BY patient_id DESC";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, doctorId);
            String searchPattern = "%" + keyword + "%";
            ps.setString(2, searchPattern);
            ps.setString(3, searchPattern);
            ps.setString(4, searchPattern);
            
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                list.add(mapRow(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    // 统计医生病人数量
    public int countByDoctorId(int doctorId) {
        String sql = "SELECT COUNT(*) FROM patient WHERE doctor_id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, doctorId);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }
    
    // 映射ResultSet到Patient对象
    private Patient mapRow(ResultSet rs) throws SQLException {
        Patient patient = new Patient();
        patient.setPatientId(rs.getInt("patient_id"));
        patient.setName(rs.getString("name"));
        patient.setGender(rs.getString("gender"));
        patient.setBirthDate(rs.getDate("birth_date"));
        patient.setPhone(rs.getString("phone"));
        patient.setAddress(rs.getString("address"));
        patient.setIdCard(rs.getString("id_card"));
        patient.setCreateTime(rs.getTimestamp("create_time"));
        patient.setDoctorId(rs.getInt("doctor_id"));
        return patient;
    }
}
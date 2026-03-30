package com.clinic.dao;

import com.clinic.model.MedicalCase;
import com.clinic.model.Patient;
import com.clinic.util.DBUtil;
import org.springframework.stereotype.Repository;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@Repository
public class MedicalCaseDao {

    // 根据医生ID获取病例列表
    public List<MedicalCase> findByDoctorId(int doctorId) {
        List<MedicalCase> list = new ArrayList<>();
        String sql = "SELECT c.*, p.name as patient_name " +
                     "FROM medical_case c " +
                     "LEFT JOIN patient p ON c.patient_id = p.patient_id " +
                     "WHERE c.doctor_id = ? " +
                     "ORDER BY c.visit_time DESC";
        
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

    // 根据病人ID获取病例列表
    public List<MedicalCase> findByPatientId(int patientId) {
        List<MedicalCase> list = new ArrayList<>();
        String sql = "SELECT * FROM medical_case WHERE patient_id = ? ORDER BY visit_time DESC";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, patientId);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                list.add(mapRow(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
 // 根据ID获取病例
    public MedicalCase findById(int caseId) {
        String sql = "SELECT c.*, p.name as patient_name " +
                     "FROM medical_case c " +
                     "LEFT JOIN patient p ON c.patient_id = p.patient_id " +
                     "WHERE c.case_id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, caseId);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                return mapRow(rs);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // 创建新病例
    public boolean create(MedicalCase medicalCase) {
        String sql = "INSERT INTO medical_case (patient_id, doctor_id, symptom, visit_time, total_fee) " +
                     "VALUES (?, ?, ?, NOW(), ?)";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, medicalCase.getPatientId());
            ps.setInt(2, medicalCase.getDoctorId());
            ps.setString(3, medicalCase.getSymptom());
            ps.setDouble(4, medicalCase.getTotalFee() != null ? medicalCase.getTotalFee() : 0.0);
            
            int affectedRows = ps.executeUpdate();
            if (affectedRows > 0) {
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    medicalCase.setCaseId(rs.getInt(1));
                }
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
 // 更新病例
    public boolean update(MedicalCase medicalCase) {
        String sql = "UPDATE medical_case SET symptom = ?, total_fee = ? " +
                     "WHERE case_id = ? AND doctor_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, medicalCase.getSymptom());
            ps.setDouble(2, medicalCase.getTotalFee() != null ? medicalCase.getTotalFee() : 0.0);
            ps.setInt(3, medicalCase.getCaseId());
            ps.setInt(4, medicalCase.getDoctorId());
            
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // 删除病例
    public boolean delete(int caseId, int doctorId) {
        String sql = "DELETE FROM medical_case WHERE case_id = ? AND doctor_id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, caseId);
            ps.setInt(2, doctorId);
            
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
 // 更新病例总费用
    public boolean updateTotalFee(int caseId, double totalFee) {
        String sql = "UPDATE medical_case SET total_fee = ? WHERE case_id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setDouble(1, totalFee);
            ps.setInt(2, caseId);
            
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
 // 根据关键词搜索病例（按病人姓名或症状）
    public List<MedicalCase> searchByKeyword(int doctorId, String keyword) {
        List<MedicalCase> list = new ArrayList<>();
        String sql = "SELECT c.*, p.name as patient_name " +
                     "FROM medical_case c " +
                     "LEFT JOIN patient p ON c.patient_id = p.patient_id " +
                     "WHERE c.doctor_id = ? " +
                     "AND (p.name LIKE ? OR c.symptom LIKE ?) " +
                     "ORDER BY c.visit_time DESC";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, doctorId);
            String likeKeyword = "%" + keyword + "%";
            ps.setString(2, likeKeyword);
            ps.setString(3, likeKeyword);
            
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapRow(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // 映射方法
    private MedicalCase mapRow(ResultSet rs) throws SQLException {
        MedicalCase medicalCase = new MedicalCase();
        medicalCase.setCaseId(rs.getInt("case_id"));
        medicalCase.setPatientId(rs.getInt("patient_id"));
        medicalCase.setDoctorId(rs.getInt("doctor_id"));
        medicalCase.setSymptom(rs.getString("symptom"));
        medicalCase.setVisitTime(rs.getTimestamp("visit_time"));
        medicalCase.setTotalFee(rs.getDouble("total_fee"));
        medicalCase.setPatientName(rs.getString("patient_name"));
        return medicalCase;
    }
}

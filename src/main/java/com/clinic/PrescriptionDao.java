package com.clinic.dao;

import com.clinic.model.Prescription;
import com.clinic.util.DBUtil;
import org.springframework.stereotype.Repository;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@Repository
public class PrescriptionDao {
    
    // 根据病例ID获取处方
    public List<Prescription> findByCaseId(int caseId) {
        List<Prescription> list = new ArrayList<>();
        String sql = "SELECT cm.*, m.medicine_name, m.description " +
                "FROM case_medicine cm " +
                "LEFT JOIN medicine m ON cm.medicine_id = m.medicine_id " +
                "WHERE cm.case_id = ? " +
                "ORDER BY cm.id";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, caseId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapRow(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    // 添加处方项
    public boolean add(Prescription prescription) {
        String sql = "INSERT INTO case_medicine (case_id, medicine_id, quantity, price) " +
                     "VALUES (?, ?, ?, ?)";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, prescription.getCaseId());
            ps.setInt(2, prescription.getMedicineId());
            ps.setInt(3, prescription.getQuantity());
            ps.setDouble(4, prescription.getPrice());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // 删除处方项
    public boolean delete(int id) {
        String sql = "DELETE FROM case_medicine WHERE id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // 删除病例的所有处方项
    public boolean deleteByCaseId(int caseId) {
        String sql = "DELETE FROM case_medicine WHERE case_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, caseId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // 计算病例总费用
    public double calculateTotalFee(int caseId) {
        String sql = "SELECT SUM(quantity * price) as total FROM case_medicine WHERE case_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, caseId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getDouble("total");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0.0;
    }
    
    // 映射方法
    private Prescription mapRow(ResultSet rs) throws SQLException {
        Prescription prescription = new Prescription();
        prescription.setId(rs.getInt("id"));
        prescription.setCaseId(rs.getInt("case_id"));
        prescription.setMedicineId(rs.getInt("medicine_id"));
        prescription.setMedicineName(rs.getString("medicine_name"));
        prescription.setDescription(rs.getString("description")); // 新增
        prescription.setQuantity(rs.getInt("quantity"));
        prescription.setPrice(rs.getDouble("price"));
        return prescription;
    }
}
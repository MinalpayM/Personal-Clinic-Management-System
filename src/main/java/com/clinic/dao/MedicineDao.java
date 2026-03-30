package com.clinic.dao;

import com.clinic.model.Medicine;
import com.clinic.util.DBUtil;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Repository;

@Repository
public class MedicineDao {
    
    // 查询所有药品
    public List<Medicine> findAll() {
        List<Medicine> medicines = new ArrayList<>();
        String sql = "SELECT * FROM medicine ORDER BY medicine_id DESC";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                Medicine medicine = new Medicine();
                medicine.setMedicineId(rs.getInt("medicine_id"));
                medicine.setMedicineName(rs.getString("medicine_name"));
                medicine.setPrice(rs.getDouble("price"));
                medicine.setStock(rs.getInt("stock"));
                medicine.setDescription(rs.getString("description"));
                medicine.setCreateTime(rs.getTimestamp("create_time"));
                medicines.add(medicine);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return medicines;
    }
    
    // 根据ID查询药品
    public Medicine findById(int medicineId) {
        String sql = "SELECT * FROM medicine WHERE medicine_id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, medicineId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Medicine medicine = new Medicine();
                    medicine.setMedicineId(rs.getInt("medicine_id"));
                    medicine.setMedicineName(rs.getString("medicine_name"));
                    medicine.setPrice(rs.getDouble("price"));
                    medicine.setStock(rs.getInt("stock"));
                    medicine.setDescription(rs.getString("description"));
                    medicine.setCreateTime(rs.getTimestamp("create_time"));
                    return medicine;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    
    // 添加药品
    public boolean insert(Medicine medicine) {
        String sql = "INSERT INTO medicine (medicine_name, price, stock, description) VALUES (?, ?, ?, ?)";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, medicine.getMedicineName());
            ps.setDouble(2, medicine.getPrice());
            ps.setInt(3, medicine.getStock());
            ps.setString(4, medicine.getDescription());
            
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // 更新药品
    public boolean update(Medicine medicine) {
        String sql = "UPDATE medicine SET medicine_name = ?, price = ?, stock = ?, description = ? WHERE medicine_id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, medicine.getMedicineName());
            ps.setDouble(2, medicine.getPrice());
            ps.setInt(3, medicine.getStock());
            ps.setString(4, medicine.getDescription());
            ps.setInt(5, medicine.getMedicineId());
            
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    // 删除药品
    public boolean delete(int medicineId) {
        String sql = "DELETE FROM medicine WHERE medicine_id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, medicineId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // 搜索药品
    public List<Medicine> search(String keyword) {
        List<Medicine> medicines = new ArrayList<>();
        String sql = "SELECT * FROM medicine WHERE medicine_name LIKE ? OR description LIKE ? ORDER BY medicine_id DESC";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            String searchPattern = "%" + keyword + "%";
            ps.setString(1, searchPattern);
            ps.setString(2, searchPattern);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Medicine medicine = new Medicine();
                    medicine.setMedicineId(rs.getInt("medicine_id"));
                    medicine.setMedicineName(rs.getString("medicine_name"));
                    medicine.setPrice(rs.getDouble("price"));
                    medicine.setStock(rs.getInt("stock"));
                    medicine.setDescription(rs.getString("description"));
                    medicine.setCreateTime(rs.getTimestamp("create_time"));
                    medicines.add(medicine);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return medicines;
    }
    
    // 查询库存不足的药品
    public List<Medicine> findLowStock(int threshold) {
        List<Medicine> medicines = new ArrayList<>();
        String sql = "SELECT * FROM medicine WHERE stock < ? ORDER BY stock ASC, medicine_id DESC";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, threshold);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Medicine medicine = new Medicine();
                    medicine.setMedicineId(rs.getInt("medicine_id"));
                    medicine.setMedicineName(rs.getString("medicine_name"));
                    medicine.setPrice(rs.getDouble("price"));
                    medicine.setStock(rs.getInt("stock"));
                    medicine.setDescription(rs.getString("description"));
                    medicine.setCreateTime(rs.getTimestamp("create_time"));
                    medicines.add(medicine);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return medicines;
    }

    // 统计库存不足药品数量
    public int countLowStock(int threshold) {
        String sql = "SELECT COUNT(*) as count FROM medicine WHERE stock < ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, threshold);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("count");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return 0;
    }

    public boolean updateStock(int medicineId, int newStock) {
        String sql = "UPDATE medicine SET stock = ? WHERE medicine_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, newStock);
            ps.setInt(2, medicineId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
} 
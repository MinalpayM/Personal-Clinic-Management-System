package com.clinic.dao;

import com.clinic.model.SysUser;
import com.clinic.util.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;
@Repository
public class UserDao {

    public SysUser findByUsername(String username) {
        String sql = "SELECT * FROM sys_user WHERE username = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                SysUser user = new SysUser();
                user.setUserId(rs.getInt("user_id"));
                user.setUsername(rs.getString("username"));
                user.setPassword(rs.getString("password"));
                user.setRole(rs.getString("role"));
                user.setDoctorId(rs.getInt("doctor_id"));
                user.setStatus(rs.getInt("status"));
                return user;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    
    // 查询所有用户
    public List<SysUser> findAll() {
        List<SysUser> list = new ArrayList<>();
        String sql = "SELECT * FROM sys_user ORDER BY user_id DESC";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                list.add(mapRow(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
 // 根据ID查询用户
    public SysUser findById(int userId) {
        String sql = "SELECT * FROM sys_user WHERE user_id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                return mapRow(rs);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    
    // 新增用户
    public boolean insert(SysUser user) {
        String sql = "INSERT INTO sys_user (username, password, role, doctor_id, status, create_time) " +
                    "VALUES (?, ?, ?, ?, ?, NOW())";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, user.getUsername());
            ps.setString(2, user.getPassword());
            ps.setString(3, user.getRole());
            
            if (user.getDoctorId() != null) {
                ps.setInt(4, user.getDoctorId());
            } else {
                ps.setNull(4, Types.INTEGER);
            }
            
            ps.setInt(5, user.getStatus());
            
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // 更新用户
    public boolean update(SysUser user) {
        String sql = "UPDATE sys_user SET username = ?, password = ?, role = ?, " +
                    "doctor_id = ?, status = ? WHERE user_id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, user.getUsername());
            ps.setString(2, user.getPassword());
            ps.setString(3, user.getRole());
            
            if (user.getDoctorId() != null) {
                ps.setInt(4, user.getDoctorId());
            } else {
                ps.setNull(4, Types.INTEGER);
            }
            
            ps.setInt(5, user.getStatus());
            ps.setInt(6, user.getUserId());
            
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // 删除用户
    public boolean delete(int userId) {
        String sql = "DELETE FROM sys_user WHERE user_id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, userId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
	// 检查用户名是否已存在
    public boolean isUsernameExists(String username, Integer excludeUserId) {
        String sql = "SELECT COUNT(*) FROM sys_user WHERE username = ?";
        
        if (excludeUserId != null) {
            sql += " AND user_id != ?";
        }
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, username);
            
            if (excludeUserId != null) {
                ps.setInt(2, excludeUserId);
            }
            
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // 搜索用户
    public List<SysUser> search(String keyword) {
        List<SysUser> list = new ArrayList<>();
        String sql = "SELECT * FROM sys_user WHERE username LIKE ? OR role LIKE ? ORDER BY user_id DESC";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            String searchPattern = "%" + keyword + "%";
            ps.setString(1, searchPattern);
            ps.setString(2, searchPattern);
            
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapRow(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    // 统计用户数量
    public int count() {
        String sql = "SELECT COUNT(*) FROM sys_user";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }
    
    // 获取所有医生用户（用于关联选择）
    public List<SysUser> findAllDoctors() {
        List<SysUser> list = new ArrayList<>();
        String sql = "SELECT u.* FROM sys_user u " +
                     "INNER JOIN doctor d ON u.doctor_id = d.doctor_id " +
                     "WHERE u.role = 'doctor' ORDER BY u.user_id DESC";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(mapRow(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
 // 获取所有医生信息（从doctor表）
    public List<Map<String, Object>> findAllDoctorInfo() {
        List<Map<String, Object>> list = new ArrayList<>();
        String sql = "SELECT doctor_id, name, title FROM doctor ORDER BY doctor_id DESC";
        
        System.out.println("=== 开始查询医生数据 ===");
        System.out.println("SQL: " + sql);
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            int count = 0;
            while (rs.next()) {
                Map<String, Object> doctor = new HashMap<>();
                doctor.put("doctorId", rs.getInt("doctor_id"));
                doctor.put("name", rs.getString("name"));
                doctor.put("title", rs.getString("title"));
                list.add(doctor);
                
                System.out.println("找到医生: ID=" + rs.getInt("doctor_id") + 
                                 ", 姓名=" + rs.getString("name") + 
                                 ", 职称=" + rs.getString("title"));
                count++;
            }
            System.out.println("总共找到 " + count + " 个医生");
            
        } catch (Exception e) {
            System.out.println("查询医生信息失败: " + e.getMessage());
            e.printStackTrace();
        }
        
        System.out.println("返回医生列表大小: " + list.size());
        return list;
    }
    
    // 映射方法
    private SysUser mapRow(ResultSet rs) throws SQLException {
        SysUser user = new SysUser();
        user.setUserId(rs.getInt("user_id"));
        user.setUsername(rs.getString("username"));
        user.setPassword(rs.getString("password"));
        user.setRole(rs.getString("role"));
        user.setDoctorId(rs.getInt("doctor_id"));
        if (rs.wasNull()) {
            user.setDoctorId(null);
        }
        user.setStatus(rs.getInt("status"));
        user.setCreateTime(rs.getTimestamp("create_time"));
        return user;
    }
   
}
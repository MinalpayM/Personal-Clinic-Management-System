package com.clinic.dao;

import com.clinic.model.Doctor;
import com.clinic.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import org.springframework.stereotype.Repository;


@Repository
public class DoctorDao {

    // 查询全部医生
    public List<Doctor> findAll() {
        List<Doctor> list = new ArrayList<>();
        String sql = "SELECT * FROM doctor ORDER BY doctor_id DESC";

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

    // 新增医生
    public void addDoctor(Doctor d) {
        String sql = "INSERT INTO doctor(name, gender, birth_date, title, salary, phone, address, id_card, create_time, avatar) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, NOW(), ?)";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, d.getName());
            ps.setString(2, d.getGender());
            ps.setDate(3, new java.sql.Date(d.getBirthDate().getTime()));
            ps.setString(4, d.getTitle());
            ps.setDouble(5, d.getSalary());
            ps.setString(6, d.getPhone());
            ps.setString(7, d.getAddress());
            ps.setString(8, d.getIdCard());
            ps.setString(9, d.getAvatar());

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // 根据 ID 查询
    public Doctor findById(int id) {
        String sql = "SELECT * FROM doctor WHERE doctor_id=?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) return mapRow(rs);

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // 更新医生
    public void updateDoctor(Doctor d) {
        String sql = "UPDATE doctor SET name=?, gender=?, birth_date=?, title=?, salary=?, phone=?, address=?, id_card=?, avatar=? WHERE doctor_id=?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, d.getName());
            ps.setString(2, d.getGender());
            ps.setDate(3, new java.sql.Date(d.getBirthDate().getTime()));
            ps.setString(4, d.getTitle());
            ps.setDouble(5, d.getSalary());
            ps.setString(6, d.getPhone());
            ps.setString(7, d.getAddress());
            ps.setString(8, d.getIdCard());
            ps.setString(9, d.getAvatar());
            ps.setInt(10, d.getDoctorId());

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // 删除医生
    public void deleteDoctor(int id) {
        String sql = "DELETE FROM doctor WHERE doctor_id=?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // 统计医生数量
    public int countDoctors() {
        String sql = "SELECT COUNT(*) FROM doctor";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) return rs.getInt(1);

        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }
 // 多条件搜索
    public List<Doctor> search(String keyword, String title) {
        List<Doctor> list = new ArrayList<>();
        String sql = "SELECT * FROM doctor WHERE 1=1";

        if (keyword != null && !keyword.isEmpty()) {
            sql += " AND (name LIKE ? OR phone LIKE ? OR id_card LIKE ?)";
        }
        if (title != null && !title.isEmpty()) {
            sql += " AND title=?";
        }

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            int idx = 1;

            if (keyword != null && !keyword.isEmpty()) {
                ps.setString(idx++, "%" + keyword + "%");
                ps.setString(idx++, "%" + keyword + "%");
                ps.setString(idx++, "%" + keyword + "%");
            }
            if (title != null && !title.isEmpty()) {
                ps.setString(idx++, title);
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(mapRow(rs));

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // 映射方法
    private Doctor mapRow(ResultSet rs) throws Exception {
        Doctor d = new Doctor();
        d.setDoctorId(rs.getInt("doctor_id"));
        d.setName(rs.getString("name"));
        d.setGender(rs.getString("gender"));
        d.setBirthDate(rs.getDate("birth_date"));
        d.setTitle(rs.getString("title"));
        d.setSalary(rs.getDouble("salary"));
        d.setPhone(rs.getString("phone"));
        d.setAddress(rs.getString("address"));
        d.setIdCard(rs.getString("id_card"));
        d.setCreateTime(rs.getTimestamp("create_time"));
        d.setAvatar(rs.getString("avatar"));
        return d;
    }
}

    
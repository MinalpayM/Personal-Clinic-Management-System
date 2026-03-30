package com.clinic.util;

public class ValidatorUtil {

    // 校验用户名：字母或数字，长度 5~10，不能以数字开头
    public static boolean isValidUsername(String username) {
        if (username == null) return false;
        return username.matches("^[A-Za-z][A-Za-z0-9]{4,9}$");
    }

    // 校验密码：长度 5~15，必须包含字母和数字
    public static boolean isValidPassword(String password) {
        if (password == null) return false;
        return password.matches("^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{5,15}$");
    }

    // 校验电话：必须是 11 位数字
    public static boolean isValidPhone(String phone) {
        if (phone == null) return false;
        return phone.matches("^\\d{11}$");
    }

    // 校验身份证：18 位，前 17 位数字，最后一位可以是数字或 X
    public static boolean isValidIdCard(String idCard) {
        if (idCard == null) return false;
        return idCard.matches("^\\d{17}[\\dXx]$");
    }
}

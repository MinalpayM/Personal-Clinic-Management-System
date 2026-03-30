<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/jsp/common/header.jsp" %>

<style>
    .edit-wrapper {
        width: 520px;
        margin: 20px auto;
        font-family: Arial, sans-serif;
    }
    .edit-wrapper h3 {
        text-align: center;
        color: #1e88e5;
        margin-bottom: 20px;
    }
    .edit-form {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 6px;
    }
    .edit-form label {
        grid-column: span 2;
        font-size: 13px;
        color: #666;
    }
    .edit-form input,
    .edit-form select {
        padding: 8px;
        border: 1px solid #ccc;
        border-radius: 5px;
        font-size: 14px;
    }
    .edit-form .full {
        grid-column: span 2;
    }
    .avatar-box {
        grid-column: span 2;
        display: flex;
        align-items: center;
        gap: 15px;
    }
    .avatar-box img {
        width: 80px;
        height: 80px;
        border-radius: 50%;
        object-fit: cover;
        border: 1px solid #ddd;
    }
    .hint {
        grid-column: span 2;
        font-size: 12px;
        color: #9aa0a6;
        margin-top: 3px;
    }
    #errorBox {
        grid-column: span 2;
        display: none;
        background: #fce8e6;
        color: #c5221f;
        padding: 10px;
        border-radius: 6px;
        margin-bottom: 12px;
        font-size: 14px;
        line-height: 1.5;
    }
    .btn-area {
        grid-column: span 2;
        display: flex;
        justify-content: center;
        margin-top: 15px;
    }
    .btn {
        background: #1e88e5;
        color: white;
        border: none;
        padding: 10px 28px;
        border-radius: 6px;
        cursor: pointer;
        font-size: 15px;
    }
    .btn:hover {
        background: #1565c0;
    }
    .error-field {
        border-color: #e53935 !important;
    }
</style>

<div class="edit-wrapper">

    <h3>编辑医生信息</h3>

    <!-- 错误提示框 -->
    <div id="errorBox"></div>

    <form id="editForm"
          class="edit-form"
          method="post"
          action="${pageContext.request.contextPath}/admin/doctor/update"
          enctype="multipart/form-data">

        <input type="hidden" name="doctorId" value="${doctor.doctorId}">

        <label>姓名 *</label>
        <input name="name" value="${doctor.name}" required>

        <label>性别 *</label>
        <select name="gender" required>
            <option value="" disabled>请选择性别</option>
            <option value="M" ${doctor.gender == 'M' ? 'selected' : ''}>男</option>
            <option value="F" ${doctor.gender == 'F' ? 'selected' : ''}>女</option>
        </select>

        <label>出生日期</label>
        <input type="date" name="birthDate" value="${doctor.birthDate}">

        <label>职称</label>
        <input name="title" value="${doctor.title}">

        <label>薪资</label>
        <input type="number" step="0.01" name="salary" value="${doctor.salary}">

        <label>联系电话 *</label>
        <input name="phone" value="${doctor.phone}" required pattern="\d{11}">
        <div class="hint">电话需为 11 位数字</div>

        <label>联系地址</label>
        <input class="full" name="address" value="${doctor.address}">

        <label>身份证号 *</label>
        <input class="full" name="idCard" value="${doctor.idCard}" required pattern="[0-9]{17}[0-9Xx]">
        <div class="hint">身份证需为 18 位，前 17 位数字，最后一位数字或 X/x</div>

        <label>头像</label>
        <div class="avatar-box">
            <c:choose>
                <c:when test="${not empty doctor.avatar}">
                    <img src="${pageContext.request.contextPath}/${doctor.avatar}">
                </c:when>
                <c:otherwise>
                    <img src="${pageContext.request.contextPath}/images/default.png">
                </c:otherwise>
            </c:choose>

            <input type="file" name="avatarFile" accept="image/*">
        </div>

        <div class="btn-area">
    <button type="button"  class="btn" onclick="submitEdit()">保存修改</button>
</div>


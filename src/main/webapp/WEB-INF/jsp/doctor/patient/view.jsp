<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    com.clinic.model.Patient patient = (com.clinic.model.Patient)request.getAttribute("patient");
    
    // 格式化日期
    String birthDateStr = "";
    String createTimeStr = "";
    
    if (patient != null) {
        java.text.SimpleDateFormat dateSdf = new java.text.SimpleDateFormat("yyyy年MM月dd日");
        java.text.SimpleDateFormat timeSdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm");
        
        if (patient.getBirthDate() != null) {
            birthDateStr = dateSdf.format(patient.getBirthDate());
        }
        
        if (patient.getCreateTime() != null) {
            createTimeStr = timeSdf.format(patient.getCreateTime());
        }
        
        // 计算年龄
        if (patient.getBirthDate() != null) {
            java.util.Calendar birthCal = java.util.Calendar.getInstance();
            birthCal.setTime(patient.getBirthDate());
            java.util.Calendar nowCal = java.util.Calendar.getInstance();
            
            int age = nowCal.get(java.util.Calendar.YEAR) - birthCal.get(java.util.Calendar.YEAR);
            if (nowCal.get(java.util.Calendar.DAY_OF_YEAR) < birthCal.get(java.util.Calendar.DAY_OF_YEAR)) {
                age--;
            }
            request.setAttribute("age", age);
        }
    }
%>

<style>
    .patient-detail-grid {
        display: grid;
        grid-template-columns: 120px 1fr;
        gap: 15px;
        margin-bottom: 15px;
    }
    
    .detail-label {
        font-weight: bold;
        color: #666;
        text-align: right;
    }
    
    .detail-value {
        color: #333;
        padding: 5px 0;
    }
    
    .section-title {
        font-size: 16px;
        font-weight: bold;
        color: #1e88e5;
        margin: 25px 0 15px 0;
        padding-bottom: 8px;
        border-bottom: 2px solid #e0e0e0;
    }
    
    .patient-card {
        background: #fff;
        border-radius: 8px;
        box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        overflow: hidden;
    }
    
    .patient-header {
        background: linear-gradient(135deg, #1e88e5, #42a5f5);
        color: white;
        padding: 20px;
        text-align: center;
    }
    
    .patient-name {
        font-size: 24px;
        font-weight: bold;
        margin-bottom: 5px;
    }
    
    .patient-id {
        font-size: 14px;
        opacity: 0.9;
    }
    
    .patient-body {
        padding: 20px;
    }
    
    .info-group {
        margin-bottom: 20px;
        padding: 15px;
        background: #f8f9fa;
        border-radius: 6px;
        border-left: 4px solid #1e88e5;
    }
    
    .info-group h4 {
        margin: 0 0 10px 0;
        color: #333;
        font-size: 14px;
        text-transform: uppercase;
        letter-spacing: 1px;
    }
</style>

<c:if test="${not empty patient}">
    <div class="patient-card">
        <div class="patient-header">
            <div class="patient-name">${patient.name}</div>
            <div class="patient-id">ID: ${patient.patientId}</div>
        </div>
        
        <div class="patient-body">
            <div class="info-group">
                <h4>基本信息</h4>
                <div class="patient-detail-grid">
                    <div class="detail-label">姓名：</div>
                    <div class="detail-value">${patient.name}</div>
                    
                    <div class="detail-label">性别：</div>
                    <div class="detail-value">${patient.gender == 'M' ? '男' : '女'}</div>
                    
                    <div class="detail-label">出生日期：</div>
                    <div class="detail-value"><%= birthDateStr %></div>
                    
                    <c:if test="${not empty age}">
                        <div class="detail-label">年龄：</div>
                        <div class="detail-value">${age}岁</div>
                    </c:if>
                </div>
            </div>
            
            <div class="info-group">
                <h4>联系信息</h4>
                <div class="patient-detail-grid">
                    <div class="detail-label">联系电话：</div>
                    <div class="detail-value">${patient.phone}</div>
                    
                    <div class="detail-label">身份证号：</div>
                    <div class="detail-value">${patient.idCard}</div>
                    
                    <div class="detail-label">联系地址：</div>
                    <div class="detail-value">${not empty patient.address ? patient.address : '未填写'}</div>
                </div>
            </div>
            
            <div class="info-group">
                <h4>系统信息</h4>
                <div class="patient-detail-grid">
                    <div class="detail-label">登记时间：</div>
                    <div class="detail-value"><%= createTimeStr %></div>
                    
                    <div class="detail-label">负责医生：</div>
                    <div class="detail-value">${sessionScope.user.username}</div>
                </div>
            </div>
        </div>
    </div>
</c:if>
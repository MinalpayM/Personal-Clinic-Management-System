<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/WEB-INF/jsp/common/doctor_header.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>编辑病例 - #${medicalCase.caseId}</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f5f6f7;
            color: #333;
            line-height: 1.6;
        }
        
        .container {
            max-width: 1000px;
            margin: 100px auto 30px;
            background: white;
            border-radius: 12px;
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }
        
        .header {
            background: linear-gradient(135deg, #ff9800, #ffb74d);
            color: white;
            padding: 25px 30px;
            border-bottom: 1px solid #e0e0e0;
        }
        
        .header h1 {
            margin: 0;
            font-size: 24px;
            font-weight: 600;
        }
        
        .header p {
            margin: 8px 0 0;
            opacity: 0.9;
            font-size: 14px;
        }
        
        .content {
            padding: 30px;
        }
        
        .form-section {
            margin-bottom: 30px;
        }
        
        .section-title {
            font-size: 18px;
            font-weight: 600;
            color: #ff9800;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 2px solid #e0e0e0;
            display: flex;
            align-items: center;
        }
        
        .section-title i {
            margin-right: 10px;
            font-size: 20px;
        }
        
        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 25px;
            margin-bottom: 20px;
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        .form-group.full-width {
            grid-column: 1 / -1;
        }
        
        label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #444;
            font-size: 14px;
        }
        
        .required::after {
            content: " *";
            color: #e53935;
        }
        
        input, select, textarea {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 14px;
            font-family: inherit;
            transition: all 0.3s ease;
            background: #fafafa;
        }
        
        input:focus, select:focus, textarea:focus {
            outline: none;
            border-color: #ff9800;
            background: white;
            box-shadow: 0 0 0 3px rgba(255, 152, 0, 0.1);
        }
        
        textarea {
            min-height: 150px;
            resize: vertical;
            line-height: 1.5;
        }
        
        select {
            appearance: none;
            background-image: url("data:image/svg+xml;charset=UTF-8,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='none' stroke='currentColor' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3e%3cpolyline points='6 9 12 15 18 9'%3e%3c/polyline%3e%3c/svg%3e");
            background-repeat: no-repeat;
            background-position: right 15px center;
            background-size: 16px;
            padding-right: 40px;
        }
        
        .form-hint {
            color: #666;
            font-size: 12px;
            margin-top: 5px;
            font-style: italic;
        }
        
        .error {
            color: #e53935;
            font-size: 12px;
            margin-top: 5px;
            display: none;
        }
        
        .btn-group {
            display: flex;
            gap: 15px;
            margin-top: 40px;
            padding-top: 25px;
            border-top: 1px solid #e0e0e0;
            justify-content: flex-end;
        }
        
        .btn {
            padding: 12px 30px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 14px;
            font-weight: 600;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
        }
        
        .btn i {
            font-size: 16px;
        }
        
        .btn-primary {
            background: linear-gradient(135deg, #ff9800, #ffb74d);
            color: white;
        }
        
        .btn-primary:hover {
            background: linear-gradient(135deg, #ef6c00, #ff9800);
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(255, 152, 0, 0.3);
        }
        
        .btn-secondary {
            background: #f5f5f5;
            color: #666;
        }
        
        .btn-secondary:hover {
            background: #e0e0e0;
        }
        
        .case-info-card {
            background: #fff8e1;
            border-radius: 8px;
            padding: 20px;
            border-left: 4px solid #ff9800;
            margin-bottom: 20px;
        }
        
        .case-info-row {
            display: flex;
            gap: 30px;
            margin-bottom: 10px;
        }
        
        .case-info-label {
            font-weight: 600;
            color: #666;
            min-width: 100px;
        }
        
        .case-info-value {
            color: #333;
        }
        
        .readonly-field {
            background: #f5f5f5;
            border-color: #ddd;
            color: #666;
            cursor: not-allowed;
        }
        
        .total-fee-display {
            font-size: 18px;
            font-weight: 600;
            color: #43a047;
            padding: 10px 15px;
            background: #e8f5e9;
            border-radius: 8px;
            display: inline-block;
        }
        
        @media (max-width: 768px) {
            .container {
                margin: 90px 15px 30px;
            }
            
            .content {
                padding: 20px;
            }
            
            .form-row {
                grid-template-columns: 1fr;
                gap: 15px;
            }
            
            .btn-group {
                flex-direction: column;
            }
            
            .btn {
                width: 100%;
            }
        }
    </style>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <div class="container">
        <div class="header">
            <h1><i class="fas fa-edit"></i> 编辑病例</h1>
            <p>病例编号: #${medicalCase.caseId} | 就诊时间: 
               <fmt:formatDate value="${medicalCase.visitTime}" pattern="yyyy-MM-dd HH:mm" />
            </p>
        </div>
        
        <div class="content">
            <!-- 病例基本信息卡片 -->
            <div class="case-info-card">
                <h4 style="margin-bottom: 15px; color: #ff9800;">
                    <i class="fas fa-info-circle"></i> 病例基本信息
                </h4>
                <div class="case-info-row">
                    <div>
                        <span class="case-info-label">病例编号：</span>
                        <span class="case-info-value">#${medicalCase.caseId}</span>
                    </div>
                    <div>
                        <span class="case-info-label">就诊时间：</span>
                        <span class="case-info-value">
                            <fmt:formatDate value="${medicalCase.visitTime}" pattern="yyyy-MM-dd HH:mm" />
                        </span>
                    </div>
                </div>
                <div class="case-info-row">
                    <div>
                        <span class="case-info-label">当前状态：</span>
                        <span class="case-info-value">
                            <c:choose>
                                <c:when test="${medicalCase.totalFee > 0}">
                                    <span style="color: #43a047; font-weight: 600;">已开药（总费用：¥<fmt:formatNumber value="${medicalCase.totalFee}" pattern="#,##0.00" />）</span>
                                </c:when>
                                <c:otherwise>
                                    <span style="color: #ff9800; font-weight: 600;">未开药</span>
                                </c:otherwise>
                            </c:choose>
                        </span>
                    </div>
                </div>
            </div>
            
            <form id="editForm" onsubmit="return false;">
                <input type="hidden" id="caseId" name="caseId" value="${medicalCase.caseId}">
                <input type="hidden" id="doctorId" name="doctorId" value="${doctorId}">
                
                <div class="form-section">
                    <div class="section-title">
                        <i class="fas fa-user-injured"></i> 病人信息
                    </div>
                    
                    <div class="form-group full-width">
                        <label for="patientSelect" class="required">选择病人</label>
                        <select id="patientSelect" name="patientId" required disabled class="readonly-field">
                            <option value="">请选择病人...</option>
                            <c:forEach items="${patients}" var="patient">
                                <%
                                    // 计算年龄
                                    com.clinic.model.Patient p = (com.clinic.model.Patient)pageContext.getAttribute("patient");
                                    int age = 0;
                                    if (p.getBirthDate() != null) {
                                        java.util.Calendar birth = java.util.Calendar.getInstance();
                                        birth.setTime(p.getBirthDate());
                                        java.util.Calendar now = java.util.Calendar.getInstance();
                                        age = now.get(java.util.Calendar.YEAR) - birth.get(java.util.Calendar.YEAR);
                                        if (now.get(java.util.Calendar.MONTH) < birth.get(java.util.Calendar.MONTH) ||
                                            (now.get(java.util.Calendar.MONTH) == birth.get(java.util.Calendar.MONTH) &&
                                             now.get(java.util.Calendar.DAY_OF_MONTH) < birth.get(java.util.Calendar.DAY_OF_MONTH))) {
                                            age--;
                                        }
                                    }
                                    pageContext.setAttribute("patientAge", age);
                                %>
                                <option value="${patient.patientId}" 
                                        ${medicalCase.patientId == patient.patientId ? 'selected' : ''}
                                        data-name="${patient.name}"
                                        data-gender="${patient.gender}"
                                        data-age="${patientAge}"
                                        data-phone="${patient.phone}"
                                        data-idcard="${patient.idCard}">
                                    ${patient.name} (${patient.gender == 'M' ? '男' : '女'}, ${patientAge}岁, ${patient.phone})
                                </option>
                            </c:forEach>
                        </select>
                        <div class="form-hint">病人信息在创建病例后不可更改</div>
                    </div>
                    
                    <!-- 病人信息展示 -->
                    <div id="patientInfo" class="case-info-card">
                        <h4 style="margin-bottom: 15px; color: #ff9800;">
                            <i class="fas fa-info-circle"></i> 病人信息
                        </h4>
                        <div class="case-info-row">
                            <div>
                                <span class="case-info-label">姓名：</span>
                                <span class="case-info-value" id="patientName">-</span>
                            </div>
                            <div>
                                <span class="case-info-label">性别：</span>
                                <span class="case-info-value" id="patientGender">-</span>
                            </div>
                            <div>
                                <span class="case-info-label">年龄：</span>
                                <span class="case-info-value" id="patientAge">-</span>
                            </div>
                        </div>
                        <div class="case-info-row">
                            <div>
                                <span class="case-info-label">电话：</span>
                                <span class="case-info-value" id="patientPhone">-</span>
                            </div>
                            <div>
                                <span class="case-info-label">身份证号：</span>
                                <span class="case-info-value" id="patientIdCard">-</span>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="form-section">
    <div class="section-title">
        <i class="fas fa-pills"></i> 处方信息
    </div>
    <div class="form-group">
        <label>当前总费用</label>
        <div class="total-fee-display">
            ¥<fmt:formatNumber value="${medicalCase.totalFee}" pattern="#,##0.00"/>
        </div>
        <div class="form-hint">
            <c:choose>
                <c:when test="${medicalCase.totalFee > 0}">
                    <div style="margin-bottom: 10px;">
                        已开药，可查看或修改处方信息：
                    </div>
                    <div style="display: flex; gap: 10px; flex-wrap: wrap;">
                        <a href="${pageContext.request.contextPath}/doctor/prescription/detail/${medicalCase.caseId}"
                           class="btn btn-sm" style="background: #1e88e5; color: white; padding: 8px 15px;">
                            <i class="fas fa-prescription-bottle-alt"></i> 查看/修改药品
                        </a>
                        <a href="${pageContext.request.contextPath}/doctor/prescription/detail/${medicalCase.caseId}?edit=true"
                           class="btn btn-sm" style="background: #ff9800; color: white; padding: 8px 15px;">
                            <i class="fas fa-edit"></i> 直接编辑药品
                        </a>
                        <button type="button" class="btn btn-sm" onclick="viewPrescription()" 
                                style="background: #43a047; color: white; padding: 8px 15px;">
                            <i class="fas fa-eye"></i> 预览处方
                        </button>
                    </div>
                </c:when>
                <c:otherwise>
                    尚未开药，请前往 <a href="${pageContext.request.contextPath}/doctor/prescription/detail/${medicalCase.caseId}"
                       style="color: #1e88e5; font-weight: 600;">开药页面</a> 添加药品
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>
                
                <div class="btn-group">
    <button type="button" class="btn btn-secondary" onclick="cancelEdit()">
        <i class="fas fa-times"></i> 取消
    </button>
    
    <%-- 如果已经有药品，显示开药按钮 --%>
    <c:if test="${medicalCase.totalFee > 0}">
        <button type="button" class="btn btn-warning" onclick="goToPrescription()">
            <i class="fas fa-prescription-bottle-alt"></i> 修改药品
        </button>
    </c:if>
    
    <button type="button" class="btn btn-primary" onclick="updateCase()">
        <i class="fas fa-save"></i> 保存病例
    </button>
</div>
    
    <!-- Toast提示 -->
    <div id="toast" style="position: fixed; top: 20px; right: 20px; background: #333; color: white; padding: 15px 25px;
                           border-radius: 5px; display: none; z-index: 10000; box-shadow: 0 4px 12px rgba(0,0,0,0.15);"></div>
    
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // 初始化显示病人信息
            const patientSelect = document.getElementById('patientSelect');
            const selectedOption = patientSelect.options[patientSelect.selectedIndex];
            
            if (selectedOption && selectedOption.value) {
                document.getElementById('patientInfo').style.display = 'block';
                document.getElementById('patientName').textContent = selectedOption.dataset.name;
                document.getElementById('patientGender').textContent = selectedOption.dataset.gender === 'M' ? '男' : '女';
                document.getElementById('patientAge').textContent = selectedOption.dataset.age + '岁';
                document.getElementById('patientPhone').textContent = selectedOption.dataset.phone;
                document.getElementById('patientIdCard').textContent = selectedOption.dataset.idcard;
            }
            
            // 监听症状输入
            const symptomTextarea = document.getElementById('symptom');
            const originalSymptom = symptomTextarea.value.trim();
            
            symptomTextarea.addEventListener('input', function() {
                const currentValue = this.value.trim();
                if (currentValue !== originalSymptom && currentValue.length >= 5) {
                    this.style.borderColor = '#4caf50';
                    this.style.boxShadow = '0 0 0 3px rgba(76, 175, 80, 0.1)';
                } else {
                    this.style.borderColor = '#e0e0e0';
                    this.style.boxShadow = 'none';
                }
            });
        });
        
        // 表单验证
        function validateForm() {
            let isValid = true;
            
            // 清空错误信息
            document.querySelectorAll('.error').forEach(el => {
                el.style.display = 'none';
                el.textContent = '';
            });
            
            // 验证症状描述
            const symptom = document.getElementById('symptom').value.trim();
            if (!symptom) {
                showError('symptomError', '请输入症状描述');
                isValid = false;
            } else if (symptom.length < 5) {
                showError('symptomError', '症状描述至少需要5个字符');
                isValid = false;
            }
            
            return isValid;
        }
        
        function showError(elementId, message) {
            const errorElement = document.getElementById(elementId);
            errorElement.textContent = message;
            errorElement.style.display = 'block';
        }
        
        function viewPrescription() {
            window.open('${pageContext.request.contextPath}/doctor/prescription/detail/${medicalCase.caseId}?view=true', 
                        '_blank', 'width=1200,height=700');
        }
        
        function goToPrescription() {
            const url = '${pageContext.request.contextPath}/doctor/prescription/detail/${medicalCase.caseId}?edit=true&from=edit';
            window.location.href = url;
        }
        
        // 显示Toast提示
        function showToast(message, type = 'info') {
            const toast = document.getElementById('toast');
            toast.textContent = message;
            toast.style.display = 'block';
            
            // 设置颜色
            if (type === 'success') {
                toast.style.background = '#43a047';
            } else if (type === 'error') {
                toast.style.background = '#e53935';
            } else if (type === 'warning') {
                toast.style.background = '#ff9800';
            } else {
                toast.style.background = '#1e88e5';
            }
            
            // 3秒后隐藏
            setTimeout(() => {
                toast.style.display = 'none';
            }, 3000);
        }
        
        // 更新病例
        function updateCase() {
            if (!validateForm()) {
                showToast('请填写完整的病例信息', 'error');
                return;
            }
            
            const formData = new FormData(document.getElementById('editForm'));
            const data = Object.fromEntries(formData.entries());
            
            // 显示加载状态
            const submitBtn = document.querySelector('.btn-primary');
            const originalText = submitBtn.innerHTML;
            submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> 保存中...';
            submitBtn.disabled = true;
            
            fetch('${pageContext.request.contextPath}/doctor/prescription/edit', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: new URLSearchParams(data)
            })
            .then(response => response.text())
            .then(result => {
                if (result === 'ok') {
                    showToast('病例更新成功！', 'success');
                    setTimeout(() => {
                        window.location.href = '${pageContext.request.contextPath}/doctor/prescription';
                    }, 1500);
                } else if (result === 'error') {
                    showToast('更新失败，请稍后重试', 'error');
                } else if (result === 'login') {
                    showToast('请先登录', 'error');
                    setTimeout(() => {
                        window.location.href = '${pageContext.request.contextPath}/login';
                    }, 1500);
                } else if (result === 'permission_denied') {
                    showToast('没有权限修改此病例', 'error');
                } else {
                    showToast('未知错误: ' + result, 'error');
                }
            })
            .catch(error => {
                console.error('Error:', error);
                showToast('网络错误，请检查连接', 'error');
            })
            .finally(() => {
                submitBtn.innerHTML = originalText;
                submitBtn.disabled = false;
            });
        }
        
        // 取消编辑
        function cancelEdit() {
            if (isFormModified()) {
                if (confirm('您有未保存的修改，确定要取消吗？未保存的信息将丢失。')) {
                    goBack();
                }
            } else {
                goBack();
            }
        }
        
        // 检查表单是否被修改
        function isFormModified() {
            const originalSymptom = '${medicalCase.symptom}';
            const currentSymptom = document.getElementById('symptom').value.trim();
            
            return currentSymptom !== originalSymptom;
        }
        
        // 返回上一页
        function goBack() {
            if (document.referrer && document.referrer.includes('doctor/prescription')) {
                window.location.href = document.referrer;
            } else {
                window.location.href = '${pageContext.request.contextPath}/doctor/prescription';
            }
        }
        
        // 快捷键支持
        document.addEventListener('keydown', function(event) {
            // Ctrl + S 保存
            if (event.ctrlKey && event.key === 's') {
                event.preventDefault();
                updateCase();
            }
            
            // Esc 取消
            if (event.key === 'Escape') {
                cancelEdit();
            }
        });
        
    </script>
</body>
</html>
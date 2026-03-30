<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/jsp/common/doctor_header.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>新建病例</title>
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
            background: linear-gradient(135deg, #1e88e5, #42a5f5);
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
            color: #1e88e5;
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
            border-color: #1e88e5;
            background: white;
            box-shadow: 0 0 0 3px rgba(30, 136, 229, 0.1);
        }
        
        textarea {
            min-height: 120px;
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
            background: linear-gradient(135deg, #1e88e5, #42a5f5);
            color: white;
        }
        
        .btn-primary:hover {
            background: linear-gradient(135deg, #1565c0, #1e88e5);
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(30, 136, 229, 0.3);
        }
        
        .btn-secondary {
            background: #f5f5f5;
            color: #666;
        }
        
        .btn-secondary:hover {
            background: #e0e0e0;
        }
        
        .patient-info-card {
            background: #f8f9fa;
            border-radius: 8px;
            padding: 20px;
            border-left: 4px solid #1e88e5;
            margin-bottom: 20px;
        }
        
        .patient-info-row {
            display: flex;
            gap: 30px;
            margin-bottom: 10px;
        }
        
        .patient-info-label {
            font-weight: 600;
            color: #666;
            min-width: 100px;
        }
        
        .patient-info-value {
            color: #333;
        }
        
        .no-patients {
            text-align: center;
            padding: 40px 20px;
            color: #666;
        }
        
        .no-patients i {
            font-size: 48px;
            color: #ccc;
            margin-bottom: 15px;
            display: block;
        }
        
        .no-patients h3 {
            margin-bottom: 10px;
            color: #444;
        }
        
        .no-patients p {
            margin-bottom: 20px;
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
            <h1><i class="fas fa-file-medical"></i> 新建病例</h1>
            <p>为病人创建新的医疗病例记录</p>
        </div>
        
        <div class="content">
            <c:choose>
                <c:when test="${not empty patients}">
                    <div class="form-section">
                        <div class="section-title">
                            <i class="fas fa-user-injured"></i> 选择病人
                        </div>
                        
                        <div class="form-group full-width">
                            <label for="patientSelect" class="required">选择病人</label>
                            <select id="patientSelect" name="patientId" required>
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
           						 	data-name="${patient.name}"
            						data-gender="${patient.gender}"
            						data-age="${patientAge}"
            						data-phone="${patient.phone}"
            						data-idcard="${patient.idCard}">
        							${patient.name} (${patient.gender == 'M' ? '男' : '女'}, 
        							${patientAge}岁, ${patient.phone})
    							</option>
							</c:forEach>
                            </select>
                            <div class="form-hint">请从您的病人列表中选择一位病人</div>
                            <div class="error" id="patientError"></div>
                        </div>
                        
                        <!-- 病人信息展示 -->
                        <div id="patientInfo" class="patient-info-card" style="display: none;">
                            <h4 style="margin-bottom: 15px; color: #1e88e5;">
                                <i class="fas fa-info-circle"></i> 病人信息
                            </h4>
                            <div class="patient-info-row">
                                <div>
                                    <span class="patient-info-label">姓名：</span>
                                    <span class="patient-info-value" id="patientName">-</span>
                                </div>
                                <div>
                                    <span class="patient-info-label">性别：</span>
                                    <span class="patient-info-value" id="patientGender">-</span>
                                </div>
                                <div>
                                    <span class="patient-info-label">年龄：</span>
                                    <span class="patient-info-value" id="patientAge">-</span>
                                </div>
                            </div>
                            <div class="patient-info-row">
                                <div>
                                    <span class="patient-info-label">电话：</span>
                                    <span class="patient-info-value" id="patientPhone">-</span>
                                </div>
                                <div>
                                    <span class="patient-info-label">身份证号：</span>
                                    <span class="patient-info-value" id="patientIdCard">-</span>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <form id="caseForm" onsubmit="return false;">
                        <input type="hidden" id="patientId" name="patientId">
                        <input type="hidden" id="doctorId" name="doctorId" value="${doctorId}">
                        
                        <div class="form-section">
                            <div class="section-title">
                                <i class="fas fa-stethoscope"></i> 病情信息
                            </div>
                            
                            <div class="form-group full-width">
                                <label for="symptom" class="required">症状描述</label>
                                <textarea id="symptom" name="symptom" 
                                          placeholder="请详细描述病人的症状，包括发病时间、部位、性质、持续时间等..."
                                          required></textarea>
                                <div class="form-hint">例如：发热3天，体温最高39℃，伴有咳嗽、咳黄痰</div>
                                <div class="error" id="symptomError"></div>
                            </div>
                            
                            
                        </div>
                        
                        
                        <div class="btn-group">
                            <button type="button" class="btn btn-secondary" onclick="cancelCreate()">
                                <i class="fas fa-times"></i> 取消
                            </button>
                            <button type="button" class="btn btn-primary" onclick="createCase()">
                                <i class="fas fa-save"></i> 创建病例
                            </button>
                        </div>
                    </form>
                </c:when>
                
                <c:otherwise>
                    <div class="no-patients">
                        <i class="fas fa-user-slash"></i>
                        <h3>暂无病人信息</h3>
                        <p>您还没有添加任何病人，请先添加病人后再创建病例。</p>
                        <button class="btn btn-primary" onclick="goToPatientManagement()">
                            <i class="fas fa-user-plus"></i> 去管理病人
                        </button>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
    
    <!-- Toast提示 -->
    <div id="toast" style="position: fixed; top: 20px; right: 20px; background: #333; color: white; padding: 15px 25px; 
          border-radius: 5px; display: none; z-index: 10000; box-shadow: 0 4px 12px rgba(0,0,0,0.15);"></div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // 病人选择事件
            const patientSelect = document.getElementById('patientSelect');
            if (patientSelect) {
                patientSelect.addEventListener('change', function() {
                    const selectedOption = this.options[this.selectedIndex];
                    
                    if (selectedOption.value) {
                        // 显示病人信息
                        document.getElementById('patientInfo').style.display = 'block';
                        
                        // 更新显示的信息
                        document.getElementById('patientName').textContent = selectedOption.dataset.name;
                        document.getElementById('patientGender').textContent = selectedOption.dataset.gender === 'M' ? '男' : '女';
                        document.getElementById('patientAge').textContent = selectedOption.dataset.age + '岁';
                        document.getElementById('patientPhone').textContent = selectedOption.dataset.phone;
                        document.getElementById('patientIdCard').textContent = selectedOption.dataset.idcard;
                        
                        // 设置隐藏的表单字段
                        document.getElementById('patientId').value = selectedOption.value;
                    } else {
                        // 隐藏病人信息
                        document.getElementById('patientInfo').style.display = 'none';
                        document.getElementById('patientId').value = '';
                    }
                });
            }
        });
        
        // 表单验证
        function validateForm() {
            let isValid = true;
            
            // 清空错误信息
            document.querySelectorAll('.error').forEach(el => {
                el.style.display = 'none';
                el.textContent = '';
            });
            
            // 验证病人选择
            const patientId = document.getElementById('patientId').value;
            if (!patientId) {
                showError('patientError', '请选择病人');
                isValid = false;
            }
            
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
            } else {
                toast.style.background = '#1e88e5';
            }
            
            // 3秒后隐藏
            setTimeout(() => {
                toast.style.display = 'none';
            }, 3000);
        }
        
        // 创建病例
        function createCase() {
            if (!validateForm()) {
                showToast('请填写完整的病例信息', 'error');
                return;
            }
            
            const formData = new FormData(document.getElementById('caseForm'));
            const data = Object.fromEntries(formData.entries());
            
            // 显示加载状态
            const submitBtn = document.querySelector('.btn-primary');
            const originalText = submitBtn.innerHTML;
            submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> 创建中...';
            submitBtn.disabled = true;
            
            fetch('${pageContext.request.contextPath}/doctor/prescription/create', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: new URLSearchParams(data)
            })
            .then(response => response.text())
            .then(result => {
                if (result === 'ok') {
                    showToast('病例创建成功！', 'success');
                    setTimeout(() => {
                        window.location.href = '${pageContext.request.contextPath}/doctor/prescription';
                    }, 1500);
                } else if (result === 'error') {
                    showToast('创建失败，请稍后重试', 'error');
                } else if (result === 'login') {
                    showToast('请先登录', 'error');
                    setTimeout(() => {
                        window.location.href = '${pageContext.request.contextPath}/login';
                    }, 1500);
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
        
        // 取消创建
        function cancelCreate() {
            if (confirm('确定要取消创建病例吗？未保存的信息将丢失。')) {
                window.history.back();
            }
        }
        
        // 前往病人管理
        function goToPatientManagement() {
            window.location.href = '${pageContext.request.contextPath}/doctor/patient';
        }
        
        // 自动计算年龄（如果病人没有age属性）
        function calculateAge(birthDate) {
            if (!birthDate) return null;
            const today = new Date();
            const birth = new Date(birthDate);
            let age = today.getFullYear() - birth.getFullYear();
            const monthDiff = today.getMonth() - birth.getMonth();
            if (monthDiff < 0 || (monthDiff === 0 && today.getDate() < birth.getDate())) {
                age--;
            }
            return age;
        }
    </script>
</body>
</html>
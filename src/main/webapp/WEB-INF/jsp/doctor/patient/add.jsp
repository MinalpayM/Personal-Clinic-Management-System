<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/jsp/common/doctor_header.jsp" %>

<script>
    document.title = "添加病人";
</script>

<style>
    body {
        background: #f5f6f7;
        font-family: Arial, sans-serif;
    }
    
    .container {
        width: 90%;
        max-width: 800px;
        margin: 90px auto 30px;
        background: #fff;
        border-radius: 10px;
        padding: 30px;
        box-shadow: 0 4px 12px rgba(0,0,0,.08);
    }
    
    h2 {
        color: #1e88e5;
        margin-bottom: 30px;
        padding-bottom: 15px;
        border-bottom: 2px solid #e0e0e0;
    }
    
    .form-row {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 30px;
        margin-bottom: 20px;
    }
    
    .form-group {
        margin-bottom: 20px;
    }
    
    label {
        display: block;
        margin-bottom: 8px;
        font-weight: bold;
        color: #333;
    }
    
    input, select {
        width: 100%;
        padding: 10px 15px;
        border: 1px solid #ccc;
        border-radius: 5px;
        font-size: 14px;
        transition: border-color 0.3s;
    }
    
    input:focus, select:focus {
        outline: none;
        border-color: #1e88e5;
        box-shadow: 0 0 0 2px rgba(30, 136, 229, 0.2);
    }
    
    .form-hint {
        color: #666;
        font-size: 12px;
        margin-top: 5px;
    }
    
    .btn-group {
        display: flex;
        gap: 15px;
        margin-top: 40px;
        padding-top: 20px;
        border-top: 1px solid #e0e0e0;
    }
    
    .btn {
        padding: 12px 30px;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        font-size: 14px;
        font-weight: bold;
        transition: 0.3s;
    }
    
    .btn-primary {
        background: #1e88e5;
        color: white;
        flex: 1;
    }
    
    .btn-primary:hover {
        background: #1565c0;
    }
    
    .btn-secondary {
        background: #f5f5f5;
        color: #333;
    }
    
    .btn-secondary:hover {
        background: #e0e0e0;
    }
    
    .required::after {
        content: " *";
        color: #e53935;
    }
    
    .error {
        color: #e53935;
        font-size: 12px;
        margin-top: 5px;
        display: none;
    }
</style>

<div class="container">
    <h2>添加新病人</h2>
    
    <form id="patientForm" onsubmit="return savePatient();">
        <div class="form-row">
            <div class="form-group">
                <label for="name" class="required">姓名</label>
                <input type="text" id="name" name="name" required 
                       placeholder="请输入病人姓名">
                <div class="error" id="nameError"></div>
            </div>
            
            <div class="form-group">
                <label for="gender" class="required">性别</label>
                <select id="gender" name="gender" required>
                    <option value="">请选择性别</option>
                    <option value="M">男</option>
                    <option value="F">女</option>
                </select>
                <div class="error" id="genderError"></div>
            </div>
        </div>
        
        <div class="form-row">
            <div class="form-group">
                <label for="birthDate" class="required">出生日期</label>
                <input type="date" id="birthDate" name="birthDate" required>
                <div class="form-hint">用于计算年龄</div>
                <div class="error" id="birthDateError"></div>
            </div>
            
            <div class="form-group">
                <label for="phone" class="required">联系电话</label>
                <input type="tel" id="phone" name="phone" required 
                       pattern="\d{11}" placeholder="11位手机号码">
                <div class="form-hint">11位手机号码</div>
                <div class="error" id="phoneError"></div>
            </div>
        </div>
        
        <div class="form-row">
            <div class="form-group">
                <label for="idCard" class="required">身份证号</label>
                <input type="text" id="idCard" name="idCard" required 
                       pattern="\d{17}[\dXx]" placeholder="18位身份证号码">
                <div class="form-hint">18位身份证号码，最后一位可以是X</div>
                <div class="error" id="idCardError"></div>
            </div>
            
            <div class="form-group">
                <label for="address">联系地址</label>
                <input type="text" id="address" name="address" 
                       placeholder="请输入详细地址">
                <div class="error" id="addressError"></div>
            </div>
        </div>
        
        <div class="btn-group">
            <button type="button" class="btn btn-secondary" 
                    onclick="window.history.back()">取消</button>
            <button type="submit" class="btn btn-primary">保存</button>
        </div>
    </form>
</div>

<script>
    // 表单验证
    function validateForm() {
        let isValid = true;
        
        // 清空错误信息
        document.querySelectorAll('.error').forEach(el => {
            el.style.display = 'none';
            el.textContent = '';
        });
        
        // 验证姓名
        const name = document.getElementById('name').value.trim();
        if (!name) {
            showError('nameError', '请输入姓名');
            isValid = false;
        }
        
        // 验证性别
        const gender = document.getElementById('gender').value;
        if (!gender) {
            showError('genderError', '请选择性别');
            isValid = false;
        }
        
        // 验证出生日期
        const birthDate = document.getElementById('birthDate').value;
        if (!birthDate) {
            showError('birthDateError', '请选择出生日期');
            isValid = false;
        } else {
            const selectedDate = new Date(birthDate);
            const today = new Date();
            if (selectedDate > today) {
                showError('birthDateError', '出生日期不能晚于今天');
                isValid = false;
            }
        }
        
        // 验证电话
        const phone = document.getElementById('phone').value.trim();
        const phonePattern = /^\d{11}$/;
        if (!phone) {
            showError('phoneError', '请输入联系电话');
            isValid = false;
        } else if (!phonePattern.test(phone)) {
            showError('phoneError', '请输入11位手机号码');
            isValid = false;
        }
        
        // 验证身份证
        const idCard = document.getElementById('idCard').value.trim();
        const idCardPattern = /^\d{17}[\dXx]$/;
        if (!idCard) {
            showError('idCardError', '请输入身份证号');
            isValid = false;
        } else if (!idCardPattern.test(idCard)) {
            showError('idCardError', '请输入18位有效身份证号');
            isValid = false;
        }
        
        return isValid;
    }
    
    function showError(elementId, message) {
        const errorElement = document.getElementById(elementId);
        errorElement.textContent = message;
        errorElement.style.display = 'block';
    }
    
    // 保存病人
    function savePatient() {
        if (!validateForm()) {
            return false;
        }
        
        const formData = new FormData(document.getElementById('patientForm'));
        
        fetch('${pageContext.request.contextPath}/doctor/patient/add', {
            method: 'POST',
            body: new URLSearchParams(new FormData(document.getElementById('patientForm')))
        })
        .then(response => response.text())
        .then(result => {
            if (result === 'ok') {
                alert('病人添加成功！');
                window.location.href = '${pageContext.request.contextPath}/doctor/patient';
            } else if (result === 'error') {
                alert('添加失败，请检查输入信息！');
            } else if (result === 'login') {
                alert('请先登录！');
                window.location.href = '${pageContext.request.contextPath}/login';
            }
        })
        .catch(error => {
            console.error('Error:', error);
            alert('网络错误，请稍后重试！');
        });
        
        return false; // 防止表单默认提交
    }
    
    // 设置默认日期范围
    document.addEventListener('DOMContentLoaded', function() {
        const today = new Date().toISOString().split('T')[0];
        const minDate = '1900-01-01';
        
        document.getElementById('birthDate').max = today;
        document.getElementById('birthDate').min = minDate;
    });
</script>
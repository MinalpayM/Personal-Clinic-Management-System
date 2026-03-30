<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/jsp/common/doctor_header.jsp" %>

<script>
    document.title = "管理病人";
</script>

<style>
    body {
        background: #f5f6f7;
        font-family: Arial, sans-serif;
    }
    
    .container {
        width: 95%;
        margin: 90px auto 30px;
        background: #fff;
        border-radius: 10px;
        padding: 25px;
        box-shadow: 0 4px 12px rgba(0,0,0,.08);
    }
    
    .header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 25px;
        padding-bottom: 15px;
        border-bottom: 1px solid #e0e0e0;
    }
    
    .search-box {
        display: flex;
        gap: 10px;
        margin-bottom: 20px;
    }
    
    .search-box input {
        flex: 1;
        padding: 10px 15px;
        border: 1px solid #ccc;
        border-radius: 5px;
        font-size: 14px;
    }
    
    .btn {
        padding: 10px 20px;
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
    }
    
    .btn-primary:hover {
        background: #1565c0;
    }
    
    .btn-success {
        background: #43a047;
        color: white;
    }
    
    .btn-success:hover {
        background: #388e3c;
    }
    
    .btn-danger {
        background: #e53935;
        color: white;
    }
    
    .btn-danger:hover {
        background: #c62828;
    }
    
    .btn-sm {
        padding: 5px 10px;
        font-size: 12px;
    }
    
    .patient-table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 20px;
    }
    
    .patient-table th,
    .patient-table td {
        padding: 12px 15px;
        text-align: left;
        border-bottom: 1px solid #e0e0e0;
    }
    
    .patient-table th {
        background: #f8f9fa;
        font-weight: bold;
        color: #333;
    }
    
    .patient-table tr:hover {
        background: #f5f5f5;
    }
    
    .actions {
        display: flex;
        gap: 8px;
    }
    
    .empty-state {
        text-align: center;
        padding: 50px 20px;
        color: #666;
    }
    
    .empty-state i {
        font-size: 48px;
        color: #ccc;
        margin-bottom: 15px;
        display: block;
    }
    
    .badge {
        padding: 3px 8px;
        border-radius: 12px;
        font-size: 12px;
        font-weight: bold;
    }
    
    .badge-info {
        background: #e3f2fd;
        color: #1e88e5;
    }
    
    /* 模态框样式 */
    .modal {
        display: none;
        position: fixed;
        z-index: 1000;
        left: 0;
        top: 0;
        width: 100%;
        height: 100%;
        background-color: rgba(0,0,0,0.5);
    }
    
    .modal-content {
        background-color: white;
        margin: 5% auto;
        padding: 0;
        width: 90%;
        max-width: 600px;
        border-radius: 10px;
        box-shadow: 0 4px 20px rgba(0,0,0,0.2);
        animation: modalFadeIn 0.3s;
    }
    
    .modal-header {
        padding: 15px 20px;
        background: #1e88e5;
        color: white;
        border-radius: 10px 10px 0 0;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
    
    .modal-body {
        padding: 20px;
        max-height: 70vh;
        overflow-y: auto;
    }
    
    .close {
        color: white;
        font-size: 28px;
        font-weight: bold;
        cursor: pointer;
        opacity: 0.8;
    }
    
    .close:hover {
        opacity: 1;
    }
    
    .patient-detail {
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
    }
    
    @keyframes modalFadeIn {
        from { opacity: 0; transform: translateY(-50px); }
        to { opacity: 1; transform: translateY(0); }
    }
</style>

<div class="container">
    <div class="header">
        <h2 style="margin: 0; color: #1e88e5;">病人管理</h2>
        <button class="btn btn-success" onclick="showAddModal()">
            ＋ 新增病人
        </button>
    </div>
    
    <!-- 搜索框 -->
    <form id="searchForm" action="${pageContext.request.contextPath}/doctor/patient" method="get">
        <div class="search-box">
            <input type="text" name="keyword" value="${keyword}" 
                   placeholder="输入姓名、电话或身份证号搜索...">
            <button type="submit" class="btn btn-primary">搜索</button>
            <c:if test="${not empty keyword}">
                <a href="${pageContext.request.contextPath}/doctor/patient" class="btn">重置</a>
            </c:if>
        </div>
    </form>
    
    <!-- 病人列表 -->
    <c:choose>
        <c:when test="${not empty patients}">
            <div style="margin-bottom: 10px; color: #666;">
                共找到 <span style="color: #1e88e5; font-weight: bold;">${totalPatients}</span> 位病人
            </div>
            
            <table class="patient-table">
                <thead>
                    <tr>
                        <th>序号</th>
                        <th>姓名</th>
                        <th>性别</th>
                        <th>年龄</th>
                        <th>电话</th>
                        <th>身份证号</th>
                        <th>登记时间</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${patients}" var="patient" varStatus="status">
                        <tr>
                            <td>${status.index + 1}</td>
                            <td style="font-weight: bold;">${patient.name}</td>
                            <td>${patient.gender == 'M' ? '男' : '女'}</td>
                            <td>
                                <c:if test="${not empty patient.birthDate}">
                                    <%
                                        java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy");
                                        int birthYear = Integer.parseInt(sdf.format(((com.clinic.model.Patient)pageContext.getAttribute("patient")).getBirthDate()));
                                        int currentYear = java.util.Calendar.getInstance().get(java.util.Calendar.YEAR);
                                        int age = currentYear - birthYear;
                                        out.print(age + "岁");
                                    %>
                                </c:if>
                            </td>
                            <td>${patient.phone}</td>
                            <td>${patient.idCard}</td>
                            <td>
                                <%
                                    com.clinic.model.Patient p = (com.clinic.model.Patient)pageContext.getAttribute("patient");
                                    if (p.getCreateTime() != null) {
                                        java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm");
                                        out.print(sdf.format(p.getCreateTime()));
                                    }
                                %>
                            </td>
                            <td class="actions">
                                <button class="btn btn-primary btn-sm" onclick="viewPatient(${patient.patientId})">
                                    查看
                                </button>
                                <button class="btn btn-success btn-sm" onclick="editPatient(${patient.patientId})">
                                    编辑
                                </button>
                                <button class="btn btn-danger btn-sm" onclick="deletePatient(${patient.patientId}, '${patient.name}')">
                                    删除
                                </button>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:when>
        <c:otherwise>
            <div class="empty-state">
                <i>👤</i>
                <h3>暂无病人信息</h3>
                <p>${not empty keyword ? '未找到相关病人' : '点击右上角"新增病人"按钮添加第一位病人'}</p>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<!-- 查看详情模态框 -->
<div id="viewModal" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <h3 style="margin: 0;">病人详情</h3>
            <span class="close" onclick="closeModal('viewModal')">&times;</span>
        </div>
        <div class="modal-body" id="viewModalBody">
            <!-- 详情内容将通过AJAX加载 -->
        </div>
    </div>
</div>

<!-- 添加/编辑模态框 -->
<div id="editModal" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <h3 style="margin: 0;" id="modalTitle">添加病人</h3>
            <span class="close" onclick="closeModal('editModal')">&times;</span>
        </div>
        <div class="modal-body">
            <form id="patientForm" onsubmit="return false;">
                <input type="hidden" id="patientId" name="patientId">
                
                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 20px;">
                    <div>
                        <div style="margin-bottom: 15px;">
                            <label style="display: block; margin-bottom: 5px; font-weight: bold; color: #333;">姓名 *</label>
                            <input type="text" id="name" name="name" required 
                                   style="width: 100%; padding: 8px; border: 1px solid #ccc; border-radius: 4px;">
                        </div>
                        
                        <div style="margin-bottom: 15px;">
                            <label style="display: block; margin-bottom: 5px; font-weight: bold; color: #333;">性别 *</label>
                            <select id="gender" name="gender" required 
                                    style="width: 100%; padding: 8px; border: 1px solid #ccc; border-radius: 4px;">
                                <option value="">请选择</option>
                                <option value="M">男</option>
                                <option value="F">女</option>
                            </select>
                        </div>
                        
                        <div style="margin-bottom: 15px;">
                            <label style="display: block; margin-bottom: 5px; font-weight: bold; color: #333;">出生日期 *</label>
                            <input type="date" id="birthDate" name="birthDate" required 
                                   style="width: 100%; padding: 8px; border: 1px solid #ccc; border-radius: 4px;">
                        </div>
                    </div>
                    
                    <div>
                        <div style="margin-bottom: 15px;">
                            <label style="display: block; margin-bottom: 5px; font-weight: bold; color: #333;">联系电话 *</label>
                            <input type="tel" id="phone" name="phone" required 
                                   pattern="\d{11}" title="请输入11位手机号码"
                                   style="width: 100%; padding: 8px; border: 1px solid #ccc; border-radius: 4px;">
                            <small style="color: #666;">11位手机号码</small>
                        </div>
                        
                        <div style="margin-bottom: 15px;">
                            <label style="display: block; margin-bottom: 5px; font-weight: bold; color: #333;">身份证号 *</label>
                            <input type="text" id="idCard" name="idCard" required 
                                   pattern="\d{17}[\dXx]" title="请输入18位身份证号码"
                                   style="width: 100%; padding: 8px; border: 1px solid #ccc; border-radius: 4px;">
                            <small style="color: #666;">18位身份证号码</small>
                        </div>
                        
                        <div style="margin-bottom: 15px;">
                            <label style="display: block; margin-bottom: 5px; font-weight: bold; color: #333;">联系地址</label>
                            <input type="text" id="address" name="address" 
                                   style="width: 100%; padding: 8px; border: 1px solid #ccc; border-radius: 4px;">
                        </div>
                    </div>
                </div>
                
                <div style="margin-top: 20px; text-align: right;">
                    <button type="button" class="btn" onclick="closeModal('editModal')" 
                            style="background: #f5f5f5; color: #333; margin-right: 10px;">取消</button>
                    <button type="button" class="btn btn-primary" onclick="savePatient()">保存</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    // 显示查看模态框
    function viewPatient(patientId) {
        fetch('${pageContext.request.contextPath}/doctor/patient/view?id=' + patientId)
            .then(response => response.text())
            .then(html => {
                document.getElementById('viewModalBody').innerHTML = html;
                document.getElementById('viewModal').style.display = 'block';
            });
    }
    
    // 显示添加模态框
    function showAddModal() {
        document.getElementById('modalTitle').textContent = '添加病人';
        document.getElementById('patientForm').reset();
        document.getElementById('patientId').value = '';
        document.getElementById('editModal').style.display = 'block';
    }
    
    // 显示编辑模态框
    function editPatient(patientId) {
        // 这里可以加载病人数据到表单
        window.location.href = '${pageContext.request.contextPath}/doctor/patient/edit?id=' + patientId;
    }
    
    // 保存病人
    function savePatient() {
        const form = document.getElementById('patientForm');
        const formData = new FormData(form);
        const patientId = formData.get('patientId');
        
        const url = patientId ? 
            '${pageContext.request.contextPath}/doctor/patient/update' : 
            '${pageContext.request.contextPath}/doctor/patient/add';
        
        fetch(url, {
            method: 'POST',
            body: new URLSearchParams(new FormData(form))
        })
        .then(response => response.text())
        .then(result => {
            if (result === 'ok') {
                alert('保存成功！');
                closeModal('editModal');
                window.location.reload();
            } else if (result === 'error') {
                alert('保存失败，请检查输入信息！');
            } else if (result === 'login') {
                alert('请先登录！');
                window.location.href = '${pageContext.request.contextPath}/login';
            } else if (result === 'permission_denied') {
                alert('没有权限操作此病人！');
            }
        });
    }
    
    // 删除病人
    function deletePatient(patientId, patientName) {
        if (confirm(`确定要删除病人"${patientName}"吗？此操作不可恢复！`)) {
            fetch('${pageContext.request.contextPath}/doctor/patient/delete?id=' + patientId)
                .then(response => response.text())
                .then(result => {
                    if (result === 'ok') {
                        alert('删除成功！');
                        window.location.reload();
                    } else if (result === 'permission_denied') {
                        alert('没有权限删除此病人！');
                    } else if (result === 'login') {
                        alert('请先登录！');
                        window.location.href = '${pageContext.request.contextPath}/login';
                    } else {
                        alert('删除失败！');
                    }
                });
        }
    }
    
    // 关闭模态框
    function closeModal(modalId) {
        document.getElementById(modalId).style.display = 'none';
    }
    
    // 点击模态框外部关闭
    window.onclick = function(event) {
        const viewModal = document.getElementById('viewModal');
        const editModal = document.getElementById('editModal');
        
        if (event.target == viewModal) {
            viewModal.style.display = 'none';
        }
        if (event.target == editModal) {
            editModal.style.display = 'none';
        }
    }
</script>
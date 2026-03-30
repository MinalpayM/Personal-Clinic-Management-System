<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/jsp/common/doctor_header.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>病例管理</title>
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
        }
        
        .container {
            max-width: 1400px;
            margin: 100px auto 30px;
            background: white;
            border-radius: 12px;
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }
        
        .header {
            padding: 25px 30px;
            border-bottom: 1px solid #e0e0e0;
            background: #f8f9fa;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 20px;
        }
        
        .header-left h1 {
            margin: 0;
            font-size: 24px;
            font-weight: 600;
            color: #1e88e5;
        }
        
        .header-left p {
            margin: 5px 0 0;
            color: #666;
            font-size: 14px;
        }
        
        .header-stats {
            display: flex;
            gap: 20px;
        }
        
        .stat-item {
            text-align: center;
            padding: 15px;
            min-width: 120px;
            background: white;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }
        
        .stat-value {
            font-size: 24px;
            font-weight: 600;
            color: #1e88e5;
            display: block;
        }
        
        .stat-label {
            font-size: 12px;
            color: #666;
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        
        .content {
            padding: 30px;
        }
        
        .actions-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
            flex-wrap: wrap;
            gap: 15px;
        }
        
        .search-box {
            display: flex;
            gap: 10px;
            flex: 1;
            max-width: 400px;
        }
        
        .search-box input {
            flex: 1;
            padding: 12px 15px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 14px;
            transition: all 0.3s ease;
        }
        
        .search-box input:focus {
            outline: none;
            border-color: #1e88e5;
            box-shadow: 0 0 0 3px rgba(30, 136, 229, 0.1);
        }
        
        .btn {
            padding: 12px 24px;
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
        
        .btn-success {
            background: linear-gradient(135deg, #43a047, #66bb6a);
            color: white;
        }
        
        .btn-success:hover {
            background: linear-gradient(135deg, #388e3c, #43a047);
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(67, 160, 71, 0.3);
        }
        
        .btn-outline {
            background: transparent;
            border: 2px solid #1e88e5;
            color: #1e88e5;
        }
        
        .btn-outline:hover {
            background: #1e88e5;
            color: white;
        }
        
        .btn-sm {
            padding: 6px 12px;
            font-size: 12px;
        }
        
        .btn-danger {
            background: #e53935;
            color: white;
        }
        
        .btn-danger:hover {
            background: #c62828;
        }
        
        .btn-warning {
            background: #ff9800;
            color: white;
        }
        
        .btn-warning:hover {
            background: #ef6c00;
        }
        
        .table-container {
            overflow-x: auto;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }
        
        .case-table {
            width: 100%;
            border-collapse: collapse;
            background: white;
        }
        
        .case-table th {
            background: #f8f9fa;
            padding: 16px 20px;
            text-align: left;
            font-weight: 600;
            color: #444;
            border-bottom: 2px solid #e0e0e0;
            white-space: nowrap;
        }
        
        .case-table td {
            padding: 16px 20px;
            border-bottom: 1px solid #e0e0e0;
            vertical-align: middle;
        }
        
        .case-table tbody tr:hover {
            background: #f5f5f5;
        }
        
        .case-table tbody tr:last-child td {
            border-bottom: none;
        }
        
        .patient-info {
            display: flex;
            flex-direction: column;
            gap: 5px;
        }
        
        .patient-name {
            font-weight: 600;
            color: #333;
        }
        
        .patient-meta {
            font-size: 12px;
            color: #666;
        }
        
        .symptom-preview {
            max-width: 200px;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }
        
        .diagnosis {
            padding: 6px 12px;
            background: #e3f2fd;
            color: #1e88e5;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
            display: inline-block;
        }
        
        .visit-time {
            color: #666;
            font-size: 13px;
        }
        
        .total-fee {
            font-weight: 600;
            color: #43a047;
        }
        
        .actions {
            display: flex;
            gap: 8px;
            flex-wrap: wrap;
        }
        
        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: #666;
        }
        
        .empty-state i {
            font-size: 64px;
            color: #ccc;
            margin-bottom: 20px;
            display: block;
        }
        
        .empty-state h3 {
            margin-bottom: 15px;
            color: #444;
            font-weight: 600;
        }
        
        .empty-state p {
            margin-bottom: 25px;
            max-width: 400px;
            margin-left: auto;
            margin-right: auto;
        }
        
        .badge {
            padding: 4px 10px;
            border-radius: 20px;
            font-size: 11px;
            font-weight: 600;
            letter-spacing: 0.5px;
            text-transform: uppercase;
        }
        
        .badge-new {
            background: #ffebee;
            color: #e53935;
        }
        
        .badge-active {
            background: #e8f5e9;
            color: #43a047;
        }
        
        .badge-completed {
            background: #e3f2fd;
            color: #1e88e5;
        }
        
        .pagination {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 10px;
            margin-top: 30px;
            padding-top: 25px;
            border-top: 1px solid #e0e0e0;
        }
        
        .pagination button {
            padding: 8px 16px;
            border: 1px solid #e0e0e0;
            background: white;
            border-radius: 6px;
            cursor: pointer;
            font-size: 14px;
            transition: all 0.3s ease;
        }
        
        .pagination button:hover {
            background: #f5f5f5;
            border-color: #1e88e5;
        }
        
        .pagination .active {
            background: #1e88e5;
            color: white;
            border-color: #1e88e5;
        }
        
        /* 模态框样式 */
        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
            z-index: 1000;
            align-items: center;
            justify-content: center;
            animation: fadeIn 0.3s ease;
        }
        
        .modal-content {
            background: white;
            border-radius: 12px;
            width: 90%;
            max-width: 500px;
            max-height: 80vh;
            overflow-y: auto;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.2);
            animation: slideUp 0.3s ease;
        }
        
        .modal-header {
            padding: 20px 25px;
            border-bottom: 1px solid #e0e0e0;
            background: #1e88e5;
            color: white;
            border-radius: 12px 12px 0 0;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .modal-header h3 {
            margin: 0;
            font-size: 18px;
        }
        
        .modal-body {
            padding: 25px;
        }
        
        .modal-footer {
            padding: 20px 25px;
            border-top: 1px solid #e0e0e0;
            text-align: right;
        }
        
        .close {
            background: none;
            border: none;
            color: white;
            font-size: 24px;
            cursor: pointer;
            opacity: 0.8;
            padding: 0;
            width: 30px;
            height: 30px;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        .close:hover {
            opacity: 1;
        }
        
        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }
        
        @keyframes slideUp {
            from { transform: translateY(50px); opacity: 0; }
            to { transform: translateY(0); opacity: 1; }
        }
        
        @media (max-width: 768px) {
            .container {
                margin: 90px 15px 30px;
            }
            
            .content {
                padding: 20px;
            }
            
            .header {
                flex-direction: column;
                text-align: center;
                gap: 15px;
            }
            
            .header-stats {
                width: 100%;
                justify-content: center;
            }
            
            .actions-bar {
                flex-direction: column;
                align-items: stretch;
            }
            
            .search-box {
                max-width: none;
            }
            
            .case-table th,
            .case-table td {
                padding: 12px 15px;
            }
            
            .actions {
                flex-direction: column;
            }
        }
    </style>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <div class="container">
        <div class="header">
            <div class="header-left">
                <h1><i class="fas fa-file-medical"></i> 病例管理</h1>
                <p>管理您的医疗病例记录，为病人开药</p>
            </div>
            <div class="header-stats">
                <div class="stat-item">
                    <span class="stat-value">${not empty cases ? cases.size() : 0}</span>
                    <span class="stat-label">总病例数</span>
                </div>
                <div class="stat-item">
                    <span class="stat-value" id="todayCases">0</span>
                    <span class="stat-label">今日新增</span>
                </div>
                <div class="stat-item">
                    <span class="stat-value" id="totalFee">0</span>
                    <span class="stat-label">总费用(元)</span>
                </div>
            </div>
        </div>
        
        <div class="content">
            <div class="actions-bar">
                <div class="search-box">
                    <input type="text" id="searchInput" placeholder="搜索病人姓名或症状..." 
                           value="${param.keyword}">
                    <button class="btn btn-outline" onclick="searchCases()">
                        <i class="fas fa-search"></i> 搜索
                    </button>
                    <c:if test="${not empty param.keyword}">
                        <button class="btn" onclick="clearSearch()">
                            <i class="fas fa-times"></i> 清除
                        </button>
                    </c:if>
                </div>
                <button class="btn btn-success" onclick="createNewCase()">
                    <i class="fas fa-plus"></i> 新建病例
                </button>
            </div>
            
            <c:choose>
                <c:when test="${not empty cases}">
                    <div class="table-container">
                        <table class="case-table">
                            <thead>
                                <tr>
                                    <th>病例ID</th>
                                    <th>病人信息</th>
                                    <th>症状描述</th>
                                    <th>就诊时间</th>
                                    <th>总费用</th>
                                    <th>状态</th>
                                    <th>操作</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${cases}" var="medicalCase">
                                    <%
                                        // 计算病例状态
                                        com.clinic.model.MedicalCase mc = 
                                            (com.clinic.model.MedicalCase)pageContext.getAttribute("medicalCase");
                                        String statusClass = "badge-active";
                                        String statusText = "进行中";
                                        
                                        if (mc.getTotalFee() != null && mc.getTotalFee() > 0) {
                                            statusClass = "badge-completed";
                                            statusText = "已完成";
                                        }
                                        
                                        // 格式化时间
                                        java.text.SimpleDateFormat sdf = 
                                            new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm");
                                        String visitTime = sdf.format(mc.getVisitTime());
                                        
                                        // 计算是否今天
                                        java.util.Calendar today = java.util.Calendar.getInstance();
                                        java.util.Calendar caseDate = java.util.Calendar.getInstance();
                                        caseDate.setTime(mc.getVisitTime());
                                        boolean isToday = today.get(java.util.Calendar.YEAR) == caseDate.get(java.util.Calendar.YEAR) &&
                                                        today.get(java.util.Calendar.MONTH) == caseDate.get(java.util.Calendar.MONTH) &&
                                                        today.get(java.util.Calendar.DAY_OF_MONTH) == caseDate.get(java.util.Calendar.DAY_OF_MONTH);
                                        
                                        pageContext.setAttribute("visitTime", visitTime);
                                        pageContext.setAttribute("isToday", isToday);
                                        pageContext.setAttribute("statusClass", statusClass);
                                        pageContext.setAttribute("statusText", statusText);
                                    %>
                                    <tr>
                                        <td>
                                            <span class="badge ${isToday ? 'badge-new' : ''}">
                                                #${medicalCase.caseId}
                                            </span>
                                        </td>
                                        <td>
                                            <div class="patient-info">
                                                <span class="patient-name">${medicalCase.patientName}</span>
                                                <span class="patient-meta">病人ID: ${medicalCase.patientId}</span>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="symptom-preview" title="${medicalCase.symptom}">
                                                ${medicalCase.symptom}
                                            </div>
                                        </td>
                                        <td class="visit-time">${visitTime}</td>
                                        <td class="total-fee">
                                            ¥<fmt:formatNumber value="${medicalCase.totalFee}" pattern="#,##0.00"/>
                                        </td>
                                        <td>
                                            <span class="badge ${statusClass}">${statusText}</span>
                                        </td>
                                        <td>
                                            <div class="actions">
                                                <button class="btn btn-sm btn-outline" 
                                                        onclick="viewCase(${medicalCase.caseId})">
                                                    <i class="fas fa-eye"></i> 查看
                                                </button>
                                                <button class="btn btn-sm btn-primary" 
                                                        onclick="editCase(${medicalCase.caseId})">
                                                    <i class="fas fa-prescription-bottle"></i> 开药
                                                </button>
                                                <button class="btn btn-sm btn-warning" 
                                                        onclick="editCaseInfo(${medicalCase.caseId})">
                                                    <i class="fas fa-edit"></i> 编辑
                                                </button>
                                                <button class="btn btn-sm btn-danger" 
                                                        onclick="deleteCase(${medicalCase.caseId}, '${medicalCase.patientName}')">
                                                    <i class="fas fa-trash"></i> 删除
                                                </button>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:when>
                
                <c:otherwise>
                    <div class="empty-state">
                        <i class="fas fa-file-medical-alt"></i>
                        <h3>暂无病例记录</h3>
                        <p>您还没有创建任何病例，点击"新建病例"按钮开始为病人创建病例。</p>
                        <button class="btn btn-success" onclick="createNewCase()">
                            <i class="fas fa-plus"></i> 新建病例
                        </button>
                    </div>
                </c:otherwise>
            </c:choose>
            
            <!-- 分页控件 -->
            <c:if test="${not empty cases && cases.size() > 10}">
                <div class="pagination">
                    <button onclick="prevPage()"><i class="fas fa-chevron-left"></i></button>
                    <button class="active">1</button>
                    <button>2</button>
                    <button>3</button>
                    <button onclick="nextPage()"><i class="fas fa-chevron-right"></i></button>
                </div>
            </c:if>
        </div>
    </div>
    
    <!-- 删除确认模态框 -->
    <div id="deleteModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h3><i class="fas fa-exclamation-triangle"></i> 确认删除</h3>
                <button class="close" onclick="closeModal('deleteModal')">&times;</button>
            </div>
            <div class="modal-body">
                <p id="deleteMessage">确定要删除这个病例吗？此操作不可恢复，相关的处方记录也会被删除。</p>
                <input type="hidden" id="caseIdToDelete">
            </div>
            <div class="modal-footer">
                <button class="btn" onclick="closeModal('deleteModal')">取消</button>
                <button class="btn btn-danger" onclick="confirmDelete()">确认删除</button>
            </div>
        </div>
    </div>
    
    <!-- 查看病例模态框 -->
    <div id="viewModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h3><i class="fas fa-file-medical"></i> 病例详情</h3>
                <button class="close" onclick="closeModal('viewModal')">&times;</button>
            </div>
            <div class="modal-body" id="viewModalContent">
                <!-- 内容将通过AJAX加载 -->
            </div>
            <div class="modal-footer">
                <button class="btn" onclick="closeModal('viewModal')">关闭</button>
            </div>
        </div>
    </div>
    
    <!-- Toast提示 -->
    <div id="toast" style="position: fixed; top: 20px; right: 20px; background: #333; color: white; padding: 15px 25px; 
          border-radius: 5px; display: none; z-index: 10000; box-shadow: 0 4px 12px rgba(0,0,0,0.15);"></div>

    <script>
        // 页面加载时计算统计数据
        document.addEventListener('DOMContentLoaded', function() {
            calculateStats();
        });
        
        function calculateStats() {
            // 计算今日病例数
            const today = new Date().toISOString().split('T')[0];
            const todayCases = document.querySelectorAll('tbody tr').length;
            document.getElementById('todayCases').textContent = todayCases;
            
            // 计算总费用
            let totalFee = 0;
            document.querySelectorAll('.total-fee').forEach(cell => {
                const feeText = cell.textContent.replace('¥', '').trim();
                const fee = parseFloat(feeText) || 0;
                totalFee += fee;
            });
            document.getElementById('totalFee').textContent = totalFee.toFixed(2);
        }
        
        function createNewCase() {
            window.location.href = '${pageContext.request.contextPath}/doctor/prescription/create';
        }
        
        function viewCase(caseId) {
            fetch('${pageContext.request.contextPath}/doctor/prescription/view/' + caseId)
                .then(response => response.text())
                .then(html => {
                    document.getElementById('viewModalContent').innerHTML = html;
                    document.getElementById('viewModal').style.display = 'flex';
                })
                .catch(error => {
                    console.error('Error:', error);
                    showToast('加载病例详情失败', 'error');
                });
        }
        
        function editCase(caseId) {
            window.location.href = '${pageContext.request.contextPath}/doctor/prescription/detail/' + caseId;
        }
        
        function editCaseInfo(caseId) {
            window.location.href = '${pageContext.request.contextPath}/doctor/prescription/edit?caseId=' + caseId;
        }
        
        function deleteCase(caseId, patientName) {
            document.getElementById('caseIdToDelete').value = caseId;
            document.getElementById('deleteMessage').textContent = 
                `确定要删除病人"${patientName}"的病例吗？此操作不可恢复，相关的处方记录也会被删除。`;
            document.getElementById('deleteModal').style.display = 'flex';
        }
        
        function confirmDelete() {
            const caseId = document.getElementById('caseIdToDelete').value;
            
            fetch('${pageContext.request.contextPath}/doctor/prescription/deleteCase', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: 'caseId=' + caseId
            })
            .then(response => response.text())
            .then(result => {
                if (result === 'ok') {
                    showToast('病例删除成功', 'success');
                    setTimeout(() => {
                        window.location.reload();
                    }, 1500);
                } else if (result === 'permission_denied') {
                    showToast('没有权限删除此病例', 'error');
                } else if (result === 'login') {
                    showToast('请先登录', 'error');
                    setTimeout(() => {
                        window.location.href = '${pageContext.request.contextPath}/login';
                    }, 1500);
                } else {
                    showToast('删除失败: ' + result, 'error');
                }
                closeModal('deleteModal');
            })
            .catch(error => {
                console.error('Error:', error);
                showToast('网络错误，删除失败', 'error');
                closeModal('deleteModal');
            });
        }
        
        function searchCases() {
            const keyword = document.getElementById('searchInput').value.trim();
            if (keyword) {
                // 构建带搜索参数的URL
                const url = new URL(window.location.href);
                url.searchParams.set('keyword', keyword);
                window.location.href = url.toString();
            } else {
                showToast('请输入搜索关键词', 'info');
            }
        }

        function clearSearch() {
            // 清除搜索参数
            const url = new URL(window.location.href);
            url.searchParams.delete('keyword');
            window.location.href = url.toString();
        }
        
        function closeModal(modalId) {
            document.getElementById(modalId).style.display = 'none';
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
        
        // 点击模态框外部关闭
        window.onclick = function(event) {
            const modals = document.querySelectorAll('.modal');
            modals.forEach(modal => {
                if (event.target === modal) {
                    modal.style.display = 'none';
                }
            });
        }
        
        // 分页功能
        function prevPage() {
            showToast('上一页', 'info');
        }
        
        function nextPage() {
            showToast('下一页', 'info');
        }
    </script>
</body>
</html>
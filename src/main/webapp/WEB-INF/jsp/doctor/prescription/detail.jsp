<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/WEB-INF/jsp/common/doctor_header.jsp" %>

<style>
.medicine-description {
    max-width: 200px;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
    font-size: 13px;
    color: #666;
}

/* 添加鼠标悬停显示完整说明的功能 */
.medicine-description:hover {
    overflow: visible;
    white-space: normal;
    background-color: #fff;
    box-shadow: 0 0 10px rgba(0,0,0,0.1);
    position: relative;
    z-index: 10;
    max-width: 300px;
}
</style>

<div class="container">
    <!-- 病例信息 -->
    <div class="case-info">
        <h2>病例 #${detail.medicalCase.caseId}</h2>
        <p>病人：${detail.patient.name}</p>
        <p>症状：${detail.medicalCase.symptom}</p>
        <p>总费用：<fmt:formatNumber value="${detail.medicalCase.totalFee}" pattern="¥#,##0.00"/></p>
    </div>

    <!-- 处方列表 -->
<div class="prescription-list">
    <h3>处方单</h3>
    <table>
        <thead>
            <tr>
                <th>药品名称</th>
                <th>药品说明</th> <!-- 新增药品说明列 -->
                <th>数量</th>
                <th>单价</th>
                <th>小计</th>
                <th>操作</th>
            </tr>
        </thead>
        <tbody id="prescriptionItems">
            <c:forEach items="${detail.prescriptions}" var="item">
                <tr id="item-${item.id}">
                    <td>${item.medicineName}</td>
                    <td class="medicine-description"> <!-- 新增药品说明单元格 -->
                        <c:choose>
                            <c:when test="${not empty item.description}">
    							${item.description}
							</c:when>
                            <c:otherwise>
                                <span style="color: #999; font-style: italic;">无说明</span>
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td>${item.quantity}</td>
                    <td>¥${item.price}</td>
                    <td>¥${item.subtotal}</td>
                    <td>
                        <button onclick="deleteItem(${item.id}, ${detail.medicalCase.caseId})">删除</button>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>

    <!-- 修改为传统表单提交 -->
<div class="add-form">
    <h3>添加药品</h3>
    <form action="${pageContext.request.contextPath}/doctor/prescription/addItem" method="POST">
        <input type="hidden" name="caseId" value="${detail.medicalCase.caseId}">
        
        <select name="medicineId" id="medicineSelect" required onchange="updateMedicineStock()">
            <option value="">选择药品</option>
            <c:forEach items="${medicines}" var="medicine">
                <option value="${medicine.medicineId}" 
                        data-price="${medicine.price}"
                        data-stock="${medicine.stock}">
                    ${medicine.medicineName} (库存: ${medicine.stock}，价格: ¥${medicine.price})
                </option>
            </c:forEach>
        </select>
        
        <input type="number" name="quantity" id="quantity" placeholder="数量" min="1" required 
               oninput="validateQuantity()">
        <span id="stockInfo" style="color: #666; margin-left: 5px;"></span>
        
        <button type="submit">添加</button>
    </form>
</div>

<%-- 修改页面标题和提示 --%>
<div class="header">
    <h1>
        <i class="fas fa-prescription-bottle-alt"></i> 
        <c:choose>
            <c:when test="${isEditMode}">修改处方</c:when>
            <c:when test="${isFromEditPage}">编辑药品（来自病例编辑）</c:when>
            <c:otherwise>处方管理</c:otherwise>
        </c:choose>
    </h1>
    <p>
        病例编号: #${detail.medicalCase.caseId} 
        <c:if test="${isFromEditPage}">
            | <span style="color: #ff9800;">（从编辑页面跳转而来）</span>
        </c:if>
    </p>
</div>

<%-- 添加返回按钮 --%>
<div style="margin-bottom: 20px;">
    <button onclick="goBackToEdit()" class="btn" style="background: #666; color: white;">
        <i class="fas fa-arrow-left"></i> 
        <c:choose>
            <c:when test="${isFromEditPage}">返回编辑病例</c:when>
            <c:otherwise>返回病例列表</c:otherwise>
        </c:choose>
    </button>
</div>

<script>
// 只保留验证函数
function updateMedicineStock() {
    const select = document.getElementById('medicineSelect');
    const selectedOption = select.options[select.selectedIndex];
    const stock = selectedOption.getAttribute('data-stock') || '0';
    const price = selectedOption.getAttribute('data-price') || '0';
    const stockInfo = document.getElementById('stockInfo');
    
    if (stock === '0') {
        stockInfo.textContent = '库存不足';
        stockInfo.style.color = '#f00';
    } else {
        stockInfo.textContent = `库存: ${stock}，单价: ¥${price}`;
        stockInfo.style.color = '#666';
    }
}
function deleteItem(itemId, caseId) {
    if (!confirm('确定要删除这个药品吗？')) {
        return;
    }
    
    // 显示加载状态
    const button = event.target;
    const originalText = button.innerHTML;
    button.innerHTML = '<i class="fas fa-spinner fa-spin"></i> 删除中...';
    button.disabled = true;
    
    fetch('${pageContext.request.contextPath}/doctor/prescription/deleteItem', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: new URLSearchParams({
            id: itemId,
            caseId: caseId
        })
    })
    .then(response => response.text())
    .then(result => {
        if (result === 'ok') {
            alert('删除成功！');
            // 重新加载页面以更新数据
            location.reload();
        } else if (result === 'permission_denied') {
            alert('没有权限删除此药品');
        } else if (result === 'login') {
            alert('请先登录');
            window.location.href = '${pageContext.request.contextPath}/login';
        } else {
            alert('删除失败，请重试');
        }
    })
    .catch(error => {
        console.error('Error:', error);
        alert('网络错误，请检查连接');
    })
    .finally(() => {
        button.innerHTML = originalText;
        button.disabled = false;
    });
}
function goBackToEdit() {
    <c:choose>
        <c:when test="${isFromEditPage}">
            // 如果有保存操作，可以提示
            if (hasUnsavedChanges()) {
                if (confirm('您有未保存的药品修改，确定要返回编辑病例吗？')) {
                    window.location.href = '${pageContext.request.contextPath}/doctor/prescription/edit?caseId=${detail.medicalCase.caseId}';
                }
            } else {
                window.location.href = '${pageContext.request.contextPath}/doctor/prescription/edit?caseId=${detail.medicalCase.caseId}';
            }
        </c:when>
        <c:otherwise>
            window.location.href = '${pageContext.request.contextPath}/doctor/prescription';
        </c:otherwise>
    </c:choose>
}

function validateQuantity() {
    const select = document.getElementById('medicineSelect');
    const selectedOption = select.options[select.selectedIndex];
    const stock = parseInt(selectedOption.getAttribute('data-stock')) || 0;
    const quantity = parseInt(document.getElementById('quantity').value) || 0;
    
    if (quantity > stock) {
        alert(`数量不能超过库存量（${stock}）`);
        document.getElementById('quantity').value = stock > 0 ? stock : '';
    }
}

// 表单提交前的验证
document.querySelector('form').addEventListener('submit', function(event) {
    const medicineId = document.getElementById('medicineSelect').value;
    const quantity = document.getElementById('quantity').value;
    
    if (!medicineId) {
        alert('请选择药品');
        event.preventDefault();
        return;
    }
    
    if (!quantity || parseInt(quantity) <= 0) {
        alert('请填写有效的数量');
        event.preventDefault();
        return;
    }
    
    const select = document.getElementById('medicineSelect');
    const selectedOption = select.options[select.selectedIndex];
    const stock = parseInt(selectedOption.getAttribute('data-stock')) || 0;
    
    if (parseInt(quantity) > stock) {
        alert(`数量不能超过库存量（${stock}）`);
        event.preventDefault();
        return;
    }
    
    if (!confirm('确认添加药品吗？')) {
        event.preventDefault();
    }
});
</script>
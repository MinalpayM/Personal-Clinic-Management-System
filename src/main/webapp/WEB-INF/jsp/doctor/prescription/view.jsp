<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>病例详情 - ${detail.medicalCase.caseId}</title>
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
            margin: 0 auto;
            padding: 20px;
        }
        
        .header {
            background: linear-gradient(135deg, #1e88e5, #42a5f5);
            color: white;
            padding: 25px 30px;
            border-radius: 12px 12px 0 0;
            margin-bottom: 20px;
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
            background: white;
            border-radius: 12px;
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }
        
        .info-section {
            padding: 25px 30px;
            border-bottom: 1px solid #e0e0e0;
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
        
        .info-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 20px;
        }
        
        .info-item {
            display: flex;
            flex-direction: column;
        }
        
        .info-label {
            font-weight: 600;
            color: #666;
            font-size: 13px;
            margin-bottom: 5px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        
        .info-value {
            color: #333;
            font-size: 15px;
        }
        
        .prescription-section {
            padding: 25px 30px;
        }
        
        .prescription-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            background: white;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }
        
        .prescription-table th {
            background: #f8f9fa;
            padding: 16px 20px;
            text-align: left;
            font-weight: 600;
            color: #444;
            border-bottom: 2px solid #e0e0e0;
        }
        
        .prescription-table td {
            padding: 16px 20px;
            border-bottom: 1px solid #e0e0e0;
            vertical-align: middle;
        }
        
        .prescription-table tbody tr:hover {
            background: #f5f5f5;
        }
        
        .prescription-table tbody tr:last-child td {
            border-bottom: none;
        }
        
        .medicine-name {
            font-weight: 600;
            color: #333;
        }
        
        .quantity, .price, .subtotal {
            text-align: right;
            font-family: 'Courier New', monospace;
        }
        
        .price, .subtotal {
            color: #43a047;
            font-weight: 600;
        }
        
        .dosage {
            font-size: 13px;
            color: #666;
        }
        
        .notes {
            font-size: 13px;
            color: #999;
            font-style: italic;
        }
        
        .total-row {
            background: #f8f9fa;
            font-weight: 600;
        }
        
        .total-row td {
            color: #1e88e5;
            font-size: 16px;
        }
        
        .no-prescriptions {
            text-align: center;
            padding: 40px 20px;
            color: #666;
        }
        
        .no-prescriptions i {
            font-size: 48px;
            color: #ccc;
            margin-bottom: 15px;
            display: block;
        }
        
        .no-prescriptions h3 {
            margin-bottom: 10px;
            color: #444;
        }
        
        .footer {
            padding: 25px 30px;
            border-top: 1px solid #e0e0e0;
            background: #f8f9fa;
            text-align: right;
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
            text-decoration: none;
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
        
        .symptom-content {
            background: #f8f9fa;
            border-radius: 8px;
            padding: 20px;
            margin-top: 10px;
            border-left: 4px solid #1e88e5;
            white-space: pre-wrap;
            line-height: 1.8;
        }
        
        .badge {
            padding: 4px 10px;
            border-radius: 20px;
            font-size: 11px;
            font-weight: 600;
            letter-spacing: 0.5px;
            text-transform: uppercase;
            display: inline-block;
        }
        
        .badge-active {
            background: #e8f5e9;
            color: #43a047;
        }
        
        .badge-completed {
            background: #e3f2fd;
            color: #1e88e5;
        }
        
        @media (max-width: 768px) {
            .container {
                padding: 10px;
            }
            
            .info-grid {
                grid-template-columns: 1fr;
            }
            
            .header, .info-section, .prescription-section, .footer {
                padding: 20px;
            }
            
            .prescription-table {
                display: block;
                overflow-x: auto;
            }
        }
    </style>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
<div class="container">
    <div class="content">
        <!-- 头部信息 -->
        <div class="header">
            <h1><i class="fas fa-file-medical"></i> 病例详情</h1>
            <p>病例编号: #${detail.medicalCase.caseId} | 就诊时间: 
                <fmt:formatDate value="${detail.medicalCase.visitTime}" pattern="yyyy-MM-dd HH:mm" />
            </p>
        </div>
        
        <!-- 病人信息 -->
        <div class="info-section">
            <div class="section-title">
                <i class="fas fa-user-injured"></i> 病人信息
            </div>
            <div class="info-grid">
                <div class="info-item">
                    <span class="info-label">姓名</span>
                    <span class="info-value">
                        <c:choose>
                            <c:when test="${not empty detail.patient and not empty detail.patient.name}">
                                ${detail.patient.name}
                            </c:when>
                            <c:otherwise>
                                <span class="no-data">未设置</span>
                            </c:otherwise>
                        </c:choose>
                    </span>
                </div>
                <div class="info-item">
                    <span class="info-label">性别</span>
                    <span class="info-value">
                        <c:choose>
                            <c:when test="${detail.patient.gender == 'M'}">男</c:when>
                            <c:when test="${detail.patient.gender == 'F'}">女</c:when>
                            <c:otherwise>
                                <span class="no-data">${detail.patient.gender}</span>
                            </c:otherwise>
                        </c:choose>
                    </span>
                </div>
                <div class="info-item">
                    <span class="info-label">年龄</span>
                    <span class="info-value">
                        <c:choose>
                            <c:when test="${not empty detail.patient and not empty detail.patient.birthDate}">
                                <%-- 安全地计算年龄 --%>
                                <%
                                com.clinic.model.Patient p = 
                                (com.clinic.model.Patient)pageContext.getAttribute("detail.patient");
                                int age = 0;
                                if (p != null && p.getBirthDate() != null) {
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
                                %>
                                <%= age %>岁
                            </c:when>
                            <c:otherwise>
                                <span class="no-data">未设置</span>
                            </c:otherwise>
                        </c:choose>
                    </span>
                </div>
                <div class="info-item">
                    <span class="info-label">联系电话</span>
                    <span class="info-value">
                        <c:choose>
                            <c:when test="${not empty detail.patient.phone}">
                                ${detail.patient.phone}
                            </c:when>
                            <c:otherwise>
                                <span class="no-data">未设置</span>
                            </c:otherwise>
                        </c:choose>
                    </span>
                </div>
                <div class="info-item">
                    <span class="info-label">身份证号</span>
                    <span class="info-value">
                        <c:choose>
                            <c:when test="${not empty detail.patient.idCard}">
                                ${detail.patient.idCard}
                            </c:when>
                            <c:otherwise>
                                <span class="no-data">未设置</span>
                            </c:otherwise>
                        </c:choose>
                    </span>
                </div>
                <div class="info-item">
                    <span class="info-label">地址</span>
                    <span class="info-value">
                        <c:choose>
                            <c:when test="${not empty detail.patient.address}">
                                ${detail.patient.address}
                            </c:when>
                            <c:otherwise>
                                <span class="no-data">未设置</span>
                            </c:otherwise>
                        </c:choose>
                    </span>
                </div>
            </div>
        </div>
            
            <!-- 病情信息 -->
        <div class="info-section">
            <div class="section-title">
                <i class="fas fa-stethoscope"></i> 病情信息
            </div>
            <div class="symptom-content">
                <c:choose>
                    <c:when test="${not empty detail.medicalCase.symptom}">
                        ${detail.medicalCase.symptom}
                    </c:when>
                    <c:otherwise>
                        <span class="no-data">暂无症状描述</span>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
            
            <!-- 处方信息 -->
            <div class="prescription-section">
                <div class="section-title">
                    <i class="fas fa-prescription-bottle-alt"></i> 处方信息
                    <c:if test="${detail.medicalCase.totalFee > 0}">
                        <span style="margin-left: auto; color: #43a047; font-size: 16px;">
                            总费用: ¥<fmt:formatNumber value="${detail.medicalCase.totalFee}" pattern="#,##0.00" />
                        </span>
                    </c:if>
                    <span class="badge ${detail.medicalCase.totalFee > 0 ? 'badge-completed' : 'badge-active'}" 
                          style="margin-left: 15px;">
                        ${detail.medicalCase.totalFee > 0 ? '已完成' : '进行中'}
                    </span>
                </div>
                
                <c:choose>
                    <c:when test="${not empty detail.prescriptions}">
                        <table class="prescription-table">
    <thead>
        <tr>
            <th width="20%">药品名称</th>
            <th width="15%">描述</th> <!-- 新增 -->
            <th width="10%">数量</th>
            <th width="15%">单价</th>
            <th width="15%">小计</th>
            <th width="10%">用法用量</th>
            <th width="10%">备注</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach items="${detail.prescriptions}" var="prescription">
            <tr>
                <td class="medicine-name">${prescription.medicineName}</td>
                <td class="description">${prescription.description}</td> <!-- 新增 -->
                <td class="quantity">${prescription.quantity}</td>
                <td class="price">¥<fmt:formatNumber value="${prescription.price}" pattern="#,##0.00"/></td>
                <td class="subtotal">¥<fmt:formatNumber value="${prescription.subtotal}" pattern="#,##0.00"/></td>
                <td class="dosage">${prescription.dosage}</td>
                <td class="notes">${prescription.notes}</td>
            </tr>
        </c:forEach>
    </tbody>
</table>
                    </c:when>
                    <c:otherwise>
                        <div class="no-prescriptions">
                            <i class="fas fa-prescription-bottle"></i>
                            <h3>暂无处方记录</h3>
                            <p>此病例尚未开药</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
            
            <!-- 底部按钮 -->
            <div class="footer">
                <button type="button" class="btn btn-secondary" onclick="window.parent.closeModal('viewModal')">
                    <i class="fas fa-times"></i> 关闭
                </button>
                <c:if test="${detail.medicalCase.totalFee == 0}">
                    <a href="${pageContext.request.contextPath}/doctor/prescription/${detail.medicalCase.caseId}" 
                       class="btn btn-primary">
                        <i class="fas fa-prescription-bottle-alt"></i> 开药
                    </a>
                </c:if>
                <button type="button" class="btn btn-primary" onclick="printCase()">
                    <i class="fas fa-print"></i> 打印
                </button>
            </div>
        </div>
    </div>
    
    <script>
 // 打印病例
    function printCase() {
        const printContent = document.querySelector('.content').cloneNode(true);
        const printWindow = window.open('', '_blank');
        
        // 移除不需要打印的按钮
        const footer = printContent.querySelector('.footer');
        if (footer) {
            footer.remove();
        }
        
        // 获取当前时间（纯JavaScript方式）
        const now = new Date();
        const year = now.getFullYear();
        const month = String(now.getMonth() + 1).padStart(2, '0');
        const day = String(now.getDate()).padStart(2, '0');
        const hours = String(now.getHours()).padStart(2, '0');
        const minutes = String(now.getMinutes()).padStart(2, '0');
        const seconds = String(now.getSeconds()).padStart(2, '0');
        const printTime = year + '-' + month + '-' + day + ' ' + hours + ':' + minutes + ':' + seconds;
        
        printWindow.document.write(`
            <!DOCTYPE html>
            <html>
            <head>
                <title>病例详情 - #${detail.medicalCase.caseId}</title>
                <style>
                    body {
                        font-family: 'SimSun', '宋体', serif;
                        line-height: 1.6;
                        color: #000;
                        padding: 20px;
                    }
                    .header {
                        text-align: center;
                        margin-bottom: 30px;
                        border-bottom: 2px solid #000;
                        padding-bottom: 20px;
                    }
                    .header h1 {
                        font-size: 24px;
                        margin: 0;
                    }
                    .info-section {
                        margin-bottom: 20px;
                    }
                    .section-title {
                        font-weight: bold;
                        font-size: 16px;
                        margin-bottom: 10px;
                        border-bottom: 1px solid #000;
                        padding-bottom: 5px;
                    }
                    .info-grid {
                        display: grid;
                        grid-template-columns: repeat(3, 1fr);
                        gap: 10px;
                    }
                    .info-item {
                        margin-bottom: 5px;
                    }
                    .info-label {
                        font-weight: bold;
                        display: inline-block;
                                min-width: 80px;
                            }
                            .symptom-content {
                                background: #f9f9f9;
                                padding: 15px;
                                border: 1px solid #ddd;
                                margin-top: 10px;
                                white-space: pre-wrap;
                            }
                            table {
                                width: 100%;
                                border-collapse: collapse;
                                margin-top: 20px;
                            }
                            th, td {
                                border: 1px solid #000;
                                padding: 8px;
                                text-align: left;
                            }
                            th {
                                background: #f0f0f0;
                                font-weight: bold;
                            }
                            .total-row {
                                font-weight: bold;
                                background: #f0f0f0;
                            }
                            .print-date {
                                text-align: right;
                                margin-top: 30px;
                                font-size: 12px;
                                color: #666;
                            }
                            @media print {
                                body {
                                    padding: 0;
                                    margin: 0;
                                }
                                .no-print {
                                    display: none;
                                }
                            }
                        </style>
                    </head>
                    <body>
                `);
                
                printWindow.document.write(printContent.innerHTML);
                printWindow.document.write(`
                        <div class="print-date">
                            打印时间: ` + printTime + `
                        </div>
                    </body>
                    </html>
                `);
                
                printWindow.document.close();
                printWindow.focus();
                
                // 延迟打印，确保内容加载完成
                setTimeout(() => {
                    printWindow.print();
                    // 可以选择是否关闭窗口
                    // printWindow.close();
                }, 500);
            }
    </script>
</body>
</html>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/jsp/common/header.jsp" %>

<script>
    document.title = "管理医生";
</script>

<style>
    body {
        background: #f5f6f7;
        font-family: Arial, sans-serif;
    }
    .container {
        display: flex;
        padding-top: 80px;
        width: 95%;
        margin: auto;
    }
    .left-panel { width: 30%; padding: 20px; }
    .right-panel { width: 70%; padding: 20px; }

    .card {
        background: white;
        padding: 20px;
        border-radius: 8px;
        box-shadow: 0 2px 6px rgba(0,0,0,0.1);
        margin-bottom: 20px;
    }
    .card h3 { color: #1e88e5; }

    .form-group { margin-bottom: 12px; }
    .form-group input, .form-group select {
        width: 100%; padding: 8px; border: 1px solid #ccc; border-radius: 5px;
    }
    .btn {
        width: 100%; background: #1e88e5; color: white;
        border: none; padding: 10px; border-radius: 5px; cursor: pointer;
    }

    .search-bar {
        background: white;
        padding: 15px;
        border-radius: 8px;
        box-shadow: 0 2px 6px rgba(0,0,0,0.1);
        margin-bottom: 20px;
        display: flex;
        gap: 10px;
    }
    .search-bar input, .search-bar select {
        flex: 1; padding: 8px; border-radius: 5px; border: 1px solid #ccc;
    }
    .search-btn {
        background: #1e88e5; color: white;
        border: none; padding: 10px 20px; border-radius: 5px; cursor: pointer;
    }

    .doctor-item {
        background: white;
        padding: 15px;
        border-radius: 8px;
        display: flex;
        align-items: center;
        margin-bottom: 15px;
        box-shadow: 0 2px 6px rgba(0,0,0,0.1);
    }
    .doctor-avatar {
        width: 70px; height: 70px;
        border-radius: 50%;
        object-fit: cover;
        margin-right: 20px;
    }
    .doctor-info { flex: 1; }
    .doctor-actions a {
        margin-left: 15px;
        color: #1e88e5;
        text-decoration: none;
    }
    .hint{
        font-size: 12px;
        color: #9aa0a6;
        margin-top: 4px;
        line-height: 1.4;
        letter-spacing: .3px;
    }
    .error-field {
        border-color: #e53935 !important;
    }
</style>

<div class="container">

    <!-- 左侧 -->
    <div class="left-panel">

        <div class="card">
            <h3>医生概览</h3>
            <p>总医生人数：${totalDoctors}</p >
        </div>

        <div class="card">
            <h3>新建医生</h3>

            <!-- 错误提示框 -->
            <div id="errorBox" style="display:none; 
                 background:#fce8e6; color:#c5221f; 
                 padding:12px; border-radius:6px; 
                 margin-bottom:16px; font-size:14px; line-height:1.5;">
            </div>

            <form id="addDoctorForm"
                  action="${pageContext.request.contextPath}/admin/doctor/add"
                  method="post"
                  enctype="multipart/form-data">

                <div class="form-group">
                    <input name="name" placeholder="姓名 *" required>
                </div>

                <div class="form-group">
                    <select name="gender" required>
                        <option value="" disabled selected>性别 *</option>
                        <option value="M">男</option>
                        <option value="F">女</option>
                    </select>
                </div>

                <div class="form-group">
                    <input type="date" name="birthDate" required>
                </div>

                <div class="form-group">
                    <input name="title" placeholder="职称">
                </div>

                <div class="form-group">
                    <input type="number" step="0.01" name="salary" placeholder="薪资">
                </div>

                <div class="form-group">
                    <input name="phone" placeholder="电话 *" required pattern="\d{11}">
                    <div class="hint">11位数字</div>
                </div>

                <div class="form-group">
                    <input name="address" placeholder="地址">
                </div>

                <div class="form-group">
                    <input name="idCard" placeholder="身份证 *" required pattern="[0-9]{17}[0-9X]">
                    <div class="hint">18位，前17位数字，最后一位数字或X</div>
                </div>

                <div class="form-group">
                    <input type="file" name="avatarFile" accept="image/*">
                </div>

                <button type="button" class="btn" onclick="submitAddDoctor()">创建医生</button>
            </form>
        </div>

    </div>

    <!-- 右侧 -->
    <div class="right-panel">

        <form class="search-bar" method="get" action="${pageContext.request.contextPath}/admin/doctor">
            <input name="keyword" placeholder="姓名 / 电话 / 身份证">
            <select name="title">
                <option value="">职称</option>
                <option value="主任医师">主任医师</option>
                <option value="副主任医师">副主任医师</option>
                <option value="主治医师">主治医师</option>
            </select>
            <button class="search-btn">搜索</button>
        </form>

        <c:forEach var="d" items="${doctors}">
            <div class="doctor-item">

                <c:choose>
                    <c:when test="${not empty d.avatar}">
                        <img src="${pageContext.request.contextPath}/${d.avatar}" class="doctor-avatar">
                    </c:when>
                    <c:otherwise>
                        <img src="${pageContext.request.contextPath}/images/default.png" class="doctor-avatar">
                    </c:otherwise>
                </c:choose>

                <div class="doctor-info">
                    <strong>${d.name}</strong><br>${d.title}
                </div>

                <div class="doctor-actions">
                    <a href="javascript:void(0)；" onclick="openModal('${pageContext.request.contextPath}/admin/doctor/view?id=${d.doctorId}')">查看</a >
                    <a href="javascript:void(0)" onclick="openModal('${pageContext.request.contextPath}/admin/doctor/edit?id=${d.doctorId}')">编辑</a >
                    <a href="${pageContext.request.contextPath}/admin/doctor/delete?id=${d.doctorId}"
                       onclick="return confirm('删除后无法撤销，确定删除吗？');">删除</a >
                </div>
            </div>
        </c:forEach>

    </div>
</div>

<!-- 弹窗 -->
<div id="doctorModal" style="display:none; position:fixed; left:0; top:0; width:100%; height:100%;
     background:rgba(0,0,0,0.4); z-index:9999;">
    <div style="width:600px; background:#fff; margin:100px auto; border-radius:8px; padding:20px; position:relative;">
        <span onclick="closeModal()" style="position:absolute; right:15px; top:10px; cursor:pointer; font-size:24px;">×</span>
        <div id="modalContent"></div>
    </div>
</div>

<script>
function openModal(url) {
    document.getElementById("doctorModal").style.display = "block";
    fetch(url).then(r => r.text()).then(html => {
        document.getElementById("modalContent").innerHTML = html;
    });
}

function closeModal() {
    document.getElementById("doctorModal").style.display = "none";
    document.getElementById("modalContent").innerHTML = "";
}

function submitAddDoctor() {
    const form = document.getElementById("addDoctorForm");
    const errorBox = document.getElementById("errorBox");

    // 先清空之前的错误样式和提示
    errorBox.style.display = "none";
    errorBox.innerHTML = "";
    document.querySelectorAll('.error-field').forEach(el => el.classList.remove('error-field'));

    // HTML5 表单校验
    if (!form.checkValidity()) {
        form.reportValidity();
        return;
    }

    const data = new FormData(form);

    fetch(form.action, {
        method: "POST",
        body: data
    })
    .then(response => response.json())
    .then(json => {
        if (json.status === "success") {
            location.href = "${pageContext.request.contextPath}/admin/doctor";
        } else if (json.errors) {
            let msg = "";
            for (const [field, errMsg] of Object.entries(json.errors)) {
                msg += "• " + errMsg + "<br>";
                const input = form.querySelector(`[name="${field}"]`);
                if (input) {
                    input.classList.add("error-field");
                    // 输入时自动清除红框
                    input.addEventListener("input", function() {
                        this.classList.remove("error-field");
                    }, {once: true});
                }
            }
            errorBox.innerHTML = msg;
            errorBox.style.display = "block";
        } else {
            errorBox.innerHTML = "创建失败，请稍后再试";
            errorBox.style.display = "block";
        }
    })
    .catch(err => {
        location.reload();
    });
}
</script>
<script>
function submitEdit() {
    const form = document.getElementById("editForm");
    const errorBox = document.getElementById("errorBox");

    if (!form || !errorBox) return;

    // 清空样式
    errorBox.style.display = "none";
    document.querySelectorAll('.error-field').forEach(el => el.classList.remove('error-field'));

    if (!form.checkValidity()) {
        form.reportValidity();
        return;
    }

    const data = new FormData(form);
    fetch(form.action, {
        method: 'POST',
        body: data
    })
    .then(response => response.json())
    .then(json => {
        if (json.status === "success") {
            // 成功后关闭弹窗并刷新列表
            closeModal();
            location.reload(); 
        } else if (json.errors) {
            let msg = "";
            for (const [field, errMsg] of Object.entries(json.errors)) {
                msg += "• " + errMsg + "<br>";
                const input = form.querySelector(`[name="${field}"]`);
                if (input) input.classList.add("error-field");
            }
            errorBox.innerHTML = msg;
            errorBox.style.display = "block";
        }
    })
    .catch(err => {
        location.reload();
    });
}
</script>
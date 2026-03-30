<%@ page contentType="text/html;charset=UTF-8" %>

<style>
.view-card {
    width: 520px;
    margin: auto;
    background: #fff;
    border-radius: 10px;
    padding: 25px 30px;
    box-shadow: 0 6px 18px rgba(0,0,0,0.15);
    font-family: Arial, sans-serif;
}

.view-header {
    text-align: center;
    margin-bottom: 25px;
}

.view-header img {
    width: 120px;
    height: 120px;
    border-radius: 50%;
    object-fit: cover;
    border: 3px solid #1e88e5;
}

.view-header h2 {
    margin-top: 15px;
    color: #1e88e5;
    font-size: 24px;
    font-weight: bold;
}

.view-row {
    display: flex;
    margin-bottom: 12px;
    font-size: 15px;
}

.view-label {
    width: 120px;
    color: #666;
    font-weight: bold;
}

.view-value {
    flex: 1;
    color: #333;
}

.view-footer {
    text-align: center;
    margin-top: 20px;
}

.close-btn {
    display: inline-block;
    padding: 8px 25px;
    background: #1e88e5;
    color: white;
    border-radius: 6px;
    cursor: pointer;
    text-decoration: none;
    font-weight: bold;
    transition: 0.2s;
}

.close-btn:hover {
    background: #1565c0;
}
</style>

<div class="view-card">

    <div class="view-header">
        <img src="${pageContext.request.contextPath}/${doctor.avatar != null ? doctor.avatar : 'images/default.png'}" alt="${doctor.name}">
        <h2>${doctor.name}</h2>
    </div>

    <div class="view-row">
        <div class="view-label">性别</div>
        <div class="view-value">${doctor.gender == 'M' ? '男' : '女'}</div>
    </div>

    <div class="view-row">
        <div class="view-label">出生日期</div>
        <div class="view-value">${doctor.birthDate}</div>
    </div>

    <div class="view-row">
        <div class="view-label">年龄</div>
        <div class="view-value">${doctor.age}岁</div>
    </div>

    <div class="view-row">
        <div class="view-label">职称</div>
        <div class="view-value">${doctor.title}</div>
    </div>

    <div class="view-row">
        <div class="view-label">薪资</div>
        <div class="view-value">￥${doctor.salary}</div>
    </div>

    <div class="view-row">
        <div class="view-label">联系电话</div>
        <div class="view-value">${doctor.phone}</div>
    </div>

    <div class="view-row">
        <div class="view-label">地址</div>
        <div class="view-value">${doctor.address}</div>
    </div>

    <div class="view-row">
        <div class="view-label">身份证号</div>
        <div class="view-value">${doctor.idCard}</div>
    </div>

    <div class="view-footer">
        <a class="close-btn" href=" " onclick="closeModal()">关闭</a >
    </div>

</div>
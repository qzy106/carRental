<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="C" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: 25760
  Date: 2019/12/19
  Time: 19:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>密码修改页面</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta http-equiv="Access-Control-Allow-Origin" content="*">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">
    <link rel="icon" href="${ctx}/resources/favicon.ico">
    <link rel="stylesheet" href="${ctx}/resources/layui/css/layui.css" media="all"/>
    <link rel="stylesheet" href="${ctx}/resources/css/index.css" media="all"/>
</head>
<body class="childrenBody">
<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
    <legend>个人信息修改页面</legend>
</fieldset>
<form class="layui-form" method="post" id="changeProfileFrm" lay-filter="changeProfileFrm">
    <div class="layui-form-item">
        <div class="layui-block">
            <label class="layui-form-label">用户姓名:</label>
            <div class="layui-input-block">
                <input type="text" name="userid" style="display: none">
                <input type="text" name="realname"  lay-verify="required" placeholder="请输入用户姓名" autocomplete="off"
                       class="layui-input">
            </div>
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-block">
            <label class="layui-form-label">登陆名称:</label>
            <div class="layui-input-block">
                <input type="text" name="loginname"  lay-verify="required" placeholder="请输入用户登陆名称" autocomplete="off"
                       class="layui-input">
            </div>
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-block">
            <label class="layui-form-label">身份证号:</label>
            <div class="layui-input-block">
                <input type="text" name="identity"  placeholder="请输入用户身份证号" autocomplete="off"
                       class="layui-input">
            </div>
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-block">
            <label class="layui-form-label">用户地址:</label>
            <div class="layui-input-block">
                <input type="text" name="address"  placeholder="请输入用户地址" autocomplete="off"
                       class="layui-input">
            </div>
        </div>
    </div>

    <div class="layui-form-item">
        <div class="layui-block">
            <label class="layui-form-label">用户电话:</label>
            <div class="layui-input-block">
                <input type="text" name="phone"  lay-verify="required|phone" placeholder="请输入用户电话" autocomplete="off"
                       class="layui-input">
            </div>
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-block">
            <label class="layui-form-label">用户性别:</label>
            <div class="layui-input-block">
                <input type="radio" name="sex" value="1"  title="男">
                <input type="radio" name="sex" value="0"  title="女">
            </div>
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-input-block">
            <button class="layui-btn" lay-submit="" lay-filter="doSubmit">立即修改</button>
            <button type="reset" class="layui-btn layui-btn-primary">重置</button>
        </div>
    </div>
</form>
<script type="text/javascript" src="${ctx}/resources/layui/layui.js"></script>


<script type="text/javascript">
    layui.use(['form', 'jquery'], function () {
        var form = layui.form;
        var $ = layui.jquery;

        $.post("${ctx}/user/loadProfile.action",function(obj){
           form.val("changeProfileFrm",obj);
        });

        form.on('submit(doSubmit)', function () {
            var params = $("#changeProfileFrm").serialize();
            $.post("${ctx}/user/updateUser.action", params, function (obj) {
                layer.msg(obj.msg);
            });
            return false; //阻止表单跳转。如果需要表单跳转，去掉这段即可。
        });

    })

</script>
</body>
</html>

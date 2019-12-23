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
    <legend>密码修改页面</legend>
</fieldset>
<form class="layui-form" method="post" id="changePwdFrm">

    <div class="layui-form-item">
        <label class="layui-form-label">用户名</label>
        <div class="layui-input-block">
            <input type="text" value="${user.realname}" readonly="readonly" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">旧密码</label>
        <div class="layui-input-block">
            <input type="password" value="" placeholder="请输入旧密码" lay-verify="required" name="oldPassword"
                   class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">新密码</label>
        <div class="layui-input-block">
            <input type="password" value="" placeholder="请输入新密码" lay-verify="required" name="newPassword"
                   id="newPassword"
                   class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">确认密码</label>
        <div class="layui-input-block">
            <input type="password" value="" placeholder="请确认密码" class="layui-input"
                   lay-verify="required|passwordConfirm">
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-input-block">
            <button class="layui-btn" lay-submit="" lay-filter="changePwd">立即修改</button>
            <button type="reset" class="layui-btn layui-btn-primary">重置</button>
        </div>
    </div>
</form>
<script type="text/javascript" src="${ctx}/resources/layui/layui.js"></script>


<script type="text/javascript">
    layui.use(['form', 'jquery'], function () {
        var form = layui.form;
        var $ = layui.jquery;
        form.verify({
            passwordConfirm: function (value, item) {
                if (value !== $("#newPassword").val()) {
                    return '两次输入的密码不一致';
                }
            }
        });


        form.on('submit(changePwd)', function () {
            var params = $("#changePwdFrm").serialize();
            $.post("${ctx}/user/changePassword.action", params, function (obj) {
                layer.msg(obj.msg);
                if (obj.code >= 0) {
                    window.parent.location = "${ctx}/Login/toLogin.action";
                }
            });
            return false; //阻止表单跳转。如果需要表单跳转，去掉这段即可。
        });

    })

</script>
</body>
</html>

<%--
  Created by IntelliJ IDEA.
  User: 25760
  Date: 2019/12/6
  Time: 15:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>菜单管理</title>

</head>
    <frameset cols="250,*" border="1">
    <frame src="${ctx }/sys/toMenuLeft.action" name="left">
    <frame src="${ctx }/sys/toMenuRight.action" name="right">
    </frameset>
</html>

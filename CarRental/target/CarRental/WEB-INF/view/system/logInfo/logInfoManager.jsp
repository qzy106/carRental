<%--
  Created by IntelliJ IDEA.
  User: 25760
  Date: 2019/12/6
  Time: 15:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <link rel="stylesheet" href="${ctx}/resources/layui/css/layui.css">
    <link rel="stylesheet" href="${ctx }/resources/css/public.css" media="all"/>
</head>
<body class="childrenBody">

<%--搜索条件开始--%>
<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
    <legend>搜索条件</legend>
</fieldset>
<form class="layui-form" method="post" id="searchFrm">
    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">登录名称:</label>
            <div class="layui-input-inline">
                <input type="text" name="loginname" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">登录ip:</label>
            <div class="layui-input-inline">
                <input type="text" name="loginip" autocomplete="off" class="layui-input">
            </div>
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">开始时间:</label>
            <div class="layui-input-inline">
                <input type="text" name="startTime" id="startTime" readonly="readonly" autocomplete="off"
                       class="layui-input">
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">截至时间:</label>
            <div class="layui-input-inline">
                <input type="text" name="endTime" id="endTime" readonly="readonly" autocomplete="off"
                       class="layui-input">
            </div>
        </div>
        <div class="layui-inline">
            <button type="button" class="layui-btn layui-btn-normal  layui-icon layui-icon-search" id="doSearch">查询
            </button>
            <button type="reset" class="layui-btn layui-btn-warm  layui-icon layui-icon-refresh">重置</button>
        </div>
    </div>

</form>
<%--搜索条件结束--%>


<%--数据表格开始--%>
<table class="layui-hide" id="logInfoTable" lay-filter="logInfoTable"></table>
<div style="display: none" id="userToolBar">
    <div class="layui-btn-container">
        <button class="layui-btn layui-btn-sm" lay-event="deleteBatch">批量删除</button>
    </div>
</div>
<div style="display: none" id="logInfoBar">
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</div>
<%--数据表格结束--%>


<script type="text/javascript" src="${ctx}/resources/layui/layui.js"></script>
<script>
    var tableIns;
    layui.use(['form', 'layer', 'jquery', 'table', 'laydate'], function () {
        var form = layui.form
            , layer = layui.layer
            , $ = layui.jquery
            , table = layui.table
            , laydate = layui.laydate;


        //时间输入框
        laydate.render({
            elem: '#startTime',
            type: 'datetime'
        });
        laydate.render({
            elem: '#endTime',
            type: 'datetime'
        });


        tableIns = table.render({
            elem: '#logInfoTable'    //渲染的目标数据
            , url: '${ctx}/logInfo/loadAllLogInfo.action'  //数据接口
            , title: '日志数据表'  //数据导出来时的标题
            , toolbar: '#userToolBar'  //头部工具栏
            , height: 'full-200'
            , cols: [[   //列表数据
                {type: 'checkbox', fixed: 'left'}
                , {field: 'id', title: 'ID', align: 'center'}
                , {field: 'loginname', title: '登录名称', align: 'center'}
                , {field: 'loginip', title: '登录ip', align: 'center'}
                , {field: 'logintime', title: '登录时间', align: 'center'}
                , {fixed: 'right', title: '操作', toolbar: '#logInfoBar', align: 'center'}
            ]]
            , page: true
            , done: function (data, curr, count) {
                //不是第一页时如果当前返回的的数据为0那么就返回上一页
                if (data.data.length == 0 && curr != 1) {
                    tableIns.reload({
                        page: {
                            curr: curr - 1
                        }
                    });
                }
            }
        });
        //模糊查询
        $("#doSearch").click(function () {
            var params = $("#searchFrm").serialize();
            alert(params);
            tableIns.reload({
                url: "${ctx}/logInfo/loadAllLogInfo.action?" + params,
                curr: 1
            })

        });

        //头工具栏事件
        table.on('toolbar(logInfoTable)', function (obj) {
            switch (obj.event) {
                case 'deleteBatch':
                    deleteBatch();
                    break;
            }

        });


        //监听行工具事件
        table.on('tool(logInfoTable)', function (obj) {
            var data = obj.data;
            console.log(data);
            if (obj.event === 'del') {
                layer.confirm('真的删除行么?', function (index) {
                    $.post("${ctx}/logInfo/DeleteLogInfo.action?id=" + data.id, function (res) {
                        layer.msg(res.msg);
                        //刷新数据 表格
                        tableIns.reload();
                    })
                });
            }
        });


        //批量删除事件
        function deleteBatch() {
            var checkStatus = table.checkStatus('logInfoTable');
            var data = checkStatus.data;
            var params = '';
            $.each(data, function (i, item) {
                if (i == 0) {
                    params += 'ids=' + item.id;
                } else {
                    params += '&ids=' + item.id;
                }
            });
            layer.confirm('真的删除所有选中行么?', function (index) {
                $.post("${ctx}/logInfo/deleteBatchLogInfo.action", params, function (res) {
                    layer.msg(res.msg);
                    //刷新数据 表格
                    tableIns.reload();
                })
            });
        }
    });

</script>
</body>
</html>

<%--
  Created by IntelliJ IDEA.
  Check: 25760
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
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">检查单号:</label>
                <div class="layui-input-inline">
                    <input type="text" name="checkid" autocomplete="off"
                           class="layui-input">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">出租单号:</label>
                <div class="layui-input-inline">
                    <input type="text" name="rentid" autocomplete="off"
                           class="layui-input">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">操作员:</label>
                <div class="layui-input-inline">
                    <input type="text" name="opername" autocomplete="off"
                           class="layui-input">
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
                <label class="layui-form-label">结束时间:</label>
                <div class="layui-input-inline">
                    <input type="text" name="endTime" id="endTime" readonly="readonly" autocomplete="off"
                           class="layui-input">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">问题描述:</label>
                <div class="layui-input-inline">
                    <input type="text" name="checkdesc" autocomplete="off"
                           class="layui-input">
                </div>
            </div>
        </div>
    </div>
    <div class="layui-form-item" style="text-align: center;">
        <div class="layui-input-block">
            <button type="button" class="layui-btn layui-btn-normal  layui-icon layui-icon-search" id="doSearch">查询
            </button>
            <button type="reset" class="layui-btn layui-btn-warm  layui-icon layui-icon-refresh">重置</button>
        </div>
    </div>
</form>
<%--搜索条件结束--%>


<%--数据表格开始--%>
<table class="layui-hide" id="checkTable" lay-filter="checkTable"></table>
<div style="display: none" id="checkToolBar">
</div>
<div style="display: none" id="checkBar">
    <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
</div>
<%--数据表格结束--%>


<%--弹出层开始--%>
<%--修改和增加弹出层开始--%>
<div style="display: none;padding: 20px" id="saveOrUpdateDiv">
    <form class="layui-form" id="addCheckForm" action="" lay-filter="addCheckForm" method="post">
        <!-- 提示：如果你不想用form，你可以换成div等任何一个普通元素 -->
        <div class="layui-form-item">
            <label class="layui-form-label">检查单号:</label>
            <div class="layui-input-block">
                <input type="text" name="checkid" readonly="readonly"
                       placeholder="请输入检查单号" id="checkid" autocomplete="off"
                       class="layui-input">
            </div>
        </div>

        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">检查时间:</label>
                <div class="layui-input-inline">
                    <input type="text" name="checkdate" placeholder="请选择检查时间" id="checkdate" autocomplete="off"
                           class="layui-input">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">存在问题:</label>
                <div class="layui-input-inline">
                    <input type="text" name="problem" lay-verify="required" placeholder="请输入出存在问题"
                           autocomplete="off" class="layui-input">
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">问题描述:</label>
            <div class="layui-input-block">
						<textarea placeholder="请输入问题描述" lay-verify="required" name="checkdesc"
                                  class="layui-textarea"></textarea>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">出租单号:</label>
            <div class="layui-input-block">
                <input type="text" name="rentid" readonly="readonly"
                       placeholder="请输入出租单号" autocomplete="off" class="layui-input">
            </div>
        </div>

        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">赔付金额:</label>
                <div class="layui-input-inline">
                    <input type="text" name="paymoney" placeholder="请输入赔付金额"
                           lay-verify="required|number" value="0" autocomplete="off"
                           class="layui-input">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">操作员:</label>
                <div class="layui-input-inline">
                    <input type="text" name="opername" placeholder="请输入操作员"
                           readonly="readonly" autocomplete="off" class="layui-input">
                </div>
            </div>
        </div>
        <div class="layui-form-item" style="text-align: center;">
            <button type="button" lay-submit="" lay-filter="doSubmit"
                    class="layui-btn layui-btn-normal  layui-icon layui-icon-release"
                    id="doSubmit">保存
            </button>
        </div>
    </form>
</div>
<%--修改和增加弹出层结束--%>
<%--弹出层结束--%>


<script type="text/javascript" src="${ctx}/resources/layui/layui.js"></script>
<script>
    var tableIns;
    layui.use(['form', 'layer', 'jquery', 'table', 'laydate'], function () {
        var form = layui.form
            , layer = layui.layer
            , $ = layui.jquery
            , table = layui.table
            , laydate = layui.laydate;


        laydate.render({
            elem: "#startTime",
            type: "datetime"

        });

        laydate.render({
            elem: "#endTime",
            type: "datetime"

        });
        laydate.render({
            elem: "#checkdate",
            type: "datetime"

        });


        tableIns = table.render({
            elem: '#checkTable'    //渲染的目标数据
            , url: '${ctx}/check/loadAllCheck.action'  //数据接口
            , title: '检查单数据表'  //数据导出来时的标题
            , toolbar: '#checkToolBar'  //头部工具栏
            , height: 'full-250'
            , cols: [[   //列表数据
                {field: 'checkid', title: '检查单号', align: 'center', width: '280'}
                , {field: 'checkdate', title: '检查日期', align: 'center', width: '180'}
                , {field: 'rentid', title: '出租单号', align: 'center', width: '280'}
                , {field: 'problem', title: '问题', align: 'center', width: '180'}
                , {field: 'checkdesc', title: '问题描述', align: 'center', width: '280'}
                , {field: 'paymoney', title: '赔付金额', align: 'center', width: '120'}
                , {field: 'createtime', title: '创建时间', align: 'center', width: '180'}
                , {field: 'opername', title: '操作员', align: 'center', width: '120'}
                , {fixed: 'right', title: '操作', toolbar: '#checkBar', width: '100', align: 'center'}
            ]]
            , page: true
        });

        //模糊查询
        $("#doSearch").click(function () {
            var params = $("#searchFrm").serialize();
            tableIns.reload({
                url: "${ctx}/check/loadAllCheck.action?" + params,
                curr: 1
            })

        });


        //监听行工具事件
        table.on('tool(checkTable)', function (obj) {
            var data = obj.data;
            console.log(data);
            if (obj.event === 'edit') {
                openEditCheck(data);
            }
        });


        var url;
        //记录打开的弹出层index
        var mainIndex;

        //打开修改页面
        function openEditCheck(data) {
            mainIndex = layer.open({
                type: 1,
                title: "修改检查单",
                content: $("#saveOrUpdateDiv"),
                area: ["800px", '450px'],
                success: function (index) {
                    //使用之间的数据填充表单
                    form.val('addCheckForm', data);
                    url = "${ctx}/check/updateCheck.action";
                }
            })
        }

        //监听保存事件
        form.on("submit(doSubmit)", function (obj) {
            //序列化表单数据
            var params = $("#addCheckForm").serialize();
            $.post(url, params, function (obj) {
                layer.msg(obj.msg);
                //关闭弹出层
                layer.close(mainIndex);
                //刷新数据 表格
                tableIns.reload();
            })
        });

    });

</script>
</body>
</html>

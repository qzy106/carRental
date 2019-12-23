<%--
  Created by IntelliJ IDEA.
  Rent: 25760
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
                <label class="layui-form-label">出租单号:</label>
                <div class="layui-input-inline">
                    <input type="text" name="rentid" autocomplete="off"
                           class="layui-input">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">身份证号:</label>
                <div class="layui-input-inline">
                    <input type="text" name="identity" autocomplete="off"
                           class="layui-input">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">车牌号:</label>
                <div class="layui-input-inline">
                    <input type="text" name="carnumber" autocomplete="off"
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
                <label class="layui-form-label">出租单状态:</label>
                <div class="layui-input-inline">
                    <input type="radio" name="rentflag" value="1" title="已归还">
                    <input type="radio" name="rentflag" value="0" title="未归还">
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
<table class="layui-hide" id="rentTable" lay-filter="rentTable"></table>
<div style="display: none" id="rentToolBar">
</div>
<script type="text/html" id="rentBar">
    {{#  if(d.rentflag ==1){ }}
    {{#  } else { }}
    <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
    {{#  } }}
</script>
<%--数据表格结束--%>


<%--弹出层开始--%>
<%--修改和增加弹出层开始--%>
<div style="display: none;padding: 20px" id="saveOrUpdateDiv">
    <form class="layui-form" id="addRentForm" action="" lay-filter="addRentForm" method="post">
        <!-- 提示：如果你不想用form，你可以换成div等任何一个普通元素 -->
        <div class="layui-form-item">
            <div class="layui-block">
                <label class="layui-form-label">出租单号:</label>
                <div class="layui-input-block">
                    <input type="text" name="rentid" readonly="readonly" autocomplete="off" class="layui-input">
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">开始时间:</label>
                <div class="layui-input-inline">
                    <input type="text" name="begindate" id="begindate" autocomplete="off"
                           class="layui-input" readonly="readonly">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">归还时间:</label>
                <div class="layui-input-inline">
                    <input type="text" name="returndate" id="returndate" placeholder="请输入还车时间" autocomplete="off"
                           lay-verify="required" class="layui-input" readonly="readonly">
                </div>
            </div>
        </div>

        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">身份证号:</label>
                <div class="layui-input-inline">
                    <input type="text" name="identity" autocomplete="off" readonly="readonly"
                           class="layui-input">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">车牌号:</label>
                <div class="layui-input-inline">
                    <input type="text" name="carnumber" autocomplete="off" readonly="readonly"
                           class="layui-input">
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">出租价格:</label>
                <div class="layui-input-inline">
                    <input type="text" name="price" autocomplete="off" lay-verify="required|number"
                           class="layui-input">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">操作员:</label>
                <div class="layui-input-inline">
                    <input type="text" name="opername" autocomplete="off" readonly="readonly"
                           class="layui-input">
                </div>
            </div>
        </div>
        <div class="layui-form-item" style="text-align: center;">
            <div class="layui-input-block">
                <button type="button" class="layui-btn layui-btn-normal layui-btn-sm layui-icon layui-icon-release"
                        lay-filter="doSubmit" lay-submit="">提交
                </button>
                <button type="reset" class="layui-btn layui-btn-warm layui-btn-sm layui-icon layui-icon-refresh">重置
                </button>
            </div>
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
            elem: "#begindate",
            type: "datetime"

        });

        laydate.render({
            elem: "#returndate",
            type: "datetime"

        });

        laydate.render({
            elem: "#startTime",
            type: "datetime"

        });

        laydate.render({
            elem: "#endTime",
            type: "datetime"

        });


        tableIns = table.render({
            elem: '#rentTable'    //渲染的目标数据
            , url: '${ctx}/rent/loadAllRent.action'  //数据接口
            , title: '出租单数据表'  //数据导出来时的标题
            , toolbar: '#rentToolBar'  //头部工具栏
            , height: 'full-250'
            , cols: [[   //列表数据
                {field: 'rentid', title: '出租单号', align: 'center', width: '280'}
                , {field: 'identity', title: '身份证号', align: 'center', width: '180'}
                , {field: 'carnumber', title: '车牌号', align: 'center', width: '150'}
                , {
                    field: 'rentflag', title: '出租单状态', align: 'center', width: '120', templet: function (d) {
                        return d.rentflag == '1' ? '<font color=blue>已归还</font>' : '<font color=red>未归还</font>';
                    }
                }
                , {field: 'begindate', title: '起租时间', align: 'center', width: '180'}
                , {field: 'returndate', title: '还车时间', align: 'center', width: '180'}
                , {field: 'price', title: '出租价格', align: 'center', width: '120'}
                , {field: 'opername', title: '操作员', align: 'center', width: '120'}
                , {field: 'createtime', title: '录入时间', align: 'center', width: '180'}
                , {fixed: 'right', title: '操作', toolbar: '#rentBar', width: '150', align: 'center'}
            ]]
            , page: true
            , done: function (data, curr, count) {
                if (data.data.length == 0 && curr != 1) {
                    tableIns.reload({
                        page: {
                            curr: curr - 1
                        }
                    })
                }
            }
        });

        //模糊查询
        $("#doSearch").click(function () {
            var params = $("#searchFrm").serialize();
            tableIns.reload({
                url: "${ctx}/rent/loadAllRent.action?" + params,
                curr: 1
            })

        });


        //监听行工具事件
        table.on('tool(rentTable)', function (obj) {
            var data = obj.data;
            console.log(data);
            if (obj.event === 'del') {
                layer.confirm('真的删除行么?', function (index) {
                    $.post("${ctx}/rent/deleteRent.action?rentid=" + data.rentid, function (res) {
                        layer.msg(res.msg);
                        //刷新数据 表格
                        tableIns.reload();
                    })
                });
            } else if (obj.event === 'edit') {
                openEditRent(data);
            }
        });


        var url;
        //记录打开的弹出层index
        var mainIndex;

        //打开修改页面
        function openEditRent(data) {
            mainIndex = layer.open({
                type: 1,
                title: "修改出租单",
                content: $("#saveOrUpdateDiv"),
                area: ["800px", '450px'],
                success: function (index) {
                    //使用之间的数据填充表单
                    form.val('addRentForm', data);
                    url = "${ctx}/rent/updateRent.action";
                }
            })
        }

        //监听保存事件
        form.on("submit(doSubmit)", function (obj) {
            //序列化表单数据
            var params = $("#addRentForm").serialize();
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

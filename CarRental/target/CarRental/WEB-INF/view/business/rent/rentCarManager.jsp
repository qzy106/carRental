<%--
  Created by IntelliJ IDEA.
  Car: 25760
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
            <div class="layui-input-inline">
                <input type="text" name="identity" id="identity" autocomplete="off" class="layui-input"
                       placeholder="请输入身份证号">
            </div>
            <button type="button" class="layui-btn layui-btn-normal  layui-icon layui-icon-search" id="doSearch">查询
            </button>
        </div>
    </div>

</form>
<%--搜索条件结束--%>


<%--数据表格开始--%>
<div style="display: none;" id="carTable_div">
    <table class="layui-hide" id="carTable" lay-filter="carTable"></table>
    <div style="display: none" id="carBar">
        <a class="layui-btn layui-btn-warm layui-btn-xs" lay-event="carRent">车辆出租</a>
        <a class="layui-btn layui-btn-xs" lay-event="viewImage">查看大图</a>
    </div>
    <%--数据表格结束--%>
</div>

<%--弹出层开始--%>
<%--修改和增加弹出层开始--%>
<div style="display: none;padding: 20px" id="saveOrUpdateDiv">
    <form class="layui-form" id="addRentForm" action="" lay-filter="addRentForm" method="post">
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


<%--查看大图的弹出层开始--%>
<div id="viewImage_div" style="display: none;text-align: center;padding-top: 10px">
    <img alt="车辆图片" id="viewCarImage" width="550px" height="300px">
</div>


<%--查看大图的弹出层结束--%>
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

        function showTable() {
            tableIns = table.render({
                elem: '#carTable'    //渲染的目标数据
                , url: '${ctx}/car/loadAllCar.action?isrenting=0'  //数据接口
                , title: '车辆列表'  //数据导出来时的标题
                , cols: [[   //列表数据
                    {field: 'carnumber', title: '车牌号', align: 'center', width: '120'}
                    , {field: 'cartype', title: '车辆类型', align: 'center', width: '100'}
                    , {field: 'color', title: '车辆颜色', align: 'center', width: '100'}
                    , {field: 'price', title: '购买价格', align: 'center', width: '120'}
                    , {field: 'rentprice', title: '出租价格', align: 'center', width: '120'}
                    , {field: 'deposit', title: '出租押金', align: 'center', width: '120'}
                    , {
                        field: 'isrenting', title: '出租状态', align: 'center', width: '80', templet: function (d) {
                            return d.isrenting == '1' ? '<font color=blue>已出租</font>' : '<font color=red>未出租</font>';
                        }
                    }
                    , {field: 'description', title: '车辆描述', align: 'center', width: '180'}
                    , {
                        field: 'carimg', title: '缩略图', align: 'center', width: '80', templet: function (d) {
                            return "<img width=40 height=40 src=${ctx}/file/downloadShowFile.action?path=" + d.carimg + "/>";
                        }
                    }
                    , {field: 'createtime', title: '录入时间', align: 'center', width: '180'}
                    , {fixed: 'right', title: '操作', toolbar: '#carBar', width: 220, align: 'center'}
                ]]
                , page: true
            });

        }


        //模糊查询
        $("#doSearch").click(function () {
            var params = $("#searchFrm").serialize();
            $.post("${ctx}/rent/checkCustomerIsExist.action", params, function (obj) {
                if (obj.code >= 0) {
                    $("#carTable_div").show();
                    showTable();
                } else {
                    $("#carTable_div").hide();
                    layer.msg("您输入的身份证号不存在，请检查后重新输入！");
                }
            })
        });


        //监听行工具事件
        table.on('tool(carTable)', function (obj) {
            var data = obj.data;
            console.log(data);
            if (obj.event === 'carRent') {
                carRent(data);
            } else if (obj.event === 'viewImage') {
                viewImage(data);
            }
        });


        var url;
        //记录打开的弹出层index
        var mainIndex;


        //查看大图
        function viewImage(data) {
            mainIndex = layer.open({
                type: 1,
                title: data.carnumber + "的车辆图片",
                content: $("#viewImage_div"),
                area: ["600px", '370px'],
                success: function (index) {
                    $("#viewCarImage").attr("src", "${ctx}/file/downloadShowFile.action?path=" + data.carimg);
                }

            })
        }

        //车辆出租
        function carRent(data) {
            mainIndex = layer.open({
                type: 1,
                title: "添加出租单",
                content: $("#saveOrUpdateDiv"),
                area: ["800px", '520px'],
                success: function (index) {
                    var identity = $("#identity").val();
                    var carnumber = data.carnumber;
                    var opername = data.opername;
                    var price = data.rentprice;
                    $.get("${ctx}/rent/initAddRentForm.action",
                        {
                            identity: identity,
                            carnumber: carnumber,
                            opername: opername,
                            price: price
                        }, function (obj) {
                            form.val("addRentForm", obj);

                        })
                }

            })
        }

        //监听保存事件
        form.on("submit(doSubmit)", function (obj) {
            //序列化表单数据
            var params = $("#addRentForm").serialize();
            $.post("${ctx}/rent/addRent.action", params, function (obj) {
                layer.msg(obj.msg);
                //关闭弹出层
                layer.close(mainIndex);
                //隐藏数据表格
                $("#carTable_div").hide();
            })
        });

    });

</script>
</body>
</html>

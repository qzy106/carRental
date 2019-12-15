<%--
  Created by IntelliJ IDEA.
  Customer: 25760
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
            <label class="layui-form-label">身份证号:</label>
            <div class="layui-input-inline">
                <input type="text" name="identity" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">客户姓名:</label>
            <div class="layui-input-inline">
                <input type="text" name="custname" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">客户地址:</label>
            <div class="layui-input-inline">
                <input type="text" name="address" autocomplete="off" class="layui-input">
            </div>
        </div>
    </div>

    <div class="layui-form-item">

        <div class="layui-inline">
            <label class="layui-form-label">客户电话:</label>
            <div class="layui-input-inline">
                <input type="text" name="phone" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">客户职业:</label>
            <div class="layui-input-inline">
                <input type="text" name="career" autocomplete="off" class="layui-input">
            </div>
        </div>

        <div class="layui-inline">
            <label class="layui-form-label">性别:</label>
            <div class="layui-input-inline">
                <input type="radio" name="sex" value="1" title="男">
                <input type="radio" name="sex" value="0" title="女">
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
<table class="layui-hide" id="customerTable" lay-filter="customerTable"></table>
<div style="display: none" id="customerToolBar">
    <div class="layui-btn-container">
        <button class="layui-btn layui-btn-sm" lay-event="add">增加</button>
        <button class="layui-btn layui-btn-sm" lay-event="deleteBatch">批量删除</button>
    </div>
</div>
<div style="display: none" id="customerBar">
    <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</div>
<%--数据表格结束--%>


<%--弹出层开始--%>
<%--修改和增加弹出层开始--%>
<div style="display: none;padding: 20px" id="saveOrUpdateDiv">
    <form class="layui-form" id="addCustomerForm" action="" lay-filter="addCustomerForm" method="post">
        <!-- 提示：如果你不想用form，你可以换成div等任何一个普通元素 -->
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">身份证号:</label>
                <div class="layui-input-inline">
                    <input type="text" name="identity" lay-verify="required" placeholder="请输入身份证号" autocomplete="off"
                           class="layui-input">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">客户姓名:</label>
                <div class="layui-input-inline">
                    <input type="text" name="custname" lay-verify="required" placeholder="请输入客户姓名" autocomplete="off"
                           class="layui-input">
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">客户电话:</label>
                <div class="layui-input-inline">
                    <input type="text" name="phone" placeholder="请输入客户电话" autocomplete="off"
                           class="layui-input">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">客户地址:</label>
                <div class="layui-input-inline">
                    <input type="text" name="address" placeholder="请输入客户地址" autocomplete="off"
                           class="layui-input">
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">客户职位:</label>
                <div class="layui-input-inline">
                    <input type="text" name="career" placeholder="请输入客户职位" autocomplete="off"
                           class="layui-input">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">客户性别:</label>
                <div class="layui-input-inline">
                    <input type="radio" name="sex" value="1" checked="checked" title="男">
                    <input type="radio" name="sex" value="0" title="女">
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
    layui.use(['form', 'layer', 'jquery', 'table'], function () {
        var form = layui.form
            , layer = layui.layer
            , $ = layui.jquery
            , table = layui.table


        tableIns = table.render({
            elem: '#customerTable'    //渲染的目标数据
            , url: '${ctx}/customer/loadAllCustomer.action'  //数据接口
            , title: '客户数据表'  //数据导出来时的标题
            , toolbar: '#customerToolBar'  //头部工具栏
            , height: 'full-150'
            , cols: [[   //列表数据
                {type: 'checkbox', fixed: 'left'}
                , {field: 'identity', title: '身份证号', align: 'center', width: '180'}
                , {field: 'custname', title: '客户姓名', align: 'center', width: '100'}
                , {field: 'phone', title: '客户电话', align: 'center', width: '120'}
                , {field: 'address', title: '客户地址', align: 'center', width: '150'}
                , {field: 'career', title: '客户职位', align: 'center', width: '120'}
                , {
                    field: 'sex', title: '性别', align: 'center', width: '80', templet: function (d) {
                        return d.sex == '1' ? '<font color=blue>男</font>' : '<font color=red>女</font>';
                    }
                }
                , {field: 'createtime', title: '录入时间', align: 'center', width: '180'}
                , {fixed: 'right', title: '操作', toolbar: '#customerBar', width: 260, align: 'center'}
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
            alert(params);
            tableIns.reload({
                url: "${ctx}/customer/loadAllCustomer.action?" + params,
                curr: 1
            })

        });

        //头工具栏事件
        table.on('toolbar(customerTable)', function (obj) {
            switch (obj.event) {
                case 'add':
                    openAddCustomer();
                    break;
                case 'deleteBatch':
                    deleteBatch();
                    break;
            }

        });


        //监听行工具事件
        table.on('tool(customerTable)', function (obj) {
            var data = obj.data;
            console.log(data);
            if (obj.event === 'del') {
                layer.confirm('真的删除行么?', function (index) {
                    $.post("${ctx}/customer/deleteCustomer.action?identity=" + data.identity, function (res) {
                        layer.msg(res.msg);
                        //刷新数据 表格
                        tableIns.reload();
                    })
                });
            } else if (obj.event === 'edit') {
                openEditCustomer(data);
            }
        });


        var url;
        //记录打开的弹出层index
        var mainIndex;

        //打开添加页面
        function openAddCustomer() {
            mainIndex = layer.open({
                type: 1,
                title: "添加客户",
                content: $("#saveOrUpdateDiv"),
                area: ["800px", '450px'],
                btnAlign: 'c',
                success: function (index) {
                    //将jquery对象转换为dom对象  [0]
                    $("#addCustomerForm")[0].reset();
                    url = "${ctx}/customer/addCustomer.action";
                }

            })
        }

        //打开修改页面
        function openEditCustomer(data) {
            mainIndex = layer.open({
                type: 1,
                title: "修改客户",
                content: $("#saveOrUpdateDiv"),
                area: ["800px", '450px'],
                success: function (index) {
                    //使用之间的数据填充表单
                    form.val('addCustomerForm', data);
                    url = "${ctx}/customer/updateCustomer.action";
                }
            })
        }

        //监听保存事件
        form.on("submit(doSubmit)", function (obj) {
            //序列化表单数据
            var params = $("#addCustomerForm").serialize();
            $.post(url, params, function (obj) {
                layer.msg(obj.msg);
                //关闭弹出层
                layer.close(mainIndex);
                //刷新数据 表格
                tableIns.reload();
            })
        });

        //批量删除事件
        function deleteBatch() {
            var checkStatus = table.checkStatus('customerTable');
            var data = checkStatus.data;
            var params = '';
            $.each(data, function (i, item) {
                if (i == 0) {
                    params += 'ids=' + item.identity;
                } else {
                    params += '&ids=' + item.identity;
                }
            });
            layer.confirm('真的删除所有选中行么?', function (index) {
                $.post("${ctx}/customer/deleteBatchCustomer.action", params, function (res) {
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

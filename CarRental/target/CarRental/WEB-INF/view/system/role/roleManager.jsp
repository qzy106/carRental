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
    <link rel="stylesheet" href="${ctx }/resources/layui_ext/dtree/dtree.css">
    <link rel="stylesheet" href="${ctx }/resources/layui_ext/dtree/font/dtreefont.css">
    <style type="text/css">
        .select-test {
            position: absolute;
            max-height: 500px;
            height: 350px;
            overflow: auto;
            width: 100%;
            z-index: 123;
            display: none;
            border: 1px solid silver;
            top: 42px;
        }

        .layui-show {
            display: block !important;
        }
    </style>
</head>
<body class="childrenBody">

<%--搜索条件开始--%>
<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
    <legend>搜索条件</legend>
</fieldset>
<form class="layui-form" method="post" id="searchFrm">
    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">角色名称:</label>
            <div class="layui-input-inline">
                <input type="text" name="rolename" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">角色备注:</label>
            <div class="layui-input-inline">
                <input type="text" name="roledesc" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">是否可用:</label>
            <div class="layui-input-inline">
                <input type="radio" name="available" value="1" title="可用" checked="checked">
                <input type="radio" name="available" value="0" title="不可用">
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
<table class="layui-hide" id="roleTable" lay-filter="roleTable"></table>
<div style="display: none" id="userToolBar">
    <div class="layui-btn-container">
        <button class="layui-btn layui-btn-sm" lay-event="add">增加</button>
        <button class="layui-btn layui-btn-sm" lay-event="deleteBatch">批量删除</button>
    </div>
</div>
<div style="display: none" id="roleBar">
    <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
    <a class="layui-btn layui-btn-xs layui-btn-warm" lay-event="dispatchMenu">分配菜单</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</div>
<%--数据表格结束--%>


<%--弹出层开始--%>
<%--修改和增加弹出层开始--%>
<div style="display: none;padding: 20px" id="saveOrUpdateDiv">
    <form class="layui-form" id="addRoleForm" action="" lay-filter="addRoleForm" method="post">
        <!-- 提示：如果你不想用form，你可以换成div等任何一个普通元素 -->

        <div class="layui-form-item">
            <label class="layui-form-label">角色名称:</label>
            <div class="layui-input-block">
                <input type="text" name="roleid" style="display: none">
                <input type="text" name="rolename" placeholder="请输入角色名称" autocomplete="off"
                       class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">角色备注:</label>
            <div class="layui-input-block">
                <input type="text" name="roledesc" placeholder="请输入角色备注" autocomplete="off"
                       class="layui-input">
            </div>
        </div>

        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">是否可用:</label>
                <div class="layui-input-inline">
                    <input type="radio" name="available" value="1" checked="checked" title="可用">
                    <input type="radio" name="available" value="0" title="不可">
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
<%--菜单分配弹出层开始--%>
<div style="display: none;padding: 20px" id="dispatchMenuDiv">
    <ul id="menuTree" class="dtree" data-id="0"></ul>
</div>
<%--菜单分配弹出层结束--%>
<%--弹出层结束--%>


<script type="text/javascript" src="${ctx}/resources/layui/layui.js"></script>
<script>
    var tableIns;
    layui.extend({
        dtree: '${ctx}/resources/layui_ext/dist/dtree'
    }).use(['form', 'layer', 'jquery', 'table', 'dtree'], function () {
        var form = layui.form
            , layer = layui.layer
            , $ = layui.jquery
            , table = layui.table
            , dtree = layui.dtree;


        tableIns = table.render({
            elem: '#roleTable'    //渲染的目标数据
            , url: '${ctx}/role/loadAllRole.action'  //数据接口
            , title: '角色数据表'  //数据导出来时的标题
            , toolbar: '#userToolBar'  //头部工具栏
            , height: 'full-150'
            , cols: [[   //列表数据
                {type: 'checkbox', fixed: 'left'}
                , {field: 'roleid', title: 'ID', align: 'center'}
                , {field: 'rolename', title: '角色名称', align: 'center'}
                , {field: 'roledesc', title: '角色备注', align: 'center'}
                , {
                    field: 'available', title: '是否可用', align: 'center', templet: function (d) {
                        return d.available === 1 ? '<font color=blue>可用</font>' : '<font color=red>不可用</font>';
                    }
                }
                , {fixed: 'right', title: '操作', toolbar: '#roleBar', align: 'center'}
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
                url: "${ctx}/role/loadAllRole.action?" + params,
                curr: 1
            })

        });

        //头工具栏事件
        table.on('toolbar(roleTable)', function (obj) {
            switch (obj.event) {
                case 'add':
                    openAddRole();
                    break;
                case 'deleteBatch':
                    deleteBatch();
                    break;
            }

        });


        //监听行工具事件
        table.on('tool(roleTable)', function (obj) {
            var data = obj.data;
            console.log(data);
            if (obj.event === 'del') {
                layer.confirm('真的删除行么?', function (index) {
                    $.post("${ctx}/role/DeleteRole.action?roleid=" + data.roleid, function (res) {
                        layer.msg(res.msg);
                        //刷新数据 表格
                        tableIns.reload();
                    })
                });
            } else if (obj.event === 'edit') {
                openEditRole(data);
            } else if (obj.event === 'dispatchMenu') {
                openDispatchMenu(data);
            }
        });


        var url;
        //记录打开的弹出层index
        var mainIndex;

        //打开添加页面
        function openAddRole() {
            mainIndex = layer.open({
                type: 1,
                title: "添加角色",
                content: $("#saveOrUpdateDiv"),
                area: ["800px", '450px'],
                btnAlign: 'c',
                success: function (index) {
                    //将jquery对象转换为dom对象  [0]
                    $("#addRoleForm")[0].reset();
                    url = "${ctx}/role/addRole.action";
                }

            })
        }

        //打开修改页面
        function openEditRole(data) {
            mainIndex = layer.open({
                type: 1,
                title: "修改角色",
                content: $("#saveOrUpdateDiv"),
                area: ["800px", '450px'],
                success: function (index) {
                    //使用之间的数据填充表单
                    form.val('addRoleForm', data);
                    url = "${ctx}/role/updateRole.action";
                }
            })
        }

        //监听保存事件
        form.on("submit(doSubmit)", function (obj) {
            //序列化表单数据
            var params = $("#addRoleForm").serialize();
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
            var checkStatus = table.checkStatus('roleTable');
            var data = checkStatus.data;
            var params = '';
            $.each(data, function (i, item) {
                if (i == 0) {
                    params += 'ids=' + item.roleid;
                } else {
                    params += '&ids=' + item.roleid;
                }
            });
            layer.confirm('真的删除所有选中行么?', function (index) {
                $.post("${ctx}/role/deleteBatchRole.action", params, function (res) {
                    layer.msg(res.msg);
                    //刷新数据 表格
                    tableIns.reload();
                })
            });
        }


        var menuTree;

        //打开菜单分配
        function openDispatchMenu(data) {
            mainIndex = layer.open({
                type: 1,
                title: "分配菜单",
                content: $("#dispatchMenuDiv"),
                area: ["400px", '500px'],
                btnAlign: 'c',
                btn: ['<div class="layui-icon layui-icon-release">确认分配</div>', '<div class="layui-icon layui-icon-close">取消分配</div>'],
                yes: function () {
                    var nodes = dtree.getCheckbarNodesParam("menuTree");
                    var params = 'roleid=' + data.roleid;
                    $.each(nodes, function (i, item) {
                        params += '&ids=' + item.nodeId;
                    });
                    $.post('${ctx}/role/saveRoleMenu.action', params, function (result) {
                        layer.msg(result.msg);
                    });
                },
                btn2: function () {
                },
                success: function (index) {
                    // 初始化树
                    menuTree = dtree.render({
                        elem: "#menuTree",
                        dataStyle: "layuiStyle",  //使用layui风格的数据格式
                        response: {message: "msg", statusCode: 0},  //修改response中返回数据的定义
                        dataFormat: "list",  //配置data的风格为list
                        checkbar: true,
                        checkbarType: "all",
                        //这里加上roleid,初始化树复选框的选中状态
                        url: "${ctx}/role/loadMenuDispatchJson.action?roleid=" + data.roleid // 使用url加载（可与data加载同时存在）
                    });
                }
            })
        }


    });

</script>
</body>
</html>

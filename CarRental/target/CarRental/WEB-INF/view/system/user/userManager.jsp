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
            <label class="layui-form-label">用户姓名:</label>
            <div class="layui-input-inline">
                <input type="text" name="realname" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">登陆名称:</label>
            <div class="layui-input-inline">
                <input type="text" name="loginname" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">用户地址:</label>
            <div class="layui-input-inline">
                <input type="text" name="address" autocomplete="off" class="layui-input">
            </div>
        </div>
    </div>

    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">用户电话:</label>
            <div class="layui-input-inline">
                <input type="text" name="phone" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">身份证号:</label>
            <div class="layui-input-inline">
                <input type="text" name="identity" autocomplete="off" class="layui-input">
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
<table class="layui-hide" id="userTable" lay-filter="userTable"></table>
<div style="display: none" id="userToolBar">
    <div class="layui-btn-container">
        <button class="layui-btn layui-btn-sm" lay-event="add">增加</button>
        <button class="layui-btn layui-btn-sm" lay-event="deleteBatch">批量删除</button>
    </div>
</div>
<div style="display: none" id="userBar">
    <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
    <a class="layui-btn layui-btn-xs layui-btn-warm" lay-event="resetUserPwd">重置密码</a>
    <a class="layui-btn layui-btn-xs layui-btn-warm" lay-event="dispatchRole">分配角色</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</div>
<%--数据表格结束--%>


<%--弹出层开始--%>
<%--修改和增加弹出层开始--%>
<div style="display: none;padding: 20px" id="saveOrUpdateDiv">
    <form class="layui-form" id="addUserForm" action="" lay-filter="addUserForm" method="post">
        <!-- 提示：如果你不想用form，你可以换成div等任何一个普通元素 -->

        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">用户姓名:</label>
                <div class="layui-input-inline">
                    <input type="text" name="userid" style="display: none">
                    <input type="text" name="realname" lay-verify="required" placeholder="请输入用户姓名" autocomplete="off"
                           class="layui-input">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">登陆名称:</label>
                <div class="layui-input-inline">
                    <input type="text" name="loginname" lay-verify="required" placeholder="请输入用户登陆名称" autocomplete="off"
                           class="layui-input">
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">身份证号:</label>
                <div class="layui-input-inline">
                    <input type="text" name="identity" placeholder="请输入用户身份证号" autocomplete="off"
                           class="layui-input">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">用户地址:</label>
                <div class="layui-input-inline">
                    <input type="text" name="address" placeholder="请输入用户地址" autocomplete="off"
                           class="layui-input">
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">用户电话:</label>
                <div class="layui-input-inline">
                    <input type="text" name="phone" lay-verify="required|phone" placeholder="请输入用户电话" autocomplete="off"
                           class="layui-input">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">用户职位:</label>
                <div class="layui-input-inline">
                    <input type="text" name="position" placeholder="请输入用户职位" autocomplete="off"
                           class="layui-input">
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">用户性别:</label>
                <div class="layui-input-inline">
                    <input type="radio" name="sex" value="1" checked="checked" title="男">
                    <input type="radio" name="sex" value="0" title="女">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">是否可用:</label>
                <div class="layui-input-inline">
                    <input type="radio" name="available" value="1" checked="checked" title="可用">
                    <input type="radio" name="available" value="0" title="不可用">
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
<%--角色分配弹出层开始--%>
<div style="display: none" id="dispatchRoleDiv">
    <table class="layui-hide" id="roleTable" lay-filter="roleTable"></table>
</div>
<%--角色分配弹出层结束--%>
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
            elem: '#userTable'    //渲染的目标数据
            , url: '${ctx}/user/loadAllUser.action'  //数据接口
            , title: '用户数据表'  //数据导出来时的标题
            , toolbar: '#userToolBar'  //头部工具栏
            , height: 'full-250'
            , cols: [[   //列表数据
                {type: 'checkbox', fixed: 'left'}
                , {field: 'userid', title: 'ID', align: 'center', width: '80'}
                , {field: 'realname', title: '用户姓名', align: 'center', width: '100'}
                , {field: 'loginname', title: '登陆名', align: 'center', width: '100'}
                , {field: 'identity', title: '身份证号', align: 'center', width: '150'}
                , {field: 'phone', title: '用户电话', align: 'center', width: '150'}
                , {field: 'address', title: '用户地址', align: 'center', width: '160'}
                , {
                    field: 'sex', title: '性别', align: 'center', width: '80', templet: function (d) {
                        return d.sex == '1' ? '<font color=blue>男</font>' : '<font color=red>女</font>';
                    }
                }
                , {
                    field: 'pwd', title: '密码', align: 'center', width: '80', templet: function (d) {
                        return "******";
                    }
                }
                , {
                    field: 'available', title: '是否可用', width: '100', align: 'center', templet: function (d) {
                        return d.available == '1' ? '<font color=blue>可用</font>' : '<font color=red>不可用</font>';
                    }
                }
                , {fixed: 'right', title: '操作', toolbar: '#userBar', width: 260, align: 'center'}
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
                url: "${ctx}/user/loadAllUser.action?" + params,
                curr: 1
            })

        });

        //头工具栏事件
        table.on('toolbar(userTable)', function (obj) {
            switch (obj.event) {
                case 'add':
                    openAddUser();
                    break;
                case 'deleteBatch':
                    deleteBatch();
                    break;
            }

        });


        //监听行工具事件
        table.on('tool(userTable)', function (obj) {
            var data = obj.data;
            console.log(data);
            if (obj.event === 'del') {
                layer.confirm('真的删除行么?', function (index) {
                    $.post("${ctx}/user/deleteUser.action?userid=" + data.userid, function (res) {
                        layer.msg(res.msg);
                        //刷新数据 表格
                        tableIns.reload();
                    })
                });
            } else if (obj.event === 'edit') {
                openEditUser(data);
            } else if (obj.event === 'dispatchRole') {
                openDispatchRole(data);
            } else if (obj.event === 'resetUserPwd') {
                layer.confirm('真的重置【' + data.realname + '】这个用户的密码吗', function (index) {
                    //向服务端发送删除指令
                    $.post("${ctx}/user/resetUserPwd.action", {userid: data.userid}, function (res) {
                        layer.msg(res.msg);
                    })
                });
            }
        });


        var url;
        //记录打开的弹出层index
        var mainIndex;

        //打开添加页面
        function openAddUser() {
            mainIndex = layer.open({
                type: 1,
                title: "添加用户",
                content: $("#saveOrUpdateDiv"),
                area: ["800px", '450px'],
                btnAlign: 'c',
                success: function (index) {
                    //将jquery对象转换为dom对象  [0]
                    $("#addUserForm")[0].reset();
                    url = "${ctx}/user/addUser.action";
                }

            })
        }

        //打开修改页面
        function openEditUser(data) {
            mainIndex = layer.open({
                type: 1,
                title: "修改用户",
                content: $("#saveOrUpdateDiv"),
                area: ["800px", '450px'],
                success: function (index) {
                    //使用之间的数据填充表单
                    form.val('addUserForm', data);
                    url = "${ctx}/user/updateUser.action";
                }
            })
        }

        //监听保存事件
        form.on("submit(doSubmit)", function (obj) {
            //序列化表单数据
            var params = $("#addUserForm").serialize();
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
            var checkStatus = table.checkStatus('userTable');
            var data = checkStatus.data;
            var params = '';
            $.each(data, function (i, item) {
                if (i == 0) {
                    params += 'ids=' + item.userid;
                } else {
                    params += '&ids=' + item.userid;
                }
            });
            layer.confirm('真的删除所有选中行么?', function (index) {
                $.post("${ctx}/user/deleteBatchUser.action", params, function (res) {
                    layer.msg(res.msg);
                    //刷新数据 表格
                    tableIns.reload();
                })
            });
        }

        //打开角色分配
        function openDispatchRole(data) {
            mainIndex = layer.open({
                type: 1,
                title: "分配角色",
                content: $("#dispatchRoleDiv"),
                area: ["800px", '300px'],
                btnAlign: 'c',
                btn: ['<div class="layui-icon layui-icon-release">确认分配</div>', '<div class="layui-icon layui-icon-close">取消分配</div>'],
                yes: function () {
                    var checkStatus = table.checkStatus('roleTable');
                    var roleData = checkStatus.data;
                    var params = 'userid=' + data.userid;
                    $.each(roleData, function (i, item) {
                        params += '&ids=' + item.roleid;
                    });
                    $.post('${ctx}/user/saveUserRole.action', params, function (obj) {
                        layer.msg(obj.msg);
                    });
                },
                btn2: function () {
                },
                success: function (index) {
                    var tableIns = table.render({
                        elem: '#roleTable'    //渲染的目标数据
                        , url: '${ctx}/user/loadUserRole.action?userid=' + data.userid  //数据接口
                        , title: '用户角色分配表'  //数据导出来时的标题
                        , cols: [[   //列表数据
                            {type: 'checkbox', fixed: 'left'}
                            , {field: 'roleid', title: 'ID', align: 'center'}
                            , {field: 'rolename', title: '角色名称', align: 'center'}
                            , {field: 'roledesc', title: '角色备注', align: 'center'}
                        ]]
                    });
                }
            })
        }


    });

</script>
</body>
</html>

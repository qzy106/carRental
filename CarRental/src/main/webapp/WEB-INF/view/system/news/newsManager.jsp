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
            <label class="layui-form-label">公告标题:</label>
            <div class="layui-input-inline">
                <input type="text" name="title" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">公告内容:</label>
            <div class="layui-input-inline">
                <input type="text" name="content" autocomplete="off" class="layui-input">
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
<table class="layui-hide" id="newsTable" lay-filter="newsTable"></table>
<div style="display: none" id="userToolBar">
    <div class="layui-btn-container">
        <button class="layui-btn layui-btn-sm" lay-event="add">增加</button>
        <button class="layui-btn layui-btn-sm" lay-event="deleteBatch">批量删除</button>
    </div>
</div>
<div style="display: none" id="newsBar">
    <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
    <a class="layui-btn layui-btn-xs layui-btn-warm" lay-event="viewNews">查看公告</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</div>
<%--数据表格结束--%>


<%--弹出层开始--%>
<%--修改和增加弹出层开始--%>
<div style="display: none;padding: 20px" id="saveOrUpdateDiv">
    <form class="layui-form" id="addNewsForm" action="" lay-filter="addNewsForm" method="post">
        <!-- 提示：如果你不想用form，你可以换成div等任何一个普通元素 -->

        <div class="layui-form-item">
            <label class="layui-form-label">公告标题:</label>
            <div class="layui-input-block">
                <input type="text" name="id" id="id" style="display: none">
                <input type="text" name="title" placeholder="请输入公告名称" autocomplete="off"
                       class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">公告内容:</label>
            <div class="layui-input-block">
                <textarea placeholder="请输入公告内容" name="content" class="layui-textarea"></textarea>
            </div>
        </div>

        <div class="layui-form-item" style="text-align: center;">
            <div class="layui-input-block">
                <button type="button" class="layui-btn layui-btn-normal layui-btn-sm layui-icon layui-icon-release"
                        lay-filter="doSubmit" lay-submit="">提交
                </button>
                <button type="reset" id="addNewsFormResetBtn"
                        class="layui-btn layui-btn-warm layui-btn-sm layui-icon layui-icon-refresh">重置
                </button>
            </div>
        </div>
    </form>
</div>
<%--修改和增加弹出层结束--%>
<%--弹出层结束--%>

<!-- 查看公告的div -->
<div id="viewNewsDiv" style="padding: 10px;display: none;">
    <h2 id="view_title" align="center"></h2>
    <hr>
    <div style="text-align: right;">
        发布人:<span id="view_opername"></span> <span style="display: inline-block;width: 20px"></span>
        发布时间:<span id="view_createtime"></span>
    </div>
    <hr>
    <div id="view_content"></div>
</div>


<script type="text/javascript" src="${ctx}/resources/layui/layui.js"></script>
<script>
    var tableIns;
    layui.use(['form', 'layer', 'jquery', 'table', 'laydate', 'layedit'], function () {
        var form = layui.form
            , layer = layui.layer
            , $ = layui.jquery
            , table = layui.table
            , laydate = layui.laydate
            , layedit = layui.layedit;


        //时间输入框
        laydate.render({
            elem: '#startTime',
            type: 'datetime'
        });
        laydate.render({
            elem: '#endTime',
            type: 'datetime'
        });


        //监听添加表单的rest按钮，清除富文本编辑器中的内容
        $("#addNewsFormResetBtn").click(function () {
            layedit.setContent(editIndex, '');

        });


        tableIns = table.render({
            elem: '#newsTable'    //渲染的目标数据
            , url: '${ctx}/news/loadAllNews.action'  //数据接口
            , title: '公告数据表'  //数据导出来时的标题
            , cellMinWidth: 100 //设置列的最小默认宽度
            , toolbar: '#userToolBar'  //头部工具栏
            , height: 'full-200'
            , cols: [[   //列表数据
                {type: 'checkbox', fixed: 'left'}
                , {field: 'id', title: 'ID', align: 'center'}
                , {field: 'title', title: '公告名称', align: 'center'}
                , {field: 'createtime', title: '发布时间', align: 'center'}
                , {field: 'opername', title: '发布人', align: 'center'}
                , {fixed: 'right', title: '操作', toolbar: '#newsBar', align: 'center', width: 220,}
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
                url: "${ctx}/news/loadAllNews.action?" + params,
                page: {curr: 1}
            })

        });

        //头工具栏事件
        table.on('toolbar(newsTable)', function (obj) {
            switch (obj.event) {
                case 'add':
                    openAddNews();
                    break;
                case 'deleteBatch':
                    deleteBatch();
                    break;
            }

        });


        //监听行工具事件
        table.on('tool(newsTable)', function (obj) {
            var data = obj.data;
            console.log(data);
            if (obj.event === 'del') {
                layer.confirm('真的删除行么?', function (index) {
                    $.post("${ctx}/news/DeleteNews.action?id=" + data.id, function (res) {
                        layer.msg(res.msg);
                        //刷新数据 表格
                        tableIns.reload();
                    })
                });
            } else if (obj.event === 'edit') {
                openEditNews(data);
            } else if (obj.event === 'viewNews') {
                viewNews(data);
            }
        });


        var url;
        //记录打开的弹出层index
        var mainIndex;

        //打开添加页面
        function openAddNews() {
            mainIndex = layer.open({
                type: 1,
                title: "添加公告",
                content: $("#saveOrUpdateDiv"),
                area: ["800px", '300px'],
                btnAlign: 'c',
                success: function (index) {
                    //将jquery对象转换为dom对象  [0]
                    $("#addNewsForm")[0].reset();
                    url = "${ctx}/news/addNews.action";
                }

            })
        }

        //打开修改页面
        function openEditNews(data) {
            mainIndex = layer.open({
                type: 1,
                title: "修改公告",
                content: $("#saveOrUpdateDiv"),
                area: ["800px", '300px'],
                success: function (index) {

                    //使用之间的数据填充表单
                    form.val('addNewsForm', data);
                    url = "${ctx}/news/updateNews.action";
                }
            })
        }

        //监听保存事件
        form.on("submit(doSubmit)", function (obj) {
            //序列化表单数据
            var params = $("#addNewsForm").serialize();
            alert(params);
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
            var checkStatus = table.checkStatus('newsTable');
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
                $.post("${ctx}/news/deleteBatchNews.action", params, function (res) {
                    layer.msg(res.msg);
                    //刷新数据 表格
                    tableIns.reload();
                })
            });
        }


        //查看公告
        function viewNews(data) {
            mainIndex = layer.open({
                type: 1,
                title: '查看公告',
                content: $("#viewNewsDiv"),
                area: ['800px', '550px'],
                success: function (index) {
                    $("#view_title").html(data.title);
                    $("#view_opername").html(data.opername);
                    $("#view_createtime").html(data.createtime);
                    $("#view_content").html(data.content);
                }
            });
        }

    });

</script>
</body>
</html>

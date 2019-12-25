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
            <label class="layui-form-label">车牌号:</label>
            <div class="layui-input-inline">
                <input type="text" name="carnumber" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">车辆类型:</label>
            <div class="layui-input-inline">
                <input type="text" name="cartype" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">车辆颜色:</label>
            <div class="layui-input-inline">
                <input type="text" name="color" autocomplete="off" class="layui-input">
            </div>
        </div>
    </div>

    <div class="layui-form-item">

        <div class="layui-inline">
            <label class="layui-form-label">车辆描述:</label>
            <div class="layui-input-inline">
                <input type="text" name="description" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">是否出租:</label>
            <div class="layui-input-inline">
                <input type="radio" name="isrenting" value="1" title="已出租">
                <input type="radio" name="isrenting" value="0" title="未出租">
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
<table class="layui-hide" id="carTable" lay-filter="carTable"></table>
<div style="display: none" id="carToolBar">
    <div class="layui-btn-container">
        <button class="layui-btn layui-btn-sm" lay-event="add">增加</button>
        <button class="layui-btn layui-btn-sm" lay-event="deleteBatch">批量删除</button>
    </div>
</div>
<div style="display: none" id="carBar">
    <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
    <a class="layui-btn layui-btn-xs" lay-event="viewImage">查看大图</a>
</div>
<%--数据表格结束--%>


<%--弹出层开始--%>
<%--修改和增加弹出层开始--%>
<div style="display: none;padding: 20px" id="saveOrUpdateDiv">
    <form class="layui-form" id="addCarForm" action="" lay-filter="addCarForm" method="post">
        <!-- 提示：如果你不想用form，你可以换成div等任何一个普通元素 -->
        <div class="layui-col-md12 layui-col-xs12">
            <div class="layui-row layui-col-space10">
                <div class="layui-col-md9 layui-col-xs7">
                    <div class="layui-form-item magt3">
                        <label class="layui-form-label">车牌号:</label>
                        <div class="layui-input-block">
                            <input type="text" name="carnumber" id="carnumber" class="layui-input" lay-verify="required"
                                   placeholder="请输入车牌号">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">车辆类型:</label>
                        <div class="layui-input-block">
                            <input type="text" name="cartype" class="layui-input" lay-verify="required"
                                   placeholder="请输入车辆类型">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">车辆颜色:</label>
                        <div class="layui-input-block">
                            <input type="text" name="color" class="layui-input" lay-verify="required"
                                   placeholder="请输入车辆颜色">
                        </div>
                    </div>
                </div>
                <div class="layui-col-md3 layui-col-xs5">
                    <div class="layui-upload-list thumbBox mag0 magt3" id="carimgDiv">
                        <!-- 显示上传的图片 -->
                        <img class="layui-upload-img thumbImg" id="showCarImg">
                        <!-- 保存当前显示图片的地址 -->
                        <input type="text" name="carimg" id="carimg" style="display: none">
                    </div>
                </div>
            </div>
            <div class="layui-form-item magb0">
                <div class="layui-inline">
                    <label class="layui-form-label">购买价格:</label>
                    <div class="layui-input-block">
                        <input type="text" name="price" class="layui-input" lay-verify="required|number"
                               placeholder="请输入购买价格">
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">出租价格:</label>
                    <div class="layui-input-block">
                        <input type="text" name="rentprice" class="layui-input" lay-verify="required|number"
                               placeholder="请输入出租价格">
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">出租押金:</label>
                    <div class="layui-input-block">
                        <input type="text" name="deposit" class="layui-input" lay-verify="required|number"
                               placeholder="请输入出租押金">
                    </div>
                </div>
            </div>
            <div class="layui-form-item magb0">
                <label class="layui-form-label">车辆描述:</label>
                <div class="layui-input-block">
                    <input type="text" name="description" class="layui-input" lay-verify="required"
                           placeholder="请输入车辆描述">
                </div>
            </div>
            <div class="layui-form-item magb0">
                <label class="layui-form-label">出租状态:</label>
                <div class="layui-input-block">
                    <input type="radio" name="isrenting" value="1" title="已出租">
                    <input type="radio" name="isrenting" value="0" title="未出租" checked="checked">
                </div>
            </div>
            <div class="layui-form-item magb0" style="text-align: center;">
                <div class="layui-input-block">
                    <button type="button" class="layui-btn layui-btn-normal layui-btn-sm layui-icon layui-icon-release"
                            lay-filter="doSubmit" lay-submit="">提交
                    </button>
                    <button type="reset" class="layui-btn layui-btn-warm layui-btn-sm layui-icon layui-icon-refresh">
                        重置
                    </button>
                </div>
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
    layui.use(['form', 'layer', 'jquery', 'table', 'upload'], function () {
        var form = layui.form
            , layer = layui.layer
            , $ = layui.jquery
            , table = layui.table
            , upload = layui.upload;


        tableIns = table.render({
            elem: '#carTable'    //渲染的目标数据
            , url: '${ctx}/car/loadAllCar.action'  //数据接口
            , title: '车辆数据表'  //数据导出来时的标题
            , toolbar: '#carToolBar'  //头部工具栏
            , height: 'full-250'
            , cols: [[   //列表数据
                {type: 'checkbox', fixed: 'left'}
                , {field: 'carnumber', title: '车牌号', align: 'center', width: '120'}
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
                url: "${ctx}/car/loadAllCar.action?" + params,
                curr: 1
            })

        });

        //头工具栏事件
        table.on('toolbar(carTable)', function (obj) {
            switch (obj.event) {
                case 'add':
                    openAddCar();
                    break;
                case 'deleteBatch':
                    deleteBatch();
                    break;
            }

        });


        //监听行工具事件
        table.on('tool(carTable)', function (obj) {
            var data = obj.data;
            console.log(data);
            if (obj.event === 'del') {
                layer.confirm('真的删除行么?', function (index) {
                    $.post("${ctx}/car/deleteCar.action?carnumber=" + data.carnumber, function (res) {
                        layer.msg(res.msg);
                        //刷新数据 表格
                        tableIns.reload();
                    })
                });
            } else if (obj.event === 'edit') {
                openEditCar(data);
            } else if (obj.event === 'viewImage') {
                viewImage(data);
            }
        });


        var url;
        //记录打开的弹出层index
        var mainIndex;

        //打开添加页面
        function openAddCar() {
            mainIndex = layer.open({
                type: 1,
                title: "添加车辆",
                content: $("#saveOrUpdateDiv"),
                area: ["1000px", '450px'],
                btnAlign: 'c',
                success: function (index) {
                    //将jquery对象转换为dom对象  [0]
                    $("#addCarForm")[0].reset();
                    //设置汽车图片为默认图片
                    $("#showCarImg").attr("src", "${ctx}/file/downloadShowFile.action?path=images/defaultImg.jpg");
                    $("#carimg").val("images/defaultImg.jpg");
                    //设置车牌号输入框为可修改
                    $("#carnumber").removeAttr("readonly");
                    url = "${ctx}/car/addCar.action";
                }

            })
        }

        //打开修改页面
        function openEditCar(data) {
            mainIndex = layer.open({
                type: 1,
                title: "修改车辆",
                content: $("#saveOrUpdateDiv"),
                area: ["1000px", '450px'],
                success: function (index) {
                    //使用之间的数据填充表单
                    form.val('addCarForm', data);
                    //显示图片
                    $("#showCarImg").attr('src', '${ctx}/file/downloadShowFile.action?path=' + data.carimg);
                    //设置车牌号的属性为只读
                    $("#carnumber").attr("readonly","readonly");
                    url = "${ctx}/car/updateCar.action";
                }
            })
        }

        //监听保存事件
        form.on("submit(doSubmit)", function (obj) {
            //序列化表单数据
            var params = $("#addCarForm").serialize();
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
            var checkStatus = table.checkStatus('carTable');
            var data = checkStatus.data;
            var params = '';
            $.each(data, function (i, item) {
                if (i == 0) {
                    params += 'ids=' + item.carnumber;
                } else {
                    params += '&ids=' + item.carnumber;
                }
            });
            layer.confirm('真的删除所有选中行么?', function (index) {
                $.post("${ctx}/car/deleteBatchCar.action", params, function (res) {
                    layer.msg(res.msg);
                    //刷新数据 表格
                    tableIns.reload();
                })
            });
        }

        //查看大图
        function viewImage(data) {
             mainIndex = layer.open({
                type: 1,
                title: data.carnumber+"的车辆图片",
                content: $("#viewImage_div"),
                area: ["600px", '370px'],
                success: function (index) {
                    $("#viewCarImage").attr("src","${ctx}/file/downloadShowFile.action?path="+data.carimg);
                }

            })
        }


        //上传图片
        //上传缩略图
        upload.render({
            elem: '#carimgDiv',
            url: '${ctx}/file/uploadFile.action',
            method: "post",  //此处是为了演示之用，实际使用中请将此删除，默认用post方式提交
            acceptMime: 'images/*',
            field: "mf",
            done: function (res, index, upload) {
                $('#showCarImg').attr('src', "${ctx}/file/downloadShowFile.action?path=" + res.data.src);
                $("#carimg").val(res.data.src);
                $('#carimgDiv').css("background", "#fff");
            }
        });

    });

</script>
</body>
</html>

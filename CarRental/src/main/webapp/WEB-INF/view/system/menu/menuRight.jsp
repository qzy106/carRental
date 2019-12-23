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
    <link rel="stylesheet" href="${ctx }/resources/css/public.css" media="all" />
	<link rel="stylesheet" href="${ctx }/resources/layui_ext/dtree/dtree.css">
	<link rel="stylesheet" href="${ctx }/resources/layui_ext/dtree/font/dtreefont.css">
    <style type="text/css">
		.select-test{position: absolute;max-height: 500px;height: 350px;overflow: auto;width: 100%;z-index: 123;display: none;border:1px solid silver;top: 42px;}
		.layui-show{display: block!important;}
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
		      <label class="layui-form-label">菜单名称:</label>
		      <div class="layui-input-inline">
		        <input type="text" name="title"  autocomplete="off" class="layui-input">
		      </div>
		    </div>
		    <div class="layui-inline">
		      <button type="button" class="layui-btn layui-btn-normal  layui-icon layui-icon-search" id="doSearch">查询</button>
		      <button type="reset" class="layui-btn layui-btn-warm  layui-icon layui-icon-refresh">重置</button>
		    </div>
	</div>
</form>
<%--搜索条件结束--%>


<%--数据表格开始--%>
<table class="layui-hide" id="menuTable" lay-filter="menuTable"></table>
<div style="display: none" id="userToolBar">
    <div class="layui-btn-container">
        <button class="layui-btn layui-btn-sm" lay-event="add">增加</button>
        <button class="layui-btn layui-btn-sm" lay-event="deleteMany">批量删除</button>
    </div>
</div>
<div style="display: none" id="menuBar">
    <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</div>
<%--数据表格结束--%>


<%--弹出层开始--%>
	<div style="display: none;padding: 20px" id="saveOrUpdateDiv" >
<form class="layui-form" id="addMenuForm" action="" lay-filter="addMenuForm" method="post"> <!-- 提示：如果你不想用form，你可以换成div等任何一个普通元素 -->
    <div class="layui-form-item">
        <label class="layui-form-label">父级菜单</label>
            <div class="layui-input-block">
              <div class="layui-unselect layui-form-select" id="pid_div">
                <div class="layui-select-title">
                  <input type="hidden" name="pid" id="pid">
                  <input type="text" name="pid_str" id="pid_str" placeholder="请选择" readonly="" class="layui-input layui-unselect">
                  <i class="layui-edge"></i>
                </div>
              </div>
              <div class="layui-card select-test" id="menuSelectDiv">
                <div class="layui-card-body">
                  <div id="toolbarDiv"><ul id="menuTree" class="dtree" data-id="0" style="width: 100%;"></ul></div>
                </div>
              </div>
            </div>
    </div>


    <div class="layui-form-item">
        <label class="layui-form-label">菜单名称:</label>
        <div class="layui-input-block">
            <input type="text" name="id" style="display:none;">
            <input type="text" name="title"  placeholder="请输入菜单名称" autocomplete="off"
                class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">菜单地址:</label>
        <div class="layui-input-block">
            <input type="text" name="href" placeholder="请输入菜单地址" autocomplete="off"
                class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">菜单图标:</label>
            <div class="layui-input-inline">
                <input type="text" name="icon"   placeholder="请输入菜单图标" lay-verify="required" autocomplete="off"
                    class="layui-input">
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">TARGET:</label>
            <div class="layui-input-inline">
                <input type="text" name="target"  placeholder="请输入TRAGET"  autocomplete="off"
                    class="layui-input">
            </div>
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">是否展开:</label>
            <div class="layui-input-inline">
                 <input type="radio" name="spread" value="1" title="展开">
                 <input type="radio" name="spread" value="0" title="不展开"  checked="checked">
            </div>
        </div>
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
          <button type="button" class="layui-btn layui-btn-normal layui-btn-sm layui-icon layui-icon-release" lay-filter="doSubmit" lay-submit="">提交</button>
          <button type="reset" class="layui-btn layui-btn-warm layui-btn-sm layui-icon layui-icon-refresh" >重置</button>
        </div>
    </div>
</form> </div>

<%--弹出层结束--%>


<script type="text/javascript" src="${ctx}/resources/layui/layui.js"></script>
<script>
     var tableIns;
    layui.extend({
		dtree:'${ctx}/resources/layui_ext/dist/dtree'
	}).use(['form', 'layedit', 'laydate', 'jquery', 'table', 'laydate','dtree'], function () {
        var form = layui.form
            , layer = layui.layer
            , layedit = layui.layedit
            , laydate = layui.laydate
            , $ = layui.jquery
            , table = layui.table
            , dtree = layui.dtree;
        laydate.render({
            elem: '#startTime'
        });


        tableIns=table.render({
            elem: '#menuTable'    //渲染的目标数据
            , url: '${ctx}/menu/loadAllMenu.action'  //数据接口
            , title: '用户数据表'  //数据导出来时的标题
            , toolbar: '#userToolBar'  //头部工具栏
            , height: 'full-150'
            ,  cols: [[   //列表数据
			     {type: 'checkbox', fixed: 'left'}
			      ,{field:'id', title:'ID',align:'center',width:'80'}
			      ,{field:'pid', title:'父节点ID',align:'center',width:'100'}
			      ,{field:'title', title:'菜单名称',align:'center',width:'120'}
			      ,{field:'href', title:'菜单地址',align:'center',width:'220'}
			      ,{field:'spread', title:'是否展开',align:'center',width:'100',templet:function(d){
			    	  return d.spread===1?'<font color=blue>展开</font>':'<font color=red>不展开</font>';
			      }}
			      ,{field:'target', title:'TARGET',align:'center',width:'100'}
			      ,{field:'icon', title:'菜单图标',align:'center',width:'100',templet:function(d){
			    	  return "<div class='layui-icon'>"+d.icon+"</div>";
			      }}
			      ,{field:'available', title:'是否可用',align:'center',width:'100',templet:function(d){
			    	  return d.available===1?'<font color=blue>可用</font>':'<font color=red>不可用</font>';
			      }}
			      ,{fixed: 'right', title:'操作', toolbar: '#menuBar', width:180,align:'center'}
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
        $("#doSearch").click(function(){
            var params=$("#searchFrm").serialize();
            alert(params);
            tableIns.reload({
                url:"${ctx}/menu/loadAllMenu.action?"+params
            })

         });

        //头工具栏事件
        table.on('toolbar(menuTable)', function (obj) {
            switch (obj.event) {
                case 'add':
                    openAddMenu();
                    break;
                case 'deleteMany':
                    layer.msg('批量删除');
                    break;
            }

        });


        //监听行工具事件
        table.on('tool(menuTable)', function (obj) {
            var data = obj.data;
            console.log(data);
            if (obj.event === 'del') {
                $.post("${ctx}/menu/checkMenuHasChildren.action?id="+data.id,function(obj){
                    if(obj.code>=0){
                        layer.msg("该节点有子节点，请先删除子节点！");
                     }else{
                        layer.confirm('真的删除行么?', function (index) {
                            $.post("${ctx}/menu/DeleteMenu.action?id="+data.id,function(res){
                                layer.msg(res.msg);
                                //刷新数据 表格
                                tableIns.reload();
                                //刷新左边的树
                                window.parent.left.menuTree.reload();
                                //刷新添加和修改的下拉树
                                menuTree.reload();
                             })
                         });
                     }
                });
            } else if (obj.event === 'edit') {
                openEditMenu(data);
            }
        });


        var url;
        //记录打开的弹出层index
        var mainIndex;

        //打开添加页面
        function openAddMenu() {
            mainIndex=layer.open({
                type: 1,
                title: "添加用户",
                content: $("#saveOrUpdateDiv"),
                area: ["800px",'450px'],
                btnAlign: 'c',
                success: function (index) {
                    //关闭父级菜单的选择框
                    $("#menuSelectDiv").removeClass("layui-show");
                    //将jquery对象转换为dom对象  [0]
                    $("#addMenuForm")[0].reset();
                    url = "${ctx}/menu/addMenu.action";
                }

            })
        }

        //打开修改页面
        function openEditMenu(data) {
            mainIndex=layer.open({
                type: 1,
                title: "修改用户",
                content: $("#saveOrUpdateDiv"),
                area: ["800px",'450px'],
                success: function (index) {
                     //关闭父级菜单的选择框
                    $("#menuSelectDiv").removeClass("layui-show");
                    //使用之间的数据填充表单
                    form.val('addMenuForm', data);
                    //获取父节点的id
                    var pid=data.pid;
                    //根据id初始化选中相应的节点
                    var params = dtree.dataInit("menuTree", pid);
                    //填充父级菜单输入框数据
                    $("#pid_str").val(params.context);
                    //移除打开的样式
                    $("#menuSelectDiv").removeClass("layui-show");
                    url = "${ctx}/menu/updateMenu.action";
                }
            })
        }

        //监听保存事件
  	    form.on("submit(doSubmit)",function(obj){
            //序列化表单数据
            var params=$("#addMenuForm").serialize();
            $.post(url,params,function(obj){
                layer.msg(obj.msg);
                //关闭弹出层
                layer.close(mainIndex);
                //刷新数据 表格
                tableIns.reload();
                //刷新左边的树
                window.parent.left.menuTree.reload();
                //刷新添加和修改的下拉树
                menuTree.reload();
            })
        });

        //初始化添加和修改页面的下拉树
        var menuTree = dtree.render({
              elem: "#menuTree",
              dataStyle: "layuiStyle",  //使用layui风格的数据格式
              response:{message:"msg",statusCode:0},  //修改response中返回数据的定义
              dataFormat: "list",  //配置data的风格为list
              url: "${ctx}/menu/loadMenuManagerLeftTreeJson.action?spread=1",  // 使用url加载（可与data加载同时存在）
              icon: "2",
              accordion:true
        });
        $("#pid_div").on("click",function(){
          $(this).toggleClass("layui-form-selected");
          $("#menuSelectDiv").toggleClass("layui-show layui-anim layui-anim-upbit");
        });
        //监听节点点击事件(刷新父级节点输入框中的值)
        dtree.on("node(menuTree)", function(obj){
          $("#pid_str").val(obj.param.context);
          $("#pid").val(obj.param.nodeId);
          $("#pid_div").toggleClass("layui-form-selected");
          $("#menuSelectDiv").toggleClass("layui-show layui-anim layui-anim-upbit");
        });


    });


       //根据菜单树刷新数据表格
        function reloadTable(id){
            tableIns.reload({
                url:"${ctx}/menu/loadAllMenu.action?id="+id
            })
        }

</script>
</body>
</html>

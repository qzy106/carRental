<%--
  Created by IntelliJ IDEA.
  User: 25760
  Date: 2019/12/19
  Time: 14:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>公司年度月份销售额统计页面</title>
    <meta charset="utf-8">
    <link rel="stylesheet" href="${ctx}/resources/layui/css/layui.css">
    <link rel="stylesheet" href="${ctx }/resources/css/public.css" media="all"/>

</head>
<body>

<div class="childrenBody">
    <fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
        <legend>搜索条件</legend>
    </fieldset>
    <form class="layui-form" method="post" id="searchFrm">
        <div class="layui-form-item">
            <div class="layui-inline">
                <div class="layui-input-inline">
                    <input type="text" class="layui-input" id="year" placeholder="yyyy" readonly="readonly" value="">
                </div>
                <button type="button" class="layui-btn layui-btn-normal  layui-icon layui-icon-search" id="doSearch">查询
                </button>
            </div>
        </div>
    </form>
</div>


<div id="container" style="height: 75%"></div>
<script src="${ctx}/resources/js/echarts.js"></script>
<script src="${ctx}/resources/js/jquery-3.4.1.js"></script>
<script type="text/javascript" src="${ctx}/resources/layui/layui.js"></script>
<script type="text/javascript">
    layui.use(['form', 'layer', 'jquery', 'table', 'laydate'], function () {
        var form = layui.form
            , layer = layui.layer
            , $ = layui.jquery
            , table = layui.table
            , laydate = layui.laydate;


        laydate.render({
            elem: '#year',
            type: 'year',
            value: new Date()
        });

        $("#doSearch").click(function () {
            loadTu();
        });

        //页面加载初渲染图
        $(function () {
            loadTu();
        });

        function loadTu() {
            var year = $("#year").val();
            if (year === '') {
                year = new Date().getFullYear();
            }
            $.get("${ctx}/stat/loadCompanyYearGradeStaticJson.action", {year: year}, function (data) {

                var dom = document.getElementById("container");
                var myChart = echarts.init(dom);
                var app = {};
                option = null;
                option = {
                    title: {
                        text: '公司年度销售额统计',
                        x: 'center'
                    },
                    tooltip: {
                        trigger: 'axis',
                        axisPointer: {            // 坐标轴指示器，坐标轴触发有效
                            type: 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
                        }
                    },
                    xAxis: {
                        type: 'category',
                        data: ['一月', '二月', '三月', '四月', '五月', '六月', '七月', '八月', '九月', '十月', '十一月', '十二月']
                    },
                    yAxis: {
                        type: 'value'
                    },
                    series: [{
                        data: data,
                        type: 'line'
                    }]
                };
                if (option && typeof option === "object") {
                    myChart.setOption(option, true);
                }


            })
        }


    })


</script>
</body>
</html>
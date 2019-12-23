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
    <title>客户地区统计页面</title>

</head>
<body>
<div id="container" style="height: 100%"></div>
<script src="${ctx}/resources/js/echarts.js"></script>
<script src="${ctx}/resources/js/jquery-3.4.1.js"></script>
<script type="text/javascript">
    $.get("${ctx}/stat/loadCustomerAreaStaticJson.action", function (data) {
        var dom = document.getElementById("container");
        var myChart = echarts.init(dom);
        var app = {};
        option = null;
        option = {
            title: {
                text: '客户地区统计',
                subtext: 'provided by qzy',
                x: 'center'
            },
            tooltip: {
                trigger: 'item',
                formatter: "{a} <br/>{b} : {c} ({d}%)"
            },
            legend: {
                orient: 'vertical',
                left: 'left',
                data: data
            },
            series: [
                {
                    name: '客户数量及占比',
                    type: 'pie',
                    radius: '55%',
                    center: ['50%', '60%'],
                    data: data,
                    itemStyle: {
                        emphasis: {
                            shadowBlur: 10,
                            shadowOffsetX: 0,
                            shadowColor: 'rgba(0, 0, 0, 0.5)'
                        }
                    }
                }
            ]
        };
        if (option && typeof option === "object") {
            myChart.setOption(option, true);
        }


    })
</script>
</body>
</html>

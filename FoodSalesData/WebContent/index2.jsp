<%@ page language="java" 
	import="com.chinasofti.analyse.FoodAnalyse,java.util.*" 
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
ArrayList<String[]> list = FoodAnalyse.OutletLocationTypePreference();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>不同地理位置的消费倾向</title>
<link href="./css/style.css" type='text/css' rel="stylesheet" />
<script src="./js/echarts.min.js"></script>
</head>
<body>
	<div class='header'>
		<p>ECharts 可视化食品零售数据分析</p>
	</div>
	<div class="content">
		<div class="nav">
			<ul>
				<li><a href="./index1.jsp">商铺不同位置的地理分布</a></li>
				<li class="current"><a href="#">地理位置针对销量、物品单价、脂肪含量的偏好</a></li>
				<li><a href="./index3.jsp">食品类别交易额对比</a></li>
				<li><a href="./index4.jsp">商店建立年份对销售额的影响</a></li>
				<li><a href="./index5.jsp">各类商品的销售量</a></li>
				<li><a href="./index6.jsp">商品销售额的最高值和最低值</a></li>
			</ul>
		</div>
		<div class="container">
			<div class="title">商品销售额的最高值和最低值</div>
			<div class="show">
				<div class='chart-type'>雷达图</div>
				<div class="color-legend">
        			<span style="color: #FF5733;">■</span> 市中心
        			<span style="color: #33FF57;">■</span> 市区
        			<span style="color: #3357FF;">■</span> 郊区
    			</div>
    			<div id="chart" style="width: 600px; height: 400px;"></div>
				<!-- <div id="main"></div> -->
			</div>
		</div>
	</div>

    <script type="text/javascript">
        var myChart = echarts.init(document.getElementById('chart'));
        var option = {
            title: {
                show: false // 隐藏标题
            },
            tooltip: {},
            radar: {
                indicator: [
                    {name: 'Avg_Sales', max: 3000},
                    {name: 'Regular Fat', max: 2500},
                    {name: 'Avg_MRP', max: 1500},
                    {name: 'Low Fat', max: 2500}
                ]
            },
            series: [{
                type: 'radar',
                data: [
                    <% 
                    for (int i = 0; i < list.size(); i+=4) {
                        if(i+3 < list.size()) {
                            String locationType = list.get(i)[0].split("_")[0];
                            String locationName = "";
                            String locationColor = "";
                            switch(locationType) {
                                case "Location1": locationName = "市中心"; locationColor = "#FF5733"; break;
                                case "Location2": locationName = "市区"; locationColor = "#33FF57"; break;
                                case "Location3": locationName = "郊区"; locationColor = "#3357FF"; break;
                            }
                    %>
                    {
                        value: [
                            <%=list.get(i)[1]%>,
                            <%=list.get(i+2)[1]%>,
                            <%=list.get(i+1)[1]%>,
                            <%=list.get(i+3)[1]%>
                        ],
                        name: '<%=locationName%>',
                        itemStyle: {
                            normal: {
                                color: '<%=locationColor%>'
                            }
                        },
                        lineStyle: {
                            normal: {
                                color: '<%=locationColor%>'
                            }
                        },
                        areaStyle: {
                            normal: {
                                opacity: 0.3,
                                color: '<%=locationColor%>'
                            }
                        },
                    },
                    <% 
                        }
                    } 
                    %>
                ]
            }]
        };
        myChart.setOption(option);
    </script>
</body>

</html>

<%@ page language="java" import="com.chinasofti.analyse.FoodAnalyse,java.util.*"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	ArrayList<String[]> list = FoodAnalyse.ageRank();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>ECharts 可视化食品零售数据分析</title>
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
				<li><a href="./index2.jsp">地理位置针对销量、物品单价、脂肪含量的偏好</a></li>
				<li><a href="./index3.jsp">食品类别交易额对比</a></li>
				<li class="current"><a href="#">商店建立年份对销售额的影响</a></li>
				<li><a href="./index5.jsp">各类商品的销售量</a></li>
				<li><a href="./index6.jsp">商品销售额的最高值和最低值</a></li>
			</ul>
		</div>
		<div class="container">
			<div class="title">商店建立年份对销售额的影响</div>
			<div class="show">
				<div class='chart-type'>柱状图</div>
				<div id="main"></div>
			</div>
		</div>
	</div>
	<script>
		//基于准备好的dom，初始化echarts实例
		var myChart = echarts.init(document.getElementById('main'));
		// 指定图表的配置项和数据
		var x = []
		var y = []
	<%for (String[] a : list) {%>
		x.push(
	<%=a[0]%>
		);
		y.push(
	<%=a[1]%>
		);
	<%}%>
		option = {
			xAxis: {
				type: 'category',
				data: ['1985', '1987', '1997', '1998', '1999', '2002', '2004','2007','2009']
			},
			yAxis: {
				type: 'value',
				max:1500,
				min:500

			},
			series: [
				{
					data: [
						{
							value: 1463,
							itemStyle: {
								color: '#a90000'
							}
						},
						932,
						930,
						{
							value: 555,
							itemStyle: {
								color: '#cccccc'
							}
						},
						930,
						929,
						930,
						926,
						928,
					],
					type: 'bar'
				}
			]
		};
		// 使用刚指定的配置项和数据显示图表。
		myChart.setOption(option);
	</script>
</body>
</html>
<%@ page language="java"
	import="com.chinasofti.analyse.FoodAnalyse,java.util.*"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	ArrayList<String[]> list = FoodAnalyse.ItemTypeSalesComparison();
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
				<li class="current"><a href="#">食品类别交易额对比</a></li>
				<li><a href="./index4.jsp">商店建立年份对销售额的影响</a></li>
				<li><a href="./index5.jsp">各类商品的销售量</a></li>
				<li><a href="./index6.jsp">商品销售额的最高值和最低值</a></li>
			</ul>
		</div>
		<div class="container">
			<div class="title">食品类别交易额对比</div>
			<div class="show">
				<div class='chart-type'>饼图</div>
				<div id="main"></div>
			</div>
		</div>
	</div>
	<script>
		//基于准备好的dom，初始化echarts实例
		var myChart = echarts.init(document.getElementById('main'));
		// 指定图表的配置项和数据
		option =
		{
			backgroundColor : '#2c343c',

			title : {
				text : '食品类别交易额对比',
				left : 'center',
				top : 20,
				textStyle : {
					color : '#ccc'
				}
			},

			tooltip : {
				trigger : 'item',
				formatter : "{a} <br/>{b} : {c} ({d}%)"
			},

			visualMap : {
				show : false,
				min : 80,
				max : 600,
				inRange : {
					colorLightness : [ 0, 1 ]
				}
			},
			series : [ {
				name : '食品种类',
				type : 'pie',
				radius : '55%',
				center : [ '50%', '50%' ],
				data : [ {
					value :
	<%=list.get(0)[1]%>
		,
					name : 'Others'
				}, {
					value :
	<%=list.get(1)[1]%>
		,
					name : 'Baking Goods'
				}, {
					value :
	<%=list.get(2)[1]%>
		,
					name : 'Soft Drinks'
				}, {
					value :
	<%=list.get(3)[1]%>
		,
					name : 'Health and Hygiene'
				}, {
					value :
	<%=list.get(4)[1]%>
		,
					name : 'Breakfast'
				}, {
					value :
	<%=list.get(5)[1]%>
		,
					name : 'Frozen Foods'
				}, {
					value :
	<%=list.get(6)[1]%>
		,
					name : 'Hard Drinks'
				}, {
					value :
	<%=list.get(7)[1]%>
		,
					name : 'Meat'
				}, {
					value :
	<%=list.get(8)[1]%>
		,
					name : 'Breads'
				}, {
					value :
	<%=list.get(9)[1]%>
		,
					name : 'Canned'
				}, {
					value :
	<%=list.get(10)[1]%>
		,
					name : 'Dairy'
				}, {
					value :
	<%=list.get(11)[1]%>
		,
					name : 'Household'
				}, {
					value :
	<%=list.get(12)[1]%>
		,
					name : 'Snack Foods'
				}, {
					value :
	<%=list.get(13)[1]%>
		,
					name : 'Fruits and Vegetables'
				}, {
					value :
	<%=list.get(14)[1]%>
		,
					name : 'Seafood'
				}, {
					value :
	<%=list.get(15)[1]%>
		,
					name : 'Starchy Foods'
				}, 
				].sort(function(a, b) {
					return a.value - b.value
				}),
				roseType : 'angle',
				label : {
					normal : {
						textStyle : {
							color : 'rgba(255, 255, 255, 0.3)'
						}
					}
				},
				labelLine : {
					normal : {
						lineStyle : {
							color : 'rgba(255, 255, 255, 0.3)'
						},
						smooth : 0.2,
						length : 10,
						length2 : 20
					}
				},
				itemStyle : {
					normal : {
						color : '#c23531',
						shadowBlur : 200,
						shadowColor : 'rgba(0, 0, 0, 0.5)'
					}
				},

				animationType : 'scale',
				animationEasing : 'elasticOut',
				animationDelay : function(idx) {
					return Math.random() * 200;
				}
			} ]
		};

		// 使用刚指定的配置项和数据显示图表。
		myChart.setOption(option);
	</script>
</body>
</html>
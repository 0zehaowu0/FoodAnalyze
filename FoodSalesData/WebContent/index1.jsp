<%@ page language="java" import="com.chinasofti.analyse.FoodAnalyse,java.util.*"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	ArrayList<String[]> list = FoodAnalyse.outletLType();
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
				<li class="current"><a href="#">商铺不同位置的地理分布</a></li>
				<li><a href="./index2.jsp">地理位置针对销量、物品单价、脂肪含量的偏好</a></li>
				<li><a href="./index3.jsp">食品类别交易额对比</a></li>
				<li><a href="./index4.jsp">商店建立年份对销售额的影响</a></li>
				<li><a href="./index5.jsp">各类商品的销售量</a></li>
				<li><a href="./index6.jsp">商品销售额的最高值和最低值</a></li>
			</ul>
		</div>
		<div class="container">
			<div class="title">商铺不同位置的地理分布</div>
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
		option = {
			backgroundColor : '#2c343c',

			title : {
				text : '商铺不同位置的地理分布',
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
				name : '商铺数量',
				type : 'pie',
				radius : '55%',
				center : [ '50%', '50%' ],
				data : [ {
					value :
	<%=list.get(0)[1]%>
		,
					name : '郊区'
				}, {
					value :
	<%=list.get(1)[1]%>
		,
					name : '市区'
				}, {
					value :
	<%=list.get(2)[1]%>
		,
					name : '市中心'
				}, ].sort(function(a, b) {
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

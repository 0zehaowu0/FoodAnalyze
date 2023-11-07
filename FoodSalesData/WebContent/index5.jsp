<%@ page language="java" import="com.chinasofti.analyse.FoodAnalyse,java.util.*"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	ArrayList<String[]> list = FoodAnalyse.numcount();
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
				<li><a href="./index4.jsp">商店建立年份对销售额的影响</a></li>
				<li class="current"><a href="#">各类商品的销售量</a></li>
				<li><a href="./index6.jsp">商品销售额的最高值和最低值</a></li>
			</ul>
		</div>
		<div class="container">
			<div class="title">各类商品的销售量</div>
			<div class="show">
				<div class='chart-type'>柱状图</div>
				<div id="main"></div>
			</div>
		</div>
	</div>
	<script>
	var chartDom = document.getElementById('main');
	var myChart = echarts.init(chartDom);
	var option;

	// prettier-ignore
	let dataAxis = ['烘焙', '面包', '早餐', '罐装', '乳品', '冷冻', '水果', '酒水', '卫生', '家居', '肉类', '其他', '海鲜', '零食', '饮料', '主食'];
	// prettier-ignore
	let data = [648, 251,110,649, 682, 856, 1232, 214, 520, 910, 425, 169, 64, 1200, 445, 148];
	let yMax = 1300;
	let dataShadow = [];
	for (let i = 0; i < data.length; i++) {
	  dataShadow.push(yMax);
	}
	option = {
	  title: {
	
	    subtext: ''
	  },
	  xAxis: {
	    data: dataAxis,
	    axisLabel: {
	      //   inside: true,
	      color: '#000'
	    },
	    axisTick: {
	      show: false
	    },
	    axisLine: {
	      show: false
	    },
	    z: 10
	  },
	  yAxis: {
	    axisLine: {
	      show: false
	    },
	    axisTick: {
	      show: false
	    },
	    axisLabel: {
	      color: '#999'
	    }
	  },
	  dataZoom: [
	    {
	      type: 'inside'
	    }
	  ],
	  series: [
	    {
	      type: 'bar',
	      showBackground: true,
	      itemStyle: {
	        color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [
	          { offset: 0, color: '#83bff6' },
	          { offset: 0.5, color: '#188df0' },
	          { offset: 1, color: '#188df0' }
	        ])
	      },
	      emphasis: {
	        itemStyle: {
	          color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [
	            { offset: 0, color: '#2378f7' },
	            { offset: 0.7, color: '#2378f7' },
	            { offset: 1, color: '#83bff6' }
	          ])
	        }
	      },
	      data: data
	    }
	  ]
	};
	// Enable data zoom when user click bar.
	const zoomSize = 6;
	myChart.on('click', function (params) {
	  console.log(dataAxis[Math.max(params.dataIndex - zoomSize / 2, 0)]);
	  myChart.dispatchAction({
	    type: 'dataZoom',
	    startValue: dataAxis[Math.max(params.dataIndex - zoomSize / 2, 0)],
	    endValue:
	      dataAxis[Math.min(params.dataIndex + zoomSize / 2, data.length - 1)]
	  });
	});

	option && myChart.setOption(option);
	</script>
</body>
</html>
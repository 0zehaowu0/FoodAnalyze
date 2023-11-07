<%@ page language="java" import="com.chinasofti.analyse.FoodAnalyse,java.util.*"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	ArrayList<String[]> list = FoodAnalyse.maxminvalue();
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
				<li><a href="./index5.jsp">各类商品的销售量</a></li>
				<li class="current"><a href="#">商品销售额的最高值和最低值</a></li>
			</ul>
		</div>
		<div class="container">
			<div class="title">商品销售额的最高值和最低值</div>
			<div class="show">
				<div class='chart-type'>柱状图</div>
				<div id="main"></div>
			</div>
		</div>
	</div>
	<script>
	//商品售出的最高值和最小值
	var app = {};

	var chartDom = document.getElementById('main');
	var myChart = echarts.init(chartDom);
	var option;

	const posList = [
	  'left',
	  'right',
	  'top',
	  'bottom',
	  'inside',
	  'insideTop',
	  'insideLeft',
	  'insideRight',
	  'insideBottom',
	  'insideTopLeft',
	  'insideTopRight',
	  'insideBottomLeft',
	  'insideBottomRight'
	];
	app.configParameters = {
	  rotate: {
	    min: -90,
	    max: 90
	  },
	  align: {
	    options: {
	      left: 'left',
	      center: 'center',
	      right: 'right'
	    }
	  },
	  verticalAlign: {
	    options: {
	      top: 'top',
	      middle: 'middle',
	      bottom: 'bottom'
	    }
	  },
	  position: {
	    options: posList.reduce(function (map, pos) {
	      map[pos] = pos;
	      return map;
	    }, {})
	  },
	  distance: {
	    min: 0,
	    max: 100
	  }
	};
	app.config = {
	  rotate: 90,
	  align: 'left',
	  verticalAlign: 'middle',
	  position: 'insideBottom',
	  distance: 15,
	  onChange: function () {
	    const labelOption = {
	      rotate: app.config.rotate,
	      align: app.config.align,
	      verticalAlign: app.config.verticalAlign,
	      position: app.config.position,
	      distance: app.config.distance
	    };
	    myChart.setOption({
	      series: [
	        {
	          label: labelOption
	        },
	        {
	          label: labelOption
	        },
	        {
	          label: labelOption
	        },
	        {
	          label: labelOption
	        }
	      ]
	    });
	  }
	};
	const labelOption = {
	  show: true,
	  position: app.config.position,
	  distance: app.config.distance,
	  align: app.config.align,
	  verticalAlign: app.config.verticalAlign,
	  rotate: app.config.rotate,
	  formatter: '{c}  {name|{a}}',
	  fontSize: 16,
	  rich: {
	    name: {}
	  }
	};
	option = {
	  tooltip: {
	    trigger: 'axis',
	    axisPointer: {
	      type: 'shadow'
	    }
	  },
	  legend: {
	    data: ['Forest', 'Steppe']
	  },
	  toolbox: {
	    show: true,
	    orient: 'vertical',
	    left: 'right',
	    top: 'center',
	    feature: {
	      mark: { show: true },
	      dataView: { show: true, readOnly: false },
	      magicType: { show: true, type: ['line', 'bar', 'stack'] },
	      restore: { show: true },
	      saveAsImage: { show: true }
	    }
	  },
	  xAxis: [
	    {
	      type: 'category',
	      axisTick: { show: false },
	      data: [
	        '烘焙',
	        '面包',
	        '早餐',
	        '罐头',
	        '乳品',
	        '冷冻',
	        '水果',
	        '酒水',
	        '卫生',
	        '家居',
	        '肉类',
	        '其他',
	        '海鲜',
	        '零食',
	        '饮料',
	        '主食'
	      ]
	    }
	  ],
	  yAxis: [
	    {
	      type: 'value'
	    }
	  ],
	  series: [
	    {
	      name: 'MAX_VALUE',
	      type: 'bar',
	      barGap: 0,
	      label: labelOption,
	      emphasis: {
	        focus: 'series'
	      },
	      data: [
	        165.65, 263.66, 234.93, 266.89, 266.69, 264.89, 264.23, 261.43, 266.69,
	        264.79, 261.59, 254.9, 240.29, 264.96, 263.59, 263.03
	      ]
	    },
	    {
	      name: 'MIN_VALUE',
	      type: 'bar',
	      label: labelOption,
	      emphasis: {
	        focus: 'series'
	      },
	      data: [
	        33.99, 31.96, 40.05, 36.35, 33.49, 31.96, 36.25, 34.25, 33.12, 32.46,
	        34.75, 35.02, 33.72, 32.36, 31.29, 34.05
	      ]
	    }
	  ]
	};

	option && myChart.setOption(option);
	</script>
</body>
</html>
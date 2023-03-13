<template>
  <div style="padding:30px">
      <h3>销售统计</h3>
      <div id="main" style="width:100%;height:500px"></div>
  </div>
</template>
<script>
import * as echarts from "echarts";
import { getstatistics } from '../../../api'
export default {
  mounted() {
    getstatistics().then(res=>{
      const { message } = res
      const { date ,legend,list} = message
      var chartDom = document.getElementById("main");
      var myChart = echarts.init(chartDom);
      var option;

    option = {
      title: {
        text: "Stacked Line"
      },
      tooltip: {
        trigger: "axis"
      },
      legend: {
        data: legend
      },
      grid: {
        left: "3%",
        right: "4%",
        bottom: "3%",
        containLabel: true
      },
      toolbox: {
        feature: {
          saveAsImage: {}
        }
      },
      xAxis: {
        type: "category",
        boundaryGap: false,
        data: date
      },
      yAxis: {
        type: "value"
      },
      series: list
    };

    option && myChart.setOption(option);
    })
    
  }
};
</script>

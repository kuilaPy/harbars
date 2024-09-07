import ApexCharts from 'apexcharts';

document.addEventListener('turbo:load', () => {
  document.querySelectorAll('[data-chart-type]').forEach(chartElement => {
    const chartType = chartElement.getAttribute('data-chart-type');
    const chartSeries = JSON.parse(chartElement.getAttribute('data-chart-series'));
    const chartCategories = JSON.parse(chartElement.getAttribute('data-chart-categories'));
    const yTile = chartElement.getAttribute('data-chart-y-name'); 
    const xTile = chartElement.getAttribute('data-chart-x-name'); 
    const showLegend = chartElement.getAttribute('data-chart-legend'); 


    console.log(showLegend)

    const options = {
      chart: {
        type: chartType,
        height: chartType == 'pie' ? 360 : 350,
        animations: {
          enabled: true,
          speed: 2000,
        }
      },
      legend: {
        show: showLegend == 'false' ? false : true
      },
      plotOptions: {
        bar: {
          distributed: true,
        },
        line: {
          distributed: true,
        },
        pie: {
          distributed: true,
        }
      },
      series: chartSeries,
      xaxis: {
        categories: chartCategories,
        title: {
          text: xTile ?? undefined,
        },
      },
      yaxis: {
        title: {
          text: yTile ?? undefined,
        }
      },
      colors: ['#2E93fA', '#66DA26', '#546E7A', '#E91E63', '#662226', '#FF9800', "#035426"]
    };

    const chart = new ApexCharts(chartElement, options);
    chart.render();
  });
});

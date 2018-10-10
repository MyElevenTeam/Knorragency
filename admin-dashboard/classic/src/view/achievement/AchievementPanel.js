Ext.define('Admin.view.achievement.AchievementPanel', {
    extend: 'Admin.view.achievement.ChartBase',
    xtype: 'achievementPanel',

    requires: [
        'Ext.chart.CartesianChart',
        'Ext.chart.axis.Category',
        'Ext.chart.axis.Numeric',
        'Ext.chart.interactions.PanZoom',
        'Ext.chart.series.Bar'
    ],

    title: 'Bar Chart',
    iconCls: 'x-fa fa-bar-chart',

    items: [{
        xtype: 'cartesian',  //笛卡尔坐标的图表
        colors: [
            '#6aa5db'
        ],
        bind: '{barData}',
        axes: [{                //轴线
            type: 'category',  //有限集合
            fields: [
                'employeeName'
            ],
            position: 'bottom'
        },{
            type: 'numeric',   //连续数字
            fields: [
                'total'
            ],
            grid: {
                odd: {
                    fill: '#e8e8e8'
                }
            },
            position: 'left'
        }],
        series: [{          
            type: 'bar',    
            xField: 'employeeName',
            yField: [
                'total'
            ]
        }] 
    }]
});

Ext.define('Admin.view.achievement.AchievementPanel', {
    extend: 'Admin.view.achievement.ChartBase',
    xtype: 'achievementPanel',

    requires: [
        'Ext.chart.CartesianChart',
        'Ext.chart.axis.Category',
        'Ext.chart.axis.Numeric',
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
        }],
        tbar:[{
                xtype: 'combobox',
                reference:'searchFieldName',
                hideLabel: true,
                store:Ext.create("Ext.data.Store", {
                    fields: ["name", "value"],
                    data: [
                        { name: '一月', value: '一月' },
                        { name: '二月', value: '二月' },
                        { name: '三月', value: '三月' },
                        { name: '四月', value: '四月' },
                        { name: '五月', value: '五月' },
                        { name: '六月', value: '六月' },
                        { name: '七月', value: '七月' },
                        { name: '八月', value: '八月' },
                        { name: '九月', value: '九月' },
                        { name: '十月', value: '十月' },
                        { name: '十一月', value: '十一月' },
                        { name: '十二月', value: '十二月' }
                    ]
                }),
                displayField: 'name',
                valueField:'value',
                value:'一月',
                editable: false,
                queryMode: 'local',
                triggerAction: 'all',
                emptyText: 'Select a state...',
                width: 135,
                listeners:{
                    select: 'searchCombobox'
                }
            }]

    }]
});

Ext.define('Admin.view.achievement.Achievement', {
    extend: 'Ext.container.Container',
    xtype: 'achievement',

    requires: [ 
        'Admin.view.achievement.AchievementViewModel',
        'Ext.layout.container.VBox',
        'Ext.layout.container.HBox',
         'Admin.view.achievement.ChartPanel',
        'Admin.view.achievement.AchievementViewModel'
    ],
    controller: 'achievementController',
    viewModel: {
        type: 'achievementViewModel'
    },
    layout: {
        type :'vbox',
        align: 'stretch'               
    },

    defaults: {
        defaults: {
            animation : !Ext.isIE9m && Ext.os.is.Desktop
        }
    },

    items : [{
        xtype: 'analysePanel',
        flex: 1,
    },{
       xtype: 'chartPanel',
       margin: '0 0 10 0',
       flex : 1
    },{
        xtype: 'sortPanel',
        flex: 1
    }]
});

Ext.define('Admin.view.achievement.Achievement', {
    extend: 'Ext.container.Container',
    xtype: 'achievement',

    requires: [
      
        'Admin.view.achievement.AchievementPanel',
        'Admin.view.achievement.AchievementViewModel',
        'Ext.ux.layout.ResponsiveColumn'
    ],
    controller: 'achievementController',
    viewModel: {
        type: 'achievementViewModel'
    },

    layout: 'responsivecolumn',

    defaults: {
        defaults: {
            animation : !Ext.isIE9m && Ext.os.is.Desktop
        }
    },

    items: [
        {
            xtype: 'achievementPanel',
            userCls: 'big-50 small-100'
        }
    ]
});

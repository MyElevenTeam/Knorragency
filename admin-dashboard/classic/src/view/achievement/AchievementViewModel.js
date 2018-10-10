Ext.define('Admin.view.achievement.AchievementViewModel', {
    extend: 'Ext.app.ViewModel',
    alias: 'viewmodel.achievementViewModel',

    stores: {
        barData: {
            model: 'Admin.model.achievement.AchievementModel',
            autoLoad: true,

           data: {
        'lists':[ {
            "total": 1000,
            "employeeName":"小红"
        },
        {
            "total": 3000,
            "employeeName":"小明"
        },
        {
            "total": 2000,
            "employeeName":"小狼"
        }
        ]
    },
    proxy: {
        type: 'memory',
        //url: '~api/search/users'  //mvc url  xxx.json
        reader:{
            type:'json',
            rootProperty:'lists'
        }
    },
        }
    }
});

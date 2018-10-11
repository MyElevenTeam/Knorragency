Ext.define('Admin.view.achievement.AchievementViewModel', {
    extend: 'Ext.app.ViewModel',
    alias: 'viewmodel.achievementViewModel',
    stores:{
            barData:{type:'achievementStore'}
    }
});

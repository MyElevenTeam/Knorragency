Ext.define('Admin.view.achievement.AchievementController', {
    extend: 'Ext.app.ViewController',
    alias: 'controller.achievementController',
   	searchCombobox:function(combo,record,index){
		var searchField = this.lookupReference('searchFieldName').getValue();
		var store =	combo.up('cartesian').getStore();
		Ext.apply(store.proxy.extraParams, {month:searchField,area:""});
		store.load();
	}
});
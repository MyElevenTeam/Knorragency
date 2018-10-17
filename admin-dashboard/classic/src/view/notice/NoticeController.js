Ext.define('Admin.view.notice.NoticeViewController', {
    extend: 'Ext.app.ViewController',
    alias: 'controller.noticeViewController',
	/*Quick Search*/	
	quickSearch:function(btn){
		var searchField = this.lookupReference('searchFieldName').getValue();
		var searchValue = this.lookupReference('searchFieldValue').getValue();
		
		var store =	btn.up('gridpanel').getStore();
		//var store = Ext.getCmp('userGridPanel').getStore();// Ext.getCmp(）需要在OrderPanel设置id属性
		Ext.apply(store.proxy.extraParams, {employeeName:"",employeeNumber:"",employeeArea:"",post:""});
		
		if(searchField==='employeeName'){
			Ext.apply(store.proxy.extraParams, {employeeName:searchValue});
		}else if(searchField==='employeeNumber'){
			Ext.apply(store.proxy.extraParams, {employeeNumber:searchValue});
		}else if(searchField==='employeeArea'){
			Ext.apply(store.proxy.extraParams, {employeeArea:searchValue});
		}else if(searchField==='post'){
			Ext.apply(store.proxy.extraParams, {post:searchValue});
		}
		store.load({params:{start:0, limit:20, page:1}});
	}
});
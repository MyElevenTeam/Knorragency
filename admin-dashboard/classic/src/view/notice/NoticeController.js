Ext.define('Admin.view.notice.NoticeController', {
    extend: 'Ext.app.ViewController',
    alias: 'controller.noticeViewController',
	/*Quick Search*/	
	openAddWindow:function(btn){
		btn.up('panel').up('container').add(Ext.widget('putOutWindow')).show();
	},
	submitAddForm:function(btn){
		 var values=btn.up('window').down('form').getValues();
		 websocket.send("成功");
		 var record = Ext.create('Admin.model.notice.NoticeModel');
         record.set(values);
         record.save();
         // Ext.getCmp("notice_panel").getStore().load();
         // Ext.data.StoreManager.lookup('noticePanelStore').load();
         // var store=Ext.data.StoreManager.lookup('noticeDate');
         // setTimeout(store.load(),'1000');
	}
});
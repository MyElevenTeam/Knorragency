Ext.define('Admin.view.notice.NoticeController', {
    extend: 'Ext.app.ViewController',
    alias: 'controller.noticeViewController',
	/*Quick Search*/	
	openAddWindow:function(btn){
		btn.up('panel').up('container').add(Ext.widget('putOutWindow')).show();
	},
	submitAddForm:function(btn){
		var store=btn.up('window').down('form').getValues();
		websocket.send(JSON.stringify({"message":store["message"],"time":store["time"]}));
	}
});
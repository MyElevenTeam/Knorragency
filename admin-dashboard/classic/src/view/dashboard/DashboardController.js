Ext.define('Admin.view.dashboard.DashboardController', {
    extend: 'Ext.app.ViewController',
    alias: 'controller.dashboard',

    init:function(){
    	Ext.Ajax.request({
            url: '/attence/isAttence',
            success: function(response, options) {
                var json = Ext.util.JSON.decode(response.responseText);
                if(json.success){
                    Ext.getCmp('work').show();
                    Ext.getCmp('out').hide();
                }else{
                    Ext.getCmp('work').hide();
                    Ext.getCmp('out').show();
                }
            }
            
        });
    }
});

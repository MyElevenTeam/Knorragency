Ext.define('Admin.view.allattence.AllAttenceViewController', {
    extend: 'Ext.app.ViewController',
    alias: 'controller.allAttenceViewController',

    searchOpen:function(btn){
      Ext.getCmp('allattence_searchOpen').hide();
      Ext.getCmp('allattence_gridfilters').show();
    },
    /*查询*/
    searchAllAttence:function(textfield,e){
        if(e.getKey() == Ext.EventObject.ENTER){
           
            var workinTime=Ext.getCmp('allattence_workinTime').getValue();
            var workoutTime=Ext.getCmp('allattence_workoutTime').getValue();

            var store = Ext.data.StoreManager.lookup('allAttenceGridStroe');
            Ext.apply(store.proxy.extraParams, {workinTime:"",workoutTime:""});
            Ext.apply(store.proxy.extraParams,{
              
              workinTime:Ext.util.Format.date(workinTime, 'Y/m/d H:i:s'),
              workoutTime:Ext.util.Format.date(workoutTime, 'Y/m/d H:i:s')
            });
            store.load({params:{start:0, limit:20, page:1}});
        }
    },
    searchClose:function(btn){
      Ext.getCmp('allattence_gridfilters').hide();
      Ext.getCmp('allattence_searchOpen').show();
    }

    
     
});

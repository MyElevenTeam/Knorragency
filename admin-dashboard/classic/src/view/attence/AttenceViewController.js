Ext.define('Admin.view.attence.AttenceViewController', {
    extend: 'Ext.app.ViewController',
    alias: 'controller.attenceViewController',

    /***********************************************请假的增删改查***********************************************************/
    /*Find All Leave*/
    openLeaveWindow:function(toolbar, rowIndex, colIndex){
      toolbar.up('panel').up('container').add(Ext.widget('leaveGridWindow')).show();
    },
    /*Add*/
    openAddWindow:function(toolbar, rowIndex, colIndex){
      toolbar.up('panel').up('container').add(Ext.widget('leaveAddWindow')).show();
    },
    /*Add Submit*/  
    submitAddForm:function(btn){
      var win    = btn.up('window');
      var form = win.down('form');
      if(form.isValid()){
        var record = Ext.create('Admin.model.leave.LeaveModel');
        var values  =form.getValues();//获取form数据
        record.set(values);
        record.save();
        var store=Ext.data.StoreManager.lookup('leaveStroe');
        setTimeout(store.load(),'1000');
        /*store.addListener('load', function() {
              Ext.Msg.alert('提示','添加成功');
        });*/
          win.close();
      }else{
        Ext.Msg.alert('提示','不允许为空');
      }
    },
    /*Delete One Row*/  
    deleteOneRow:function(grid, rowIndex, colIndex){
      var store = grid.getStore();
      var record = store.getAt(rowIndex);
      if(record.data.processStatus=="NEW"){
        Ext.MessageBox.confirm('提示', '确定要进行删除操作吗？数据将无法还原！',function(btn, text){
          if(btn=='yes'){
            store.remove(record);
          }
        }, this);
      }else{
        Ext.Msg.alert('提示', "只可以删除'新建'状态的信息！");
      }
    },
    /*Delete More Rows*/  
    deleteMoreRows:function(btn, rowIndex, colIndex){
      var grid = btn.up('gridpanel');
      var selModel = grid.getSelectionModel();
      if (selModel.hasSelection()) {
        Ext.Msg.confirm("警告", "确定要删除吗？", function (button) {
          if (button == "yes") {
            var rows = selModel.getSelection();
            var selectIds = []; //要删除的id
            Ext.each(rows, function (row) {
              if(row.data.processStatus=="NEW"){
                selectIds.push(row.data.id);
              }
            });
            Ext.Ajax.request({ 
              url : '/leave/deletes', 
              method : 'post', 
              params : { 
                //ids[] :selectIds
                ids :selectIds
              }, 
              success: function(response, options) {
                var json = Ext.util.JSON.decode(response.responseText);
                if(json.success){
                  Ext.Msg.alert('操作成功', json.msg, function() {
                  grid.getStore().reload();
                });
                }else{
                  Ext.Msg.alert('操作失败', json.msg);
                }
              }
            });
          }
        });
      }else {
        Ext.Msg.alert("错误", "没有任何行被选中，无法进行删除操作！");
      }
    },
    /***********************************************开启请假流程***********************************************************/
    /*Star Leave Process*/ 
    starLeaveProcess:function(grid, rowIndex, colIndex){
      var record = grid.getStore().getAt(rowIndex);
      Ext.Ajax.request({ 
        url : '/leave/start', 
        method : 'post', 
        params : {
          id :record.get("id")
        }, 
        success: function(response, options) {
          var json = Ext.util.JSON.decode(response.responseText);
          if(json.success){
            Ext.Msg.alert('操作成功', json.msg, function() {
            grid.getStore().reload();
          });
          }else{
            Ext.Msg.alert('操作失败', json.msg);
          }
        }
      });
    },
    /*查看审批结果*/
    LookLeave:function(grid,rowIndex, colIndex){
       var record = grid.getStore().getAt(rowIndex);
       var win=grid.up('window').up('panel').up('container').add(Ext.widget('lookLeaveWindow')).show();
       win.down('form').getForm().loadRecord(record);
    },
    /***********************************************申诉业务***********************************************************/
    openAppealWindow:function(grid,rowIndex, colIndex){
      var record = grid.getStore().getAt(rowIndex);
      if(record.data.attenceStatus!="NORMAL"){
          Ext.Msg.alert('提示','请先填写申述表',function(){
            var attenceStatus=record.get('attenceStatus');
            if(attenceStatus=='LEAVE'){
                record.data.attenceStatus='请假';
            }else if(attenceStatus=='LATER'){
                record.data.attenceStatus='迟到';
            }else if(attenceStatus=='EARLY'){
                record.data.attenceStatus='早退';
            }
              //获取选中数据的字段值：console.log(record.get('id')); 或者 console.log(record.data.id);
            if (record ) {
              var win = grid.up('panel').up('container').add(Ext.widget('appealWindow'));
              win.show();
              win.down('form').getForm().loadRecord(record);
            }
        });
      }else{
        Ext.Msg.alert('提示','上班记录正常无需申诉');
      }
    },

     /*Star Appeal Process*/ 
    starAppealProcess:function(btn){
        Ext.Ajax.request({ 
            url : '/attence/start', 
            method : 'post', 
            params : {
              id :btn.up('window').down('form').getForm().findField("id").getValue(),
              appealreason:btn.up('window').down('form').getForm().findField("appealreason").getValue()
            }, 
            success: function(response, options) {
              var json = Ext.util.JSON.decode(response.responseText);
              if(json.success){
                Ext.Msg.alert('操作成功', json.msg, function() {
                btn.up('window').close();
                Ext.data.StoreManager.lookup('attenceGridStroe').load();
              });
              }else{
                Ext.Msg.alert('操作失败', json.msg);
              }
            }
        });
    },
    /*查看申诉结果*/
    LookAppeal:function(grid,rowIndex, colIndex){
       var record = grid.getStore().getAt(rowIndex);
       var win = grid.up('panel').up('container').add(Ext.widget('lookAppealWindow'));
       win.show();
       win.down('form').getForm().loadRecord(record);
    }
  
     
});

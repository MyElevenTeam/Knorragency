Ext.define('Admin.view.contract.ContractViewController', {
    extend: 'Ext.app.ViewController',
    alias: 'controller.contractViewController',

    
    
    /*增加合同信息*/
    onAddClick:function(toolbar){
        toolbar.up('grid').up('container').add(Ext.widget('contractAddWindow')).show();
    },
    submitContractAddFormButton:function(btn){
        var win    = btn.up('window');
        var form = win.down('form');
        var record = Ext.create('Admin.model.contract.ContractModel');
        var values  =form.getValues();//获取form数据
        record.set(values);
        record.save();
        Ext.data.StoreManager.lookup('contractGridStroe').load();
        win.close();
    },
    /*上传合同信息*/
    uploadContract:function(btn){
    	btn.up('panel').up('container').add(Ext.widget('contractUploadWindow')).show();
    },
    onClickUploadFormSumbitButton: function (btn) {
  		var form = btn.up('window').down('form');
      if(form.isValid()){
          form.getForm().submit({       
              url:'/contract/uploadWord',
              method : 'POST',
              waitMsg: '正在上传，请耐心等待....',
              success: function(form, action){    
                Ext.Msg.alert('Success', action.result.msg,function(){
                  btn.up('window').close();
                  Ext.data.StoreManager.lookup('contractGridStroe').load();
                  //form.getViewModel().getStore('processDefinitionStroe').load();
                });       
              }, 
              failure: function(form, action){
                Ext.Msg.alert('Error', '上传失败');
              }
          });
      }else{
          Ext.Msg.alert('Error', '请选择文件');
      }
      
    },

    /*删除合同信息*/
	onDeleteButton:function(grid, rowIndex, colIndex){

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

	/*删除多条*/	
	deleteMoreRows:function(btn, rowIndex, colIndex){
      var grid = btn.up('gridpanel');
      var selModel = grid.getSelectionModel();
      if (selModel.hasSelection()){
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
                      url : '/contract/deletes', 
                      method : 'post', 
                      params : { 
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

   

  searchOpen:function(btn){
    Ext.getCmp('contract_searchOpen').hide();
    Ext.getCmp('contract_gridfilters').show();
  },
  /*查询*/
  searchContract:function(textfield,e){
      if(e.getKey() == Ext.EventObject.ENTER){
          var contractNumber=Ext.getCmp('contract_contractNumber').getValue();
          var customerName=Ext.getCmp('contract_customerName').getValue();
          // var employeeName=Ext.getCmp('contract_employeeName').getValue();
          // var contractType=Ext.getCmp('contract_contractType').getValue();
          // var timeStart=Ext.getCmp('contract_timeStart').getValue();
          // var timeEnd=Ext.getCmp('contract_timeEnd').getValue();

          alert(contractNumber);
          alert(customerName);
          //alert(employeeName);
          /*var store = Ext.data.StoreManager.lookup('contractGridStroe');
          Ext.apply(store.proxy.extraParams, {contractNumber:"",customerName:"",employeeName:"",contractType:"",timeStart:"",timeEnd:""});
          Ext.apply(store.proxy.extraParams,{
            contractNumber:contractNumber,
            customerName:customerName,
            employeeName:employeeName,
            contractType:contractType,
            timeStart:Ext.util.Format.date(timeStart, 'Y/m/d H:i:s'),
            timeEnd:Ext.util.Format.date(timeEnd, 'Y/m/d H:i:s')
          });
          store.load({params:{start:0, limit:20, page:1}});*/
      }
  },
  searchClose:function(btn){
    Ext.getCmp('contract_searchClose').hide();
    Ext.getCmp('contract_searchClose').show();
  },

   /*Star Leave Process*/ 
  starLeaveProcess:function(grid, rowIndex, colIndex){
    var record = grid.getStore().getAt(rowIndex);
    Ext.Ajax.request({ 
      url : '/contract/start', 
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

  /*Cancel Leave Process*/  
  cancelLeaveProcess:function(grid, rowIndex, colIndex){
    Ext.Msg.alert("Title","Cancel Leave Process");
  },
  /*查看审批结果*/
  LookContract:function(grid,rowIndex, colIndex){
     var record = grid.getStore().getAt(rowIndex);
     var win = grid.up('panel').up('container').add(Ext.widget('lookContractWindow'));
     win.show();
     win.down('form').getForm().loadRecord(record);
  }
  

});

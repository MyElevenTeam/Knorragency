Ext.define('Admin.view.contract.ContractViewController', {
    extend: 'Ext.app.ViewController',
    alias: 'controller.contractViewController',
    
    /*上传合同信息*/
    uploadContract:function(btn){
    	btn.up('panel').up('container').add(Ext.widget('contractUploadWindow')).show();
    },
    onClickUploadFormSumbitButton: function (btn) {

		var form = btn.up('window').down('form');;
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
    },

    /*查看合同信息*/
    onGridCellItemClick:function(view, td, cellIndex, record){
    	if (cellIndex === 1){
	    		var win = new Ext.window.Window({
					title:'合同细节',
					width:780,
					height:470,
					layout:'fit',
					html:"<h1 style='text-align:center;'>家乐房产中介合同</h1>"+"<br>"+
						 "<h5 style='text-align:right;'>合同编号:"+record.get('contractNumber')+"</h5>"+"<br><hr>"+
						 "<p>甲方于"+record.get('startTime')+"正式购入"+record.get('hoseName')+"一套,总价为"+record.get('total')+",失效时间为"+record.get('endTime')+"<p>"+"<br>"+
						 "<h3>甲方:"+record.get('customerName')+"&nbsp;&nbsp;乙方:"+record.get('employeeName')+"<br>"+
						 "<h5 style='text-align:right;'>签约时间:"+record.get('startTime')+"</h5>"
				});
			    win.show();
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
  LookAppeal:function(grid,rowIndex, colIndex){
     var record = grid.getStore().getAt(rowIndex);
     var win = grid.up('panel').up('container').add(Ext.widget('lookContractWindow'));
     win.show();
     win.down('form').getForm().loadRecord(record);
  }

});

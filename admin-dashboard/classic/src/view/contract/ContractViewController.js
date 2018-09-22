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
			url:'/contract',
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
				Ext.Msg.alert('Error', action.result.msg);
			}
		});
    },

    /*查看合同信息*/
    onGridCellItemClick:function(view, td, cellIndex, record){
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
    },

    /*删除合同信息*/
	onDeleteButton:function(grid, rowIndex, colIndex){

		Ext.MessageBox.confirm('提示','确定删除该合同吗？',
			function(btn,text){
				if(btn=='yes'){
					var store = grid.getStore();
					var record = store.getAt(rowIndex);
					store.remove(record);
				}

			}
		,this);
	}

    
	
});

Ext.define('Admin.view.contract.ContractViewController', {
    extend: 'Ext.app.ViewController',
    alias: 'controller.contractViewController',
    
    /*修改资料*/
	onLookButton:function(grid, rowIndex, colIndex){
		
		var record = grid.getStore().getAt(rowIndex);
		var win = new Ext.window.Window({
			title:'合同细节',
			width:780,
			height:470,
			layout:'fit',
			html:"<h1 style='text-align:center;'>家乐房产中介合同</h1>"+"<br>"+
				 "<h5 style='text-align:right;'>合同编号:"+record.data.contractNumber+"</h5>"+"<br><hr>"+
				 "<p>甲方于"+record.data.startTime+"正式购入"+record.data.hoseName+"一套,总价为"+record.data.total+",失效时间为"+record.data.endTime+"<p>"+"<br>"+
				 "<h3>甲方:"+record.data.customerName+"&nbsp;&nbsp;乙方:"+record.data.employeeName+"<br>"+
				 "<h5 style='text-align:right;'>签约时间:"+record.data.startTime+"</h5>"
		});
		win.show();

	},

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

	/*onGridCellItemClick: function(grid, cellIndex, colIndex, rowIndex){
       
        var record = grid.getStore().getAt(rowIndex);
        alert(record.get('contractNumber'));
		var win = new Ext.window.Window({
			title:'合同细节',
			width:780,
			height:470,
			layout:'fit',
			html:"<h1 style='text-align:center;'>家乐房产中介合同</h1>"+"<br>"+
				 "<h5 style='text-align:right;'>合同编号:"+record.data.contractNumber+"</h5>"+"<br><hr>"+
				 "<p>甲方于"+record.data.startTime+"正式购入"+record.data.hoseName+"一套,总价为"+record.data.total+",失效时间为"+record.data.endTime+"<p>"+"<br>"+
				 "<h3>甲方:"+record.data.customerName+"&nbsp;&nbsp;乙方:"+record.data.employeeName+"<br>"+
				 "<h5 style='text-align:right;'>签约时间:"+record.data.startTime+"</h5>"
		});
		win.show();
       
    }*/
	
});

Ext.define('Admin.view.addressList.AddressListViewController', {
    extend: 'Ext.app.ViewController',
    alias: 'controller.addressListViewController',
	/*Quick Search*/	
	quickSearch:function(btn){
		var searchField = this.lookupReference('searchFieldName').getValue();
		var searchValue = this.lookupReference('searchFieldValue').getValue();
		
		var store =	btn.up('gridpanel').getStore();
		//var store = Ext.getCmp('userGridPanel').getStore();// Ext.getCmp(）需要在OrderPanel设置id属性
		Ext.apply(store.proxy.extraParams, {employeeName:"",storeNumber:"",storeArea:"",post:""});
		
		if(searchField==='employeeName'){
			Ext.apply(store.proxy.extraParams, {employeeName:searchValue});
		}else if(searchField==='employeeNumber'){
			Ext.apply(store.proxy.extraParams, {storeNumber:searchValue});
		}else if(searchField==='employeeArea'){
			Ext.apply(store.proxy.extraParams, {storeArea:searchValue});
		}else if(searchField==='post'){
			Ext.apply(store.proxy.extraParams, {post:searchValue});
		}
		store.load({params:{start:0, limit:20, page:1}});
	},
	//发起视频会议	
	sponsorVidwoMeeting:function(btn, rowIndex, colIndex){
      	
            var grid = btn.up('gridpanel');
            var selModel = grid.getSelectionModel();
            var selectIds = []; //选中的id
            if (selModel.hasSelection()){
               var rows = selModel.getSelection();
               Ext.each(rows, function (row) {   
                      selectIds.push(row.data.id);
               });
            }
            window.open('http://localhost:8080/test');
      // if (selModel.hasSelection()){
      //     Ext.Msg.confirm("警告", "确定要删除吗？", function (button) {
      //         if (button == "yes") {
      //             var rows = selModel.getSelection();
      //             var selectIds = []; //要删除的id
      //             Ext.each(rows, function (row) {
      //               if(row.data.processStatus=="NEW"){
      //                 selectIds.push(row.data.id);
      //               }
      //             });
      //             Ext.Ajax.request({
      //                 url : '/contract/deletes', 
      //                 method : 'post', 
      //                 params : { 
      //                   ids :selectIds
      //                 }, 
      //                 success: function(response, options) {
      //                     var json = Ext.util.JSON.decode(response.responseText);
      //                     if(json.success){
      //                       Ext.Msg.alert('操作成功', json.msg, function() {
      //                             grid.getStore().reload();
      //                         });
      //                     }else{
      //                        Ext.Msg.alert('操作失败', json.msg);
      //                     }
      //                 }
      //             });
      //         }
      //     });
      // }else {
      //       Ext.Msg.alert("错误", "没有任何行被选中，无法进行删除操作！");
      // }	
   }
});
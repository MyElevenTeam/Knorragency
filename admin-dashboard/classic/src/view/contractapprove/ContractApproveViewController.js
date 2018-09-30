Ext.define('Admin.view.contractapprove.ContractApproveViewController', {
    extend: 'Ext.app.ViewController',
    alias: 'controller.contractApproveViewController',

    /*-----------------------------流程定义业务-------------------------------------------*/
	onClickProcessDefinitionGridUploadButton: function (btn) {
		btn.up('panel').up('container').add(Ext.widget('processDefinitionUploadWindow')).show();
    },
	onClickUploadFormSumbitButton: function (btn) {
		var form = btn.up('window').down('form');;
		form.getForm().submit({       
			url:'/process-definition',
			method : 'POST',
			waitMsg: '正在上传，请耐心等待....',
			success: function(form, action){    
				Ext.Msg.alert('Success', action.result.msg,function(){
					btn.up('window').close();
					Ext.data.StoreManager.lookup('processDefinitionStroe').load();
					//form.getViewModel().getStore('processDefinitionStroe').load();
				});       
			}, 
			failure: function(form, action){
				Ext.Msg.alert('Error', action.result.msg);
			}
		});
    },
  	onClickProcessDefinitionReadResourceButton: function(view, recIndex, cellIndex, item, e, record) {
 		var resourceUrl = 'process-definition/resource?pdid='+record.get('id')+'&resourceName='+record.get('resourceName');
		var win = new Ext.window.Window({
			title : '流程文件bpmn',width : 780,height : 470,layout:'fit',
			items:[{xtype:'panel',autoScroll: true}]
		});
		win.show();
		Ext.Ajax.request({
	        url:resourceUrl,
	        success: function(response,options){
				var panel =win.down('panel');
				panel.body.update("<xmp>"+response.responseText+"</xmp>");
				//panel.body.update("<textarea style='width:775px;height:420px;overflow:auto;'>"+response.responseText+"</textarea>");
	        }
		});
    },
    onClickProcessDefinitionReadDiagramResourceButton: function(view, recIndex, cellIndex, item, e, record) {
 		var diagramResourceUrl = 'process-definition/resource?pdid=' + record.get('id') + '&resourceName=' + record.get('diagramResourceName');
        var win = new Ext.window.Window({
            title: '查看流程PNG',
            width : 860,
			height : 500,
            layout: 'fit',
            items:[new Ext.Panel({         
	           resizeTabs :true,
	           autoScroll : true,
	           html:'<iframe scrolling="auto" frameborder="0" width="100%" height="100%" src='+diagramResourceUrl+'></iframe>'
	       })]
        });
        win.show();
    },
	onClickProcessDefinitionGridDeleteButton: function (view, recIndex, cellIndex, item, e, record) {
		Ext.MessageBox.confirm('提示', '确定要进行删除操作吗？数据将无法还原！',
  			function(btn, text){
            	if(btn=='yes'){
            		Ext.Ajax.request({ 
						url : '/process-definition', 
						method : 'delete', 
						params : { 
							deploymentId :record.get('deploymentId')//record.data.deploymentId
						}, 
						success: function(response, options) {
							var json = Ext.util.JSON.decode(response.responseText); 
			                Ext.Msg.alert('操作成功', json.msg, function() {
			                    view.getStore('processDefinitionGridStore').reload();
			                });
			            },
			            failure: function(response, options) {
			            	var json = Ext.util.JSON.decode(response.responseText);
			                Ext.Msg.alert('操作失败', json.msg);
			            }
					});
				}
        	}
        , this);
    },


    /*-----------------------------合同审批业务-------------------------------------------*/
    //1.签收任务
    onClickLeaveApproveClaimButton: function(view, recIndex, cellIndex, item, e, record) {
        Ext.Ajax.request({
            url: 'contract/claim/' + record.get('taskId'),
            method: 'post',
            success: function(response, options) {
                var json = Ext.util.JSON.decode(response.responseText);
                if (json.success) {
                    Ext.Msg.alert('操作成功', json.msg, function() {
                        view.getStore().reload();
                    });
                } else {
                    Ext.Msg.alert('操作失败', json.msg);
                }
            }
        });
    },
    //2.创建审批表单（并绑定Task id）
    setCurrentView: function(view, form, title) {
		var cfg = Ext.apply({
			xtype: 'contractApproveWindow',
			items: [{xtype: form}]
		},{
			title: title
		});
		var win = Ext.widget(cfg);
        view.up('panel').up('container').add(win);
        return win;
    },
    onClickLeaveApproveCompleteWindowButton: function(view, recIndex, cellIndex, item, e, record) {
    	//选中点击的行
        var taskDefinitionKey = record.get('taskDefinitionKey');

        if (taskDefinitionKey == 'deptLeaderAudit') {
            //店长审批
            var win = this.setCurrentView(view,taskDefinitionKey, '店长审批');
            win.down('form').getForm().loadRecord(record);
        } else if (taskDefinitionKey == 'managerAudit') {
        	//经理审批
        	var win = this.setCurrentView(view,taskDefinitionKey,'经理审批');
        	win.down('form').getForm().loadRecord(record);
        }
        
    },
    //3.封装审批表单数据,并以Ajax提交到后台完成任务的流程变量封装对象中。
	complete: function(url, variables,form){
		// 转换JSON为字符串
	    var keys = "", values = "", types = "";
		if (variables) {
			Ext.each(variables, function (item) {
				if (keys != "") {
					keys += ",";
					values += ",";
					types += ",";
				}
				keys += item.key;
				values += item.value;
				types += item.type;
            });
		}
		Ext.Ajax.request({
            url: url,
            method: 'post',
            params : { 
			 	keys: keys,
		        values: values,
		        types: types
			}, 
            success: function(response, options) {
                var json = Ext.util.JSON.decode(response.responseText);
                if (json.success) {
                    Ext.Msg.alert('操作成功', json.msg, function() {
                    	form.up('window').close();
                        //grid.getStore().reload();
                        Ext.data.StoreManager.lookup('leaveApproveStore').load();
                    });
                } else {
                    Ext.Msg.alert('操作失败', json.msg);
                }
            }
        });
	},
	//店长审批
    onClickDeptleaderAuditFormSubmitButton: function(btn) {
    	var form = btn.up('form');
    	var values = form.getValues();
    	var url = 'contract/complete/' + values.taskId;
    	var variables = [{
			key: 'deptLeaderPass',
			value: values.deptLeaderPass,//获取表单选择的value
			type: 'B'
		},{
			key: 'deptLeaderBackReason',
			value: values.deptLeaderBackReason,//获取表单选择的value
			type: 'S'
		}];
        this.complete(url,variables,form);
    },
    //经理审批
    onClickHrAuditFormSubmitButton: function(btn) {
        var form = btn.up('form');
    	var values = form.getValues();
    	var url = 'contract/complete/' + values.taskId;
    	var variables = [{
			key: 'hrPass',
			value: values.hrPass,//获取表单选择的value
			type: 'B'
		},{
			key: 'hrBackReason',
			value: values.hrBackReason,//获取表单选择的value
			type: 'S'
		}];
        this.complete(url,variables,form);
    }
});

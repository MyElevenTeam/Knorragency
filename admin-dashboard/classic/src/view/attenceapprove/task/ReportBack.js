Ext.define('Admin.view.attenceapprove.task.ReportBack', {
    extend: 'Ext.form.Panel',
    alias: 'widget.leavereportBack',
    requires: [
        'Ext.button.Button',
        'Ext.form.RadioGroup',
        'Ext.form.field.*'
    ],
    bodyPadding: 10,
    bodyBorder: true,
    defaults: {
        anchor: '100%'
    },
    fieldDefaults: {
        labelAlign: 'left',
        msgTarget: 'none',
        invalidCls: '' 
    },
    items: [{
    	xtype: 'textfield',
		name: 'taskId',
		fieldLabel: '任务ID',
		hidden: true,
        readOnly: true
	},{
		xtype: 'datefield',
		fieldLabel: '实际开始时间',
		format: 'Y/m/d H:i:s', 
		name: 'realityStartTime',
		emptyText:'--------请选择---------',
		allowBlank: false,
		blankText:'请选择实际开始时间'
	},{
		xtype: 'datefield',
		fieldLabel: '实际结束时间',
		format: 'Y/m/d H:i:s', 
		name: 'realityEndTime',
		emptyText:'--------请选择---------',
		allowBlank: false,
		blankText:'请选择实际结束时间'
	}],
   	bbar: [{
		xtype: 'button',
		ui: 'soft-green',
		text: '提交'	,
		handler: 'onClickReportBackFormSubmitButton'
	},{
		xtype: 'button',
		ui: 'gray',
		text: '取消',
		handler:function(btn){
			var win = btn.up('window');
	        if (win) {
	            win.close();
	        }
		}
	}]
});

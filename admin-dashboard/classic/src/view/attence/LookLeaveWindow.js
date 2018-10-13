Ext.define('Admin.view.attence.LookLeaveWindow', {
    extend: 'Ext.window.Window',
    alias: 'widget.lookLeaveWindow',
    requires: [
        'Ext.button.Button',
        'Ext.form.RadioGroup',
        'Ext.form.field.*'
    ],
    height: 600,
    width: 550,
    title:'审批结果',
    bodyPadding: 5,
    bodyBorder: true,
    defaults: {
        anchor: '100%'
    },
    fieldDefaults: {
        labelAlign: 'left',
        msgTarget: 'none',
        invalidCls: '' 
    },
    items:[
        {
            xtype: 'form',
            layout: 'form',
            padding: '10px',
            items: [
            {
                xtype: 'textfield',
                name: 'taskId',
                fieldLabel: '任务ID',
                hidden: true,
                readOnly: true
            },{
                xtype: 'textfield',
                name: 'userId',
                cls:'lookLeave',
                fieldLabel: '申请人',
                hidden: true,
                readOnly: true
            },{
                xtype: 'combobox',
                name: 'leaveType',
                cls:'lookLeave',
                fieldLabel: '请假类型',
                store: Ext.create('Ext.data.Store', {
                    fields: ['value', 'name'],
                    data : [
                        {"value":"A", "name":"带薪假期"},
                        {"value":"B", "name":"无薪假期"},
                        {"value":"C", "name":"病假"}
                    ]
                }),
                queryMode: 'local',
                displayField: 'name',
                valueField: 'value',
                allowBlank: false
            },{
                xtype: 'datefield',
                fieldLabel: '请假开始时间',
                cls:'lookLeave',
                format: 'Y/m/d H:i:s', 
                name: 'startTime'
            },{
                xtype: 'datefield',
                fieldLabel: '请假结束时间',
                cls:'lookLeave',
                format: 'Y/m/d H:i:s', 
                name: 'endTime'
            },{
                xtype : 'textareafield',
                grow: true,
                name: 'reason',
                fieldLabel: '请假原因',
                anchor: '100%'
            },{
                xtype: 'textareafield',
                name: 'depReason',
                fieldLabel: '部门经理审批意见',
                emptyText: '部门经理还未审批',
                readOnly: true 
            },{
                xtype: 'textareafield',
                name: 'hrReason',
                fieldLabel: '人事文员审批意见',
                emptyText: '人事文员还未审批',
                readOnly: true
            }]
        }
    ]
});

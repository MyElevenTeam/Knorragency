Ext.define('Admin.view.attence.LeaveGridWindow', {
    extend: 'Ext.window.Window',
    alias: 'widget.leaveGridWindow',
    height: 550,
    minHeight: 500,
    //minWidth: 600,
    width:1200,
    scrollable: true,
    title: '我的请假单',
    closable: true,
    constrain: false,
    autoScroll:true,
    
    requires: [
        'Ext.form.field.*',
        'Ext.grid.plugin.RowEditing'
    ],
    header: {
        items:[
            {
                iconCls:'fa fa-search',
                ui: 'header',
                tooltip: '查找',
                handler:'hhh'  
            },
            {
                iconCls:'fa fa-trash',
                ui: 'header',
                id: 'leaveGridPanelRemove',
                disabled: true,
                tooltip: '删除多条',
                handler:'deleteMoreRows'  
            }
        ]
    },  
    listeners: {
		selectionchange: function(selModel, selections){
			if(selections.length>1){
				Ext.getCmp('#leaveGridPanelRemove').setDisabled(false);
			}
		}
	},
    modal:true,
    layout: 'fit',
    items: [
        {
            xtype:'gridpanel',
            bind: '{leaveLists}',
            //scrollable: false,
            autoScroll:true,
            selModel: {type: 'checkboxmodel'},
            plugins: {
                rowediting: {
                    clicksToEdit: 2
                }
            },
            columns: [
                 {header: 'id',dataIndex:'id',width: 60,sortable: true,hidden:true}
                ,{header: '审核状态',dataIndex: 'processStatus',width: 60,sortable: true,
                    renderer: function(val) {
                        if (val =='NEW') {
                            return '<span style="color:green;">新建</span>';
                        } else if (val =='APPROVAL') {
                            return '<span style="color:blue;">审批中...</span>';
                        } else if (val =='COMPLETE') {
                            return '<span style="color:orange;">完成审批</span>';
                        }else{
                            return '<span style="color:red;">取消申请</span>';
                        }
                        return val;
                    }
                }
                ,{header: '申请人',dataIndex: 'userId',width: 60,sortable: true}
                ,{header: '开始时间',dataIndex: 'startTime',width: 180,sortable: true,renderer:Ext.util.Format.dateRenderer('Y/m/d H:i:s'),
                    editor: {
                        xtype:'datefield',
                        value:new Date(),
                        minValue: new Date(),
                        format: 'Y/m/d H:i:s', 
                        altFormats : "Y/m/d|Ymd"
                    }
                 }
                ,{header: '结束时间',dataIndex: 'endTime',width: 180,sortable: true,renderer: Ext.util.Format.dateRenderer('Y/m/d H:i:s'),
                    editor: {
                        xtype:'datefield',
                        value:new Date(),
                        minValue: new Date(),
                        format: 'Y/m/d H:i:s', 
                        altFormats : "Y/m/d|Ymd"
                    }
                 }
                ,{header: '请假类型',dataIndex: 'leaveType',width: 120,sortable: true,
                    renderer: function(val) {
                        if (val =='A') {
                            return '<span style="color:green;">带薪假期</span>';
                        } else if (val =='B') {
                            return '<span style="color:red;">无薪假期</span>';
                        } else if (val =='C') {
                            return '<span style="color:blue;">病假</span>';
                        }
                        return val;
                    },
                    editor: {
                        xtype: 'combobox',
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
                        valueField: 'value'
                    }
                }
                ,{header: '请假原因',dataIndex: 'reason',width: 220,sortable: true,editor: 'textfield'}
                ,{header: '部门经理审批意见',dataIndex: 'depReason',width: 220,sortable: true,hidden:true}
                ,{header: '人事经理审批意见',dataIndex: 'hrReason',width: 220,sortable: true,hidden:true}
                ,{xtype: 'actioncolumn',cls: 'content-column', width: 120,text: '操作',tooltip: 'edit ',
                    items: [
                        //{xtype: 'button', iconCls: 'x-fa fa-pencil',handler: 'openEditWindow'},
                        {xtype: 'button',iconCls: 'x-fa fa-close',handler: 'deleteOneRow'},
                        {
                            xtype: 'button',iconCls: 'x-fa fa-star',tooltip: '发起请假',
                            getClass: function(v, meta, rec) {
                                if (rec.get('processInstanceId')!="") {
                                    return 'x-hidden';
                                }
                                return 'x-fa fa-star';
                            },
                            handler: 'starLeaveProcess'
                        },
                        {
                            xtype: 'button',iconCls: 'x-fa fa-ban',tooltip: '取消请假',
                            getClass: function(v, meta, rec) {
                                if (rec.get('processInstanceId')=="") {
                                    return 'x-hidden';
                                }
                                return 'x-fa fa-ban';
                            },
                            handler: 'cancelLeaveProcess'
                        },
                        {
                            xtype: 'button',iconCls: 'x-fa fa-file-text-o',tooltip: '查看审批结果',
                            getClass: function(v, meta, rec) {
                                if (rec.get('processStatus')=='COMPLETE') {
                                    return 'x-fa fa-file-text-o';
                                }
                                return 'x-hidden';
                            },
                            handler: 'LookLeave'
                        }
                    ]
                }
            ],
            dockedItems: [{
                xtype: 'pagingtoolbar',
                dock: 'bottom',
                displayInfo: true,
                bind: '{leaveLists}'
            }]
        }
    ]
});



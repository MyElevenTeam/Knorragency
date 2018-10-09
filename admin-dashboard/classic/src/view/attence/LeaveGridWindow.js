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
    ],
    header: {
        items:[
            {
                iconCls:'fa fa-search',
                ui: 'header',
                tooltip: '查找',
                handler:'hhh'  
            }
        ]
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
                ,{header: '开始时间',dataIndex: 'startTime',width: 180,sortable: true,renderer:Ext.util.Format.dateRenderer('Y/m/d H:i:s')}
                ,{header: '结束时间',dataIndex: 'endTime',width: 180,sortable: true,renderer: Ext.util.Format.dateRenderer('Y/m/d H:i:s')}
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
                    }
                }
                ,{header: '请假原因',dataIndex: 'reason',width: 220,sortable: true}
                //,{header: 'realityStartTime',dataIndex: 'realityStartTime',width: 60,sortable: true,renderer: Ext.util.Format.dateRenderer('Y/m/d H:i:s')}
                //,{header: 'realityEndTime',dataIndex: 'realityEndTime',width: 60,sortable: true,renderer: Ext.util.Format.dateRenderer('Y/m/d H:i:s')}
                ,{header: '经理意见',dataIndex: 'depReason',width: 120,sortable: true}
                ,{header: '人事经理意见' ,dataIndex: 'hrReason',width: 120,sortable: true}
                ,{xtype: 'actioncolumn',cls: 'content-column', width: 120,text: '操作',tooltip: 'edit ',
                    items: [
                        {xtype: 'button', iconCls: 'x-fa fa-pencil',handler: 'openEditWindow'},
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
                        },{
                            xtype: 'button',iconCls: 'x-fa fa-ban',tooltip: '取消请假',
                            getClass: function(v, meta, rec) {
                                if (rec.get('processInstanceId')=="") {
                                    return 'x-hidden';
                                }
                                return 'x-fa fa-ban';
                            },
                            handler: 'cancelLeaveProcess'
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



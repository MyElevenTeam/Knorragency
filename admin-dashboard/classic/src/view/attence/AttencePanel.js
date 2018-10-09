Ext.define('Admin.view.attence.AttencePanel', {
    extend: 'Ext.panel.Panel',
    xtype: 'attencePanel',

     requires: [
        'Ext.grid.Panel',
        'Ext.toolbar.Paging',
        'Ext.form.field.ComboBox',
        'Ext.grid.column.Date',
        'Ext.selection.CheckboxModel'
    ],
    layout: {
        type: 'vbox',
        pack: 'start',
        align: 'stretch'
    },
    items: [
        {
            title: '个人考勤列表'
        },
        {
        	//margin: '10 0 0 0',
            bodypadding:15,
            cls: 'has-border',
        	height:60,
        	tbar: [
        		{
                    iconCls:'fa fa-folder-o fa-5x',
                    ui: 'header',
                    tooltip: '我的请假单',
                    handler: 'openLeaveWindow'
                },
                '-',
                {
                    iconCls:'fa fa-edit fa-5x',
                    ui: 'header',
                    tooltip: '填写请假单',
                    handler: 'openAddWindow'
                },
                '->',
                {
	                xtype:'textfield',
	                id:'attence_searchFieldValue',
	                name:'userPanelSearchField',
	                hidden:true
                },
                '-',
                {
                    iconCls:'fa fa-search fa-5x',
                    id:'attence_search',
                    ui: 'header',
                    tooltip: '查找',
                    handler:'search'
                },
                '-',
                {
                    iconCls:'fa fa-download fa-5x',
                    ui: 'header',
                    tooltip: '导出个人考勤表'
                }
        	]   
        },
        {
            xtype: 'gridpanel',
            cls: 'has-border',
            height:650,
            bind: '{attenceLists}',
            scrollable: false,
            selModel: {type: 'checkboxmodel',checkOnly: true},     //多选框checkbox
            //选中时才激活删除多条按钮
            listeners: {                            
                    selectionchange: function(selModel, selections){
                        this.up('panel').down('#contractPanelRemove').setDisabled(selections.length === 0);
                    },
                    cellclick: 'onGridCellItemClick'
            },
            columns: [
                {xtype: 'gridcolumn',width: 40,dataIndex: 'id',text: 'id',hidden:true},
                {header: '上班状态',dataIndex: 'attenceStatus',width: 120,sortable: true,
                    renderer: function(val) {
                        if (val =='NORMAL') {
                            return '<span style="color:green;">正常</span>';
                        } else if (val =='LEAVE') {
                            return '<span style="color:blue;">请假</span>';
                        } else if (val =='LATER') {
                            return '<span style="color:red;">迟到</span>';
                        }else if (val =='EARLY') {
                            return '<span style="color:red;">早退</span>';
                        }
                        return val;
                    }
                },
                {xtype: 'gridcolumn', cls: 'content-column',width:150,dataIndex: 'employeeName',text: '员工姓名'},
                {xtype: 'gridcolumn', cls: 'content-column',width:150,dataIndex: 'location',text: '打卡地点'},
                {xtype: 'datecolumn',cls: 'content-column',width: 150,dataIndex: 'workinTime',text: '上班时间',flex:1,formatter: 'date("Y/m/d H:i:s")'},
                {xtype: 'datecolumn',cls: 'content-column',width: 150,dataIndex: 'workoutTime',text: '下班时间',flex:1,formatter: 'date("Y/m/d H:i:s")'},
                {xtype: 'gridcolumn', cls: 'content-column',width:150,dataIndex: 'processInstanceId',text: '流程id',hidden:true},
                {xtype: 'gridcolumn', cls: 'content-column',width:150,dataIndex: 'processStatus',text: '审核状态',hidden:true,id:'attencePanel_processStatus'},
                {xtype: 'actioncolumn',cls: 'content-column', width: 150,dataIndex: 'bool',text: '操作',tooltip: 'edit ',
                    items: [
                        {
                            xtype: 'button',iconCls: 'x-fa  fa-hand-paper-o',tooltip: '发起请假',
                            getClass: function(v, meta, rec,grid) {
                                if (rec.get('processInstanceId')!="") {
                                    return 'x-hidden';
                                }
                                return 'x-fa fa-hand-paper-o';
                            }
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
                        }
                    ]
                }
            ],
            dockedItems: [{
                xtype: 'pagingtoolbar',
                dock: 'bottom',
                itemId: 'userPaginationToolbar',
                displayInfo: true,
                bind: '{attenceLists}'
            }]
        }
    ]
});



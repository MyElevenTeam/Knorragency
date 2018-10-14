Ext.define('Admin.view.allattence.AllAttencePanel', {
    extend: 'Ext.panel.Panel',
    xtype: 'allAttencePanel',

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
            title: '考勤列表'
        },
        {
        	//margin: '10 0 0 0',
            bodypadding:15,
            cls: 'has-border',
        	height:60,
        	tbar: [
                '->',
                {
                        xtype:'splitbutton',
                        id:'allattence_gridfilters',
                        text:'请选择搜索条件',
                        menu:[
                        {
                            xtype: 'menucheckitem',
                            text: '签约时间',
                            menu:[
                                {
                                    xtype: 'datefield',
                                    id:'allattence_workinTime',
                                    value:new Date(),
                                    format: 'Y/m/d H:i:s',
                                    listeners:{
                                        specialkey: 'searchAllAttence'
                                    }
                                }
                            ]
                        },{
                            xtype: 'menucheckitem',                           
                            text: '失效时间',
                            menu:[
                                {
                                    xtype: 'datefield',
                                    id:'allattence_workoutTime',
                                    value:new Date(),
                                    format: 'Y/m/d H:i:s',
                                    listeners:{
                                        specialkey: 'searchAllAttence'
                                    }
                                }
                            ]
                        }]
                },'-',{
                    iconCls:'fa fa-search fa-5x',
                    ui: 'header',
                    tooltip: '查找',
                    id:'allattence_searchOpen',
                    handler:'searchOpen'   
                },'-',{
                    iconCls:'fa fa-close fa-5x',
                    ui: 'header',
                    tooltip: '取消',
                    id:'allattence_searchClose',
                    handler:'searchClose'   
                },
                '-',
                {
                    iconCls:'fa fa-download fa-5x',
                    ui: 'header',
                    tooltip: '导出考勤表'
                }
        	]   
        },
        {
            xtype: 'gridpanel',
            cls: 'has-border',
            height:650,
            bind: '{allAttenceLists}',
            scrollable: false,
            // selModel: {type: 'checkboxmodel',checkOnly: true},     //多选框checkbox
            // //选中时才激活删除多条按钮
            // listeners: {                            
            //         selectionchange: function(selModel, selections){
            //             this.up('panel').down('#contractPanelRemove').setDisabled(selections.length === 0);
            //         },
            //         cellclick: 'onGridCellItemClick'
            // },
            features: [{
                ftype: 'grouping',
                groupHeaderTpl: '{name}',
                hideGroupedHeader: false,
                startCollapsed: true,
                // enableGroupingMenu: true
            }],
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
                {xtype: 'gridcolumn', cls: 'content-column',width:150,dataIndex: 'storeName',text: '部门名'},
                {xtype: 'gridcolumn', cls: 'content-column',width:150,dataIndex: 'location',text: '打卡地点'},
                {xtype: 'datecolumn',cls: 'content-column',width: 160,dataIndex: 'workinTime',text: '上班时间',flex:1,formatter: 'date("Y/m/d H:i:s")'},
                {xtype: 'datecolumn',cls: 'content-column',width: 160,dataIndex: 'workoutTime',text: '下班时间',flex:1,formatter: 'date("Y/m/d H:i:s")'},
                 {xtype: 'datecolumn',cls: 'content-column',width: 160,dataIndex: 'day',text: '考勤时间',flex:1,formatter: 'date("Y/m")'},
                {xtype: 'actioncolumn',cls: 'content-column', width: 80,dataIndex: 'bool',text: '操作',tooltip: 'edit '}
            ],
            dockedItems: [{
                xtype: 'pagingtoolbar',
                dock: 'bottom',
                itemId: 'userPaginationToolbar',
                displayInfo: true,
                bind: '{allAttenceLists}'
            }]
        }
    ]
});



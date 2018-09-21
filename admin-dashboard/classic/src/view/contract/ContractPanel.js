Ext.define('Admin.view.contract.ContractPanel', {
    extend: 'Ext.panel.Panel',
    xtype: 'contractPanel',

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
            title: '合同列表'
        },
        {
            html:'<br><hr>'
        },
        {
            xtype: 'gridpanel',
            cls: 'user-grid',
            //title: '合同列表',
            bind: '{contractLists}',
            scrollable: false,
            selModel: {type: 'checkboxmodel',checkOnly: true},     //多选框checkbox
            //选中时才激活删除多条按钮
            listeners: {                            
                    selectionchange: function(selModel, selections){
                        this.down('#userPanelRemove').setDisabled(selections.length === 0);
                    }
            },
            columns: [
                {xtype: 'gridcolumn',width: 40,dataIndex: 'id',text: 'id',hidden:true},
                {xtype: 'gridcolumn', cls: 'content-column',width:100,dataIndex: 'contractNumber',text: '合同编号'},
                {xtype: 'gridcolumn', cls: 'content-column',width:100,dataIndex: 'customerName',text: '客户姓名'},
                {xtype: 'gridcolumn', cls: 'content-column',width:100,dataIndex: 'hoseName',text: '房源名称'},
                {xtype: 'gridcolumn', cls: 'content-column',width:120,dataIndex: 'employeeName',text: '房产经纪人姓名'},
                {xtype: 'datecolumn',cls: 'content-column',width: 150,dataIndex: 'startTime',text: '签约时间',flex:1,formatter: 'date("Y/m/d H:i:s")'},
                {xtype: 'datecolumn',cls: 'content-column',width: 150,dataIndex: 'endTime',text: '失效时间',flex:1,formatter: 'date("Y/m/d H:i:s")'},
                {xtype: 'gridcolumn', cls: 'content-column',width:90,dataIndex: 'contractType',text: '合同类型'},
                {xtype: 'gridcolumn', cls: 'content-column',width:100,dataIndex: 'total',text: '金额',
                    renderer: function(val) {
                        return '<span>'+Ext.util.Format.number(val, '0,000.00')+'万</span>';
                    }
                },
                {xtype: 'gridcolumn', cls: 'content-column',width:100,dataIndex: 'area',text: '公司区域'},
                {xtype: 'actioncolumn',cls: 'content-column', width: 150,dataIndex: 'bool',text: '操作',tooltip: 'edit ',
                    items: [
                        {xtype: 'button', iconCls: 'x-fa fa-clipboard' , tooltip: '查看详情',handler: 'onLookButton'},
                        {xtype: 'button',iconCls: 'x-fa fa-close'   , tooltip: '删除合同',handler: 'onDeleteButton'},
                        {xtype: 'button',iconCls: 'x-fa fa-ban'     ,handler: 'onDisableButton'}
                    ]
                }
            ],
            dockedItems: [{
                xtype: 'pagingtoolbar',
                dock: 'bottom',
                itemId: 'userPaginationToolbar',
                displayInfo: true,
                bind: '{contractLists}'
            }]
        }
    ]
});

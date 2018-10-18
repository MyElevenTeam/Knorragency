Ext.define('Admin.view.file.FileInboxPanel', {
    extend: 'Ext.panel.Panel',
    xtype: 'fileInboxPanel',

     requires: [
        'Ext.grid.Panel',
        'Ext.toolbar.Paging',
        'Ext.form.field.ComboBox',
        'Ext.grid.column.Date'
    ],

    controller: 'fileViewController',               //viewController:代码与视图分离。声明视图绑定的事件，可以多个视图共享。
    viewModel: {type: 'fileViewModel'},
    
    layout: {
        type: 'vbox',
        pack: 'start',
        align: 'stretch'
    },
    items: [
        {
            title: '收件箱'
        },
        {
            bodypadding:15,
            cls: 'has-border',
            height:60,
            tbar: [
                {
                    xtype: 'button',
                    ui: 'gray',
                    text: '写草稿',
                    iconCls:'fa fa-file-text-o',
                    handler: 'openFileWindow'
                },
                '->',
                {
                    xtype: 'button',
                    ui: 'soft-red',
                    text: 'Discard',
                    handler: 'onComposeDiscardClick'
                },
                {
                    xtype: 'button',
                    ui: 'soft-green',
                    text: '发邮件',
                    iconCls:'fa fa-send-o',
                    handler:'openFileWindow'
                }
            ]
        },
        {
            xtype: 'gridpanel',
            cls: 'has-border',
            flex: 2,
            bind: '{inboxLists}',
            scrollable: false,
            columns: [
                {xtype: 'gridcolumn',width: 40,dataIndex: 'id',text: 'id'},
                {xtype: 'gridcolumn', cls: 'content-column',width:150,dataIndex: 'emailStatus',text: '邮件状态',
                    renderer: function(val) {
                        if (val =='NOREAD') {
                            return '<span style="color:red;">未读</span>';
                        } else if (val =='READ') {
                            return '<span style="color:green;">已读</span>';
                        } 
                        return val;
                    }
                },
                {xtype: 'gridcolumn', cls: 'content-column',width:150,dataIndex: 'emailFrom',text: '发件人'},
                {xtype: 'gridcolumn', cls: 'content-column',width:150,dataIndex: 'emailSubject',text: '主题'},
                {xtype: 'gridcolumn', cls: 'content-column',width:150,dataIndex: 'emailContent',text: '内容'},
                {xtype: 'datecolumn',cls: 'content-column',width: 150,dataIndex: 'sendTime',text: '接受时间',formatter: 'date("Y/m/d H:i:s")'},
                {xtype: 'actioncolumn',cls: 'content-column', width: 150,dataIndex: 'bool',text: 'Actions',tooltip: 'edit ',
                    items: [
                        {xtype: 'button', iconCls: 'x-fa fa-pencil' ,handler: 'onEditButton'},
                        {xtype: 'button',iconCls: 'x-fa fa-close'   ,handler: 'onDeleteButton'}
                    ]
                }
            ],
            dockedItems: [{
                xtype: 'pagingtoolbar',
                dock: 'bottom',
                itemId: 'userPaginationToolbar',
                displayInfo: true,
                bind: '{inboxLists}',
            }]
        }
    ]
});

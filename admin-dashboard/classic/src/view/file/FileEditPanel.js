Ext.define('Admin.view.file.FileEditPanel', {
    extend: 'Ext.panel.Panel',
    xtype: 'fileEditPanel',

     requires: [
        'Ext.grid.Panel',
        'Ext.toolbar.Paging',
        'Ext.form.field.ComboBox',
        'Ext.grid.column.Date',
        'Ext.selection.CheckboxModel',
        'Ext.grid.feature.Grouping'
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
            title: '草稿箱'
        },
        {
        	//margin: '10 0 0 0',
            bodypadding:15,
            cls: 'has-border',
        	height:60,
        	tbar: [
        		
        	]   
        },
        {
            xtype: 'gridpanel',
            cls: 'has-border',
            flex: 2,
            bind: '{editLists}',
            scrollable: false,
            columns: [
                {xtype: 'gridcolumn',width: 40,dataIndex: 'id',text: 'id'},
                {xtype: 'gridcolumn', cls: 'content-column',width:150,dataIndex: 'emailTo',text: '收件人'},
                {xtype: 'gridcolumn', cls: 'content-column',width:150,dataIndex: 'emailSubject',text: '主题'},
                {xtype: 'gridcolumn', cls: 'content-column',width:150,dataIndex: 'emailContent',text: '内容'},
                {xtype: 'datecolumn',cls: 'content-column',width: 150,dataIndex: 'sendTime',text: '保存时间',formatter: 'date("Y/m/d H:i:s")'},
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
                bind: '{editLists}'
            }]
        }
    ]
});



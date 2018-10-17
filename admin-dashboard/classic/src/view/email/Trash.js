Ext.define('Admin.view.email.Trash', {
    extend: 'Ext.panel.Panel',
    xtype: 'trash',

    layout:'fit',
    items:[
        {
            xtype: 'gridpanel',
            title:'回收箱',
            bind: '{trashLists}',
            scrollable: false,
            height:700,
            selModel: {type: 'checkboxmodel',checkOnly: true},     //多选框checkbox
            //选中时才激活删除多条按钮
            listeners: {                            
                    /*selectionchange: function(selModel, selections){
                        this.down('#userPanelRemove').setDisabled(selections.length === 0);
                    }*/
            },
            columns: [
                {xtype: 'gridcolumn',width: 40,dataIndex: 'id',text: 'id',hidden:true},
                {xtype: 'gridcolumn', cls: 'content-column',width:120,dataIndex: 'emailTo',text: '收件人'},
                 {xtype: 'gridcolumn', cls: 'content-column',width:120,dataIndex: 'emailFrom',text: '发件人'},
                {xtype: 'gridcolumn', cls: 'content-column',width:120,dataIndex: 'emailSubject',text: '主题'},
                {xtype: 'gridcolumn', cls: 'content-column',width:150,dataIndex: 'emailContent',text: '内容'},
                {xtype: 'gridcolumn', cls: 'content-column',width:150,dataIndex: 'sendTime',text: '发送时间',formatter: 'date("Y/m/d H:i:s")'},
                {xtype: 'actioncolumn',cls: 'content-column', width: 250,dataIndex: 'bool',text: '操作',tooltip: 'edit ',
                    items: [
                        {xtype: 'button',iconCls: 'x-fa fa-close'   ,handler: 'onDeleteButton'},
                        {xtype: 'button',iconCls: 'x-fa fa-ban'     ,handler: 'onDisableButton'}
                    ]
                }
            ],
            dockedItems: [{
                xtype: 'pagingtoolbar',
                dock: 'bottom',
                itemId: 'userPaginationToolbar',
                displayInfo: true,
                bind: '{trashLists}'
            }]

        }
    ]
});

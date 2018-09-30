Ext.define('Admin.view.addressList.AddressListPanel', {
    extend: 'Ext.panel.Panel',
    xtype: 'addressListPanel',

    requires: [
        'Ext.grid.Panel',
        'Ext.toolbar.Paging', 
    ],
    //controller: 'searchresults',
   // viewModel: {type: 'orderViewModel'},
    layout: 'fit',
    items: [{
            xtype: 'gridpanel',
            cls: 'user-grid',
            title: 'AddressList Results',
            //routeId: 'user',
            bind: '{addressListLists}',
            scrollable: false,
            columns: [
                {xtype: 'gridcolumn',width: 40,dataIndex: 'id',text: '#'},
                {xtype: 'gridcolumn', cls: 'content-column',dataIndex: 'employeeName',text: 'Name',flex: 1},
                {xtype: 'gridcolumn',cls: 'content-column',dataIndex: 'employeeNumber',text: 'Number',flex: 1},
                {xtype: 'datecolumn',cls: 'content-column',dataIndex: 'employeeArea',text: 'Area',flex: 1},
                {xtype: 'gridcolumn',cls: 'content-column',dataIndex: 'post',text: 'post',flex: 1},
                {xtype: 'gridcolumn',cls: 'content-column',dataIndex: 'email',text: 'email',flex: 1},
                {xtype: 'actioncolumn',cls: 'content-column', width: 120,dataIndex: 'bool',text: 'Actions',tooltip: 'edit ',
                    items: [
                        {xtype: 'button', iconCls: 'x-fa fa-pencil' ,handler: 'onEditButton'},
                        {xtype: 'button',iconCls: 'x-fa fa-close'	,handler: 'onDeleteButton'},
                        {xtype: 'button',iconCls: 'x-fa fa-ban'	 	,handler: 'onDisableButton'}
                    ]
                }
            ],
            dockedItems: [{
                xtype: 'pagingtoolbar',
                dock: 'bottom',
                itemId: 'userPaginationToolbar',
                displayInfo: true,
                bind: '{addressListLists}'
            }]
        }]
});

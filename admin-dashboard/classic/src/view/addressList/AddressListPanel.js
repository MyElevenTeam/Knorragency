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
            selModel: {type: 'checkboxmodel',checkOnly: true},     //多选框checkbox
            listeners: {                            
                    selectionchange: function(selModel, selections){
                        this.down('#videoMeeting').setDisabled(selections.length === 0);
                    }
            },
            columns: [
                {xtype: 'gridcolumn',width: 40,dataIndex: 'id',text: '#',hidden:true},
                {xtype: 'gridcolumn', cls: 'content-column',dataIndex: 'employeeName',text: 'Name',flex: 1},
                {xtype: 'gridcolumn',cls: 'content-column',dataIndex: 'employeeNumber',text: 'Number',flex: 1},
                {xtype: 'gridcolumn',cls: 'content-column',dataIndex: 'storeName',text: 'Area',flex: 1},
                {xtype: 'gridcolumn',cls: 'content-column',dataIndex: 'post',text: 'post',flex: 1},
                {xtype: 'gridcolumn',cls: 'content-column',dataIndex: 'email',text: 'email',flex: 1},
                {xtype: 'actioncolumn',cls: 'content-column', width: 120,dataIndex: 'bool',text: 'Actions',tooltip: 'edit ',
                    items: [
                        {xtype: 'button', iconCls: 'x-fa fa-pencil' ,handler: 'onEditButton'}
                    ]
                }
            ],
            tbar: [{
	            xtype: 'combobox',
	            reference:'searchFieldName',
	            hideLabel: true,
	            store:Ext.create("Ext.data.Store", {
				    fields: ["name", "value"],
				    data: [
				      	{ name: '姓名', value: 'employeeName' },
						{ name: '工号', value: 'employeeNumber' },
						{ name: '门店', value: 'storeName' },
						{ name: '职称', value: 'post' }
				    ]
				}),
	            displayField: 'name',
	            valueField:'value',
	            value:'employeeName',
	            editable: false,
	            queryMode: 'local',
	            triggerAction: 'all',
	            emptyText: 'Select a state...',
	            width: 135, 
	        }, '-',{
            	xtype:'textfield',
            	reference:'searchFieldValue',
            	name:'orderPanelSearchField'
		    }, '-',{
		        text: '搜索',
		        iconCls: 'fa fa-search',
		        handler: 'quickSearch'
		    },'->',{
		        text: '视频会议',
                itemId:'videoMeeting',
		        tooltip: 'Add a new row',
		        iconCls: 'fa fa-plus',
                disabled: true,
		        handler: 'sponsorVidwoMeeting'	
		    }],
            dockedItems: [{
                xtype: 'pagingtoolbar',
                dock: 'bottom',
                itemId: 'userPaginationToolbar',
                displayInfo: true,
                bind: '{addressListLists}'
            }]
        }]
});

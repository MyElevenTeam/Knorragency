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
        	//margin: '10 0 0 0',
            bodypadding:15,
            cls: 'has-border',
        	height:80,
        	tbar: [{
                xtype: 'combobox',
                reference:'searchFieldName',
                hidden:true,
                hideLabel: true,
                store:Ext.create("Ext.data.Store", {
                    fields: ["name", "value"],
                    data: [
                        { name: '用户名', value: 'userName' },
                        { name: '创建时间', value: 'createTime' }
                    ]
                }),
                displayField: 'name',
                valueField:'value',
                value:'userName',
                editable: false,
                queryMode: 'local',
                triggerAction: 'all',
                //emptyText: 'Select a state...',
                width: 135,
                listeners:{
                    select: 'searchComboboxSelectChange'
                }
            }, '-',/*{
                xtype:'textfield',
                reference:'searchFieldValue',
                name:'userPanelSearchField'
            }, '-',{
                xtype: 'datefield',
                hideLabel: true,
                hidden:true,
                format: 'Y/m/d H:i:s',
                reference:'searchDataFieldValue',
                fieldLabel: 'From',
                name: 'from_date'
            },{
                xtype: 'datefield',
                hideLabel: true,
                hidden:true,
                format: 'Y/m/d H:i:s',
                reference:'searchDataFieldValue2',
                fieldLabel: 'To',
                name: 'to_date'
            },'-',{
                text: 'Search',
                iconCls: 'fa fa-search',
                handler: 'quickSearch'
            }, '-',*/{
                //text: 'Search More',
                cls:'has',
                iconCls: 'fa fa-search-plus',
               
                //handler: 'openSearchWindow' 
            }, '->',{
                text: '导入合同',
                tooltip: '导入合同信息',
                iconCls: 'fa fa-cloud-upload',
                handler: 'uploadContract' 
                   
            },'-',{
            	text: '模板下载',
                tooltip: '合同模板下载',
                iconCls: 'fa fa-cloud-download',
                href:'/contract/downloadWord',
                hrefTarget: '_self'

                    
            },'-',{
                text: '批量删除',
                itemId: 'contractPanelRemove',
                tooltip: '批量删除',
                iconCls:'fa fa-trash',
                disabled: true,
                handler: 'deleteMoreRows'   
            }]
                
        },
        {
            xtype: 'gridpanel',
            cls: 'has-border',
            height:650,
            bind: '{contractLists}',
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
                {header: 'processStatus',dataIndex: 'processStatus',width: 60,sortable: true,
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
                },
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
                        {xtype: 'button', iconCls: 'x-fa fa-arrow-circle-o-down' , tooltip: '合同下载'},
                        {xtype: 'button',iconCls: 'x-fa fa-close'   , tooltip: '删除合同',handler: 'onDeleteButton'},
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
                            handler: 'LookContract'
                        }
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



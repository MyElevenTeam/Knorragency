Ext.define('Admin.view.contract.ContractPanel', {
    extend: 'Ext.panel.Panel',
    xtype: 'contractPanel',

     requires: [
        'Ext.grid.Panel',
        'Ext.toolbar.Paging',
        'Ext.form.field.ComboBox',
        'Ext.grid.column.Date',
        'Ext.selection.CheckboxModel',
        'Ext.grid.plugin.*'
    ],
    controller:'contractViewController',
    layout:'fit',
    items: [
        {
            xtype: 'gridpanel',
            title:'合同信息表',
            plugins: {
		        rowexpander: {
		            rowBodyTpl: new Ext.XTemplate(
		                '<p><b>合同编号:</b>{contractNumber}</p>',
		                '<p><b>客户姓名:</b></p>{customerName}<br>',
		                '<p><b>房源名称:</b>{hoseName}</p>',
                        '<p><b>房产经纪人姓名:</b>{employeeName}</p>',
                        '<p><b>签约时间:</b></p>{startTime}<br>',
                        '<p><b>失效时间:</b>{endTime}</p>',
                        '<p><b>金额:</b>{total}</p>'
		            )
		        },
                rowediting:{
                    saveBtnText: '保存', 
                    cancelBtnText: "取消", 
                    autoCancel: false, 
                    clicksToMoveEditor: 2
                }
		    },
            cls: 'has-border',
            bind: '{contractLists}',
            selModel: {type: 'checkboxmodel',checkOnly: true},     //多选框checkbox
            //选中时才激活删除多条按钮
           /* listeners: {                            
                    selectionchange: function(selModel, selections){
                        this.up('panel').down('#contractPanelRemove').setDisabled(selections.length === 0);
                    },
                    cellclick: 'onGridCellItemClick'
            },*/
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
                {xtype: 'gridcolumn', cls: 'content-column',width:100,dataIndex: 'contractNumber',text: '合同编号',
	                editor: {
	                	xtype: 'textfield',
			            allowBlank: false
			        }
		    	},
                {xtype: 'gridcolumn', cls: 'content-column',width:100,dataIndex: 'customerName',text: '客户姓名',
                	editor: {
                		xtype: 'textfield',
			            allowBlank: false
			        }
            	},
                {xtype: 'gridcolumn', cls: 'content-column',width:100,dataIndex: 'hoseName',text: '房源名称'},
                {xtype: 'gridcolumn', cls: 'content-column',width:120,dataIndex: 'employeeName',text: '房产经纪人姓名'},
                {xtype: 'datecolumn',cls: 'content-column',width: 150,dataIndex: 'startTime',text: '签约时间',flex:1,formatter: 'date("Y/m/d H:i:s")',filter: true },
                {xtype: 'datecolumn',cls: 'content-column',width: 150,dataIndex: 'endTime',text: '失效时间',flex:1,formatter: 'date("Y/m/d H:i:s")',filter: true },
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
            tbar: [{
                        xtype:'splitbutton',
                        id:'contract_gridfilters',
                        
                        text:'请选择搜索条件',
                        menu:[
                        {
                            xtype: 'menucheckitem',
                            text: '合同编号',
                            menu:[
                                {
                                    xtype: 'textfield',
                                    id:'contract_contractNumber',
                                    emptyText:'请输入合同编号',
                                    listeners:{
                                         specialkey: 'searchContract'
                                    }
                                }
                            ]
                            
                        },{
                            xtype: 'menucheckitem',
                            text: '客户姓名',
                            menu:[
                                {
                                    xtype: 'textfield',
                                    emptyText:'请输入客户姓名',
                                    listeners:{
                                        specialkey: 'searchContract'
                                    }
                                }
                            ]
                        },{
                            xtype: 'menucheckitem',                           
                            text: '房源名称',
                            menu:[
                                {
                                    xtype: 'textfield',
                                    emptyText:'请输入房源名称',
                                    listeners:{
                                        specialkey: 'searchContract'
                                    }
                                }
                            ]
                        },{
                            xtype: 'menucheckitem',
                            text: '签约时间',
                            menu:[
                                {
                                    xtype: 'datefield',
                                    value:new Date(),
                                    format: 'Y/m/d H:i:s',
                                    listeners:{
                                        specialkey: 'searchContract'
                                    }
                                }
                            ]
                        },{
                            xtype: 'menucheckitem',                           
                            text: '失效时间',
                            menu:[
                                {
                                    xtype: 'datefield',
                                    value:new Date(),
                                    format: 'Y/m/d H:i:s',
                                    listeners:{
                                        specialkey: 'searchContract'
                                    }
                                }
                            ]
                        },{
                            xtype: 'menucheckitem',
                            text: '合同类型',
                            menu:[
                                {
                                    xtype: 'textfield',
                                    emptyText:'请输入合同类型',
                                    listeners:{
                                        specialkey: 'searchContract'
                                    }
                                }
                            ]
                        }]
                    },'-',{
                        iconCls:'fa fa-search fa-5x',
                        ui: 'header',
                        tooltip: '查找',
                        id:'contract_search',
                        handler:'searchContract'   
                    },'-',{
                        iconCls:'fa fa-search fa-5x',
                        ui: 'header',
                        tooltip: '取消',
                        //id:'contract_search',
                        handler:'searchContract'   
                    },
                    '->',{
                        tooltip: '添加合同信息',
                        ui: 'header',
                        iconCls: 'fa fa-plus-square',
                        handler:'onAddClick'   
                    },'-',{
                        //text: '导入合同',
                        tooltip: '导入合同信息',
                        ui: 'header',
                        iconCls: 'fa fa-cloud-upload',
                        handler: 'uploadContract' 
                           
                    },'-',{
                     //text: '模板下载',
                        tooltip: '合同模板下载',
                        ui: 'header',
                        iconCls: 'fa fa-cloud-download',
                        href:'/contract/downloadWord',
                        hrefTarget: '_self'

                            
                    }/*,'-',{
                        //text: '批量删除',
                       // itemId: 'contractPanelRemove',
                        ui: 'header',
                        tooltip: '批量删除',
                        iconCls:'fa fa-trash',
                        disabled: true,
                        handler: 'deleteMoreRows'   
                    }*/
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






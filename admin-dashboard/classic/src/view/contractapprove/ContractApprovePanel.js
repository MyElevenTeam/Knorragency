Ext.define('Admin.view.contractapprove.ContractApprovePanel', {
    extend: 'Ext.tab.Panel',
    xtype: 'contractApprovePanel',

     requires: [
        'Ext.grid.Panel',
        'Ext.toolbar.Paging',
        'Ext.form.field.ComboBox',
        'Ext.grid.column.Date',
        'Ext.selection.CheckboxModel'
    ],

    items: [
    {
        title: '合同审核',
        xtype: 'gridpanel',
        cls: 'process-definition-grid',
        layout:'fit',
        bind: '{contractApproveLists}',
        columns: [
            {
                xtype: 'actioncolumn',
                items: [{
                    xtype: 'button',
                    iconCls: 'x-fa fa-pencil',
                    tooltip: '签收任务',
                    getClass: function(v, meta, rec) {
                        if (rec.get('assignee')!='') {
                              return 'x-hidden';
                        }
                        return 'x-fa fa-pencil';
                    },
                    handler: 'onClickLeaveApproveClaimButton'   //ajax  taskId
                },{
                    xtype: 'button',
                    iconCls: 'x-fa fa-edit',
                    tooltip: '审批任务',
                    getClass: function(v, meta, rec) {
                        if (rec.get('assignee')=='') {
                              return 'x-hidden';
                        }
                        return 'x-fa fa-edit';
                    },
                    handler: 'onClickLeaveApproveCompleteWindowButton'  //taskDefinitionKey 动态表单
                },{
                    xtype: 'button',
                    iconCls: 'x-fa fa-object-group',
                    tooltip: '任务跟踪',
                    handler: 'onClickGraphTraceButton'  //流程跟踪
                }],
                cls: 'content-column',
                width: 120,
                dataIndex: 'bool',
                text: 'Actions',
                tooltip: 'edit '
            }
            ,{header: 'id'          ,dataIndex: 'id',width: 60,sortable: true   ,hidden:true}
            ,{header: 'processStatus',dataIndex: 'processStatus',width: 60,sortable: true,
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
            }
            ,{header: 'userId'          ,dataIndex: 'userId',width: 60,sortable: true}
            ,{header: 'processInstanceId' ,dataIndex: 'processInstanceId',width: 80,sortable: true}
            ,{header: 'taskId'          ,dataIndex: 'taskId',width: 80,sortable: true}
            ,{header: 'taskName'        ,dataIndex: 'taskName',width: 80,sortable: true}
            ,{header: 'taskCreateTime'  ,dataIndex: 'taskCreateTime',width: 150,sortable: true,renderer: Ext.util.Format.dateRenderer('Y/m/d H:i:s')}
            ,{header: 'assignee'        ,dataIndex: 'assignee',width: 80,sortable: true}
            ,{header: 'taskDefinitionKey',dataIndex: 'taskDefinitionKey',width: 80,sortable: true}
            ,{header: 'processDefinitionId' ,dataIndex: 'processDefinitionId',width: 80,sortable: true}
            ,{header: 'suspended'       ,dataIndex: 'suspended',width: 80,sortable: true}
            ,{header: 'version'         ,dataIndex: 'version',width: 60,sortable: true}
        ],
        dockedItems: [{
            xtype: 'pagingtoolbar',
            dock: 'bottom',
            displayInfo: true,
            bind: '{contractApproveLists}'
        }]
        
    }, {
        title: '流程定义',
        layout:'fit',
        items:[
            {
                xtype: 'gridpanel',
                cls: 'process-definition-grid',
                //title: '流程定义列表',
                bind: '{processDefinitionLists}',
                scrollable: false,
                columns : [
                     {header : '流程定义实体Id',dataIndex : 'id',width : 120,sortable : true}
                    ,{header : '类别',dataIndex : 'category',width : 200,sortable : true}
                    ,{header : '名称',dataIndex : 'name',width : 100,sortable : true}
                    ,{header : '流程key',dataIndex : 'key',width : 80,sortable : true}
                    ,{header : '版本号',dataIndex : 'version',width : 60,sortable : true}
                    ,{header : '部署Id',dataIndex : 'deploymentId',width : 60,sortable : true,hidden : true}
                    //,{header : '部署时间',dataIndex : 'deploymentTime',width : 150,sortable : true,renderer : Ext.util.Format.dateRenderer('Y/m/d H:i:s')}
                    ,{header : 'bpmn XML',dataIndex : 'resourceName',width : 120,sortable : true,hidden : true,
                        renderer : function(value, metaData, record, rowIdx, colIdx, store, view) {
                            return '<a target="_blank" href="'
                                    + 'process-definition/resource?pdid='
                                    + record.get('id') + '&resourceName='
                                    + record.get('resourceName') + '">'
                                    + record.get('resourceName') + '</a>';
                        }
                    }
                    ,{header : '流程图',dataIndex : 'diagramResourceName',width : 120,sortable : true,hidden : true,
                        renderer : function(value, metaData, record, rowIdx, colIdx,store, view) {
                            return '<a target="_blank" href="'
                                    + 'process-definition/resource?pdid='
                                    + record.get('id') + '&resourceName='
                                    + record.get('diagramResourceName') + '">'
                                    + record.get('diagramResourceName') + '</a>';
                        }
                    }
                    ,{header : '是否挂起',dataIndex : 'suspended',width : 80,   sortable : true,hidden : true}
                    ,{header : 'startFormKey',dataIndex : 'startFormKey',width : 180,sortable : true,hidden : true} 
                    ,{header : 'graphicalNotation',dataIndex : 'graphicalNotation',width : 180,sortable : true,hidden : true} 
                    ,{header : 'description',dataIndex : 'description',width : 60,sortable : true,hidden : true }
                    ,{header : 'tenantId',dataIndex : 'tenantId',width : 180,sortable : true,hidden : true  }
                    ,{xtype : 'actioncolumn',cls : 'content-column',width : 260,text : '操作',
                        items : [
                            {
                                xtype : 'button',iconCls : 'x-fa fa-trash-o',tooltip: '删除',
                                handler : 'onClickProcessDefinitionGridDeleteButton'
                            }, {
                                xtype : 'button',iconCls : 'x-fa  fa-file-excel-o',tooltip: 'BPMN XML',
                                handler : 'onClickProcessDefinitionReadResourceButton'
                            } ,{
                                xtype: 'button',iconCls: 'x-fa fa-file-picture-o',tooltip: '流程定义图',
                                handler: 'onClickProcessDefinitionReadDiagramResourceButton'
                            }
                        ]
                    }
                ],
                tbar: [{
                    text: '上传BPMN',
                    tooltip: '上传流程图',
                    iconCls:'fa fa-cloud-upload',
                    handler: 'onClickProcessDefinitionGridUploadButton' 
                }], 
                dockedItems: [{
                    xtype: 'pagingtoolbar',
                    dock: 'bottom',
                    displayInfo: true,
                    bind: '{processDefinitionLists}'
                }]
            }
        ]
    }]
    
});



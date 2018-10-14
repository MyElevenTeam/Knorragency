Ext.define('Admin.view.contract.ContractAddWindow', {
    extend: 'Ext.window.Window',
    alias: 'widget.contractAddWindow',
    height: 650,
    // minHeight: 200,
    // minWidth: 300,
    width: 500,
    scrollable: true,
    title: '合同添加窗口',
    closable: true,
    modal:true,
    layout: 'fit',
    items: [{
        xtype: 'form',
        layout: 'form',
        padding: '10px',
        items: [{
            xtype: 'textfield',
            fieldLabel: 'id',
            name:'id',
            hidden: true,
            readOnly: true
        },{
            xtype: 'textfield',
            fieldLabel: 'processStatus',
            name:'processStatus',
            value:'NEW',
            hidden: true,
            readOnly: true
        },{
            xtype: 'textfield',
            fieldLabel: '客户姓名',
            name:'customerName',
            allowBlank: false,
            emptyText:'请填写客户姓名',
            blankText:'请填写客户姓名'
        }, {
            xtype: 'textfield',
            fieldLabel: '房源名称',
            name:'hoseName',
            allowBlank: false,
            emptyText:'请填写房源名称',
            blankText:'请填写房源名称'
        },{
            xtype: 'datefield',
            fieldLabel: '签约时间',
            name:'startTime',
            value:new Date(),
            format: 'Y/m/d H:i:s', 
            emptyText:'--------请选择---------',
            allowBlank: false,
            blankText:'请选择签约时间'
        },{
            xtype: 'datefield',
            fieldLabel: '失效时间',
            name:'endTime',
            value:new Date(),
            format: 'Y/m/d H:i:s', 
            emptyText:'--------请选择---------',
            allowBlank: false,
            blankText:'请选择失效时间'
        }, {
            xtype: 'textfield',
            fieldLabel: '合同类型',
            name:'contractType',
            allowBlank: false,
            emptyText:'请填写合同类型',
            blankText:'请填写合同类型'
        }, {
            xtype: 'textfield',
            fieldLabel: '金额',
            name:'total',
            allowBlank: false,
            emptyText:'请填写金额',
            blankText:'请填写金额'
        }]
    }],
    buttons:  [{
        xtype: 'button',
        text: 'Submit',
        handler: 'submitContractEditFormButton'//预留提交事件，在ViewController中实现。
    },{
        xtype: 'button',
        text: 'Close',
        handler: function(btn) {
            btn.up('window').close();
        }
    }]
});

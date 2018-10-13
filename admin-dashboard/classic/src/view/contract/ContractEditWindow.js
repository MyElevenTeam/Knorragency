Ext.define('Admin.view.contract.ContractEditWindow', {
    extend: 'Ext.window.Window',
    alias: 'widget.contractEditWindow',
    height: 200,
    minHeight: 200,
    minWidth: 300,
    width: 500,
    scrollable: true,
    title: '合同修改窗口',
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
        }, {
            xtype: 'textfield',
            fieldLabel: '客户姓名',
            name:'customerName'
        }, {
            xtype: 'textfield',
            fieldLabel: '房源名称',
            name:'hoseName'
        },{
            xtype: 'datefield',
            fieldLabel: '签约时间',
            name:'startTime',
            format: 'Y/m/d H:i:s'
        },{
            xtype: 'datefield',
            fieldLabel: '失效时间',
            name:'endTime',
            format: 'Y/m/d H:i:s'
        }, {
            xtype: 'textfield',
            fieldLabel: '合同类型',
            name:'contractType'
        }, {
            xtype: 'textfield',
            fieldLabel: '金额',
            name:'total'
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

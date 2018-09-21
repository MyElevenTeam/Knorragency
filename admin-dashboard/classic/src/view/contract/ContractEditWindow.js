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
    /*items: [{
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
            fieldLabel: 'UserName',
            name:'userName'
        }, {
            xtype: 'datefield',
            fieldLabel: 'Create Time',
            name:'createTime',
            format: 'Y/m/d H:i:s'
        }]
    }]*//*,
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
    }]*/
});

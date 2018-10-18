Ext.define('Aria.view.notice.PutOutWindow', {
    extend: 'Ext.window.Window',
    alias: 'widget.putOutWindow',
    height: 250,
    minHeight: 100,
    minWidth: 300,
    width: 500,
    scrollable: true,
    title: '发布公告',
    closable: true,
    constrain: true,
    
    modal:true,
    layout: 'fit',
    items: [{
        xtype: 'form',
        layout: 'form',
        padding: '10px',
        ariaLabel: 'Enter your name',
        items: [{
            xtype: 'datefield',
            fieldLabel: 'Create Time',
            name:'time',
            //disabled:true,
            readOnly: true,
            value:new Date(),
            hideLabel: true,
            format: 'Y/m/d H:i:s'
        },{
            xtype: 'textareafield',
            fieldLabel: 'Order Number',
            anchor    : '100%',
            allowBlank: false,
            hideLabel: true,
            name:'message'
        }]
    }],
	buttons: ['->',{
        xtype: 'button',
        text: '发布公告',
        handler: 'submitAddForm'
    }]
});
// xtype     : 'textareafield',
//             grow      : true,
//             name      : 'reason',
//             fieldLabel: '请假原因',
//             anchor    : '100%',
//             emptyText:'请填写请假原因',
//             allowBlank: false,
//             blankText:'请填写请假原因'
Ext.define('Admin.view.file.EditWindow', {
    extend: 'Ext.window.Window',
    alias: 'widget.editWindow',
    height: 450,
    // minHeight: 200,
    // minWidth: 300,
    width: 950,
    scrollable: true,
    title: '修改窗口',
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
            fieldLabel: 'emailStatus',
            name:'emailStatus',
            hidden: true,
            readOnly: true
        },{
            xtype: 'textfield',
            fieldLabel: 'readStatus',
            name:'readStatus',
            hidden: true,
            readOnly: true
        },{
            xtype: 'textfield',
            fieldLabel: 'inboxStatus',
            name:'inboxStatus',
            hidden: true,
            readOnly: true
        },{
            xtype: 'textfield',
            fieldLabel: 'replyStatus',
            name:'replyStatus',
            hidden: true,
            readOnly: true
        },{
            xtype: 'textfield',
            fieldLabel: '收件人:',
            name:'emailTo'
        }, {
            xtype: 'textfield',
            fieldLabel: '主题:',
            name:'emailSubject'
        },{
            xtype: 'htmleditor',
            fieldLabel: '内容:',
            buttonDefaults: {
                tooltip: {
                    align: 't-b',
                    anchor: true
                }
            },
            flex: 1,
            minHeight: 100,
            labelAlign: 'top',
            name:'emailContent'
        },{
            xtype: 'textfield',
            fieldLabel: '附件名:',
            name:'emailAttachment',
            id:'file_attachmentName',
            hidden:true
        }]
    }],
    buttons:  [{
        xtype: 'button',
        text: '上传附件',
        id:'file_attachmentUpload',
        iconCls:'fa fa-cloud-upload',
        ui: 'soft-blue',
        handler:'opendUploadWindow'
    },{
        xtype: 'button',
        text: '删除附件',
        id:'file_attachmentDelete',
        iconCls:'fa fa-close',
        ui: 'soft-red',
        hidden:true,
        handler:'deleteAttachment'

    },'->',{
        xtype: 'button',
        text: '发送',
        iconCls:'fa fa-send-o',
        ui: 'soft-green',
        handler: 'onSendFormButton'
    },{
        xtype: 'button',
        text: '保存',
        iconCls:'fa fa-save',
        ui: 'gray',
        handler: 'onEditFormButton'//预留提交事件，在ViewController中实现。
    },{
        xtype: 'button',
        text: '取消',
        ui: 'soft-red',
        handler: function(btn) {
            btn.up('window').close();
        }
    }]
});
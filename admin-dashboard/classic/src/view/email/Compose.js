Ext.define('Admin.view.email.Compose', {
    extend: 'Ext.form.Panel',
    alias: 'widget.emailcompose',
    requires: [
        'Ext.button.Button',
        'Ext.form.field.Text',
        'Ext.form.field.File',
        'Ext.form.field.HtmlEditor'
    ],

    // viewModel: {
    //     type: 'emailcompose'
    // },

    controller: 'composeViewController',

    cls: 'email-compose',

    layout: {
        type:'vbox',
        align:'stretch'
    },

    bodyPadding: 10,
    scrollable: true,

    defaults: {
        labelWidth: 60,
        labelSeparator: ''
    },

    items: [
        {
            xtype: 'textfield',
            name:'emailTo',
            id:'email_emailTo',
            fieldLabel: '收件人'
        },
        {
            xtype: 'textfield',
            name:'emailSubject',
            id:'email_emailSubject',
            fieldLabel: '主题'
        },
        {
            xtype: 'htmleditor',
            name:'emailContent',
            id:'email_emailContent',
            buttonDefaults: {
                tooltip: {
                    align: 't-b',
                    anchor: true
                }
            },
            flex: 1,
            minHeight: 100,
            labelAlign: 'top',
            fieldLabel: '内容'
        }
    ],

    bbar: {
        overflowHandler: 'menu',
        items: [
            {
                xtype: 'textfield',
                id:'email_attachmentName',
                hidden:true
            },'-',
            {
                text: '删除附件',
                tooltip: '删除附件',
                id:'email_attachmentDelete',
                ui: 'soft-red',
                iconCls:'fa fa-close',
                hidden:true,
                handler: 'deleteAttachment' 
            },
            {
                text: '上传附件',
                tooltip: '上传附件',
                id:'email_attachmentUpload',
                ui: 'soft-blue',
                iconCls:'fa fa-cloud-upload',
                handler: 'opendUploadWindow' 
            },
            '->',
            {
                xtype: 'button',
                ui: 'soft-red',
                text: '清空',
                handler: 'onComposeDiscardClick'
            },
            {
                xtype: 'button',
                ui: 'gray',
                text: '保存',
                handler: 'onSaveClick'
            },
            {
                xtype: 'button',
                ui: 'soft-green',
                text: '发送',
                handler: 'onSendClick'
            }
        ]
    }
});

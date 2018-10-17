Ext.define('Admin.view.email.EmailEditWindow', {
    extend: 'Ext.window.Window',
    alias: 'widget.emailEditWindow',
    
    width: 800,
    height: 500,
    scrollable: true,
    title: '邮件编辑',
    closable: true,
    modal:true,
    layout: 'fit',
    requires: [
        'Ext.button.Button',
        'Ext.form.field.Text',
        'Ext.form.field.File',
        'Ext.form.field.HtmlEditor'
    ],
    items: [{
        xtype:'form',
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
        items:[
            {
                xtype: 'textfield',
                name:'id',
                hidden:true
            },
            {
                xtype: 'textfield',
                name:'emailTo',
                fieldLabel: '收件人',
                allowBlank:false
            },
            {
                xtype: 'textfield',
                name:'emailSubject',
                fieldLabel: '主题',
                allowBlank:false
            },
            {
                xtype: 'htmleditor',
                name:'emailContent',
                allowBlank:false,
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
                    id:'edit_attachmentName',
                    hidden:true
                },'-',
                {
                    text: '删除附件',
                    tooltip: '删除附件',
                    id:'edit_attachmentDelete',
                    ui: 'soft-red',
                    iconCls:'fa fa-close',
                    hidden:true,
                    handler: 'deleteAttachment' 
                },
                {
                    text: '上传附件',
                    tooltip: '上传附件',
                    id:'edit_attachmentUpload',
                    ui: 'soft-blue',
                    iconCls:'fa fa-cloud-upload',
                    handler: 'opendUploadWindow' 
                },
                '->',
                {
                    xtype: 'button',
                    ui: 'gray',
                    text: '保存',
                    handler: 'submitEmailEditFormButton'
                }
            ]
        }

    }]
});

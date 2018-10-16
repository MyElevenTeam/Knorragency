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
            fieldLabel: '收件人'
        },
        {
            xtype: 'textfield',
            name:'emailSubject',
            fieldLabel: '主题'
        },
        {
            xtype: 'htmleditor',
            name:'emailContent',
            // Make tips align neatly below buttons.
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
        },
        {
            xtype: 'filefield',
            id:'email_attachment',
            width: 80,
            labelWidth: 80,
            emptyText: '请选择附件',
            labelSeparator: '',
            buttonConfig: {
                xtype: 'filebutton',
                glyph:'',
                iconCls: 'x-fa fa-cloud-upload',
                text: '上传'
            }
        }
    ],

    bbar: {
        overflowHandler: 'menu',
        items: [
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
                text: '发送'
            }
        ]
    }
});

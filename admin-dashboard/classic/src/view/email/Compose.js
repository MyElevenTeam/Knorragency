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

    // controller: 'emailcompose',

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
            fieldLabel: '收件人'
        },
        {
            xtype: 'textfield',
            fieldLabel: '主题'
        },
        {
            xtype: 'htmleditor',
            
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
        }
    ],

    bbar: {
        overflowHandler: 'menu',
        items: [
            {
                xtype: 'filefield',
                width: 400,
                labelWidth: 80,
                fieldLabel: '请选择附件',
                labelSeparator: '',
                buttonConfig: {
                    xtype: 'filebutton',
                    glyph:'',
                    iconCls: 'x-fa fa-cloud-upload',
                    text: '上传'
                }
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
                text: '保存'
            },
            {
                xtype: 'button',
                ui: 'soft-green',
                text: '发送'
            }
        ]
    }
});

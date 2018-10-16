Ext.define('Admin.view.email.EmailViewModel', {
    extend: 'Ext.app.ViewModel',
    alias: 'viewmodel.emailViewModel',

    requires: [
        'Ext.data.Store',
        'Ext.data.proxy.Memory',
        'Ext.data.field.Integer',
        'Ext.data.field.String',
        'Ext.data.field.Date',
        'Ext.data.field.Boolean',
        'Ext.data.reader.Json'
    ],

    stores: {
		editLists: {type: 'emailEditStroe'},
        sendLists: {type: 'emailSendStroe'},
        trashLists: {type: 'emailTrashStroe'},
    }
});

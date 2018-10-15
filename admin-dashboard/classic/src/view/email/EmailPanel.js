Ext.define('Admin.view.email.EmailPanel', {
    extend: 'Ext.panel.Panel',
    xtype: 'emailPanel',

     requires: [
        'Ext.grid.Panel',
        'Ext.toolbar.Paging',
        'Ext.form.field.*',
        'Ext.grid.column.Date',
        'Ext.selection.CheckboxModel',
        'Ext.grid.plugin.*',
        'Admin.view.GridFilters.GridFilters'
    ],

    layout: 'fit',

    margin: '20 0 0 20',
  
    // items: [
    //     {
    //         xtype: 'container',

    //         itemId: 'navigationPanel',

    //         layout: {
    //             type: 'vbox',
    //             align: 'stretch'
    //         },

    //         width: '30%',
    //         minWidth: 180,
    //         maxWidth: 240,

    //         defaults: {
    //             cls: 'navigation-email',
    //             margin: '0 20 20 0'
    //         },

    //         items: [
    //             {
    //                 xtype: 'emailMenu',
    //                 listeners: {
    //                     click: 'onMenuClick'
    //                 }
    //             }
    //         ]
    //     },
    //     {
    //         xtype: 'container',
    //         itemId: 'contentPanel',
    //         margin: '0 20 20 0',
    //         flex: 1,
    //         layout: {
    //             type : 'anchor',
    //             anchor : '100%'
    //         }
    //     }
    // ]
});

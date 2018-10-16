Ext.define('Admin.view.email.EmailMenu', {
    extend: 'Ext.menu.Menu',
    alias: 'widget.emailMenu',

    viewModel: {
        type: 'emailmenu'
    },

    title: '企业信箱',

    iconCls: 'x-fa fa-inbox',

    floating: false,

    items: [
        {
            routeId: 'emailcompose', //xtype and used for url routing
            params: {
                openWindow: true, // Let the controller know that we want this component in the window,
                targetCfg: {
                    //put any extra configs for your view here
                },
                windowCfg: {
                    // Any configs that you would like to apply for window popup goes here
                    title: '写信'
                }
            },
            iconCls: 'x-fa fa-edit',
            text: '撰写邮件'
        },
        {
            routeId: 'edit',
            iconCls: 'x-fa fa-inbox',
            text: '草稿箱'
        },
        {
            routeId: 'send',
            iconCls: 'x-fa fa-check-circle',
            text: '已发送'
        },
        {
            routeId: 'trash',
            iconCls: 'x-fa fa-trash-o',
            text: '回收站'
        }
    ]
});

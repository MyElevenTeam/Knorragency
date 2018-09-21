Ext.define('Admin.store.NavigationTree', {
    extend: 'Ext.data.TreeStore',

    storeId: 'NavigationTree',

    fields: [{
        name: 'text'
    }],

    root: {
        expanded: true,
        children: [
            {
                text: 'Dashboard',
                iconCls: 'x-fa fa-desktop',
                viewType: 'admindashboard',
                routeId: 'dashboard', // routeId defaults to viewType
                leaf: true
            },{
                text: '模板',
                iconCls: 'x-fa fa-address-card',
                //rowCls: 'nav-tree-badge nav-tree-badge-new',
                viewType: 'user',
                leaf: true
            },{
                text: '业务管理模块',
                iconCls: 'x-fa fa-briefcase',
                expanded: false,
                selectable: false,
                children: [
                    {
                        text: '合同管理',
                        iconCls: 'x-fa fa-clipboard',
                        viewType: 'contract',
                        leaf: true
                    },
                    {
                        text: '业务审核',
                        iconCls: 'x-fa fa-pencil-square-o',
                        viewType: 'page404',
                        leaf: true
                    }
                ]
            }
        ]
    }
});

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
            }
        ]
    }
});

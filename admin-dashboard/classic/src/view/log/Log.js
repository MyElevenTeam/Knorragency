﻿Ext.define('Admin.view.log.Log', {
    extend: 'Ext.container.Container',
    xtype: 'log',

    //requires: [],
    controller: 'logViewController',				//viewController:代码与视图分离。声明视图绑定的事件，可以多个视图共享。
    viewModel: {type: 'LogViewModel'},	           //viewModel：配置Stote数据源。多个视图共享Store。
    	
    layout: 'fit',
    items: [{xtype:'logPanel'}]
});

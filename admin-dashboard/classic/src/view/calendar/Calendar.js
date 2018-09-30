﻿Ext.define('Admin.view.calendar.Calendar', {
    extend: 'Ext.container.Container',
    xtype: 'calendar',
    requires: ['Ext.calendar.form.AbstractForm'],
    //controller: 'order',				//viewController:代码与视图分离。声明视图绑定的事件，可以多个视图共享。
    //viewModel: {type: 'orderlist'},	//viewModel：配置Stote数据源。多个视图共享Store。
    
    controller: 'calendarViewController',
    // viewModel: {type: 'userViewModel'},
    	
    layout: 'fit',
    items: [{xtype:'calendarPanel'}]
    //html:'用户管理模块'
});
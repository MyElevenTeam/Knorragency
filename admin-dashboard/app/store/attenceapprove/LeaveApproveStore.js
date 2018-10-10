﻿Ext.define('Admin.store.attenceapprove.LeaveApproveStore', {
    extend: 'Ext.data.Store',
    storeId:'leaveApproveStore',
    alias: 'store.leaveApproveStore',
    model: 'Admin.model.attenceapprove.LeaveApproveModel',
    //pageSize: 25,
    proxy: {
        type: 'ajax',
        url: 'leave/tasks', 			//需要修改
        reader : new Ext.data.JsonReader({  
            type : 'json',  
            rootProperty  : 'content',
            totalProperty : 'totalElements'
        })
        ,simpleSortMode: true
    },
    remoteSort: true,
    sorters: [{ property: 'id',direction: 'desc'}],
    autoLoad: true
});	
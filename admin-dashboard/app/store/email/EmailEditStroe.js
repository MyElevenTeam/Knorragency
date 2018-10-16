Ext.define('Admin.store.email.EmailEditStroe', {
    extend: 'Ext.data.Store',
    storeId:'emailEditStroe',
    alias: 'store.emailEditStroe',
	model:'Admin.model.email.EmailModel',

    //连接后台数据
   proxy: {
		type: 'rest',
		url: '/email/findEmailEdit',
		reader:{
			type:'json',
			rootProperty:'content',//对应后台返回的结果集名称
			totalProperty: 'totalElements'//分页需要知道总记录数
		},
		writer: {
			type: 'json'
		},
		simpleSortMode: true	//简单排序模式
	},
	autoLoad: 'true',
    autoSync:true,
    remoteSort:true,
    pageSize:20,
    sorters: {
        direction: 'ASC',
        property: 'id'
    }
	
});

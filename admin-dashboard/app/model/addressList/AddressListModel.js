Ext.define('Admin.model.addressList.AddListModel', {
extend: 'Admin.model.Base',
requires: [
	'Ext.data.proxy.Rest'
],
	fields: [
		{type: 'int',name: 'id'},
		{type: 'string',name: 'employeeName'},
		{type: 'string', name: 'employeeNumber'},
		{type: 'string',name: 'employeeArea'},
		{type: 'string', name: 'post'},
		{type: 'string',name: 'email'}
	],
	proxy: {
		type: 'rest',
		url: '/addressList',
	}
});


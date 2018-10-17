Ext.define('Admin.model.email.EmailModel', {
extend: 'Admin.model.Base',
requires: [
	'Ext.data.proxy.Rest'
],
	fields: [
		{type: 'int',name: 'id'},
		{type: 'string',name: 'emailTo'},
		{type: 'string',name: 'emailFrom'},
		{type: 'string',name: 'emailSubject'},
		{type: 'string',name: 'emailContent'},
		{type: 'date', name: 'sendTime', dateFormat:'Y/m/d H:i:s'},
		{type: 'string',name: 'employeeName'},
		{type: 'string',name: 'emailStatus'},
		{type: 'string',name: 'readStatus'},
		{type: 'string',name: 'emailAttachment'}
	],
	proxy: {
		type: 'rest',
		url: '/email',
	}
});

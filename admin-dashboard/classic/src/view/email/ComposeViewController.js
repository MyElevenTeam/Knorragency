Ext.define('Admin.view.email.ComposeViewController', {
    extend: 'Ext.app.ViewController',
    alias: 'controller.composeViewController',

    onComposeDiscardClick: function(bt) {
        var win = bt.up('window');
        if (win) {
            win.close();
        }
    },
    onSaveClick:function(btn){
    	var win    = btn.up('window');
	    var form = win.down('form');
	    var values  =form.getValues();//获取form数据
	    //alert(values.emailTo);
	    //
	    //
	    var data=Ext.getCmp('email_attachment').getValue();
	    var str=data.split('\\');

	   // alert(str[length-1]);
	    alert(str[0]);
	    alert(str[1]);
	    alert(str[2]);

    }
    
});

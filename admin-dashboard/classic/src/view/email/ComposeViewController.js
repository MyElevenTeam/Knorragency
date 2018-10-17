var email_attachmentRebackId;
Ext.define('Admin.view.email.ComposeViewController', {
    extend: 'Ext.app.ViewController',
    alias: 'controller.composeViewController',

    opendUploadWindow:function(btn){
       btn.up('panel').up('container').add(Ext.widget('emailUploadWindow')).show();
    },
    onClickUploadAttachment:function(){
      var form = btn.up('window').down('form');
      if(form.isValid()){
          form.getForm().submit({       
              url:'/email/uploadAttachment',
              method : 'POST',
              waitMsg: '正在上传，请耐心等待....',
              success: function(form, action){    
                Ext.Msg.alert('提示', '上传成功！',function(){
                  btn.up('window').close();
                });       
              }, 
              failure: function(form, action){
                Ext.Msg.alert('提示', '上传失败！');
              }
          });
      }else{
         Ext.Msg.alert('提示', '请选择文件');
      }
      
    },
    onComposeDiscardClick: function(bt) {
        var win = bt.up('window');
        if (win) {
            win.close();
        }
    },
    onSaveClick:function(btn){
      /*var form = btn.up('window').down('form');
      if(form.isValid()){
          form.getForm().submit({       
              url:'/contract/uploadWord',
              method : 'POST',
              waitMsg: '正在上传，请耐心等待....',
              success: function(form, action){    
                Ext.Msg.alert('Success', action.result.msg,function(){
                  btn.up('window').close();
                  Ext.data.StoreManager.lookup('contractGridStroe').load();
                  //form.getViewModel().getStore('processDefinitionStroe').load();
                });       
              }, 
              failure: function(form, action){
                Ext.Msg.alert('Error', '上传失败');
              }
          });
      }else{
          Ext.Msg.alert('Error', '请选择文件');
      }*/


    }
    
});

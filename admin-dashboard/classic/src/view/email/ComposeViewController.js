Ext.define('Admin.view.email.ComposeViewController', {
    extend: 'Ext.app.ViewController',
    alias: 'controller.composeViewController',

    /*上传附件*/
    opendUploadWindow:function(btn){
       btn.up('panel').add(Ext.widget('emailUploadWindow')).show();
    },
    onClickUploadAttachment:function(btn){
      var form = btn.up('window').down('form');
      if(form.isValid()){
          form.getForm().submit({       
              url:'/email/uploadAttachment',
              method : 'POST',
              waitMsg: '正在上传，请耐心等待....',
              success: function(form, action){ 
                  var file=action.result.msg;
                  Ext.Msg.alert('提示', '文件上传成功！',function(){
                    btn.up('window').close();
                    Ext.getCmp('email_attachmentName').setValue(file);
                    Ext.getCmp('email_attachmentName').show();
                    Ext.getCmp('email_attachmentDelete').show();
                    Ext.getCmp('email_attachmentUpload').hide();
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
    /*删除附件*/
    deleteAttachment:function(btn){
        Ext.getCmp('email_attachmentName').setValue('');
        Ext.getCmp('email_attachmentName').hide();
        Ext.getCmp('email_attachmentDelete').hide();
        Ext.getCmp('email_attachmentUpload').show();
    },
   /*保存至草稿箱*/
    onSaveClick:function(btn){
      var win=btn.up('window');
      var form = btn.up('window').down('form');
      if(form.isValid()){
          var values  =form.getValues();
          Ext.Ajax.request({
            url : '/email/save', 
            method : 'post', 
            params : { 
              emailTo :values.emailTo,
              emailSubject:values.emailSubject,
              emailContent:values.emailContent,
              emailStatus:'EDIT',
              emailAttachment: Ext.getCmp('email_attachmentName').getValue()
            }, 
            success: function(response, options) {
                var json = Ext.util.JSON.decode(response.responseText);
                if(json.success){
                  Ext.Msg.alert('操作成功', json.msg, function() {
                        win.close();
                        // Ext.data.StoreManager.lookup('emailEditStroe').load();
                    });
                }else{
                   Ext.Msg.alert('操作失败', json.msg);
                }
            }
        });
      }else{
        Ext.Msg.alert('提示', '请填写正确格式');
      }
    },
    /*发送邮件*/
    onSendClick:function(btn){
      var win=btn.up('window');
      var form = btn.up('window').down('form');
      if(form.isValid()){
          var values  =form.getValues();
          Ext.Ajax.request({
            url : '/email/save', 
            method : 'post', 
            params : { 
              emailTo :values.emailTo,
              emailSubject:values.emailSubject,
              emailContent:values.emailContent,
              emailStatus:'SEND',
              emailAttachment: Ext.getCmp('email_attachmentName').getValue()
            }, 
            success: function(response, options) {
                var json = Ext.util.JSON.decode(response.responseText);
                if(json.success){
                  Ext.Msg.alert('操作成功', json.msg, function() {
                        win.close();
                        // Ext.data.StoreManager.lookup('emailEditStroe').load();
                    });
                }else{
                   Ext.Msg.alert('操作失败', json.msg);
                }
            }
        });
      }else{
        Ext.Msg.alert('提示', '请填写正确格式');
      }
    },
    /*清空*/
    onComposeDiscardClick: function(bt) {
        Ext.getCmp('email_emailTo').setValue('');
        Ext.getCmp('email_emailSubject').setValue('');
        Ext.getCmp('email_emailContent').setValue('');
        Ext.getCmp('email_attachmentName').setValue('');
        Ext.getCmp('email_attachmentName').hide();
        Ext.getCmp('email_attachmentDelete').hide();
        Ext.getCmp('email_attachmentUpload').show();
    }
    
});

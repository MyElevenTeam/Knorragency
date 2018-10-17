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
        Ext.MessageBox.confirm('提示', '确定要删除附件吗?',function(btn, text){
          if(btn=='yes'){
              Ext.Ajax.request({
                  url : '/email/deleteAttachment', 
                  method : 'post', 
                  params : { 
                    fileName: Ext.getCmp('email_attachmentName').getValue()
                  }, 
                  success: function(response, options) {
                      var json = Ext.util.JSON.decode(response.responseText);
                      if(json.success){
                        Ext.Msg.alert('操作成功', json.msg, function() {
                              Ext.getCmp('email_attachmentName').setValue('');
                              Ext.getCmp('email_attachmentName').hide();
                              Ext.getCmp('email_attachmentDelete').hide();
                              Ext.getCmp('email_attachmentUpload').show();
                          });
                      }else{
                         Ext.Msg.alert('操作失败', json.msg);
                      }
                  }
              });
          }
        }, this);
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
                  Ext.Msg.alert('操作成功', '发送成功', function() {
                        win.close();
                        // Ext.data.StoreManager.lookup('emailEditStroe').load();
                    });
                }else{
                   Ext.Msg.alert('操作失败', '发送失败');
                }
            }
        });
      }else{
        Ext.Msg.alert('提示', '请填写正确格式');
      }
    },
    /*清空*/
    onComposeDiscardClick: function(bt) {

      Ext.MessageBox.confirm('提示', '确定要进行删除操作吗？数据将无法还原！',function(btn, text){
        if(btn=='yes'){
          var fileName=Ext.getCmp('email_attachmentName').setValue('');
          if(fileName!=null){
                Ext.Ajax.request({
                  url : '/email/deleteAttachment', 
                  method : 'post', 
                  params : { 
                    fileName: Ext.getCmp('email_attachmentName').getValue()
                  }, 
                  success: function(response, options) {
                      var json = Ext.util.JSON.decode(response.responseText);
                      if(json.success){
                            Ext.getCmp('email_attachmentName').setValue('');
                            Ext.getCmp('email_attachmentName').hide();
                            Ext.getCmp('email_attachmentDelete').hide();
                            Ext.getCmp('email_attachmentUpload').show();

                            Ext.getCmp('email_emailTo').setValue('');
                            Ext.getCmp('email_emailSubject').setValue('');
                            Ext.getCmp('email_emailContent').setValue('');
                      }else{
                         Ext.Msg.alert('操作失败', json.msg);
                      }
                  }
              });
          }else{
              Ext.getCmp('email_emailTo').setValue('');
              Ext.getCmp('email_emailSubject').setValue('');
              Ext.getCmp('email_emailContent').setValue('');
          }
        }
      }, this);
        
    }
    
});

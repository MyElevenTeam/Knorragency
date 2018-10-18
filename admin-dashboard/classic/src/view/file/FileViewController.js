Ext.define('Admin.view.file.FileViewController', {
    extend: 'Ext.app.ViewController',
    alias: 'controller.fileViewController',

    /*保存*/
    openFileWindow:function(toolbar){
    	toolbar.up('panel').up('container').add(Ext.widget('fileWindow')).show();
    },
    submitEditFormButton:function(btn){
    	  var win    = btn.up('window');
        var form = win.down('form');
        var record = Ext.create('Admin.model.file.FileModel');
        var values  =form.getValues();
        record.set(values);
        record.save();
        Ext.data.StoreManager.lookup('editGridStroe').load();
        win.close();
    },
    submitSendFormButton:function(btn){
        var win    = btn.up('window');
        var form = win.down('form');
        var record = Ext.create('Admin.model.file.FileModel');
        var values  =form.getValues();
        alert(values.emailStatus);
        // record.set(values);
        // record.save();
        // Ext.data.StoreManager.lookup('editGridStroe').load();
        win.close();
    },
    /*上传附件*/
    opendUploadWindow:function(btn){
       btn.up('panel').up('container').add(Ext.widget('attachmentUploadWindow')).show();
    },
    onClickUploadFormSumbitButton:function(btn){
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
                    Ext.getCmp('file_attachmentName').setValue(file);
                    Ext.getCmp('file_attachmentName').show();
                    Ext.getCmp('file_attachmentDelete').show();
                    Ext.getCmp('file_attachmentUpload').hide();
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
                    fileName: Ext.getCmp('file_attachmentName').getValue()
                  }, 
                  success: function(response, options) {
                      var json = Ext.util.JSON.decode(response.responseText);
                      if(json.success){
                        Ext.Msg.alert('操作成功', json.msg, function() {
                              Ext.getCmp('file_attachmentName').setValue('');
                              Ext.getCmp('file_attachmentName').hide();
                              Ext.getCmp('file_attachmentDelete').hide();
                              Ext.getCmp('file_attachmentUpload').show();
                          });
                      }else{
                         Ext.Msg.alert('操作失败', json.msg);
                      }
                  }
              });
          }
        }, this);
    },
});

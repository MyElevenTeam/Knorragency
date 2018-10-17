Ext.define('Admin.view.email.EmailViewController', {
    extend: 'Ext.app.ViewController',

    alias: 'controller.emailViewController',

    init: function() {
        this.setCurrentView('edit');
    },

    onBackBtnClick: function() {
        this.setCurrentView('edit');
    },

    onMenuClick: function (menu, item) {
        if (item && item.routeId === 'emailcompose') {
            this.setCurrentView(item.routeId, item.params);
            //Ext.getCmp('emailFrom').setValue(Ext.getCmp('loginUserName').getValue());
        }
        if (item && item.routeId === 'edit') {
            this.setCurrentView('edit');
        }
        if (item && item.routeId === 'send') {
            this.setCurrentView('send');
        }
        if (item && item.routeId === 'trash') {
            this.setCurrentView('trash');
        }
        
    },

    setCurrentView: function(view, params) {
        var contentPanel = this.getView().down('#contentPanel');

        //We skip rendering for the following scenarios:
        // * There is no contentPanel
        // * view xtype is not specified
        // * current view is the same
        if(!contentPanel || view === '' || (contentPanel.down() && contentPanel.down().xtype === view)){
            return false;
        }

        if (params && params.openWindow) {
            var cfg = Ext.apply({
                xtype: 'emailwindow',
                items: [
                    Ext.apply({
                        xtype: view
                    }, params.targetCfg)
                ]
            }, params.windowCfg);

            Ext.create(cfg);
        } else {
            Ext.suspendLayouts();

            contentPanel.removeAll(true);
            contentPanel.add(
                Ext.apply({
                    xtype: view
                }, params)
            );

            Ext.resumeLayouts(true);
        }
    },

    onGridCellItemClick: function(view, td, cellIndex, record){
        if(cellIndex > 1){
            this.setCurrentView('emaildetails', {record: record});
        } else if (cellIndex === 1) {
            //Invert selection
            record.set('favorite', !record.get('favorite'));
        }
    },

    beforeDetailsRender: function(view) {
        var record = view.record ? view.record : {};

        view.down('#mailBody').setHtml(record.get('contents'));
        view.down('#attachments').setData(record.get('attachments'));
        view.down('#emailSubjectContainer').setData(record.data? record.data: {});
        view.down('#userImage').setSrc('resources/images/user-profile/'+ record.get('user_id') + '.png');
    },

    /*对草稿箱进行编辑*/
    onEditButton:function(grid, rowIndex, colIndex){
        var record = grid.getStore().getAt(rowIndex);
        if (record ) {
            var win = grid.up('panel').up('container').add(Ext.widget('emailEditWindow'));
            if(record.data.emailAttachment!=''){
                Ext.getCmp('edit_attachmentName').setValue(record.data.emailAttachment);
                Ext.getCmp('edit_attachmentName').show();
                Ext.getCmp('edit_attachmentDelete').show();
                Ext.getCmp('edit_attachmentUpload').hide();
            }
            win.show();
            win.down('form').getForm().loadRecord(record);
        }
    },
    /*保存修改*/
    submitEmailEditFormButton:function(btn){
          var win=btn.up('window');
          var form = btn.up('window').down('form');
          var values  =form.getValues();
          alert(values.id);
          // if(form.isValid()){
             
          //     Ext.Ajax.request({
          //       url : '/email/update', 
          //       method : 'post', 
          //       params : { 
          //         id:values.id,
          //         emailTo :values.emailTo,
          //         emailSubject:values.emailSubject,
          //         emailContent:values.emailContent,
          //         emailAttachment: Ext.getCmp('edit_attachmentName').getValue()
          //       }, 
          //       success: function(response, options) {
          //           var json = Ext.util.JSON.decode(response.responseText);
          //           if(json.success){
          //             Ext.Msg.alert('操作成功', json.msg, function() {
          //                   win.close();
          //                   // Ext.data.StoreManager.lookup('emailEditStroe').load();
          //               });
          //           }else{
          //              Ext.Msg.alert('操作失败', json.msg);
          //           }
          //       }
          //   });
          // }else{
          //   Ext.Msg.alert('提示', '请填写正确格式');
          // }
    },
    /*上传附件*/
    opendUploadWindow:function(btn){
       btn.up('window').add(Ext.widget('emailUploadWindow')).show();
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
                    Ext.getCmp('edit_attachmentName').setValue(file);
                    Ext.getCmp('edit_attachmentName').show();
                    Ext.getCmp('edit_attachmentDelete').show();
                    Ext.getCmp('edit_attachmentUpload').hide();
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
                    fileName: Ext.getCmp('edit_attachmentName').getValue()
                  }, 
                  success: function(response, options) {
                      var json = Ext.util.JSON.decode(response.responseText);
                      if(json.success){
                        Ext.Msg.alert('操作成功', json.msg, function() {
                              Ext.getCmp('edit_attachmentName').setValue('');
                              Ext.getCmp('edit_attachmentName').hide();
                              Ext.getCmp('edit_attachmentDelete').hide();
                              Ext.getCmp('edit_attachmentUpload').show();
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

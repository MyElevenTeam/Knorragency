var video_userId;
Ext.define('Admin.view.authentication.AuthenticationController', {
    extend: 'Ext.app.ViewController',
    alias: 'controller.authentication',

    //TODO: implement central Facebook OATH handling here

    onFaceBookLogin : function() {
        this.redirectTo('dashboard', true);
    },

	onLoginButton: function(btn){
    	var me = this;
        Ext.Ajax.request({
            url: 'login',
            method: 'post',
            async:false,
            params: {
                userName: btn.up("form").getForm().findField("userid").getValue(),
                password: btn.up("form").getForm().findField("password").getValue()
            },
            success: function(response, options) {
            	var json = Ext.util.JSON.decode(response.responseText);
	            if(json.success){
                    me.redirectTo('dashboard', true);
                    Ext.getCmp('loginUserName').setText(json.map.userName);
                    //通过全局变量传递用户id
                    video_userId=json.map.userId;
		        }else{
		        	Ext.Msg.alert('登录失败', json.msg);
		        }
            }
        }); 
          //websocket初始化
        websocket = null;
        if('WebSocket' in window){ 
              websocket = new WebSocket("ws://localhost:8080/websocket/"+video_userId);
        }else{
            Ext.Msg.alert('Not support websocket');
        }
        websocket.onmessage = function(event){
            var json = JSON.parse(event.data);
            if(json.event=="notice"){
                if(Ext.getCmp("notice_panel")){
                     Ext.getCmp("notice_panel").getStore().load();
                 }
	             Ext.Msg.alert("公告",json.data);
             }else{
                Ext.MessageBox.confirm('提示', '是否接收群聊',function(btn, text){
                    if(btn=='yes'){
                         var ids={
                            "userId":parseInt(video_userId),
                            "idGroup":json.idGroup
                          }
                         sessionStorage.setItem("orderPage_ids", JSON.stringify(ids));
                         window.open('https://'+window.location.host+'/a');
                    }
                }, this);
             }
            
        }
        window.onbeforeunload = function(){
            websocket.close();
        }   
	},
    onLoginAsButton: function() {
        this.redirectTo('login', true);
    },

    onNewAccount:  function() {
        this.redirectTo('register', true);
    },

    onSignupClick:  function() {
        this.redirectTo('dashboard', true);
    },

    onResetClick:  function() {
        this.redirectTo('dashboard', true);
    }
});
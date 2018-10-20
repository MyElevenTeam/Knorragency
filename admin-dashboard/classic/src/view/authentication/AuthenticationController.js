
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
                    //websocket初始化
                    websocket = null;
                    if('WebSocket' in window){
                        websocket = new WebSocket("ws://localhost:8080/websocket/"+video_userId);
                    }else{
                        Ext.Msg.alert('Not support websocket');
                    }
                    //接收到消息的回调方法
                    websocket.onmessage = function(event){
                         Ext.getCmp("notice_panel").getStore().load();
                    }

                    //监听窗口关闭事件，当窗口关闭时，主动去关闭websocket连接，防止连接还没断开就关闭窗口，server端会抛异常。
                    window.onbeforeunload = function(){
                        websocket.close();
                    }
		        }else{
		        	Ext.Msg.alert('登录失败', json.msg);
		        }
            }
        });
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
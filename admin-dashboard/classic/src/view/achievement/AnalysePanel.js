Ext.define('Admin.view.achievement.AnalysePanel', {
    extend: 'Ext.container.Container',
    xtype: 'analysePanel',
    requires: [ 
        'Ext.layout.container.HBox',
    ],
    dataIndex:'fullname',
    layout: {
        type :'hbox',
        align: 'stretch'               
    },
    margin: '0 0 10 0',
    items: [
        {   
          xtype: 'dataview',
          bind: '{anlyseDate}',
          itemTpl:
           "<img src='resources/images/user-profile/{picture}' alt='Profile Pic'  style='height:100px ;width:100px;border-radius:500px;position: absolute;left:33%;top: 25%;'>"+
           "<img src='resources/images/icons/crown1.png' alt='Profile Pic'  style='height:120px ;width:200px;position: absolute;left:16%;top: -11%;'>"+
           "<img src='resources/images/icons/crown2.png' alt='Profile Pic'  style='height:120px ;width:200px;position: absolute;left:16%;top: 30%;'>"+
           "<tpl for='.'><h2 style='position: absolute;bottom:0px;text-align: center;left: 0;right: 0;color:#919191;'>销售冠军:"+"{winner}"+"</h2></tpl>",
           cls:'_boder',
           flex : 1
        },
        {  
           xtype: 'dataview',
           bind: '{anlyseDate}',
           itemTpl:
           "<br><br><div style='color:#919191;text-align:center;line-height:0.8em'><p style='font-size:3em'>￥{total}</p><br>"+
           "<h2>销售总额</h2></div><br><br><br>",
           cls:'_boder',
           flex : 1              
        },
        {
           xtype: 'dataview',
           bind: '{anlyseDate}',
           itemTpl:
           "<br><br><div style='color:#919191;text-align:center;line-height:0.8em'><p style='font-size:3em'>{rate}%</p><br>"+
           "<h2>月增长率</h2></div><br><br><br>",
           cls:'_boder',
           flex : 1
        },
        {
           xtype: 'dataview',
           bind: '{anlyseDate}',
           itemTpl:
          "<br><br><div style='color:#919191;text-align:center;line-height:0.8em'><p style='font-size:3em'>{peopleNum}</p><br>"+
           "<h2>总人数</h2><br><br><br>",
           cls:'_boder',
           flex : 1
        }
    ]
    
});

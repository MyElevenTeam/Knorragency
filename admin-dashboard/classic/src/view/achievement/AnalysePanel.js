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
           itemSelector: 'test',
           html:
           "<img src='resources/images/user-profile/1.png' alt='Profile Pic'  style='height:100px ;width:100px;border-radius:500px;position: absolute;left:33%;top: 25%;'>"+
           "<img src='resources/images/icons/crown1.png' alt='Profile Pic'  style='height:120px ;width:200px;position: absolute;left:16%;top: -18%;'>"+
           "<img src='resources/images/icons/crown2.png' alt='Profile Pic'  style='height:120px ;width:200px;position: absolute;left:16%;top: 26%;'>",
           itemTpl:"<tpl for='.'><h2 style='position: absolute;bottom:0px;text-align: center;left: 0;right: 0;color:#919191;'>"+"{fullname}"+"</h2></tpl>",
           cls:'_boder',
           flex : 1
        },
        {    
           html :
           "<div style='color:#919191;text-align:center;line-height:0.8em'><p style='font-size:3em'>￥2000000000</p><br>"+
           "<h2>销售总额</h2></div>",
           cls:'_boder',
           flex : 1              
        },
        {
           html : 
           "<div style='color:#919191;text-align:center;line-height:0.8em'><p style='font-size:3em'>20%</p><br>"+
           "<h2>月增长率</h2></div>",
           cls:'_boder',
           flex : 1
        },
        {
           html :
          "<div style='color:#919191;text-align:center;line-height:0.8em'><p style='font-size:3em'>20</p><br>"+
           "<h2>总人数</h2></div>",
           cls:'_boder',
           flex : 1
        }
    ]
    
});

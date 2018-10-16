Ext.define('Admin.view.achievement.SortPanel', {
    extend: 'Ext.container.Container',
    xtype: 'sortPanel',
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
             bind: '{sortDate}',
             itemTpl:
            "<tpl if='rank==1'><div style='color:#919191;'><div style='text-align:center;'><img src='resources/images/user-profile/1.png' alt='Profile Pic'  style='height:100px ;width:100px;border-radius:500px;text-align:center;'>"+
            "<h2>我就是这么优秀</h2></div><br>"+
            "<h2 style='text-align:right'>———{employeeName}</h2></div></tpl>",
             cls:'_boder',
             flex : 1
          },
          {    
             xtype: 'dataview',
             bind: '{sortDate}',
             itemTpl: 
            "<tpl if='rank==2'><div style='color:#919191;'><div style='text-align:center;'><img src='resources/images/user-profile/20.png' alt='Profile Pic'  style='height:100px ;width:100px;border-radius:500px;text-align:center;'>"+
            "<h2>像我这么优秀的还有三个</h2></div><br>"+
            "<h2 style='text-align:right'>———{employeeName}</h2></div></tpl>",
             cls:'_boder',
             flex : 1            
          },
          {
            xtype: 'dataview',
            bind: '{sortDate}',
            itemTpl:
            "<tpl if='rank==3'><div style='color:#919191;'><div style='text-align:center;'><img src='resources/images/user-profile/10.png' alt='Profile Pic'  style='height:100px ;width:100px;border-radius:500px;text-align:center;'>"+
            "<h2>你们好优秀啊</h2></div><br>"+
            "<h2 style='text-align:right'>———{employeeName}</h2></div></tpl>",
             cls:'_boder',
             flex : 1    
          },
          {
             xtype: 'dataview',
             bind: '{sortDate}',
             itemTpl: 
            "<tpl if='rank==4'><div style='color:#919191;'><div style='text-align:center;'><img src='resources/images/user-profile/7.png' alt='Profile Pic'  style='height:100px ;width:100px;border-radius:500px;text-align:center;'>"+
            "<h2>是啊</h2></div><br>"+
            "<h2 style='text-align:right'>———{employeeName}</h2></div></tpl>",
             cls:'_boder',
             flex : 1    
          }
      ]
    
});

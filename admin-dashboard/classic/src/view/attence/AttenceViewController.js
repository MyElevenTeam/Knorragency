Ext.define('Admin.view.attence.AttenceViewController', {
    extend: 'Ext.app.ViewController',
    alias: 'controller.attenceViewController',

    /*LeaveWindow*/
    openLeaveWindow:function(toolbar, rowIndex, colIndex){
      toolbar.up('panel').up('container').add(Ext.widget('leaveGridWindow')).show();
    },
    /*Add*/
    openAddWindow:function(toolbar, rowIndex, colIndex){
      toolbar.up('panel').up('container').add(Ext.widget('leaveAddWindow')).show();
    },
    search:function(btn){
      Ext.getCmp('attence_searchFieldValue').show();
      Ext.getCmp('attence_search').hide();
    },
    hhh:function(btn){
      alert("sss");
    },
    starLeaveProcess:function(grid){
      Ext.getCmp('attencePanel_processInstanceId').show();
      //grid.columns['workoutTime'].show();
    }
	
});

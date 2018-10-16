Ext.define('Admin.model.achievement.AnalyseModel', {
    extend: 'Admin.model.Base',

    fields: [
      {type:'string',name:'winner'},
      {type:'float',name:'total'},
      {type:'float',name:'rate'},
      {type:'int',name:'peopleNum'}
    ]
});

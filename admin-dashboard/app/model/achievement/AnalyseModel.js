Ext.define('Admin.model.achievement.AnalyseModel', {
    extend: 'Admin.model.Base',

    fields: [
      {type:'string',name:'winner'},
      {type:'int',name:'monthTotal'},
      {type:'int',name:'monthRate'},
      {type:'int',name:'peopleNum'},
    ]
});

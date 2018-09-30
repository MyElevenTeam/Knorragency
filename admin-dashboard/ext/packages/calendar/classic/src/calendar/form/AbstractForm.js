/**
 * A base implementation of a form for the classic toolkit.
 * @abstract
 */
Ext.define('Ext.calendar.form.AbstractForm', {
    extend: 'Ext.window.Window',

    requires: [
        'Ext.layout.container.Fit',
        'Ext.layout.container.VBox',
        'Ext.layout.container.HBox',
        'Ext.form.Panel',
        'Ext.form.field.Text',
        'Ext.form.field.Date',
        'Ext.form.field.Time',
        'Ext.form.field.Checkbox',
        'Ext.calendar.form.CalendarPicker'
    ],

    layout: 'fit',
    modal: true,
    closable: false,
    defaultListenerScope: true,

    config: {
        /**
         * @cfg {Object} calendarField
         * The config for the calendar field.
         */
        idField:{
            xtype: 'textfield',
            fieldLabel: '序号',
            name: 'id',
            hidden: true
          //  allowBlank: false
        },
        calendarField: {
            xtype: 'calendar-calendar-picker',
            fieldLabel: '类型',
            name: 'calendarId',
            forceSelection: true,
            editable: false,
            queryMode: 'local',
            displayField: 'title',
            valueField: 'id'
        },

        /**
         * @cfg {Object} titleField
         * The config for the title field.
         */
        titleField: {
            xtype: 'textfield',
            fieldLabel: '标题',
            name: 'title',
            allowBlank: false
        },

        /**
         * @cfg {Object} fromContainer
         * The config for the from container.
         */
        fromContainer: {
            xtype: 'fieldcontainer',
            fieldLabel: '开始',
            layout: 'hbox'
        },

        /**
         * @cfg {Object} startDateField
         * The config for the start date field.
         */
        startDateField: {
            xtype: 'datefield',
            itemId: 'startDate',
            name: 'startDate',
          //  format: 'Y/m/d H:i:s',
            allowBlank: false
        },

        /**
         * @cfg {Object} startTimeField
         * The config for the start time field.
         */
        startTimeField: {
            xtype: 'timefield',
            itemId: 'startTime',
            name: 'startTime',
            margin: '0 0 0 5'
        },

        /**
         * @cfg {Object} toContainer
         * The config for the to container.
         */
        toContainer: {
            xtype: 'fieldcontainer',
            fieldLabel: '结束',
            layout: 'hbox'
        },

        /**
         * @cfg {Object} endDateField
         * The config for the end date field.
         */
        endDateField: {
            xtype: 'datefield',
            itemId: 'endDate',
            name: 'endDate',
          //  format: 'Y/m/d H:i:s',
            allowBlank: false
        },

        /**
         * @cfg {Object} endTimeField
         * The config for the end time field.
         */
        endTimeField: {
            xtype: 'timefield',
            itemId: 'endTime',
            name: 'endTime',
            margin: '0 0 0 5'
        },

        /**
         * @cfg {Object} allDayField
         * The config for the all day field.
         */
        allDayField: {
            xtype: 'checkbox',
            itemId: 'allDay',
            name: 'allDay',
            boxLabel: '全天',
            hideEmptyLabel: false,
            handler: 'onAllDayChange'
        },

        /**
         * @cfg {Object} descriptionField
         * The config for the description field.
         */
        descriptionField: {
            xtype: 'textarea',
            fieldLabel: '详细内容',
            name: 'description',
            flex: 1
        },

        /**
         * @cfg {Object} dropButton
         * The config for the drop button. `null` to not show this button.
         */
        dropButton: {
            text: '删除',
            handler: 'onDropTap'
        },

        /**
         * @cfg {Object} saveButton
         * The config for the save button.
         */
        saveButton: {
            text: '保存',
            handler: 'onSaveTap'
        },

        /**
         * @cfg {Object} cancelButton
         * The config for the cancel button.
         */
        cancelButton: {
            text: '取消',
            handler: 'onCancelTap'
        }
    },

    initComponent: function() {
        var me = this;

        me.initForm();
        me.fbar = me.generateButtons();

        me.callParent();
        me.form = me.items.first();
        me.checkFields();
        me.applyValues();
    },

    generateButtons: function() {
        var buttons = [],
            drop = this.getDropButton();

        if (drop) {
            buttons.push(drop);
        }

        buttons.push({
            xtype: 'component',
            flex: 1
        }, this.getSaveButton(), this.getCancelButton());

        return buttons;
    },

    applyValues: function() {
        this.form.getForm().setValues(this.consumeEventData());
    },

    createItems: function() {
        var me = this,
            calField = me.getCalendarField(),
            fromCt = me.getFromContainer(),
            toCt = me.getToContainer();

        if (!calField.store) {
            calField.store = me.getCalendarStore();
        }

        if (!fromCt.items) {
            fromCt.items = [me.getStartDateField(), me.getStartTimeField()];
        }

        if (!toCt.items) {
            toCt.items = [me.getEndDateField(), me.getEndTimeField()];
        }

        this.items = [{
            xtype: 'form',
            border: false,
            trackResetOnLoad: true,
            layout: {
                type: 'vbox',
                align: 'stretch'
            },
            bodyPadding: 10,
            items: [
                calField,
                me.getIdField(),
                me.getTitleField(),
                fromCt,
                toCt,
                me.getAllDayField(),
                me.getDescriptionField()
            ]
        }];
    },

    privates: {
        checkFields: function() {
            var checked = this.down('#allDay').checked;
            this.down('#startTime').setDisabled(checked);
            this.down('#endTime').setDisabled(checked);
        },

        onAllDayChange: function() {
            this.checkFields();
        },

        onCancelTap: function() {
            // var form = this.form;
            // form.getForm().findField('description').setValue(1);
            this.fireCancel();
        },

        onDropTap: function() {
            var form = this.form,
            values = form.getForm().getFieldValues();
                if (!form.isValid()) {
                    return;
                }
            Ext.Ajax.request({ 
                url : '/calendar/delete', 
                method : 'post', 
                //headers: {'Content-Type':'application/json'},
                params : {
                        id:values.id
                }, 
                success: function(response, options) {
                }
            });
            this.fireDrop();
        },

        onSaveTap: function() {
            var form = this.form,
                values = form.getForm().getFieldValues();
            var id = values.id;
                if (!form.isValid()) {
                    return;
                }
                values.allDay = this.down('#allDay').checked;
 
            if(values.allDay == true){
                 var stime = Ext.util.Format.date(values.startDate,'Y-m-d') + 'T00:00:00.000Z';
                 var etime = Ext.util.Format.date(values.endDate,'Y-m-d') + 'T24:00:00.000Z';
            }else{
                 var stime = Ext.util.Format.date(values.startDate,'Y-m-d') + 'T' + Ext.util.Format.date(values.startTime,'H:i:s')+'.000Z';
                 var etime = Ext.util.Format.date(values.endDate,'Y-m-d') + 'T' + Ext.util.Format.date(values.endTime,'H:i:s')+'.000Z';
            }
          //  form.lookupReference('title').setValue("465346");
            var me = this;
            

            if(id.search("Ext") != -1){
             var data =  JSON.stringify({
                                    startDate : stime,
                                    endDate :   etime,
                                    calendarId : values.calendarId,
                                    title : values.title,
                                    description : values.description,
                                    allDay : values.allDay
                            });

               
            }else{
                var data = JSON.stringify({
                                    id : id,
                                    startDate : stime,
                                    endDate :   etime,
                                    calendarId : values.calendarId,
                                    title : values.title,
                                    description : values.description,
                                    allDay : values.allDay
                            });
            }

             Ext.Ajax.request({ 
                            url : '/calendar', 
                            method : 'post', 
                            headers: {'Content-Type':'application/json'},
                            params : data,
                            success: function(response, options) {
                                    values.id=response.responseText; 
                                    me.fireSave(me.produceEventData(values));
                                   // window.location.reload();
                            }
                        });
        }
    }
});
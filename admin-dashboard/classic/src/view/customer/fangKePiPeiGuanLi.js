/*
 * Copyright (C) 2018, Victorique Ko. All rights reserved.
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Affero General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Affero General Public License for more details.
 *
 * You should have received a copy of the GNU Affero General Public License
 * along with this program.  If not, see <https://www.gnu.org/licenses/>.
 */

Ext.define('Admin.view.customer.fangKePiPeiGuanLi', {
  extend: 'Ext.container.Container',
  xtype: 'fangKePiPeiGuanLi',
  items: [{
    xtype: 'panel',
    listeners: {
      render: function(e) {
        function bootstrap(e) {
          if (render !== undefined) {
            render(FangKePiPeiGuanLi, e.id);
          } else {
            setTimeout(function() {
              bootstrap(e);
            }, 100);
          }
        };
        bootstrap(e);
      }
    }
  }]
});
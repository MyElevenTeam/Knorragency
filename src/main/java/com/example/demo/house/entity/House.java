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

package com.example.demo.house.entity;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity()
public class House {

    /**
     * ID
     */
    @Id()
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    /**
     * 房源名称
     */
    private String houseName;

    /**
     * 房源类型
     */
    private String houseType;

    /**
     * 区域
     */
    private double housePrice;

    /**
     * 售价
     */
    private double houseProportion;

    /**
     * 位置
     */
    private String housePosition;

    /**
     * 私有
     */
    private boolean own;
}

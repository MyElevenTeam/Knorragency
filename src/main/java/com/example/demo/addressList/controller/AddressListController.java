package com.example.demo.addressList.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.demo.addressList.entity.Employee;
import com.example.demo.addressList.entity.EmployeeQueryDTO;
import com.example.demo.addressList.service.AddressListService;
import com.example.demo.addressList.service.IAddressListService;
import com.example.demo.common.controller.ExtjsPageRequest;

@RestController
@RequestMapping("/addressList")
public class AddressListController {
	@Autowired
	private IAddressListService addressListService;
	@GetMapping
	public Page<Employee> getPage(EmployeeQueryDTO employeeQueryDTO,ExtjsPageRequest extjsPageRequest) {
		return  addressListService.findAll(EmployeeQueryDTO.getWhereClause(employeeQueryDTO), extjsPageRequest.getPageable());
	}
}

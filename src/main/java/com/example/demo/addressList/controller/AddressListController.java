package com.example.demo.addressList.controller;

import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.demo.addressList.service.IAddressListService;
import com.example.demo.employee.domain.EmployeeDTO;
import com.example.demo.employee.domain.EmployeeQueryDTO;
import com.example.demo.employee.util.ExtjsPageRequest;
import com.example.demo.log.config.SystemControllerLog;

@RestController
@RequestMapping("/addressList")
public class AddressListController {
	
	@Autowired
	IAddressListService addressListService;
	
	private static final Logger log = LoggerFactory.getLogger(AddressListController.class);
	@GetMapping
	@SystemControllerLog(description="查看通讯录")
	public Page<EmployeeDTO> getAddressList(EmployeeQueryDTO employeeQueryDTO,
			HttpSession session,ExtjsPageRequest pageable){
		
		String en=(String) session.getAttribute("employeeNumber");
		String post=(String) session.getAttribute("post");
		//判断session中employeeNumber和post是否都为空，是就返回null，不为空就执行
		if(StringUtils.isNotBlank(en) && StringUtils.isNotBlank(post)) {
			pageable.setLimit(10);
			Page<EmployeeDTO> page;
			page=addressListService.addressListFindAll(EmployeeQueryDTO.getWhereClause(employeeQueryDTO), pageable.getPageable(),session);
			return page;
		}
		return null;
		
	}
}

package com.example.demo.addressList.service;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.demo.common.utils.ListPageUtil;
import com.example.demo.employee.domain.Employee;
import com.example.demo.employee.domain.EmployeeDTO;
import com.example.demo.employee.repository.EmployeeRepository;
import com.example.demo.employee.util.BeanUtils;

@Service
@Transactional
public class AddressListService implements IAddressListService{
	
	@Autowired
	EmployeeRepository employeeRepository;

	@Override
	public Page<EmployeeDTO> addressListFindAll(Specification<Employee> spec, Pageable pageable, HttpSession session) {
		// TODO Auto-generated method stub
		List<EmployeeDTO> results=null;
		List<Employee> employees = null;
		List<Employee> pageList=null;
		ListPageUtil<Employee> listPageUtil=null;//分页工具List
		employees=employeeRepository.findAll(spec);
		Employee employee=employeeRepository.findByEmployeeNumber((String) session.getAttribute("employeeNumber"));
		employees.remove(employee);
		listPageUtil = new ListPageUtil<Employee>(employees
				,pageable.getPageNumber()+1, pageable.getPageSize());
		pageList=listPageUtil.getPagedList();
		if(null!=pageList) {
			results=new ArrayList<EmployeeDTO>();
			for(Employee entity : pageList) {
				
				EmployeeDTO employeeDTO=new EmployeeDTO();
				//注意，因为BeanUtils.copyProperties是让source把target里面相同的属性名的属性覆盖掉
				//即便source里相同属性名中有null，这里先让entity.getLocalStore()覆盖是因为
				//entity.getLocalStore()与entity中主键都叫id
				if(entity.getLocalStore()!=null) {
					BeanUtils.copyProperties(entity.getLocalStore(), employeeDTO);
				}
				BeanUtils.copyProperties(entity, employeeDTO);
				results.add(employeeDTO);
			}
		}
		return new PageImpl<EmployeeDTO>(results, pageable, employees.size());
		
	}
	
}

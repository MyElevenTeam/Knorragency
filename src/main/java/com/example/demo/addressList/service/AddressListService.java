package com.example.demo.addressList.service;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import com.example.demo.addressList.entity.Employee;
import com.example.demo.addressList.repository.AddressListRepository;


@Service
@Transactional
public class AddressListService implements IAddressListService {
	@Autowired
	private AddressListRepository addressListRepository;
	
	public void save(Employee employee) {
		addressListRepository.save(employee);	
	}
	
	public Page<Employee> findAll(Specification<Employee> emp,Pageable pageable){
		return addressListRepository.findAll(emp,pageable);
	}

}

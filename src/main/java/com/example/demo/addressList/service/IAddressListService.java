package com.example.demo.addressList.service;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;

import com.example.demo.addressList.entity.Employee;

public interface IAddressListService {
	public void save(Employee employee);
	public Page<Employee> findAll(Specification<Employee> emp,Pageable pageable);
}

package com.example.demo.addressList.repository;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.example.demo.addressList.entity.Employee;

public interface AddressListRepository extends JpaSpecificationExecutor<Employee>,PagingAndSortingRepository<Employee , Long>{

}

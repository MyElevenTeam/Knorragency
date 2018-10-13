package com.example.demo.employee.repository;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.stereotype.Repository;

import com.example.demo.employee.domain.Employee;


@Repository
public interface EmployeeRepository extends PagingAndSortingRepository<Employee, Long>,JpaSpecificationExecutor<Employee>{
	
	@Query("from Employee e where e.employeeNumber = ?1")
	public Employee findByEmployeeNumber(String employeeNumber);
	
	@Query("from Employee e where e.employeeNumber = ?1 and e.password = ?2")
	public Employee checkPassword(String employeeNumber,String password);
}

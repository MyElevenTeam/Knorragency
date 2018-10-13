package com.example.demo.contract.repository;

import java.util.Date;
import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.stereotype.Repository;

import com.example.demo.contract.entity.Contract;

@Repository
public interface ContractRepository extends PagingAndSortingRepository<Contract, Long>,JpaSpecificationExecutor<Contract>{
	
	@Query("select sum(c.total) from Contract c where month(c.startTime) like month(?1) and c.employeeName like ?2 group by c.employeeName order by sum(c.total) desc")
	public List<Object> sum(Date d,String employeeName);
}

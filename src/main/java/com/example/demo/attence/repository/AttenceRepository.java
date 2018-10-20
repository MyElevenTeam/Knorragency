package com.example.demo.attence.repository;

import java.util.Date;
import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.stereotype.Repository;

import com.example.demo.attence.entity.Attence;

@Repository
public interface AttenceRepository extends PagingAndSortingRepository<Attence, Long>,JpaSpecificationExecutor<Attence>{
	
	@Query("from Attence a where month(a.workinTime) like month(?1) and a.employee.localStore.storeName like ?2")
	public List<Attence> findByMonthAndStoreName(Date month,String storeName);
	
	@Query("from Attence a where month(a.workinTime) like month(?1) and a.employee.employeeName like ?2")
	public List<Attence> findByMonth(Date month,String employeeName);
}

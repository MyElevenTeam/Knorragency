package com.example.demo.store.repository;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.stereotype.Repository;

import com.example.demo.store.domain.Store;


@Repository
public interface StoreRepository extends PagingAndSortingRepository<Store, Long>,JpaSpecificationExecutor<Store>{
	
	@Query("from Store s where s.storeName = ?1")
	public Store findByStoreName(String storeName);
	
}

package com.example.demo.contract.repository;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.stereotype.Repository;

import com.example.demo.contract.entity.Contract;

@Repository
public interface ContractRepository extends PagingAndSortingRepository<Contract, Long>,JpaSpecificationExecutor<Contract>{

}

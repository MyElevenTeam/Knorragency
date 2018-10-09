package com.example.demo.attence.repository;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.stereotype.Repository;

import com.example.demo.attence.entity.Leave;

@Repository
public interface LeaveRepository extends PagingAndSortingRepository<Leave, Long>,JpaSpecificationExecutor<Leave>
{

}

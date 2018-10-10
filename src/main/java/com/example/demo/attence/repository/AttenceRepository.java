package com.example.demo.attence.repository;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.stereotype.Repository;

import com.example.demo.attence.entity.Attence;

@Repository
public interface AttenceRepository extends PagingAndSortingRepository<Attence, Long>,JpaSpecificationExecutor<Attence>{

}

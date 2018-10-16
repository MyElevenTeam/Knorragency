package com.example.demo.email.repository;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.stereotype.Repository;

import com.example.demo.email.entity.Email;

@Repository
public interface EmailRepository extends PagingAndSortingRepository<Email, Long>,JpaSpecificationExecutor<Email>{

}

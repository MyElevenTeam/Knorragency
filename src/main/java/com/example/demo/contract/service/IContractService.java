package com.example.demo.contract.service;

import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;

import com.example.demo.contract.entity.Contract;

public interface IContractService {
	
	public void save(Contract contract);
	
	public void deleteById(Long id);
	
	public Optional<Contract> findById(Long id);
	
	public void deleteAll(Long[] ids);
	
	public Page<Contract> findAll(Specification<Contract> spec, Pageable pageable);

}

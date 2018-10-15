package com.example.demo.log.service;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;

import com.example.demo.log.entity.Log;

public interface ILogService {
	
	public void save(Log Log);
	
	public void delete(Long id);
	
	public void deleteAll(Long[] ids);
	
	public Log findOne(Long id);
	
	public Page<Log> findAll(Specification<Log> spec, Pageable pageable);

}

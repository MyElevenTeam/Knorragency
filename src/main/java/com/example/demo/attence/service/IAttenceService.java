package com.example.demo.attence.service;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;

import com.example.demo.attence.entity.Attence;

public interface IAttenceService {
	
	public void save(Attence attence);
	
	public void deleteById(Long id);
	
	public void deleteAll(Long[] ids);
	
	public Optional<Attence> findById(Long id);
	
	public Page<Attence> findAll(Specification<Attence> spec, Pageable pageable);
	
	public List<Attence> findAttence(Specification<Attence> spec);

}

package com.example.demo.attence.service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Optional;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import com.example.demo.attence.entity.Attence;
import com.example.demo.attence.repository.AttenceRepository;

@Service
@Transactional
public class AttenceService implements IAttenceService {
	
	@Autowired
	private AttenceRepository attenceRepository;
	
	@Override
	public void save(Attence attence) {
		attenceRepository.save(attence);
	}

	@Override
	public void deleteById(Long id) {
		attenceRepository.deleteById(id);
	}

	@Override
	public void deleteAll(Long[] ids) {
		List<Long> idLists = new ArrayList<Long>(Arrays.asList(ids));
		
		List<Attence> attenceLists=(List<Attence>) attenceRepository.findAllById(idLists);
		
		if(attenceLists!=null) {
			attenceRepository.deleteAll(attenceLists);
		}
	}

	@Override
	public Optional<Attence> findById(Long id) {
		return attenceRepository.findById(id);
	}

	@Override
	public Page<Attence> findAll(Specification<Attence> spec, Pageable pageable) {
		return attenceRepository.findAll(spec, pageable);
	}

	@Override
	public List<Attence> findAttence(Specification<Attence> spec) {
		return attenceRepository.findAll(spec);
	}

}

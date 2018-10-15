package com.example.demo.log.service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.demo.log.entity.Log;
import com.example.demo.log.repository.LogRepository;

@Service
@Transactional
public class LogService implements ILogService {
	
	@Autowired
	private LogRepository logRepository;

	@Override
	public void save(Log Log) {
		logRepository.save(Log);
	}

	@Override
	public void delete(Long id) {
		logRepository.deleteById(id);
	}

	@Override
	public void deleteAll(Long[] ids) {
		List<Long> idLists = new ArrayList<Long>(Arrays.asList(ids));
		
		List<Log> logs = (List<Log>) logRepository.findAllById(idLists);
		if(logs!=null) {
			logRepository.deleteAll(logs);
		}
	}

	@Override
	public Log findOne(Long id) {
		return logRepository.findById(id).get();
	}

	@Override
	public Page<Log> findAll(Specification<Log> spec, Pageable pageable) {
		return logRepository.findAll(spec, pageable);
	}

}

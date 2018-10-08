package com.example.demo.attence.service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.List;
import java.util.Optional;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import com.example.demo.attence.entity.Attence;
import com.example.demo.attence.entity.AttenceQueryDTO;
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
	public int findAttence(String employeeName) {
		
		 /*取得当前时间的零点*/
	    Calendar todayStart = Calendar.getInstance();		
		todayStart.set(Calendar.HOUR_OF_DAY, 0);		
		todayStart.set(Calendar.MINUTE, 0);		
		todayStart.set(Calendar.SECOND, 0);
		
		/*按用户名和当天时间查该用户是否已打卡*/
		AttenceQueryDTO dto=new AttenceQueryDTO();
		dto.setEmployeeName(employeeName);
		dto.setWorkinTime(todayStart.getTime());
		List<Attence> attenceList=new ArrayList<Attence>();
		
		attenceList=attenceRepository.findAll(AttenceQueryDTO.getWhereClause(dto));
		if(attenceList!=null) {
			for(Attence attence:attenceList) {
				if(attence.getWorkoutTime()==null) {
					return 1; //已上班但未下班
				}else {
					return 2; //已经下班
				}
			}
		}else {
			return 0;  //未上班
		}
		return 0;
	}

	@Override
	public List<Attence> findByEmployeeName(Specification<Attence> spec) {
		return attenceRepository.findAll(spec);
	}

}

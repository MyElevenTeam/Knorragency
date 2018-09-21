package com.example.demo.contract.service;

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

import com.example.demo.contract.entity.Contract;
import com.example.demo.contract.repository.ContractRepository;

@Service
@Transactional
public class ContractService implements IContractService {
	
	@Autowired
	private ContractRepository contractRepository;

	@Override
	public void save(Contract contract) {
		contractRepository.save(contract);
	}

	@Override
	public void deleteById(Long id) {
		contractRepository.deleteById(id);
	}

	@Override
	public Optional<Contract> findById(Long id) {
		return contractRepository.findById(id);
	}

	@Override
	public void deleteAll(Long[] ids) {
		
        List<Long> idLists = new ArrayList<Long>(Arrays.asList(ids));
		
		List<Contract> contractLists=(List<Contract>) contractRepository.findAllById(idLists);
		
		if(contractLists!=null) {
			contractRepository.deleteAll(contractLists);
		}

	}

	@Override
	public Page<Contract> findAll(Specification<Contract> spec, Pageable pageable) {
		return contractRepository.findAll(spec, pageable);
	}

}

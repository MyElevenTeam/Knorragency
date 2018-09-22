package com.example.demo.contract.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
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

	/*上传word文档*/
	@Override
	public Contract readWord(String buffer) {
		Contract c=new Contract();
		try {
	        String[] lines = buffer.split("\\r?\\n");
	        
	        for (int i = 0; i < lines.length; i++) {
	        	String str=lines[i];
	        	
	        	if(i==1) {
					String contractNumber=str.substring(5, 8);
					c.setContractNumber(contractNumber);
				}
	        	
	        	if(i==2) {
					String startTime=str.substring(3, 12);
					SimpleDateFormat ssdf = new SimpleDateFormat("yyyy/MM/dd");
				    Date sutilDate = ssdf.parse(startTime);
				    c.setStartTime(sutilDate);
				    
					String houseName=str.substring(16, 19);
					c.setHoseName(houseName);
					
					String stotal=str.substring(25, 30);
					Double total=Double.valueOf(stotal);
					c.setTotal(total);
					
					String endTime=str.substring(36);
					SimpleDateFormat esdf = new SimpleDateFormat("yyyy/MM/dd");
				    Date eutilDate = esdf.parse(endTime);
				    c.setEndTime(eutilDate);
				}
	        	
	        	if(i==3) {
					String customerName=str.substring(3);
					c.setCustomerName(customerName);
				}
				if(i==4) {
					String employeeName=str.substring(3);
					c.setEmployeeName(employeeName);
				}
			}
			return c;
		} catch (Exception e) {
			return null;
		}
	}

}

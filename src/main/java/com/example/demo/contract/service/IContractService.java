package com.example.demo.contract.service;

import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;

import com.example.demo.contract.entity.Contract;
import com.example.demo.contract.entity.ContractDTO;

public interface IContractService {
	
	/*合同业务*/
	public void save(Contract contract);
	
	public void deleteById(Long id);
	
	public void deleteAll(Long[] ids);
	
	public Optional<Contract> findById(Long id);
	
	public Page<Contract> findAll(Specification<Contract> spec, Pageable pageable);
	
	public List<Contract> findAllContract(Specification<Contract> spec);
	
	/*上传word文档*/
	public Contract readWord(String buffer);
	
	
	/*合同审核业务*/
	//1.启动流程
	public void startWorkflow(String userId,Long leaveId, Map<String, Object> variables);
	
	//2.查询流程任务
	public Page<ContractDTO> findTodoTasks(String userId, Pageable pageable);
	
	//3.签收流程任务
	public void claim(String taskId,String userId);
	
	//4.完成流程任务
	public void complete(String taskId, Map<String, Object> variables); 

}

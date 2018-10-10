package com.example.demo.contract.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import javax.transaction.Transactional;

import org.activiti.engine.runtime.ProcessInstance;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import com.example.demo.activiti.entity.ProcessStatus;
import com.example.demo.activiti.entity.WorkflowDTO;
import com.example.demo.activiti.service.IWorkflowService;
import com.example.demo.contract.entity.Contract;
import com.example.demo.contract.entity.ContractDTO;
import com.example.demo.contract.repository.ContractRepository;

@Service
@Transactional
public class ContractService implements IContractService {
	
	@Autowired
	private ContractRepository contractRepository;
	
	@Autowired 
	private IWorkflowService workflowService;
	
	private String depreason=null;
	private String manreason=null;
	
	/*----------------------------------------------系统业务--------------------------------------------*/
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
	
	@Override
	public List<Contract> findAllContract(Specification<Contract> spec) {
		return contractRepository.findAll(spec);
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
	
	/*----------------------------------------------合同审核业务--------------------------------------------*/
	/**
     * 开始请假流程
     *
     * @param userId 用户ID
     * @param pageable 分页条件
     * @return
     */
	@Override
	public void startWorkflow(String userId, Long contractId, Map<String, Object> variables) {

		//1.声明流程实例
		ProcessInstance processInstance = null;
		//2.获取创建好的合同审核实例
		Contract contract=contractRepository.findById(contractId).get();
		if(contract!=null) {
			try {
				processInstance = workflowService.startWorkflow(userId, "contract", contract.getId().toString(), variables);
				contract.setProcessStatus(ProcessStatus.APPROVAL);
				contract.setProcessInstanceId(processInstance.getId());
				//leave.setApplyTime(new Date());
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
	}
	
	 /**
     * 查询待办任务
     *
     * @param userId 用户ID
     * @param pageable 分页条件
     * @return
     */
	@Override
	public Page<ContractDTO> findTodoTasks(String userId, Pageable pageable) {
		
		List<ContractDTO> results = null;
		List<WorkflowDTO> workflowLists = workflowService.findTodoTasks(userId);
		// 根据流程的业务ID查询实体并关联
		if(null!=workflowLists) {
			results = new ArrayList<ContractDTO>();
			for (WorkflowDTO workflow : workflowLists) {
	        	Long businessKey = new Long(workflow.getBusinessKey());
	            if (workflow.getBusinessKey() == null) {
	                continue;
	            }
	            Optional<Contract> contractOptional=contractRepository.findById(businessKey);
	            if(contractOptional!=null&&contractOptional.isPresent()){
	            	Contract contract=contractOptional.get();
	            	ContractDTO contractDTO = new ContractDTO();
	            	
	            	contractDTO.setDepreason(depreason);
	            	contractDTO.setManreason(manreason);
	            	
	            	BeanUtils.copyProperties(contract, contractDTO);
	            	BeanUtils.copyProperties(workflow, contractDTO);
	            	results.add(contractDTO);
	            }
	        }
		}
		return new PageImpl<ContractDTO> (results, pageable, null!=results?results.size():0);
	}
	
	/**
     * 签收流程任务
     *
     * @param taskId 任务ID
     * @param userId 签收人用户ID
     * @return
     */
	@Override
	public void claim(String taskId, String userId) {
		workflowService.claim(taskId, userId);
	}
	
	/**
     * 完成流程任务
     *
     * @param taskId 任务ID
     * @param variables 流程变量
     * @return
     */
	@Override
	public void complete(String taskId, Map<String, Object> variables) {
		
		//流程变量的处理
		if(variables.containsKey("confirmName")) {
			depreason=null;
			manreason=null;
		}
		if(variables.containsKey("deptLeaderPass")&&(boolean) variables.get("deptLeaderPass")) {
			depreason="同意";
		}
		if(variables.containsKey("manLeaderPass")&&(boolean) variables.get("manLeaderPass")) {
			manreason="同意";
		}
		if(variables.containsKey("deptLeaderBackReason")) {
			depreason=(String) variables.get("deptLeaderBackReason");
		}
		if(variables.containsKey("managerBackReason")) {
			manreason=(String) variables.get("managerBackReason");
		}
		workflowService.complete(taskId, variables);
	}

	
}

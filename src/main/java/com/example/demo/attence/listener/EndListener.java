package com.example.demo.attence.listener;

import org.activiti.engine.RuntimeService;
import org.activiti.engine.delegate.DelegateExecution;
import org.activiti.engine.delegate.DelegateTask;
import org.activiti.engine.delegate.ExecutionListener;
import org.activiti.engine.delegate.TaskListener;
import org.activiti.engine.runtime.ProcessInstance;
import org.springframework.beans.factory.annotation.Autowired;

import com.example.demo.activiti.entity.ProcessStatus;
import com.example.demo.attence.entity.Attence;
import com.example.demo.attence.entity.AttenceStatus;
import com.example.demo.attence.service.IAttenceService;

public class EndListener implements ExecutionListener,TaskListener{
	
	private static final long serialVersionUID = 1L;
	
	@Autowired
    private IAttenceService attenceService;

    @Autowired
    private RuntimeService runtimeService;
    
    private boolean flag=false;
	
	@Override
	public void notify(DelegateExecution execution) {
	    String eventName = execution.getEventName();
	    if(eventName.equals("start")) {
	    	System.out.println("Start");
	    }
	    if(eventName.equals("end")) {
	    	System.out.println("End");
	    	flag=true;
	    }
	}

	@Override
	public void notify(DelegateTask delegateTask) {
		if(flag) {
			String processInstanceId = delegateTask.getProcessInstanceId();
	        ProcessInstance processInstance = runtimeService.createProcessInstanceQuery().processInstanceId(processInstanceId).singleResult();
	        System.out.println("sss");
	        Attence attence = attenceService.findById(new Long(processInstance.getBusinessKey())).get();
	        attence.setAttenceStatus(AttenceStatus.NORMAL);
	        attence.setProcessStatus(ProcessStatus.COMPLETE);
	        attenceService.save(attence);
		}
		
   
	}

}

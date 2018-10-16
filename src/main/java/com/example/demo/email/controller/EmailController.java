package com.example.demo.email.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.demo.common.controller.ExtjsPageRequest;
import com.example.demo.email.entity.EmailDTO;
import com.example.demo.email.entity.EmailQueryDTO;
import com.example.demo.email.service.IEmailService;
import com.example.demo.log.config.SystemControllerLog;

@RestController
@RequestMapping("/email")
public class EmailController {
	
	@Autowired
	private IEmailService emailService;
	
	@SystemControllerLog(description="Email")
	@RequestMapping("/findEmailEdit")
	public Page<EmailDTO> findEmailEdit(HttpSession session,EmailQueryDTO emailQueryDTO,ExtjsPageRequest pageRequest){
		emailQueryDTO.setEmailStatus(0);
		return emailService.findAll(EmailQueryDTO.getWhereClause(emailQueryDTO), pageRequest.getPageable());
	}
	
	@SystemControllerLog(description="Email")
	@RequestMapping("/findEmailSend")
	public Page<EmailDTO> findEmailSend(HttpSession session,EmailQueryDTO emailQueryDTO,ExtjsPageRequest pageRequest){
		emailQueryDTO.setEmailStatus(1);
		return emailService.findAll(EmailQueryDTO.getWhereClause(emailQueryDTO), pageRequest.getPageable());
	}
	
	@SystemControllerLog(description="Email")
	@RequestMapping("/findEmailTrash")
	public Page<EmailDTO> findEmailTrash(HttpSession session,EmailQueryDTO emailQueryDTO,ExtjsPageRequest pageRequest){
		emailQueryDTO.setEmailStatus(2);
		return emailService.findAll(EmailQueryDTO.getWhereClause(emailQueryDTO), pageRequest.getPageable());
	}

}

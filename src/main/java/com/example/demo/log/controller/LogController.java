package com.example.demo.log.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.demo.common.controller.ExtjsPageRequest;
import com.example.demo.log.config.SystemControllerLog;
import com.example.demo.log.entity.LogDTO;
import com.example.demo.log.entity.LogQueryDTO;
import com.example.demo.log.service.ILogService;

@RestController
@RequestMapping("/log")
public class LogController {
	
	@Autowired
	private ILogService logService;
	
	@SystemControllerLog(description="查看日志记录")
	@GetMapping
	public Page<LogDTO> findLog(HttpSession session,LogQueryDTO logQueryDTO,ExtjsPageRequest pageRequest){
		return logService.findAll(LogQueryDTO.getWhereClause(logQueryDTO), pageRequest.getPageable());
	}
}

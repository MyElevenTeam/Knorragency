package com.example.demo.login.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.example.demo.employee.domain.Employee;
import com.example.demo.employee.repository.EmployeeRepository;
import com.example.demo.login.util.ExtAjaxResponse;



@RestController
public class LoginController {
	
	private static final Logger log = LoggerFactory.getLogger(LoginController.class);
	
	@Autowired
	private EmployeeRepository employeeRepository;
	
	//登录
	@RequestMapping(value="/login")
	public @ResponseBody ExtAjaxResponse logon(@RequestParam("employeeNumber") String employeeNumber
			, @RequestParam("password") String password, HttpSession session) {
		Employee employee=employeeRepository.findByEmployeeNumber(employeeNumber);
		if(employee==null || !employee.getPassword().equals(password)) {
			return new ExtAjaxResponse(false,"登录失败!帐号或者密码有误!请重新登录!");
		}else {
			session.setAttribute("employeeNumber", employee.getEmployeeNumber());
			session.setAttribute("post", employee.getPost());
			session.setAttribute("picture", employee.getPicture());
			/*Map<String,String> map=new HashMap<String,String>();
			map.put("employeeNumber", employee.getEmployeeNumber());
			map.put("picture", employee.getPicture());
			map.put("msg", "登录成功！");*/
			
			return new ExtAjaxResponse(true,"登录成功");
		}
	}
	
	//获取登录后的信息
	@RequestMapping(value="/getLoginMessage")
	public @ResponseBody ExtAjaxResponse getLoginMessage(HttpServletRequest request) {
		/*log.info("进来了/login/getLoginMessage");
		String en=(String) request.getSession().getAttribute("employeeNumber");
		String picture=(String) request.getSession().getAttribute("picture");
		log.info(en);
		log.info(picture);*/
		log.info("进来了/login/getLoginMessage");
		Map<String,String> map=new HashMap<String,String>();
		map.put("employeeNumber", (String) request.getSession().getAttribute("employeeNumber"));
		map.put("picture", (String) request.getSession().getAttribute("picture"));
		
		return new ExtAjaxResponse(true,map);
	}
	
	//注销
	@RequestMapping(value = "/logout")
	public @ResponseBody ExtAjaxResponse logout(HttpSession session) {
		
		try {
			log.info("-----------------------------------------logout");
			session.removeAttribute("employeeNumber");
			session.removeAttribute("post");
			return new ExtAjaxResponse(true,"登出成功!");
		} catch (Exception e) {
			return new ExtAjaxResponse(true,"登出失败!");
		}
		
	}
}

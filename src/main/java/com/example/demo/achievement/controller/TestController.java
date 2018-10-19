package com.example.demo.achievement.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.demo.log.config.SystemControllerLog;

//@Controller
//
//public class TestController {
//	@SystemControllerLog(description="测试")
//	@RequestMapping("/test")
//   public String render(HttpSession session,Model model) {
////	   Long id=(Long)session.getAttribute("id");
////	   Map<String,String> map=new HashMap<String,String>();
//	   model.addAttribute("userName","小明");
////	   model.put("password", "wwww");
//	   return "test";
//  }
//}
@Controller

public class TestController {  	
	@RequestMapping(value="/test")
	public String secondRequest(Model model){
		String key = "hello world";
		model.addAttribute("key", key);
		//此时没有定义变量的名字，默认就用这个参数的类型的名字做为变量的名字，不过首字母大写变小写
		model.addAttribute("xxxxxxx");
		return "test";
	}
}

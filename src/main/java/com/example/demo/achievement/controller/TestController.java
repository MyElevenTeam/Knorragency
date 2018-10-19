package com.example.demo.achievement.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller

public class TestController {
	@RequestMapping("/test")
   public String render() {
	   System.out.println("TestController.render()");
	   return "test";
  }
}

package com.example.demo.employee.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringBootConfiguration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;

@SpringBootConfiguration
public class Config extends WebMvcConfigurerAdapter{
	
<<<<<<< HEAD
//	@Autowired
//	private EmployeeConfig employeeConfig;
//	@Autowired
//	private EmployeeConfig2 employeeConfig2;
//	
//	@Override
//	public void addInterceptors(InterceptorRegistry registry) {
//		//registry.addInterceptor(employeeConfig2).addPathPatterns("/**");
//		registry.addInterceptor(employeeConfig).addPathPatterns("/store/**");
//		registry.addInterceptor(employeeConfig).addPathPatterns("/employee/**");
//	}
=======
	/*@Autowired
	private EmployeeConfig employeeConfig;
	@Autowired
	private EmployeeConfig2 employeeConfig2;
	
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		//registry.addInterceptor(employeeConfig2).addPathPatterns("/**");
		registry.addInterceptor(employeeConfig).addPathPatterns("/store/**");
		registry.addInterceptor(employeeConfig).addPathPatterns("/employee/**");
	}*/
>>>>>>> branch 'master' of https://github.com/MyElevenTeam/Knorragency.git
	
}

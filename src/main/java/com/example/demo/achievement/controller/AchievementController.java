package com.example.demo.achievement.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.example.demo.achievement.entity.RequestDTO;
import com.example.demo.achievement.entity.ResponseDTO;
import com.example.demo.achievement.service.AchievementService;
import com.example.demo.achievement.service.IAchievementService;

@RestController
@RequestMapping("/achievement")
public class AchievementController {
	@Autowired
	IAchievementService achievementService;
    @GetMapping
	public List<ResponseDTO> findByMonth(RequestDTO requestDTO) {
    	if(requestDTO.getMonth()==null) {
		   return achievementService.findByMonth("一月");
    	}else {
    		return achievementService.findByMonth(requestDTO.getMonth());
    	}
	}
	

}

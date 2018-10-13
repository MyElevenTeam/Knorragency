package com.example.demo.achievement.service;

import java.util.List;

import com.example.demo.achievement.entity.ResponseDTO;

public interface IAchievementService {
	List<ResponseDTO> findByMonth(String month);
}


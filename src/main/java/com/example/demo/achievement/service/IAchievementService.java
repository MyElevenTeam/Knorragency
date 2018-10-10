package com.example.demo.achievement.service;

import java.util.List;

import com.example.demo.achievement.entity.AchievementDTO;

public interface IAchievementService {
	List<AchievementDTO> findByMonth(String month);
}

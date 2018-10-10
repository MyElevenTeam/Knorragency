package com.example.demo;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import com.example.demo.achievement.entity.AchievementDTO;
import com.example.demo.achievement.service.AchievementService;
import com.example.demo.achievement.service.IAchievementService;
import com.example.demo.contract.entity.Contract;

@RunWith(SpringRunner.class)
@SpringBootTest
public class AchievementServiceTest {

	/**
	 * 业绩排行测试
	 */
	@Autowired
	IAchievementService achievementService;
	@Test
	public void achievementTest() {
		List<AchievementDTO> tmps=achievementService.findByMonth("十月");
		for(AchievementDTO tmp:tmps) {
			System.out.println(tmp);	
		}	
	}
}

package com.example.demo.achievement.service;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.achievement.entity.AchievementDTO;
import com.example.demo.contract.entity.Contract;
import com.example.demo.contract.service.IContractService;
@Service
@Transactional
public class AchievementService implements IAchievementService {
	@Autowired
	IContractService contractService;
	/**
	 * 一个月份中员工业绩排行
	 */
	@Override
	public List<AchievementDTO> findByMonth(String month) {
		List<AchievementDTO> achieveList=new ArrayList<AchievementDTO>();
		List<Contract> contracts=contractService.findAllContract(null);
		String[] monthArray= {"一月","二月","三月","四月","五月","六月","七月","八月","九月","十月","十一月","十二月"};
		Calendar calendar=Calendar.getInstance();
		for(Contract contract:contracts) {
			calendar.setTime(contract.getStartTime());
			int monthTmp=calendar.get(Calendar.MONTH);
			if(monthArray[monthTmp].equals(month)) {
				int i=0;
				for(;i<achieveList.size();i++) {
					if(achieveList.get(i).getEmployeeName().equals(contract.getEmployeeName())){
						double all=contract.getTotal()+achieveList.get(i).getTotal();
						achieveList.get(i).setTotal(all);
						break;
					}
				}
				if(i==achieveList.size()) {
					AchievementDTO achieveTmp=new AchievementDTO();
					BeanUtils.copyProperties(contract, achieveTmp);
					achieveList.add(achieveTmp);
				}
			}
		}
		return achieveList;
	}
}

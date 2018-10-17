package com.example.demo.achievement.controller;

import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.Iterator;
import java.util.List;
import java.util.ListIterator;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.Mapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.example.demo.achievement.entity.AnalyseResponseDTO;
import com.example.demo.achievement.entity.RequestDTO;
import com.example.demo.achievement.entity.SortResponseDTO;
import com.example.demo.contract.entity.ContractDTO;
import com.example.demo.contract.service.IContractService;
import com.example.demo.log.config.SystemControllerLog;
import com.example.demo.store.domain.StoreName;
import com.example.demo.store.service.IStoreService;

@RestController
@RequestMapping("/achievement")
public class AchievementController {
	@Autowired
	private IContractService contractService;
	@Autowired
	private IStoreService storeService;
	
	@SystemControllerLog(description="查询销售员月销售额")
    @GetMapping
	public List<ContractDTO> findByMonthAndArea(RequestDTO requestDTO) {
		if(requestDTO.getArea()==null||requestDTO.getMonth()==null) {
			List<StoreName> storeNames=storeService.findAllStoreName();
			requestDTO.setMonth("一月");
			requestDTO.setArea(storeNames.get(0).getStoreName());
		}
        return  contractService.getSumAndEmployeeNameByMonthAndStoreName(requestDTO.getMonth(), requestDTO.getArea());
    	
	}
	@SystemControllerLog(description="数据分析")
	@GetMapping("/analyse")
	public List<AnalyseResponseDTO> dataAnalyse(RequestDTO requestDTO) {
		if(requestDTO.getArea()==null||requestDTO.getMonth()==null) {
			List<StoreName> storeNames=storeService.findAllStoreName();
			requestDTO.setMonth("一月");
			requestDTO.setArea(storeNames.get(0).getStoreName());
		}
		List<AnalyseResponseDTO> listTmp=new ArrayList<AnalyseResponseDTO>();
		try {
			AnalyseResponseDTO dto=new AnalyseResponseDTO();
			List<ContractDTO> tmps=contractService.getSumAndEmployeeNameByMonthAndStoreName(requestDTO.getMonth(), requestDTO.getArea());
			dto.setPeopleNum(tmps.size());
			dto.setWinner(tmps.get(0).getEmployeeName());
			double total = 0;
			for(ContractDTO tmp:tmps) {
				total+=tmp.getTotal();
			}
			dto.setTotal(total);
			if(requestDTO.getMonth().equals("一月")) {
				dto.setPeopleNum(0);
			}else {
				List<String> monthList = new ArrayList<String>(Arrays.asList("一月","二月","三月","四月","五月","六月","七月","八月","九月","十月","十一月","十二月"));
				int monthIndex=monthList.indexOf(requestDTO.getMonth());
				String monthName=monthList.get(monthIndex-1);
				List<ContractDTO> lastMonth=contractService.getSumAndEmployeeNameByMonthAndStoreName(monthName, requestDTO.getArea());
				double lastTotal=0;
				for(ContractDTO tmp:lastMonth) {
					lastTotal+=tmp.getTotal();
				}
				double rate=(total-lastTotal)/lastTotal;
				BigDecimal bd = new BigDecimal(rate); 
				Double d = bd.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue(); 
				dto.setRate(d);			
			}
			
			listTmp.add(dto);
			return listTmp;	
		}catch(Exception e) {
			e.printStackTrace();
		}
		return listTmp;
		
	}
	@SystemControllerLog(description="业绩排行")
	@GetMapping("/sort")
	public List<SortResponseDTO> dataSort(RequestDTO requestDTO) {
		List<SortResponseDTO> queue=new ArrayList<SortResponseDTO>();
		if(requestDTO.getArea()==null||requestDTO.getMonth()==null) {
			List<StoreName> storeNames=storeService.findAllStoreName();
			requestDTO.setMonth("一月");
			requestDTO.setArea(storeNames.get(0).getStoreName());
		}
		try {	
			List<ContractDTO> tmps=contractService.getSumAndEmployeeNameByMonthAndStoreName(requestDTO.getMonth(), requestDTO.getArea());
			for(int i=0;i<tmps.size()&&i<4;i++) {
				SortResponseDTO sortResponseDTO=new SortResponseDTO();
				sortResponseDTO.setRank(i+1);
				sortResponseDTO.setEmployeeName(tmps.get(i).getEmployeeName());
				sortResponseDTO.setWord(tmps.get(i).getQuotation());
				queue.add(sortResponseDTO);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return queue;
	}
	

}

package com.example.demo.attence.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.demo.attence.entity.Attence;
import com.example.demo.attence.entity.AttenceQueryDTO;
import com.example.demo.attence.entity.AttenceStatus;
import com.example.demo.attence.service.AttenceService;
import com.example.demo.attence.utils.AttenceUtil;
import com.example.demo.common.controller.ExtAjaxResponse;
import com.example.demo.common.controller.SessionUtil;


@RestController
@RequestMapping("/attence")
public class AttenceController {
	
	@Autowired
	private AttenceService attenceService;
	
	@PostMapping("/workIn")
	public ExtAjaxResponse workIn(HttpSession session){
		ExtAjaxResponse response=new ExtAjaxResponse();
		try {
			//获取打卡人姓名
			String employeeName = SessionUtil.getUserName(session);
			System.out.println("workIn"+employeeName);
			//设置上班时间
			String workTime="10:00:00";
			String[]array1 = workTime.split(":");				
			int total1 = Integer.valueOf(array1[0])*3600+Integer.valueOf(array1[1])*60+Integer.valueOf(array1[2]);
			
			//获取打卡时间
			SimpleDateFormat sdf = new SimpleDateFormat("HH:mm:ss");
			Date date=new Date();
			String attenceTime=sdf.format(date);
			String[]array2 = attenceTime.split(":");				
			int total2 = Integer.valueOf(array2[0])*3600+Integer.valueOf(array2[1])*60+Integer.valueOf(array2[2]);
			
			//获取打卡地点
			JSONObject json=new JSONObject();
			json=AttenceUtil.readJsonFromUrl();
			String location=((JSONObject) json.get("content")).getString("address");
			
			Attence attence=new Attence();
			if(total2>total1) {
				//迟到
				attence.setAttenceStatus(AttenceStatus.LATER);
				response.setMsg("打卡成功,您今天上班迟到");
				response.setSuccess(true);
			}else {
				//正常上班
				attence.setAttenceStatus(AttenceStatus.NORMAL);
				response.setMsg("打卡成功");
				response.setSuccess(true);
			}
			
			attence.setEmployeeName(employeeName);
			attence.setLocation(location);
			attence.setWorkinTime(date);
			attenceService.save(attence);
			return response;
			
		} catch (Exception e) {
			response.setMsg("打卡失败");
			response.setSuccess(false);
			return response;
		}
	}
	
	@PostMapping("/workOut")
	public ExtAjaxResponse workOut(HttpSession session) {
		try {
			//获取打卡人姓名
			String employeeName = SessionUtil.getUserName(session);
			Date date=new Date();
			
			AttenceQueryDTO dto=new AttenceQueryDTO();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
			String time=sdf.format(date);
			dto.setEmployeeName(employeeName);
			
			List<Attence> attenceList=new ArrayList<Attence>();
			attenceList=attenceService.findAttence(AttenceQueryDTO.getWhereClause(dto));
			for(Attence attence:attenceList) {
				if(time.equals(sdf.format(attence.getWorkinTime()))) {
					attence.setWorkoutTime(date);
					attenceService.save(attence);
				}
			}
			return new ExtAjaxResponse(true,"成功");
		} catch (Exception e) {
			return new ExtAjaxResponse(false,"失败");
		}
		
	}
	
	
	@GetMapping("/isAttence")
	public ExtAjaxResponse isAttence(HttpSession session) {
		ExtAjaxResponse response=new ExtAjaxResponse();
		try {
			//获取打卡人姓名
			String employeeName = SessionUtil.getUserName(session);
			System.out.println("isAttence:"+employeeName);
			Date date=new Date();
			
			AttenceQueryDTO dto=new AttenceQueryDTO();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
			String time=sdf.format(date);
			dto.setEmployeeName(employeeName);
			
			List<Attence> attenceList=new ArrayList<Attence>();
			attenceList=attenceService.findAttence(AttenceQueryDTO.getWhereClause(dto));
			for(Attence attence:attenceList) {
				System.out.println(attence);
				if(time.equals(sdf.format(attence.getWorkinTime()))) {
					response.setMsg("已经打了打卡");
					response.setSuccess(false);
					break;
				}else {
					response.setMsg("没有打卡");
					response.setSuccess(true);
					break;
				}
			}
			return response;
		} catch (Exception e) {
			return new ExtAjaxResponse(false,"失败");
		}
		
	}
	
	
}

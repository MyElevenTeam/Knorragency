package com.example.demo.attence.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.example.demo.activiti.entity.ProcessStatus;
import com.example.demo.activiti.util.WorkflowVariable;
import com.example.demo.attence.entity.Attence;
import com.example.demo.attence.entity.AttenceDTO;
import com.example.demo.attence.entity.AttenceQueryDTO;
import com.example.demo.attence.entity.AttenceStatus;
import com.example.demo.attence.service.AttenceService;
import com.example.demo.attence.utils.AttenceUtil;
import com.example.demo.common.controller.ExtAjaxResponse;
import com.example.demo.common.controller.ExtjsPageRequest;
import com.example.demo.common.controller.SessionUtil;

@RestController
@RequestMapping("/attence")
public class AttenceController {
	
	@Autowired
	private AttenceService attenceService;
	
	
	/*----------------------------------------------考勤业务--------------------------------------------*/
	//查看个人的考勤记录
	@GetMapping 
	public Page<Attence> getPersonAttence(HttpSession session,AttenceQueryDTO attenceQueryDTO,ExtjsPageRequest pageRequest) {
		
		Page<Attence> page;
		String userId = SessionUtil.getUserName(session);  //通过session查找userId
		if(userId!=null) {
			attenceQueryDTO.setEmployeeName(userId);
			page=attenceService.findAll(AttenceQueryDTO.getWhereClause(attenceQueryDTO), pageRequest.getPageable());
		}else {
			page = new PageImpl<Attence>(new ArrayList<Attence>(),pageRequest.getPageable(),0);
		}
		return page;
		
	}
	
	//上班打卡
	@PostMapping("/workIn")
	public ExtAjaxResponse workIn(HttpSession session){
		int flag;
		ExtAjaxResponse response=new ExtAjaxResponse();
		//获取打卡人姓名
		String employeeName = SessionUtil.getUserName(session);
		flag=attenceService.findAttence(employeeName);
		try {
			if(flag==0) {   //当天未打卡才允许打卡
				Attence attence=new Attence();
				//获取打卡地点
				JSONObject json=new JSONObject();
				json=AttenceUtil.readJsonFromUrl();
				String location=((JSONObject) json.get("content")).getString("address");
				//获取打卡时间
				Date date=new Date();
				
				int work=AttenceUtil.isTimeAndLocation(date, location, true);
				if(work==-1) {
					//打卡地错误
					attence.setAttenceStatus(AttenceStatus.TRIP);
					attence.setProcessStatus(ProcessStatus.NEW);
					response.setMsg("打卡成功,您今天不在公司上班哦");
					response.setSuccess(true);
				}else if(work==-2) {
					//迟到
					attence.setAttenceStatus(AttenceStatus.LATER);
					attence.setProcessStatus(ProcessStatus.NEW);
					response.setMsg("打卡成功,您今天上班迟到哦");
					response.setSuccess(true);
				}else if(work==0) {
					//正常上班
					attence.setAttenceStatus(AttenceStatus.NORMAL);
					attence.setProcessStatus(ProcessStatus.NEW);
					response.setMsg("打卡成功,今天要加油哦");
					response.setSuccess(true);
				}
				attence.setEmployeeName(employeeName);
				attence.setLocation(location);
				attence.setWorkinTime(date);
				attenceService.save(attence);
				return response;
			}
			else if(flag==2) {
				response.setMsg("已经辛苦工作一天了，好好休息吧");
				response.setSuccess(false);
				return response;
			}else {
				response.setMsg("打卡失败1");
				response.setSuccess(false);
				return response;
			}
		} catch (Exception e) {
			response.setMsg("打卡失败2");
			response.setSuccess(false);
			return response;
		}
	}
	
	//下班签退
	@PostMapping("/workOut")
	public ExtAjaxResponse workOut(HttpSession session) {
		ExtAjaxResponse response=new ExtAjaxResponse();
		try {
			//获取打卡人姓名
			String employeeName = SessionUtil.getUserName(session);
			//获取打卡地点
			JSONObject json=new JSONObject();
			json=AttenceUtil.readJsonFromUrl();
			String location=((JSONObject) json.get("content")).getString("address");
			//获取打卡时间
			Date date=new Date();
			
			int work=AttenceUtil.isTimeAndLocation(date, location, false);
			
			AttenceQueryDTO dto=new AttenceQueryDTO();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
			String time=sdf.format(date);
			dto.setEmployeeName(employeeName);
			
			List<Attence> attenceList=new ArrayList<Attence>();
			attenceList=attenceService.findByEmployeeName(AttenceQueryDTO.getWhereClause(dto));
			for(Attence attence:attenceList) {
				if(time.equals(sdf.format(attence.getWorkinTime()))) {
					if(work==-1) {
						//打卡地错误
						attence.setAttenceStatus(AttenceStatus.TRIP);
						attence.setWorkoutTime(date);
						attenceService.save(attence);
						response.setMsg("签退成功,您今天不在公司上班哦");
						response.setSuccess(true);
					}else if(work==-3) {
						//早退
						attence.setAttenceStatus(AttenceStatus.EARLY);
						attence.setWorkoutTime(date);
						attenceService.save(attence);
						response.setMsg("签退成功,您今天提早下班了哦");
						response.setSuccess(true);
					}else if(work==0) {
						attence.setWorkoutTime(date);
						attenceService.save(attence);
						response.setMsg("下班了，好好休息吧");
						response.setSuccess(true);
					}
				}
			}
			return response;
		} catch (Exception e) {
			return new ExtAjaxResponse(false,"签退失败");
		}
		
	}
	
	//判断是否已打卡
	@GetMapping("/isAttence")
	public ExtAjaxResponse isAttence(HttpSession session) {
		String employeeName = SessionUtil.getUserName(session);

		int flag=attenceService.findAttence(employeeName);
		if(flag==0) {
			return new ExtAjaxResponse(true,"work");  //未上班
		}else if(flag==1) {
			return new ExtAjaxResponse(true,"working"); //已上班但未下班
		}else if(flag==2) {
			return new ExtAjaxResponse(true,"out"); //已经下班
		}else {
			return new ExtAjaxResponse(false,"false");
		}	
	}
	
	
	/*----------------------------------------------申诉业务--------------------------------------------*/
	/**
	 * 启动流程
	 * @param leaveId	请假信息Id
	 * @param session	通过会话获取登录用户(请假人)
	 * @return
	 */
	@RequestMapping(value = "/start")
    public @ResponseBody ExtAjaxResponse start(@RequestParam(name="id") Long appealId,@RequestParam(name="appealreason") String appealreason,HttpSession session) {
    	try {
    		String userId = SessionUtil.getUserName(session);
    		
    		Attence attence=attenceService.findById(appealId).get();
    		if(attence!=null) {
    			attence.setAppealreason(appealreason);
        		attenceService.save(attence);
    		}
    		
    		Map<String, Object> variables = new HashMap<String, Object>();
    		variables.put("deptLeader", "financeManager");
    		variables.put("hr", "hrManager");
    		variables.put("applyUserId", userId);
    		attenceService.startWorkflow(userId,appealId, variables);
    		return new ExtAjaxResponse(true,"操作成功!");
	    } catch (Exception e) {
	    	e.printStackTrace();
	        return new ExtAjaxResponse(false,"操作失败!");
	    }
    }
	
	/**
	 * 查询待处理流程任务
	 * @param pageable	分页对象
	 * @param session	通过会话获取登录用户(请假人)
	 * @return
	 */
	@RequestMapping(value = "/tasks")
    public @ResponseBody Page<AttenceDTO> findTodoTasks(HttpSession session,ExtjsPageRequest pageable) {
		Page<AttenceDTO> page = new PageImpl<AttenceDTO>(new ArrayList<AttenceDTO>(), pageable.getPageable(), 0);
    	try {
    		page = attenceService.findTodoTasks(SessionUtil.getUserName(session), pageable.getPageable());
	    } catch (Exception e) {
	    	e.printStackTrace();
	    }
    	return page;
    }
	
	/**
     * 签收任务
     */
    @RequestMapping(value = "claim/{id}")
    public @ResponseBody ExtAjaxResponse claim(@PathVariable("id") String taskId, HttpSession session) {
    	try{
    		attenceService.claim(taskId, SessionUtil.getUserName(session));
	    	return new ExtAjaxResponse(true,"任务签收成功!");
	    } catch (Exception e) {
	    	e.printStackTrace();
	        return new ExtAjaxResponse(false,"任务签收失败!");
	    }
    }
    
    /**
     * 完成任务
     * @param id
     * @return
     */
    @RequestMapping(value = "complete/{id}")
    public @ResponseBody ExtAjaxResponse complete(@PathVariable("id") String taskId, WorkflowVariable var) {
    	try{
    		Map<String, Object> variables = var.getVariableMap();
    		attenceService.complete(taskId, variables);
	    	return new ExtAjaxResponse(true,"审批成功!");
	    } catch (Exception e) {
	    	e.printStackTrace();
	        return new ExtAjaxResponse(false,"审批失败!");
	    }
    }
	
}
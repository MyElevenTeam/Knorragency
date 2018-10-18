package com.example.demo.email.controller;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.example.demo.common.controller.ExtAjaxResponse;
import com.example.demo.common.controller.ExtjsPageRequest;
import com.example.demo.common.controller.SessionUtil;
import com.example.demo.email.entity.Email;
import com.example.demo.email.entity.EmailDTO;
import com.example.demo.email.entity.EmailQueryDTO;
import com.example.demo.email.service.IEmailService;
import com.example.demo.employee.domain.Employee;
import com.example.demo.employee.service.IEmployeeService;
import com.example.demo.log.config.SystemControllerLog;

@RestController
@RequestMapping("/email")
public class EmailController {
	
	@Autowired
	private IEmailService emailService;
	
	@Autowired
	private IEmployeeService employeeService;
	
	/*findEdit*/
	@SystemControllerLog(description="查询草稿箱")
	@GetMapping 
	public Page<EmailDTO> findEdit(HttpSession session,EmailQueryDTO emailQueryDTO,ExtjsPageRequest pageRequest) {
		
		String userId = SessionUtil.getUserName(session);  //通过session查找userId
		if(userId!=null) {
			emailQueryDTO.setEmployeeName(userId);
			emailQueryDTO.setEmailStatus(0);
		}
		return emailService.findAll(EmailQueryDTO.getWhereClause(emailQueryDTO), pageRequest.getPageable());
	}
	
	
	/*findInbox*/
	@SystemControllerLog(description="查询收件箱")
	@RequestMapping("/findInbox") 
	public Page<EmailDTO> findInbox(HttpSession session,EmailQueryDTO emailQueryDTO,ExtjsPageRequest pageRequest) {
		
		String userId = SessionUtil.getUserName(session);  //通过session查找userId
		if(userId!=null) {
			emailQueryDTO.setEmailTo(userId);
			emailQueryDTO.setEmailStatus(2);
		}
		return emailService.findAll(EmailQueryDTO.getWhereClause(emailQueryDTO), pageRequest.getPageable());
	}
	
	/*findSend*/
	@SystemControllerLog(description="查询已发送")
	@RequestMapping("/findSend") 
	public Page<EmailDTO> findSend(HttpSession session,EmailQueryDTO emailQueryDTO,ExtjsPageRequest pageRequest) {
		
		String userId = SessionUtil.getUserName(session);  //通过session查找userId
		if(userId!=null) {
			emailQueryDTO.setEmployeeName(userId);
			emailQueryDTO.setEmailStatus(1);
		}
		return emailService.findAll(EmailQueryDTO.getWhereClause(emailQueryDTO), pageRequest.getPageable());
	}
	
	/*save*/
	@SystemControllerLog(description="保存信息")
	@PostMapping
	public ExtAjaxResponse saveOne(HttpSession session,@RequestBody Email email) {
		
		try {
			String userId = SessionUtil.getUserName(session);
			if(userId!=null) {
				Employee employee=employeeService.EmployeeName(userId);
				email.setEmailFrom(userId);
				email.setEmployee(employee);
				email.setSendTime(new Date());
				emailService.save(email);
    		}
			return new ExtAjaxResponse(true,"保存成功！");
		} catch (Exception e) {
			return new ExtAjaxResponse(false,"保存失败！");
		}
		
	}
	
	@SystemControllerLog(description="修改")
	@RequestMapping("/update")
    public ExtAjaxResponse update(HttpSession session,Email email) {
    	try {
    		System.out.println(email.getId());
    		return new ExtAjaxResponse(true,"保存成功!");
	    } catch (Exception e) {
	    	e.printStackTrace();
	        return new ExtAjaxResponse(false,"保存失败!");
	    }
    }
	
	@SystemControllerLog(description="上传附件")
	@PostMapping("/uploadAttachment")
    @ResponseBody
    public ExtAjaxResponse uploadAttachment(@RequestParam("file") MultipartFile file, HttpServletRequest request) {
		if (!file.isEmpty()) {
            String saveFileName = file.getOriginalFilename();
            System.out.println(saveFileName);
            File saveFile = new File(request.getSession().getServletContext().getRealPath("/upload/") + saveFileName);
            if (!saveFile.getParentFile().exists()) {
                saveFile.getParentFile().mkdirs();
            }
            try {
                BufferedOutputStream out = new BufferedOutputStream(new FileOutputStream(saveFile));
                out.write(file.getBytes());
                out.flush();
                out.close();
                return new ExtAjaxResponse(true,saveFileName);
            } catch (FileNotFoundException e) {
                e.printStackTrace();
                return new ExtAjaxResponse(false,"上传失败");
            } catch (IOException e) {
                e.printStackTrace();
                return new ExtAjaxResponse(false,"上传失败");
            }
        } else {
        	return new ExtAjaxResponse(false,"文件不能为空");
        }
    }
	
	
	@SystemControllerLog(description="删除附件")
	@PostMapping("/deleteAttachment")
    @ResponseBody
    public ExtAjaxResponse deleteAttachment(@RequestParam("fileName") String fileName, HttpServletRequest request) {
		String path=request.getSession().getServletContext().getRealPath("/upload/");
		String realPath=path+fileName;
		try {
			File fileTemp=new File(realPath);
			if(fileTemp.exists()) {
				fileTemp.delete();
				return new ExtAjaxResponse(true,"附件删除成功");
			}else {
				return new ExtAjaxResponse(false,"附件删除失败");
			}
		} catch (Exception e) {
			e.printStackTrace();
            return new ExtAjaxResponse(false,"附件删除失败");
		}
	}

}

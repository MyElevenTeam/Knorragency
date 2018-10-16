package com.example.demo.email.controller;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.example.demo.common.controller.ExtAjaxResponse;
import com.example.demo.common.controller.ExtjsPageRequest;
import com.example.demo.email.entity.Email;
import com.example.demo.email.entity.EmailDTO;
import com.example.demo.email.entity.EmailQueryDTO;
import com.example.demo.email.service.IEmailService;
import com.example.demo.log.config.SystemControllerLog;

@RestController
@RequestMapping("/email")
public class EmailController {
	
	@Autowired
	private IEmailService emailService;
	
	@SystemControllerLog(description="查询草稿箱")
	@RequestMapping("/findEmailEdit")
	public Page<EmailDTO> findEmailEdit(HttpSession session,EmailQueryDTO emailQueryDTO,ExtjsPageRequest pageRequest){
		emailQueryDTO.setEmailStatus(0);
		return emailService.findAll(EmailQueryDTO.getWhereClause(emailQueryDTO), pageRequest.getPageable());
	}
	
	@SystemControllerLog(description="查询已发送邮件")
	@RequestMapping("/findEmailSend")
	public Page<EmailDTO> findEmailSend(HttpSession session,EmailQueryDTO emailQueryDTO,ExtjsPageRequest pageRequest){
		emailQueryDTO.setEmailStatus(1);
		return emailService.findAll(EmailQueryDTO.getWhereClause(emailQueryDTO), pageRequest.getPageable());
	}
	
	@SystemControllerLog(description="查询回收站")
	@RequestMapping("/findEmailTrash")
	public Page<EmailDTO> findEmailTrash(HttpSession session,EmailQueryDTO emailQueryDTO,ExtjsPageRequest pageRequest){
		emailQueryDTO.setEmailStatus(2);
		return emailService.findAll(EmailQueryDTO.getWhereClause(emailQueryDTO), pageRequest.getPageable());
	}
	
	@SystemControllerLog(description="上传附件")
	@PostMapping("/uploadAttachment")
    @ResponseBody
    public ExtAjaxResponse uploadAttachment(HttpServletRequest request) {
        String to=request.getAttribute("emailTo").toString();
        System.out.println(to);
        String file=request.getAttribute("file").toString();
        System.out.println(file);
//		if (!file.isEmpty()) {
//            String saveFileName = file.getOriginalFilename();
//            System.out.println(saveFileName);
//            File saveFile = new File(request.getSession().getServletContext().getRealPath("/upload/") + saveFileName);
//            if (!saveFile.getParentFile().exists()) {
//                saveFile.getParentFile().mkdirs();
//            }
//            try {
//                BufferedOutputStream out = new BufferedOutputStream(new FileOutputStream(saveFile));
//                out.write(file.getBytes());
//                out.flush();
//                out.close();
//                return new ExtAjaxResponse(true,"文件上传成功");
//            } catch (FileNotFoundException e) {
//                e.printStackTrace();
//                return new ExtAjaxResponse(false,"上传失败");
//            } catch (IOException e) {
//                e.printStackTrace();
//                return new ExtAjaxResponse(false,"上传失败");
//            }
//        } else {
//        	return new ExtAjaxResponse(false,"文件不能为空");
//        }
        return new ExtAjaxResponse(true,"文件不能为空");
    }

}

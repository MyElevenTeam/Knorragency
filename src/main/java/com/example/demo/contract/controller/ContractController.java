package com.example.demo.contract.controller;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.poi.POIXMLTextExtractor;
import org.apache.poi.hwpf.HWPFDocument;
import org.apache.poi.hwpf.extractor.WordExtractor;
import org.apache.poi.hwpf.usermodel.Range;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.apache.poi.xwpf.extractor.XWPFWordExtractor;
import org.apache.poi.xwpf.usermodel.XWPFDocument;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.util.ResourceUtils;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.example.demo.activiti.entity.ProcessStatus;
import com.example.demo.activiti.util.WorkflowVariable;
import com.example.demo.common.beans.BeanUtils;
import com.example.demo.common.controller.ExtAjaxResponse;
import com.example.demo.common.controller.ExtjsPageRequest;
import com.example.demo.common.controller.SessionUtil;
import com.example.demo.contract.entity.Contract;
import com.example.demo.contract.entity.ContractDTO;
import com.example.demo.contract.entity.ContractQueryDTO;
import com.example.demo.contract.service.IContractService;
import com.example.demo.employee.domain.Employee;
import com.example.demo.employee.service.IEmployeeService;
import com.example.demo.log.config.SystemControllerLog;

@RestController
@RequestMapping("/contract")
public class ContractController {
	
	@Autowired
	private IContractService contractService;
	
	@Autowired
	private IEmployeeService employeeService;
	
	/*----------------------------------------------系统业务--------------------------------------------*/
	/*save*/
	@SystemControllerLog(description="保存合同信息")
	@PostMapping
	public ExtAjaxResponse saveOne(HttpSession session,@RequestBody Contract contract) {
		
		try {
			String userId = SessionUtil.getUserName(session);
			if(userId!=null) {
				contract.setUserId(userId);
				contract.setProcessStatus(ProcessStatus.NEW);
				Employee employee=employeeService.EmployeeName(userId);
				contract.setEmployee(employee);
				contractService.save(contract);
    		}
			return new ExtAjaxResponse(true,"保存成功！");
		} catch (Exception e) {
			return new ExtAjaxResponse(false,"保存失败！");
		}
		
	}
	
	/*update*/
	@SystemControllerLog(description="更新合同信息")
	@PutMapping(value="{id}")  
	public ExtAjaxResponse update(@PathVariable("id") Long Id,@RequestBody Contract dto) {
		
		try {
			Contract entity = contractService.findById(Id).get();
			if(entity!=null) {
				BeanUtils.copyProperties(dto, entity);//使用自定义的BeanUtils
				contractService.save(entity);
			}
			return new ExtAjaxResponse(true,"更新成功！");
		} catch (Exception e) {
			return new ExtAjaxResponse(true,"更新失败！");
		}
	}
	
	/*delete one*/
	@SystemControllerLog(description="删除一条合同信息")
	@DeleteMapping(value="{id}")    
	public ExtAjaxResponse deleteById(@PathVariable("id") Long id) {
		
		try {
			Optional<Contract> contract=contractService.findById(id);
			if(contract.get()!=null) {
				contract.get().setEmployee(null);
				contractService.deleteById(id);
			}
			return new ExtAjaxResponse(true,"删除成功！");
		} catch (Exception e) {
			return new ExtAjaxResponse(false,"无该合同信息,删除失败！");
		}
		
	}
	
	/*delete rows*/
	@SystemControllerLog(description="删除多条合同信息")
	@PostMapping("/deletes")
	public ExtAjaxResponse deleteRows(@RequestParam(name="ids") Long[] ids) {
		
		try {
			if(ids!=null) {
				contractService.deleteAll(ids);
			}
			return new ExtAjaxResponse(true,"批量删除成功！");
		} catch (Exception e) {
			return new ExtAjaxResponse(false,"批量删除失败！");
		}
		
	}
	
	
	
	/*search one*/
	@SystemControllerLog(description="查看合同信息")
	@GetMapping(value="{id}")  
	public Contract findById(@PathVariable("id") Long id){
		return contractService.findById(id).get();
		
	}
	
	/*动态查询*/
	@SystemControllerLog(description="查看合同信息")
	@GetMapping 
	public Page<ContractDTO> getPage(HttpSession session,ContractQueryDTO contractQueryDTO,ExtjsPageRequest pageRequest) {
		
		String userId = SessionUtil.getUserName(session);  //通过session查找userId
		if(userId!=null) {
			contractQueryDTO.setEmployeeName(userId);
		}
		return contractService.findAll(ContractQueryDTO.getWhereClause(contractQueryDTO), pageRequest.getPageable());
		
	}
	
	/*上传word文档*/
	@SystemControllerLog(description="上传合同信息")
	@PostMapping("/uploadWord")
    public @ResponseBody ExtAjaxResponse uploadWord(@RequestParam(value = "file", required = true) MultipartFile file) {
		// 获取上传的文件名
        String fileName = file.getOriginalFilename();
        System.out.println("fileName:"+fileName);
        String buffer="";
        try {
        	
        	if (fileName.endsWith(".doc")) {
    			InputStream is = file.getInputStream();
    			WordExtractor doc = new WordExtractor(is);
    			buffer = doc.getText();
    			doc.close();
    			Contract c=contractService.readWord(buffer);
    			System.out.println(c.toString());
    			if(c!=null) {
    				c.setProcessStatus(ProcessStatus.NEW);
    				contractService.save(c);
    			}
    		} else if (fileName.endsWith("docx")) {
    			InputStream is = file.getInputStream();
                XWPFDocument docx = new XWPFDocument(is);
    			POIXMLTextExtractor extractor = new XWPFWordExtractor(docx);
    			buffer = extractor.getText();
    			extractor.close();
    			Contract c=contractService.readWord(buffer);
    			if(c!=null) {
    				c.setProcessStatus(ProcessStatus.NEW);
    				contractService.save(c);
    			}
    		} else {
    			System.out.println("此文件不是word文件！");
    		}
        	 return new ExtAjaxResponse(true,"上传成功!");
		} catch (Exception e) {
			 return new ExtAjaxResponse(false,"上传失败!");
		}
		
	}
	
	@SystemControllerLog(description="下载合同信息")
	@RequestMapping("/downloadWord")
    public void downloadWord(HttpServletRequest request, HttpServletResponse response)throws IOException{
		String tmpFile = "classpath:template.doc";
		FileInputStream tempFileInputStream = new FileInputStream(ResourceUtils.getFile(tmpFile));
		
		Map<String, String> datas = new HashMap<String, String>();
	    datas.put("title", "标题部份");
	    datas.put("content", "这里是内容，测试使用POI导出到Word的内容！");
	    datas.put("author", "知识林");
	    datas.put("url", "http://www.zslin.com");
		
		@SuppressWarnings("resource")
		HWPFDocument document = new HWPFDocument(tempFileInputStream);
	    // 读取文本内容
	    Range bodyRange = document.getRange();
	    // 替换内容
	    for (Map.Entry<String, String> entry : datas.entrySet()) {
	        bodyRange.replaceText("${" + entry.getKey() + "}", entry.getValue());
	    }
	    
	    //导出到文件
	    /*ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
	    document.write(byteArrayOutputStream);*/
	    
	    response.setHeader("Content-disposition", "attachment;filename=createList.doc");//默认Excel名称
        response.flushBuffer();
        document.write(response.getOutputStream());
	}
	
	
	
	/*下载excel文档*/
	@SystemControllerLog(description="下载合同信息")
	@RequestMapping("/downloadExcel")
    public void downloadExcel(HttpServletRequest request, HttpServletResponse response)throws IOException
    {  
	   System.out.println("download");
	    //创建工作簿
		@SuppressWarnings("resource")
		XSSFWorkbook wb = new XSSFWorkbook();
		//创建一个sheet
		XSSFSheet sheet = wb.createSheet();
		
		// 创建单元格样式
		XSSFCellStyle style =  wb.createCellStyle();	
		
		//为单元格添加背景样式
		for (int i = 0; i < 6; i++) { //需要6行表格
		    Row  row =	sheet.createRow(i); //创建行
			for (int j = 0; j < 6; j++) {//需要6列
				row.createCell(j).setCellStyle(style);
			}
		}
		
		//合并单元格
		sheet.addMergedRegion(new CellRangeAddress(0, 1, 0, 0));//合并单元格，cellRangAddress四个参数，第一个起始行，第二终止行，第三个起始列，第四个终止列
		sheet.addMergedRegion(new CellRangeAddress(0, 0, 1, 5));
		
		//tian入数据
		XSSFRow row = sheet.getRow(0); //获取第一行
		row.getCell(1).setCellValue("2018期末考试"); //在第一行中创建一个单元格并赋值
		XSSFRow row1 = sheet.getRow(1); //获取第二行，为每一列添加字段
		row1.getCell(1).setCellValue("语文");
		row1.getCell(2).setCellValue("数学");
		row1.getCell(3).setCellValue("英语");
		row1.getCell(4).setCellValue("物理");
		row1.getCell(5).setCellValue("化学");
		XSSFRow row2 = sheet.getRow(2); //获取第三行
		row2.getCell(0).setCellValue("张三");
		XSSFRow row3 = sheet.getRow(3); //获取第四行
		row3.getCell(0).setCellValue("张三");
		XSSFRow row4 = sheet.getRow(4); //获取第五行
		row4.getCell(0).setCellValue("张三");
		XSSFRow row5 = sheet.getRow(5); //获取第五行
		row5.getCell(0).setCellValue("张三");
        
        //response.setContentType("application/octet-stream");
        response.setHeader("Content-disposition", "attachment;filename=createList.xls");//默认Excel名称
        response.flushBuffer();
        wb.write(response.getOutputStream());
    }
	
	
	/*-------------------------------------流程引擎web层------------------------------------------*/
	/**
	 * 启动流程
	 * @param leaveId	请假信息Id
	 * @param session	通过会话获取登录用户(请假人)
	 * @return
	 */
	@SystemControllerLog(description="启动合同审批流程")
	@RequestMapping(value = "/start")
    public @ResponseBody ExtAjaxResponse start(@RequestParam(name="id") Long contractId,HttpSession session) {
    	try {
    		String userId = SessionUtil.getUserName(session);
    		Map<String, Object> variables = new HashMap<String, Object>();
    		variables.put("deptLeader", "financeManager");
    		variables.put("manLeader", "hrManager");
    		variables.put("applyUserId", userId);
    		contractService.startWorkflow(userId,contractId, variables);
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
	@SystemControllerLog(description="查询待处理合同审批任务")
	@RequestMapping(value = "/tasks")
    public @ResponseBody Page<ContractDTO> findTodoTasks(HttpSession session,ExtjsPageRequest pageable) {
		Page<ContractDTO> page = new PageImpl<ContractDTO>(new ArrayList<ContractDTO>(), pageable.getPageable(), 0);
    	try {
    		page = contractService.findTodoTasks(SessionUtil.getUserName(session), pageable.getPageable());
	    } catch (Exception e) {
	    	e.printStackTrace();
	    }
    	return page;
    }
	
	/**
     * 签收任务
     */
	@SystemControllerLog(description="签收合同审批任务")
    @RequestMapping(value = "claim/{id}")
    public @ResponseBody ExtAjaxResponse claim(@PathVariable("id") String taskId, HttpSession session) {
    	try{
    		contractService.claim(taskId, SessionUtil.getUserName(session));
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
	@SystemControllerLog(description="完成合同审批任务")
    @RequestMapping(value = "complete/{id}")
    public @ResponseBody ExtAjaxResponse complete(@PathVariable("id") String taskId, WorkflowVariable var) {
    	try{
    		Map<String, Object> variables = var.getVariableMap();
    		contractService.complete(taskId, variables);
	    	return new ExtAjaxResponse(true,"审批成功!");
	    } catch (Exception e) {
	    	e.printStackTrace();
	        return new ExtAjaxResponse(false,"审批失败!");
	    }
    }
	
	
}

package com.example.demo.contract.controller;

import java.io.BufferedInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.poi.POIXMLTextExtractor;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRichTextString;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
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
import org.springframework.http.MediaType;
import org.springframework.util.ResourceUtils;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.example.demo.common.beans.BeanUtils;
import com.example.demo.common.controller.ExtAjaxResponse;
import com.example.demo.common.controller.ExtjsPageRequest;
import com.example.demo.contract.entity.Contract;
import com.example.demo.contract.entity.ContractQueryDTO;
import com.example.demo.contract.service.IContractService;

@RestController
@RequestMapping("/contract")
public class ContractController {
	
	@Autowired
	private IContractService contractService;
	
	/*save*/
	@PostMapping(consumes=MediaType.APPLICATION_JSON_VALUE)
	public ExtAjaxResponse saveOne(@RequestBody Contract contract) {
		
		try {
			contractService.save(contract);
			return new ExtAjaxResponse(true,"保存成功！");
		} catch (Exception e) {
			return new ExtAjaxResponse(true,"保存失败！");
		}
		
	}
	
	/*delete one*/
	@DeleteMapping(value="{id}")    
	public ExtAjaxResponse deleteById(@PathVariable("id") Long id) {
		
		try {
			Optional<Contract> contract=contractService.findById(id);
			if(contract.get()!=null) {
				contractService.deleteById(id);
			}
			return new ExtAjaxResponse(true,"删除成功！");
		} catch (Exception e) {
			return new ExtAjaxResponse(false,"无该合同信息,删除失败！");
		}
		
	}
	
	/*delete rows*/
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
	
	/*update user*/
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
	
	/*search one*/
	@GetMapping(value="{id}")  
	public Contract findById(@PathVariable("id") Long id){
		return contractService.findById(id).get();
		
	}
	
	/*动态查询*/
	@GetMapping 
	public Page<Contract> getPage(HttpSession session,ContractQueryDTO contractQueryDTO,ExtjsPageRequest pageRequest) {
		
		/*String userId = SessionUtil.getUserName(session);  //通过session查找userId
		if(userId!=null) {
			contractQueryDTO.setEmployeeName(userId);
		}*/
		return contractService.findAll(ContractQueryDTO.getWhereClause(contractQueryDTO), pageRequest.getPageable());
		
	}
	
	/*上传word文档*/
	@PostMapping
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
	
	
	@RequestMapping("/downloadWord")
    public void downloadWord(HttpServletRequest request, HttpServletResponse response)throws IOException{
		String tmpFile = "classpath:template.doc";
		FileInputStream tempFileInputStream = new FileInputStream(ResourceUtils.getFile(tmpFile));
		
		Map<String, String> datas = new HashMap<String, String>();
	    datas.put("title", "标题部份");
	    datas.put("content", "这里是内容，测试使用POI导出到Word的内容！");
	    datas.put("author", "知识林");
	    datas.put("url", "http://www.zslin.com");
		
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

	
	
}

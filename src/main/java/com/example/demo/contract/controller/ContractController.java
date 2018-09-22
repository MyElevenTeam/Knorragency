package com.example.demo.contract.controller;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.poi.POIXMLTextExtractor;
import org.apache.poi.hwpf.extractor.WordExtractor;
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
	
	
	
	
	
	@PostMapping("/download")
	  public ExtAjaxResponse testDownload(HttpServletRequest request,HttpServletResponse response) throws IOException {
		//得到要下载的文件名
        String fileName = request.getParameter("1.doc");  //23239283-92489-阿凡达.avi
        //fileName = new String(fileName.getBytes("iso8859-1"),"UTF-8");
        //得到要下载的文件
        File file = new File("C:\\Users\\Administrator\\Desktop\\ww\\" + fileName);
        
      //处理文件名
        //String realname = fileName.substring(fileName.indexOf("_")+1);
        //设置响应头，控制浏览器下载该文件
        response.setHeader("content-disposition", "attachment;filename=" + URLEncoder.encode("1.doc", "UTF-8"));
        //读取要下载的文件，保存到文件输入流
        FileInputStream in = new FileInputStream("C:\\Users\\Administrator\\Desktop\\ww\\1.doc");
        //创建输出流
        OutputStream out = response.getOutputStream();
        //创建缓冲区
        byte buffer[] = new byte[1024];
        int len = 0;
        //循环将输入流中的内容读取到缓冲区当中
        while((len=in.read(buffer))>0){
            //输出缓冲区的内容到浏览器，实现文件下载
            out.write(buffer, 0, len);
        }
        //关闭文件输入流
        in.close();
        //关闭输出流
        out.close();
        System.out.println("success");
	        return new ExtAjaxResponse(true,"上传成功!");
	  }
	
	
}

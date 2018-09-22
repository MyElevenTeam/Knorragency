package com.example.demo.contract.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.util.Optional;

import javax.servlet.http.HttpSession;

import org.apache.poi.POIXMLDocument;
import org.apache.poi.POIXMLTextExtractor;
import org.apache.poi.hwpf.extractor.WordExtractor;
import org.apache.poi.openxml4j.opc.OPCPackage;
import org.apache.poi.xwpf.extractor.XWPFWordExtractor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.http.MediaType;
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

import com.example.demo.common.beans.BeanUtils;
import com.example.demo.common.controller.ExtAjaxResponse;
import com.example.demo.common.controller.ExtjsPageRequest;
import com.example.demo.common.controller.SessionUtil;
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
	
	@PostMapping
    public @ResponseBody ExtAjaxResponse uploadWord(@RequestParam(value = "file", required = true) MultipartFile file) {
		// 获取上传的文件名
        String fileName = file.getOriginalFilename();
        System.out.println("fileName:"+fileName);
        String buffer="";
        try {
        	
        	if (fileName.endsWith(".doc")) {
    			InputStream is = new FileInputStream(new File(fileName));
    			WordExtractor ex = new WordExtractor(is);
    			buffer = ex.getText();
    			ex.close();
    			Contract c=contractService.readWord(buffer);
    			if(c!=null) {
    				contractService.save(c);
    			}
    		} else if (fileName.endsWith("docx")) {
    			OPCPackage opcPackage = POIXMLDocument.openPackage(fileName);
    			POIXMLTextExtractor extractor = new XWPFWordExtractor(opcPackage);
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
	
}

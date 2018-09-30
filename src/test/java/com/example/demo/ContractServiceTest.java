package com.example.demo;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.apache.poi.POIXMLDocument;
import org.apache.poi.POIXMLTextExtractor;
import org.apache.poi.hwpf.HWPFDocument;
import org.apache.poi.hwpf.extractor.WordExtractor;
import org.apache.poi.hwpf.usermodel.Range;
import org.apache.poi.openxml4j.exceptions.OpenXML4JException;
import org.apache.poi.openxml4j.opc.OPCPackage;
import org.apache.poi.xwpf.extractor.XWPFWordExtractor;
import org.apache.xmlbeans.XmlException;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.util.ResourceUtils;

import com.example.demo.contract.entity.Contract;
import com.example.demo.contract.service.IContractService;

@RunWith(SpringRunner.class)
@SpringBootTest
public class ContractServiceTest {
	
	@Autowired
	private IContractService contractService;
	
	@Test
	public void readWord() throws IOException, ParseException, XmlException, OpenXML4JException {
		String buffer="";
		String path="C:\\Users\\Administrator\\Desktop\\2.docx";
		
		if (path.endsWith(".doc")) {
			InputStream is = new FileInputStream(new File(path));
			WordExtractor ex = new WordExtractor(is);
			buffer = ex.getText();
			ex.close();
			Contract c=contractService.readWord(buffer);
			if(c!=null) {
				contractService.save(c);
			}
		} else if (path.endsWith("docx")) {
			OPCPackage opcPackage = POIXMLDocument.openPackage(path);
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

	}
	
	public void build(File tmpFile, Map<String, String> contentMap, String exportFile) throws Exception {
	    FileInputStream tempFileInputStream = new FileInputStream(tmpFile);
	    HWPFDocument document = new HWPFDocument(tempFileInputStream);
	    // 读取文本内容
	    Range bodyRange = document.getRange();
	    // 替换内容
	    for (Map.Entry<String, String> entry : contentMap.entrySet()) {
	        bodyRange.replaceText("${" + entry.getKey() + "}", entry.getValue());
	    }

	    //导出到文件
	    ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
	    document.write(byteArrayOutputStream);
	    OutputStream outputStream = new FileOutputStream(exportFile);
	    outputStream.write(byteArrayOutputStream.toByteArray());
	    outputStream.close();
	}
	
	
	@Test
	public void testExportWord2() throws Exception {
	    String tmpFile = "classpath:template.doc";
	    String expFile = "C:\\Users\\Administrator\\Desktop\\3.docx";
	    Map<String, String> datas = new HashMap<String, String>();
	    datas.put("title", "标题部份");
	    datas.put("content", "这里是内容，测试使用POI导出到Word的内容！");
	    datas.put("author", "知识林");
	    datas.put("url", "http://www.zslin.com");

	    build(ResourceUtils.getFile(tmpFile), datas, expFile);
	}



	
	
	
}

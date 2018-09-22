package com.example.demo;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.apache.poi.POIXMLDocument;
import org.apache.poi.POIXMLTextExtractor;
import org.apache.poi.hwpf.extractor.WordExtractor;
import org.apache.poi.openxml4j.exceptions.OpenXML4JException;
import org.apache.poi.openxml4j.opc.OPCPackage;
import org.apache.poi.xwpf.extractor.XWPFWordExtractor;
import org.apache.xmlbeans.XmlException;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

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
	
}

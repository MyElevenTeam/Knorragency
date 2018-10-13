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
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

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

import com.example.demo.attence.entity.Attence;
import com.example.demo.attence.entity.AttenceQueryDTO;
import com.example.demo.attence.service.AttenceService;
import com.example.demo.attence.utils.AttenceUtil;
import com.example.demo.contract.entity.Contract;
import com.example.demo.contract.service.IContractService;

@RunWith(SpringRunner.class)
@SpringBootTest
public class ContractServiceTest {
	
	@Autowired
	private IContractService contractService;
	
	@Autowired
	private AttenceService attenceService;
	
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
	    @SuppressWarnings("resource")
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
	
	@Test
	public void tt() throws ParseException {
		
        
		Calendar todayStart = Calendar.getInstance();		
		todayStart.set(Calendar.HOUR_OF_DAY, 0);		
		todayStart.set(Calendar.MINUTE, 0);		
		todayStart.set(Calendar.SECOND, 0);		
		
		System.out.println("todayStart:"+todayStart.getTime());

		
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(new Date());
		calendar.set(Calendar.HOUR_OF_DAY, 0);
		calendar.set(Calendar.MINUTE, 0);
		calendar.set(Calendar.SECOND, 0);
		calendar.set(Calendar.MILLISECOND, 0);
		calendar.add(Calendar.DAY_OF_MONTH, 1);
		System.out.println("todayEnd:"+calendar.getTime());
        
        AttenceQueryDTO dto=new AttenceQueryDTO();
        dto.setEmployeeName("admin");
        dto.setWorkinTime(todayStart.getTime());
        //dto.setWorkoutTime(new Date());
        List<Attence> attenceList=new ArrayList<Attence>();
		attenceList=attenceService.findByEmployeeName(AttenceQueryDTO.getWhereClause(dto));
		for(Attence attence:attenceList) {
			System.out.println(attence);
		}

	}
	
	@Test
	public void time() throws ParseException {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date dBegin = sdf.parse("2018-10-08");
		Date dEnd = sdf.parse("2018-10-12");
		List<Date> datas = AttenceUtil.findDates(dBegin, dEnd);
        for(Date date:datas) {
        	System.out.println(sdf.format(date));
        }
	}
	
	@Test
	public void timeFormatTest() throws Exception {
		Optional<Contract> tmp=null;
		tmp=contractService.findById(1L);
		Calendar calendar=Calendar.getInstance();
		calendar.setTime(tmp.get().getStartTime());
		System.out.println(calendar.get(Calendar.MONTH));
	}
	/**
	 * 给合同表添加数据
	 */
	@Test
	public void addData() {
		//得45
		/*for(int i=0;i<10;i++) {
			Contract contract=new Contract();
			contract.setStartTime(new Date());
			contract.setTotal(i);
			contract.setEmployeeName("小明");
			contractService.save(contract);
		}*/
	/*	//得36
		for(int i=0;i<9;i++) {
			Contract contract=new Contract();
			contract.setStartTime(new Date());
			contract.setTotal(i);
			contract.setEmployeeName("小红");
			contractService.save(contract);
		}*/
		List<Contract> tmps=contractService.findAllContract(null);
		for(Contract tmp:tmps) {
			System.out.println(tmp);
		}
	}
	
	
	@Test
	public void sum() {
		double a=contractService.sum();
		System.out.println(a);
	}
	

}

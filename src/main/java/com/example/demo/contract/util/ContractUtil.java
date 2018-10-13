package com.example.demo.contract.util;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;

public class ContractUtil {

	public static Date toDate(String month) {
		
		HashMap<String, String> hashMap = new HashMap<String, String>();
		hashMap.put("一月", "01");
		hashMap.put("二月", "02");
		hashMap.put("三月", "03");
		hashMap.put("四月", "04");
		hashMap.put("五月", "05");
		hashMap.put("六月", "06");
		hashMap.put("七月", "07");
		hashMap.put("八月", "08");
		hashMap.put("九月", "09");
		hashMap.put("十月", "10");
		hashMap.put("十一月", "11");
		hashMap.put("十二月", "12");
		
		SimpleDateFormat sdf = new SimpleDateFormat("MM");
		Date dMonth=new Date();
		String str=null;
		try {
			str=hashMap.get(month);
			dMonth=sdf.parse(str);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dMonth;
	}

}

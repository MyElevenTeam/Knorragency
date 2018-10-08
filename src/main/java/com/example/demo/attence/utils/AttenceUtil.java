package com.example.demo.attence.utils;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.Reader;
import java.net.URL;
import java.nio.charset.Charset;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;

import com.example.demo.attence.entity.Attence;
import com.example.demo.attence.entity.AttenceQueryDTO;
import com.example.demo.attence.service.AttenceService;

public class AttenceUtil {
	
	@Autowired
	private static AttenceService attenceService;
	
	private static String url="http://api.map.baidu.com/location/ip?ak=sBlNFyaEHsReLGZcO4dluyc9VbwBXffV&coor=bd09ll";
	
	public static JSONObject readJsonFromUrl() throws IOException, JSONException {
		InputStream is = new URL(url).openStream();
		BufferedReader rd = new BufferedReader(new InputStreamReader(is, Charset.forName("UTF-8")));
		String jsonText = readAll(rd);
		JSONObject json=new JSONObject(jsonText);
		return json;
	}
	
	private static String readAll(Reader rd) throws IOException {
		StringBuilder sb = new StringBuilder();
		int cp;
		while ((cp = rd.read()) != -1) {
			sb.append((char) cp);
		}
		return sb.toString();
	}
	
	public static boolean isAttence(String employeeName) {
		boolean flag=false;
		try {
		    Date date=new Date();
			
			AttenceQueryDTO dto=new AttenceQueryDTO();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
			String time=sdf.format(date);
			dto.setEmployeeName(employeeName);
			
			List<Attence> attenceList=new ArrayList<Attence>();
			attenceList=attenceService.findAttence(AttenceQueryDTO.getWhereClause(dto));
			for(Attence attence:attenceList) {
				System.out.println(attence);
				if(time.equals(sdf.format(attence.getWorkinTime()))) {
					flag=false;
					break;
				}else {
					flag=true;
					break;
				}
			}
			return flag;
		} catch (Exception e) {
			return flag;
		}
	}
}

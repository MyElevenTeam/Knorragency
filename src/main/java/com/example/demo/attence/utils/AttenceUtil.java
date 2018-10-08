package com.example.demo.attence.utils;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.Reader;
import java.net.URL;
import java.nio.charset.Charset;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.json.JSONException;
import org.json.JSONObject;

public class AttenceUtil {
	
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
	
	public static List<Date> findDates(Date dBegin, Date dEnd){
		  List<Date> lDate = new ArrayList<Date>();
		  //SimpleDateFormat sd = new SimpleDateFormat("yyyy-MM-dd");
		  //lDate.add(sd.format(dBegin));
		  lDate.add(dBegin);
		  Calendar calBegin = Calendar.getInstance();
		  // 使用给定的 Date 设置此 Calendar 的时间
		  calBegin.setTime(dBegin);
		  Calendar calEnd = Calendar.getInstance();
		  // 使用给定的 Date 设置此 Calendar 的时间
		  calEnd.setTime(dEnd);
		  // 测试此日期是否在指定日期之后
		  while (dEnd.after(calBegin.getTime()))
		  {
			   // 根据日历的规则，为给定的日历字段添加或减去指定的时间量
			   calBegin.add(Calendar.DAY_OF_MONTH, 1);
			   //lDate.add(sd.format(calBegin.getTime()));
			   lDate.add(calBegin.getTime());
		  }
		  return lDate;
	}
	
}

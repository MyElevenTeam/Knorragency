package com.example.demo.attence.utils;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.Reader;
import java.net.URL;
import java.nio.charset.Charset;

import org.json.JSONException;
import org.json.JSONObject;

public class LocationByIP {
	
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
}

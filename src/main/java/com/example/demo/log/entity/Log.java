package com.example.demo.log.entity;

import java.util.Date;
import java.util.Map;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.example.demo.employee.domain.Employee;
import com.fasterxml.jackson.annotation.JsonFormat;

@Entity
@Table(name="t_log")
public class Log {
	
	private Long id;
	
	private Employee employee;
	
	private String title;
	
	private String type;
	
	private String remoteAddr;
	
	private String requestUri;
	
	private String method;
	
	private String params;
	
	private Date operateDate;
	
	private String exception;           
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	public Long getId() {
		return id;
	}
	
	@ManyToOne
	@JoinColumn(name="employee_id")
	public Employee getEmployee() {
		return employee;
	}

	public String getTitle() {
		return title;
	}

	public String getType() {
		return type;
	}

	public String getRemoteAddr() {
		return remoteAddr;
	}

	public String getRequestUri() {
		return requestUri;
	}

	public String getMethod() {
		return method;
	}

	public String getParams() {
		return params;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
	public Date getOperateDate() {
		return operateDate;
	}
	
	
	public String getException() {
		return exception;
	}

	public void setId(Long id) {
		this.id = id;
	}
	
	public void setEmployee(Employee employee) {
		this.employee = employee;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public void setType(String type) {
		this.type = type;
	}

	public void setRemoteAddr(String remoteAddr) {
		this.remoteAddr = remoteAddr;
	}

	public void setRequestUri(String requestUri) {
		this.requestUri = requestUri;
	}

	public void setMethod(String method) {
		this.method = method;
	}

	public void setParams(String params) {
		this.params = params;
	}

	public void setOperateDate(Date operateDate) {
		this.operateDate = operateDate;
	}

	public void setException(String exception) {
		this.exception = exception;
	}
	
	/**
     * 设置请求参数
     * @param paramMap
     */
    public void setMapToParams(Map<String, String[]> paramMap) {
        if (paramMap == null){
            return;
        }
        StringBuilder params = new StringBuilder();
        for (Map.Entry<String, String[]> param : ((Map<String, String[]>)paramMap).entrySet()){
            params.append(("".equals(params.toString()) ? "" : "&") + param.getKey() + "=");
            String paramValue = (param.getValue() != null && param.getValue().length > 0 ? param.getValue()[0] : "");
           // params.append(StringUtils.abbr(StringUtils.endsWithIgnoreCase(param.getKey(), "password") ? "" : paramValue, 100));
        }
        this.params = params.toString();
    }
}


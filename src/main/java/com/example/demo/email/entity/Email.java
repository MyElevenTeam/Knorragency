package com.example.demo.email.entity;

import java.util.Date;

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
@Table(name="t_email")
public class Email {
	
	private Long id;
	
	private String emailFrom;
	
	private String emailTo;
	
	private String emailSubject;
	
	private String emailContent;
	
	private Date sendTime;
	
	private Employee employee;
	
	private EmailStatus emailStatus;
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	public Long getId() {
		return id;
	}

	public String getEmailFrom() {
		return emailFrom;
	}

	public String getEmailTo() {
		return emailTo;
	}

	public String getEmailSubject() {
		return emailSubject;
	}

	public String getEmailContent() {
		return emailContent;
	}
	
	@JsonFormat(pattern="yyyy/MM/dd HH:mm:ss",timezone="GMT+8")
	public Date getSendTime() {
		return sendTime;
	}
	
	@ManyToOne
	@JoinColumn(name="employee_id")
	public Employee getEmployee() {
		return employee;
	}

	public EmailStatus getEmailStatus() {
		return emailStatus;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public void setEmailFrom(String emailFrom) {
		this.emailFrom = emailFrom;
	}

	public void setEmailTo(String emailTo) {
		this.emailTo = emailTo;
	}

	public void setEmailSubject(String emailSubject) {
		this.emailSubject = emailSubject;
	}

	public void setEmailcontent(String emailcontent) {
		this.emailContent = emailcontent;
	}

	public void setSendTime(Date sendTime) {
		this.sendTime = sendTime;
	}

	public void setEmployee(Employee employee) {
		this.employee = employee;
	}

	public void setEmailStatus(EmailStatus emailStatus) {
		this.emailStatus = emailStatus;
	}
	
}

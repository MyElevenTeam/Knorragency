package com.example.demo.email.entity;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

public class EmailDTO {
	
    private String emailFrom;
	
	private String emailTo;
	
	private String emailSubject;
	
	private String emailContent;
	
	private Date sendTime;
	
    private String employeeName;
	
	private EmailStatus emailStatus;
	
	private EmailStatus readStatus;
	
	private String emailAttachment;
	
	public String getEmailFrom() {
		return emailFrom;
	}

	public void setEmailFrom(String emailFrom) {
		this.emailFrom = emailFrom;
	}

	public String getEmailTo() {
		return emailTo;
	}

	public void setEmailTo(String emailTo) {
		this.emailTo = emailTo;
	}

	public String getEmailSubject() {
		return emailSubject;
	}

	public void setEmailSubject(String emailSubject) {
		this.emailSubject = emailSubject;
	}

	public String getEmailContent() {
		return emailContent;
	}

	public void setEmailcontent(String emailcontent) {
		this.emailContent = emailcontent;
	}
	
	@JsonFormat(pattern="yyyy/MM/dd HH:mm:ss",timezone="GMT+8")
	public Date getSendTime() {
		return sendTime;
	}

	public void setSendTime(Date sendTime) {
		this.sendTime = sendTime;
	}

	public String getEmployeeName() {
		return employeeName;
	}

	public void setEmployeeName(String employeeName) {
		this.employeeName = employeeName;
	}

	public EmailStatus getEmailStatus() {
		return emailStatus;
	}

	public void setEmailStatus(EmailStatus emailStatus) {
		this.emailStatus = emailStatus;
	}
	
	public EmailStatus getReadStatus() {
		return readStatus;
	}

	public void setReadStatus(EmailStatus readStatus) {
		this.readStatus = readStatus;
	}

	public String getEmailAttachment() {
		return emailAttachment;
	}

	public void setEmailAttachment(String emailAttachment) {
		this.emailAttachment = emailAttachment;
	}

	public void setEmailContent(String emailContent) {
		this.emailContent = emailContent;
	}
	
}

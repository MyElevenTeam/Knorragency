package com.example.demo.addressList.entity;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="t_employee")
public class Employee {
	private Long id;
	private String employeeName;
	private String employeeNumber;
	private String employeeArea;
	private String post;
	private String email;
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	public Long getId() {
		return id;
	}
	public String getEmployeeName() {
		return employeeName;
	}
	public String getEmployeeNumber() {
		return employeeNumber;
	}
	public String getEmployeeArea() {
		return employeeArea;
	}
	public String getPost() {
		return post;
	}
	public String getEmail() {
		return email;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public void setEmployeeName(String employeeName) {
		this.employeeName = employeeName;
	}
	public void setEmployeeNumber(String employeeNumber) {
		this.employeeNumber = employeeNumber;
	}
	public void setEmployeeArea(String employeeArea) {
		this.employeeArea = employeeArea;
	}
	public void setPost(String post) {
		this.post = post;
	}
	public void setEmail(String email) {
		this.email = email;
	}

}

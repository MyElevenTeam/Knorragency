package com.example.demo.addressList.entity;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;

import org.apache.commons.lang3.StringUtils;
import org.springframework.data.jpa.domain.Specification;


public class EmployeeQueryDTO {
	private String employeeName;
	private String employeeArea;
	private String post;
	private String email;
	
	public String getEmployeeName() {
		return employeeName;
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
	
	
	public void setEmployeeName(String employeeName) {
		this.employeeName = employeeName;
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
	
	@SuppressWarnings({ "serial"})
	public static Specification<Employee> getWhereClause(final EmployeeQueryDTO employeeQueryDTO) {
		return new Specification<Employee>() {
			@Override
			public Predicate toPredicate(Root<Employee> root, CriteriaQuery<?> query, CriteriaBuilder criteriaBuilder) {
			
				List<Predicate> predicate = new ArrayList<>();
				
				if(StringUtils.isNoneBlank(employeeQueryDTO.getEmployeeName())) {
					predicate.add(criteriaBuilder.like(root.get("employeeName").as(String.class),
							"%" + employeeQueryDTO.getEmployeeName() + "%"));
				}
				if(StringUtils.isNoneBlank(employeeQueryDTO.getEmployeeArea())) {
					predicate.add(criteriaBuilder.like(root.get("employeeArea").as(String.class),
							"%" + employeeQueryDTO.getEmployeeArea() + "%"));
				}
				if(StringUtils.isNoneBlank(employeeQueryDTO.getPost())) {
					predicate.add(criteriaBuilder.like(root.get("post").as(String.class),
							"%" + employeeQueryDTO.getPost() + "%"));
				}
				if(StringUtils.isNoneBlank(employeeQueryDTO.getEmail())) {
					predicate.add(criteriaBuilder.like(root.get("email").as(String.class),
							"%" + employeeQueryDTO.getEmail() + "%"));
				}
				//predicate.add(criteriaBuilder.equal(root.get("id").as(Integer.class), userQueryDTO.getId()));
				Predicate[] pre = new Predicate[predicate.size()];
				return query.where(predicate.toArray(pre)).getRestriction();
			}
		};
	}
	
	
}

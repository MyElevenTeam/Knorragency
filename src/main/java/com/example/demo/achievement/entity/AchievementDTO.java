package com.example.demo.achievement.entity;

public class AchievementDTO {
	private String employeeName;
	private double total;
	
	public String getEmployeeName() {
		return employeeName;
	}
	public double getTotal() {
		return total;
	}
	public void setEmployeeName(String employeeName) {
		this.employeeName = employeeName;
	}
	public void setTotal(double total) {
		this.total = total;
	}
	@Override
	public String toString() {
		return "AchievementDTO [employeeName=" + employeeName + ", total=" + total + "]";
	}
	
	
}

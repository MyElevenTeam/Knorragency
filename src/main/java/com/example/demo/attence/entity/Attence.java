package com.example.demo.attence.entity;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonFormat;

@Entity
@Table(name="t_attence")
public class Attence {
	
	private Long id;
	
	private String employeeName;
	
	private String location;
	
	private Date workinTime;
	
	private Date workoutTime;
	
	private AttenceStatus attenceStatus;
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	public Long getId() {
		return id;
	}

	public String getEmployeeName() {
		return employeeName;
	}

	public String getLocation() {
		return location;
	}
	
	@JsonFormat(pattern="yyyy/MM/dd HH:mm:ss",timezone="GMT+8")
	public Date getWorkinTime() {
		return workinTime;
	}
	
	@JsonFormat(pattern="yyyy/MM/dd HH:mm:ss",timezone="GMT+8")
	public Date getWorkoutTime() {
		return workoutTime;
	}
	
	
	public AttenceStatus getAttenceStatus() {
		return attenceStatus;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public void setEmployeeName(String employeeName) {
		this.employeeName = employeeName;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public void setWorkinTime(Date workinTime) {
		this.workinTime = workinTime;
	}

	public void setWorkoutTime(Date workoutTime) {
		this.workoutTime = workoutTime;
	}

	public void setAttenceStatus(AttenceStatus attenceStatus) {
		this.attenceStatus = attenceStatus;
	}

	@Override
	public String toString() {
		return "Attence [id=" + id + ", employeeName=" + employeeName + ", location=" + location + ", workinTime="
				+ workinTime + ", workoutTime=" + workoutTime + ", attenceStatus=" + attenceStatus + "]";
	}
	
}

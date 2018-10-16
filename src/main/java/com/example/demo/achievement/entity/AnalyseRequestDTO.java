package com.example.demo.achievement.entity;

public class AnalyseRequestDTO {
	private String winner;
	private double total;
	private double rate;
	private int peopleNum;
	
	public String getWinner() {
		return winner;
	}
	public double getTotal() {
		return total;
	}
	public double getRate() {
		return rate;
	}
	public int getPeopleNum() {
		return peopleNum;
	}
	public void setWinner(String winner) {
		this.winner = winner;
	}
	public void setTotal(double total) {
		this.total = total;
	}
	public void setRate(double rate) {
		this.rate = rate;
	}
	public void setPeopleNum(int peopleNum) {
		this.peopleNum = peopleNum;
	}
	@Override
	public String toString() {
		return "AnalyseRequestDTO [winner=" + winner + ", total=" + total + ", rate=" + rate + ", peopleNum="
				+ peopleNum + "]";
	}
}
package qmtm.tman.exam; 

import java.sql.Timestamp;

public class ReceiptBean {
	
	private String userid;
	private String password;
	private String name;
	private String regdate;
	private String sosok1;
	private String sosok2;
	private String level;
	private String home_phone;
	private String mobile_phone;
	private String email;
	private String corp_gubun;

	public ReceiptBean() { 
	}
		
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public void setName(String name) {
		this.name = name;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	public void setSosok1(String sosok1) {
		this.sosok1 = sosok1;
	}
	public void setSosok2(String sosok2) {
		this.sosok2 = sosok2;
	}
	public void setLevel(String level) {
		this.level = level;
	}
	public void setHome_phone(String home_phone) {
		this.home_phone = home_phone;
	}
	public void setMobile_phone(String mobile_phone) {
		this.mobile_phone = mobile_phone;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public void setCorp_gubun(String corp_gubun) {
		this.corp_gubun = corp_gubun;
	}

	public String getUserid() {
		return userid;
	}	
	public String getPassword() {
		return password;
	}	
	public String getName() {
		return name;
	}	
	public String getRegdate() {
		return regdate;
	}
	public String getSosok1() {
		return sosok1;
	}
	public String getSosok2() {
		return sosok2;
	}
	public String getLevel() {
		return level;
	}
	public String getHome_phone() {
		return home_phone;
	}
	public String getMobile_phone() {
		return mobile_phone;
	}
	public String getEmail() {
		return email;
	}
	public String getCorp_gubun() {
		return corp_gubun;
	}
}
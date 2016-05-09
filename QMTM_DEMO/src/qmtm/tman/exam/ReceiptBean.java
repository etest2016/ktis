package qmtm.tman.exam;

import java.sql.Timestamp;

public class ReceiptBean {
	
	private String userid;
	private String password;
	private String name;
	private String regdate;
	private String sosok1;
	private String sosok2;
		
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
}
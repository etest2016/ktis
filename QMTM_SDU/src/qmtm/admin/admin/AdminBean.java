package qmtm.admin.admin;

import java.sql.Timestamp;

public class AdminBean {
	
	private String userid;
	private String name;
	private String sosok;
	private String yn_valid;
	private String regdate;

	public AdminBean() {
	}
		
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public void setName(String name) {
		this.name = name;
	}
	public void setSosok(String sosok) {
		this.sosok = sosok;
	}
	public void setYn_valid(String yn_valid) {		
		this.yn_valid = yn_valid;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
		
	public String getUserid() {
		return userid;
	}
	public String getName() {
		return name;
	}
	public String getSosok() {
		return sosok;
	}
	public String getYn_valid() {				
		return yn_valid;
	}
	public String getRegdate() {
		return regdate;
	}	
}
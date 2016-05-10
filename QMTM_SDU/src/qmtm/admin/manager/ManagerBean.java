package qmtm.admin.manager;

import java.sql.Timestamp;

public class ManagerBean {
	
	private String userid;
	private String password;
	private String name;
	private String content1;
	private String yn_valid;
	private String regdate;
	private String email;
	private String hp;

	public ManagerBean() {
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
	public void setContent1(String content1) {
		this.content1 = content1;
	}
	public void setYn_valid(String yn_valid) {		
		this.yn_valid = yn_valid;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public void setHp(String hp) {
		this.hp = hp;
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
	public String getContent1() {
		return content1;
	}
	public String getYn_valid() {				
		return yn_valid;
	}
	public String getRegdate() {
		return regdate;
	}
	public String getEmail() {
		return email;
	}
	public String getHp() {
		return hp;
	}
}
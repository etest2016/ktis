package qmtm.admin;

import java.sql.Timestamp;

public class MemberBean {

	private String userid;
	private String password;
	private String name;
	private String email;
	private String home_postcode;
	private String home_addr1;
	private String home_phone;
	private String mobile_phone;
	private String sosok1;
	private String sosok2;
	private String sosok3;
	private String sosok4;
	private String jikwi;
	private String jikmu;
	private String company;
	private String regdate;
		
	public MemberBean() {
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
	public void setEmail(String email) {
		this.email = email;
	}
	public void setHome_postcode(String home_postcode) {
		this.home_postcode = home_postcode;
	}
	public void setHome_addr1(String home_addr1) {
		this.home_addr1 = home_addr1;
	}
	public void setHome_phone(String home_phone) {
		this.home_phone = home_phone;
	}
	public void setMobile_phone(String mobile_phone) {
		this.mobile_phone = mobile_phone;
	}
	public void setSosok1(String sosok1) {
		this.sosok1 = sosok1;
	}
	public void setSosok2(String sosok2) {
		this.sosok2 = sosok2;
	}
	public void setSosok3(String sosok3) {
		this.sosok3 = sosok3;
	}
	public void setSosok4(String sosok4) {
		this.sosok4 = sosok4;
	}
	public void setJikwi(String jikwi) {
		this.jikwi = jikwi;
	}
	public void setJikmu(String jikmu) {
		this.jikmu = jikmu;
	}
	public void setCompany(String company) {
		this.company = company;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
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
	
	public String getEmail() {
		return email;
	}
	public String getHome_postcode() {
		return home_postcode;
	}
	public String getHome_addr1() {
		return home_addr1;
	}
	public String getHome_phone() {
		return home_phone;
	}
	public String getMobile_phone() {
		return mobile_phone;
	}
	public String getSosok1() {
		return sosok1;
	}
	public String getSosok2() {
		return sosok2;
	}
	public String getSosok3() {
		return sosok3;
	}
	public String getSosok4() {
		return sosok4;
	}
	public String getJikwi() {
		return jikwi;
	}
	public String getJikmu() {
		return jikmu;
	}
	public String getCompany() {
		return company;
	}
	public String getRegdate() {
		return regdate;
	}	
}
package qmtm.tman;

public class UserInfoBean {
	private String name;
	private String email;
	private String home_addr1;
	private String home_addr2;
	private String home_phone;
	private String mobile_phone;
	private String regdate;
	private String password;
	private String sosok1;
	private String sosok2;
	private String sosok3;
	private String sosok4;
	private String jikwi;
	private String jikmu;
	private String company;

	public UserInfoBean() {
		this.name = "";
		this.email = "";
		this.home_addr1 = "";
		this.home_addr2 = "";
		this.home_phone = "";
		this.mobile_phone = "";
		this.regdate = "";
		this.password = "";
		this.sosok1 = "";
		this.sosok2 = "";
		this.sosok3 = "";
		this.sosok4 = "";
		this.jikwi = "";
		this.jikmu = "";
		this.company = "";
	}

	public void setName(String name) {
		this.name = name;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public void setHome_addr1(String home_addr1) {
		this.home_addr1 = home_addr1;
	}
	public void setHome_addr2(String home_addr2) {
		this.home_addr2 = home_addr2;
	}
	public void setHome_phone(String home_phone) {
		this.home_phone = home_phone;
	}
	public void setMobile_phone(String mobile_phone) {
		this.mobile_phone = mobile_phone;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	public void setPassword(String password) {
		this.password = password;
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
	public String getName() {
		return name;
	}
	public String getEmail() {
		return email;
	}
	public String getHome_addr1() {
		if(home_addr1 == null) {
			home_addr1 = "";
		}
		return home_addr1;
	}
	public String getHome_addr2() {
		if(home_addr2 == null) {
			home_addr2 = "";
		}		
		return home_addr2;
	}
	public String getHome_phone() {
		if(home_phone == null) {
			home_phone = "";
		}
		return home_phone;
	}
	public String getMobile_phone() {
		if(mobile_phone == null) {
			mobile_phone = "";
		}
		return mobile_phone;
	}
	
	public String getRegdate() {
		return regdate;
	}
	public String getPassword() {
		return password;
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
}

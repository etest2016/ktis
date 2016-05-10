package qmtm.tman;

public class UserInfoBean {
	private String name;
	private String email;
	private String home_phone;
	private String mobile_phone;
	private String regdate;
	private String password;
	private String sosok1;
	private String sosok2;
	private String level;

	public UserInfoBean() {
		this.name = "";
		this.email = "";
		this.home_phone = "";
		this.mobile_phone = "";
		this.regdate = "";
		this.password = "";
		this.sosok1 = "";
		this.sosok2 = "";
		this.level = "";
	}

	public void setName(String name) {
		this.name = name;
	}
	public void setEmail(String email) {
		this.email = email;
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
	public void setLevel(String level) {
		this.level = level;
	}
	public String getName() {
		return name;
	}
	public String getEmail() {
		return email;
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
	public String getLevel() {
		return level;
	}
}

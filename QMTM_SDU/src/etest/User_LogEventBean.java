package etest;

public class User_LogEventBean {
	private String id_exam;

	private String userid;

	private String id_activity_type;

	private String user_ip;

	private String browser;

	private String date_time;

	public User_LogEventBean() {
	}

	public void setId_exam(String id_exam) {
		this.id_exam = id_exam;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public void setId_activity_type(String id_activity_type) {
		this.id_activity_type = id_activity_type;
	}

	public void setUser_ip(String user_ip) {
		this.user_ip = user_ip;
	}

	public void setBrowser(String browser) {
		this.browser = browser;
	}

	public void setDate_time(String date_time) {
		this.date_time = date_time;
	}

	public String getId_exam() {
		return id_exam;
	}

	public String getUserid() {
		return userid;
	}

	public String getId_activity_type() {
		return id_activity_type;
	}

	public String getUser_ip() {
		return user_ip;
	}

	public String getBrowser() {
		return browser;
	}

	public String getDate_time() {
		return date_time;
	}
}

package qmtm;

public class ProfListBean {
		
	private String userid;	
	private String name;	
	private String subject_code;
	
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public void setName(String name) {
		this.name = name;
	}
	public void setSubject_code(String subject_code) {
		this.subject_code = subject_code;
	}
	
	public String getUserid() {
		return userid;
	}
	public String getName() {
		return name;
	}
	public String getSubject_code() {
		return subject_code;
	}
}
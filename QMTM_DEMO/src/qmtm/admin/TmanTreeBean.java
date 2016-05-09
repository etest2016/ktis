package qmtm.admin;

import java.sql.Timestamp;

public class TmanTreeBean {
	
	private String id_course;
	private String course;
	private String yn_valid;
	private String regdate;
	private String id_category;
	private String id_subject;
	private String subject;
	private String cnt;
	private String years;

	public TmanTreeBean() {
	}
		
	public void setId_course(String id_course) {
		this.id_course = id_course;
	}
	public void setCourse(String course) {
		this.course = course;
	}
	public void setYn_valid(String yn_valid) {
		this.yn_valid = yn_valid;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	public void setId_category(String id_category) {
		this.id_category = id_category;
	}
	public void setId_subject(String id_subject) {
		this.id_subject = id_subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public void setCnt(String cnt) {
		this.cnt = cnt;
	}
	public void setYears(String years) {
		this.years = years;
	}
		
	public String getId_course() {
		return id_course;
	}
	public String getCourse() {
		return course;
	}
	public String getYn_valid() {
		return yn_valid;
	}	
	public String getRegdate() {
		return regdate;
	}	
	public String getId_category() {
		return id_category;
	}	
	public String getId_subject() {
		return id_subject;
	}
	public String getSubject() {
		return subject;
	}	
	public String getCnt() {
		return cnt;
	}
	public String getYears() {
		return years;
	}
}
package qmtm.admin.subject;

import java.sql.Timestamp;

public class SubjectBean {
	
	private String id_course;
	private String id_subject;
	private String subject;
	private int subject_order;
	private String regdate;
	private String yn_valid;
	
	public SubjectBean() {
	}
		
	public void setId_course(String id_course) {
		this.id_course = id_course;
	}
	public void setId_subject(String id_subject) {
		this.id_subject = id_subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}	
	public void setSubject_order(int subject_order) {
		this.subject_order = subject_order;
	}	
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	public void setYn_valid(String yn_valid) {
		this.yn_valid = yn_valid;
	}

	public String getId_course() {
		return id_course;
	}
	public String getId_subject() {
		return id_subject;
	}
	public String getSubject() {
		return subject;
	}
	public int getSubject_order() {
		return subject_order;
	}
	public String getRegdate() {
		return regdate;
	}	
	public String getYn_valid() {
		return yn_valid;
	}	
}
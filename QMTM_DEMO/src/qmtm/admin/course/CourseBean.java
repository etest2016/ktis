package qmtm.admin.course;

import java.sql.Timestamp;

public class CourseBean {
	
	private String id_course;
	private String course;
	private String yn_valid;
	private String regdate;

	public CourseBean() {
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
}
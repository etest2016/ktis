package qmtm.admin.etc;

import java.sql.Timestamp;

public class GroupKindBean {
	
	private String id_category;
	private String category;
	private String regdate;
	private String id_course;
	private String course;

	public GroupKindBean() {
	}
		
	public void setId_category(String id_category) {
		this.id_category = id_category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	public void setId_course(String id_course) {
		this.id_course = id_course;
	}
	public void setCourse(String course) {
		this.course = course;
	}
		
	public String getId_category() {
		return id_category;
	}
	public String getCategory() {
		return category;
	}
	public String getRegdate() {
		return regdate;
	}
	public String getId_course() {
		return id_course;
	}
	public String getCourse() {
		return course;
	}
}
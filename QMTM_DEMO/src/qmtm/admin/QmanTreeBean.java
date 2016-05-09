package qmtm.admin;

import java.sql.Timestamp;

public class QmanTreeBean {
	
	private String id_q_subject;
	private String q_subject;
	private String yn_valid;
	private String regdate;
	private String id_q_chapter;
	private String chapter;
	private String id_category;
	private String category;
	private String years;

	public QmanTreeBean() {
	}
		
	public void setId_q_subject(String id_q_subject) {
		this.id_q_subject = id_q_subject;
	}
	public void setQ_subject(String q_subject) {
		this.q_subject = q_subject;
	}
	public void setYn_valid(String yn_valid) {
		this.yn_valid = yn_valid;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	public void setId_q_chapter(String id_q_chapter) {
		this.id_q_chapter = id_q_chapter;
	}
	public void setChapter(String chapter) {
		this.chapter = chapter;
	}
	public void setId_category(String id_category) {
		this.id_category = id_category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public void setYears(String years) {
		this.years = years;
	}
		
	public String getId_q_subject() {
		return id_q_subject;
	}
	public String getQ_subject() {
		return q_subject;
	}
	public String getYn_valid() {
		return yn_valid;
	}	
	public String getRegdate() {
		return regdate;
	}	
	public String getId_q_chapter() {
		return id_q_chapter;
	}	
	public String getChapter() {
		return chapter;
	}
	public String getId_category() {
		return id_category;
	}
	public String getCategory() {
		return category;
	}
	public String getYears() {
		return years;
	}
}
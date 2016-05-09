package qmtm.admin.qman;

import java.sql.Timestamp;

public class ChapterQmanBean {
	
	private String id_q_subject;
	private String id_q_chapter;
	private String chapter;
	private int chapter_order;
	private String yn_valid;
	private String regdate;
	private String term_id;
	
	public ChapterQmanBean() {
	}
		
	public void setId_q_subject(String id_q_subject) {
		this.id_q_subject = id_q_subject;
	}
	public void setId_q_chapter(String id_q_chapter) {
		this.id_q_chapter = id_q_chapter;
	}
	public void setChapter(String chapter) {
		this.chapter = chapter;
	}	
	public void setChapter_order(int chapter_order) {
		this.chapter_order = chapter_order;
	}	
	public void setYn_valid(String yn_valid) {
		this.yn_valid = yn_valid;
	}	
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	public void setTerm_id(String term_id) {
		this.term_id = term_id;
	}

	public String getId_q_subject() {
		return id_q_subject;
	}
	public String getId_q_chapter() {
		return id_q_chapter;
	}
	public String getChapter() {
		return chapter;
	}
	public int getChapter_order() {
		return chapter_order;
	}
	public String getYn_valid() {
		return yn_valid;
	}
	public String getRegdate() {
		return regdate;
	}	
	public String getTerm_id() {
		return term_id;
	}	
}
package qmtm.tman.exam;

import java.sql.Timestamp;

public class ExamUtilBean {
	private String id_q_subject;
	private String q_subject;
	private String id_q_chapter;
	private String chapter;
	private String subject_id;

	public void setId_q_subject(String id_q_subject) {
		this.id_q_subject = id_q_subject;
	}
	public void setQ_subject(String q_subject) {
		this.q_subject = q_subject;
	}
	public void setId_q_chapter(String id_q_chapter) {
		this.id_q_chapter = id_q_chapter;
	}
	public void setChapter(String chapter) {
		this.chapter = chapter;
	}
	public void setSubject_id(String subject_id) {
		this.subject_id = subject_id;
	}
	
	public String getId_q_subject() {
		return id_q_subject;
	}	
	public String getQ_subject() {
		return q_subject;
	}
	public String getId_q_chapter() {
		return id_q_chapter;
	}	
	public String getChapter() {
		return chapter;
	}
	public String getSubject_id() {
		return subject_id;
	}
}

package qmtm.tman.exam;

import java.sql.Timestamp;

public class ExamUtilBean {
	private String id_course;
	private String course;
	private String id_q_subject;
	private String q_subject;
	private String id_q_chapter;
	private String chapter;
	private String subject_id;

	private String id_exam;
	private String title;

	private String id_category;

	private String open_year;
	private String open_month;

	public void setId_course(String id_course) {
		this.id_course = id_course;
	}
	public void setCourse(String course) {
		this.course = course;
	}
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
	public void setId_exam(String id_exam) {
		this.id_exam = id_exam;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public void setId_category(String id_category) {
		this.id_category = id_category;
	}
	public void setOpen_year(String open_year) {
		this.open_year = open_year;
	}
	public void setOpen_month(String open_month) {
		this.open_month = open_month;
	}
	
	public String getId_course() {
		return id_course;
	}	
	public String getCourse() {
		return course;
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
	public String getId_exam() {
		return id_exam;
	}
	public String getTitle() {
		return title;
	}
	public String getId_category() {
		return id_category;
	}
	public String getOpen_year() {
		return open_year;
	}
	public String getOpen_month() {
		return open_month;
	}
}

package qmtm.admin.tman;

public class SubjectTmanBean {
	
	private String id_course;
	private String id_subject;
	private String subject;
	private int subject_order;
	private String regdate;
	private String yn_valid;
	private String course;
	private String id_category;
	private String open_year;
	private String open_month;
	private String exam_date;
	private String exam_start_hour;
	private String exam_start_minute;
	private String exam_end_hour;
	private String exam_end_minute;
	private String exam_time;
	
	public SubjectTmanBean() {
	}
		
	public void setExam_date(String exam_date) {
		this.exam_date = exam_date;
	}
	public void setExam_start_hour(String exam_start_hour) {
		this.exam_start_hour = exam_start_hour;
	}
	public void setExam_start_minute(String exam_start_minute) {
		this.exam_start_minute = exam_start_minute;
	}
	public void setExam_end_hour(String exam_end_hour) {
		this.exam_end_hour = exam_end_hour;
	}
	public void setExam_end_minute(String exam_end_minute) {
		this.exam_end_minute = exam_end_minute;
	}
	public void setExam_time(String exam_time) {
		this.exam_time = exam_time;
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
	public void setCourse(String course) {
		this.course = course;
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

	public String getExam_date() {
		return exam_date;
	}
	public String getExam_start_hour() {
		return exam_start_hour;
	}
	public String getExam_start_minute() {
		return exam_start_minute;
	}
	public String getExam_end_hour() {
		return exam_end_hour;
	}
	public String getExam_end_minute() {
		return exam_end_minute;
	}
	public String getExam_time() {
		return exam_time;
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
	public String getCourse() {
		return course;
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
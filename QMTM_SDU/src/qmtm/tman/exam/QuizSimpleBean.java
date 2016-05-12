package qmtm.tman.exam;

public class QuizSimpleBean {
	public QuizSimpleBean() {
		
	}
	
	private String id_exam;
	private String id_course;
	private String course_year;
	private String course_no;
	private int jucha;
	private String title;
	private int limittime;
	private int qcntperpage;
	private String yn_enable;
	private String userid;

	public String getId_exam() {
		return id_exam;
	}
	public void setId_exam(String id_exam) {
		this.id_exam = id_exam;
	}
	public String getId_course() {
		return id_course;
	}
	public void setId_course(String id_course) {
		this.id_course = id_course;
	}
	public String getCourse_year() {
		return course_year;
	}
	public void setCourse_year(String course_year) {
		this.course_year = course_year;
	}
	public String getCourse_no() {
		return course_no;
	}
	public void setCourse_no(String course_no) {
		this.course_no = course_no;
	}
	public int getJucha() {
		return jucha;
	}
	public void setJucha(int jucha) {
		this.jucha = jucha;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public int getLimittime() {
		return limittime;
	}
	public void setLimittime(int limittime) {
		this.limittime = limittime;
	}
	public int getQcntperpage() {
		return qcntperpage;
	}
	public void setQcntperpage(int qcntperpage) {
		this.qcntperpage = qcntperpage;
	}
	public String getYn_enable() {
		return yn_enable;
	}
	public void setYn_enable(String yn_enable) {
		this.yn_enable = yn_enable;
	}

	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	
	
	
}

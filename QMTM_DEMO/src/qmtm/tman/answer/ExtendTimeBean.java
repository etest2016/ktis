package qmtm.tman.answer;

import java.sql.Timestamp;

public class ExtendTimeBean {

	private String id_exam;
	private String userid;
	private String yn_sametime;
	private Timestamp exam_start1;
	private Timestamp exam_end1;
	private Timestamp login_start;
	private Timestamp login_end;

	private String name;
	private String ext_reason;
	private int ext_min;
	private String yn_start;
	private String regdate;
	
	public ExtendTimeBean() {
	}
		
	public void setId_exam(String id_exam) {
		this.id_exam = id_exam;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public void setYn_sametime(String yn_sametime) {
		this.yn_sametime = yn_sametime;
	}
	public void setExam_start1(Timestamp exam_start1) {
		this.exam_start1 = exam_start1;
	}
	public void setExam_end1(Timestamp exam_end1) {
		this.exam_end1 = exam_end1;
	}	
	public void setLogin_start(Timestamp login_start) {
		this.login_start = login_start;
	}
	public void setLogin_end(Timestamp login_end) {
		this.login_end = login_end;
	}

	public void setName(String name) {
		this.name = name;
	}
	public void setExt_reason(String ext_reason) {
		this.ext_reason = ext_reason;
	}
	public void setExt_min(int ext_min) {
		this.ext_min = ext_min;
	}
	public void setYn_start(String yn_start) {
		this.yn_start = yn_start;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}

	public String getId_exam() {
		return id_exam;
	}
	public String getUserid() {
		return userid;
	}
	public String getYn_sametime() {
		return yn_sametime;
	}
	public Timestamp getExam_start1() {
		return exam_start1;
	}
	public Timestamp getExam_end1() {
		return exam_end1;
	}
	public Timestamp getLogin_start() {
		return login_start;
	}
	public Timestamp getLogin_end() {
		return login_end;
	}

	public String getName() {
		return name;
	}
	public String getExt_reason() {
		return ext_reason;
	}
	public int getExt_min() {
		return ext_min;
	}
	public String getYn_start() {
		return yn_start;
	}
	public String getRegdate() {
		return regdate;
	}
}
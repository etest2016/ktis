package qmtm.tman.answer;

import java.sql.Timestamp;

public class PersonalTime2Bean {
		
	private String yn_sametime;
	private Timestamp exam_start1;
	private Timestamp exam_end1;
	private Timestamp login_start;
	private Timestamp login_end;

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
}
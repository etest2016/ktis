package etest;

public class User_LogAnswerBean {
	private String id_exam;

	private String userid;

	private String nr_q;

	private String id_q;

	private String answers;

	private String remain_time;

	private String date_time;

	public User_LogAnswerBean() {
	}

	public void setId_exam(String id_exam) {
		this.id_exam = id_exam;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public void setNr_q(String nr_q) {
		this.nr_q = nr_q;
	}

	public void setId_q(String id_q) {
		this.id_q = id_q;
	}

	public void setAnswers(String answers) {
		this.answers = answers;
	}

	public void setRemain_time(String remain_time) {
		this.remain_time = remain_time;
	}

	public void setDate_time(String date_time) {
		this.date_time = date_time;
	}

	public String getId_exam() {
		return id_exam;
	}

	public String getUserid() {
		return userid;
	}

	public String getNr_q() {
		return nr_q;
	}

	public String getId_q() {
		return id_q;
	}

	public String getAnswers() {
		return answers;
	}

	public String getRemain_time() {
		return remain_time;
	}

	public String getDate_time() {
		return date_time;
	}
}

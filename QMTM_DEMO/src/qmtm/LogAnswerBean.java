package qmtm;

public class LogAnswerBean {
	private String id_exam;

	private String userid;

	private int nr_q;

	private String id_q;

	private String answers;

	private String remain_time;

	private String date_time;

	private String ex_order;
	
	private int id_qtype;

	public LogAnswerBean() {
	}

	public void setId_exam(String id_exam) {
		this.id_exam = id_exam;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public void setNr_q(int nr_q) {
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

	public void setEx_order(String ex_order) {
		this.ex_order = ex_order;
	}

	public void setId_qtype(int id_qtype) {
		this.id_qtype = id_qtype;
	}

	public String getId_exam() {
		return id_exam;
	}

	public String getUserid() {
		return userid;
	}

	public int getNr_q() {
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

	public String getEx_order() {
		return ex_order;
	}

	public int getId_qtype() {
		return id_qtype;
	}
}

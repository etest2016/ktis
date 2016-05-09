package qmtm.tman.answer;

public class PersonalTimeBean {
		
	private String start_time;	
	private String end_time;	
	private long remain_time;
	private int exmno;

	private String yn_sametime;
	private String exam_start1;
	private String exam_end1;
	private String login_start;
	private String login_end;

	private String userid;
	private String name;
	private String regdate;
		
	public void setStart_time(String start_time) {
		this.start_time = start_time;
	}
	public void setEnd_time(String end_time) {
		this.end_time = end_time;
	}
	public void setRemain_time(long remain_time) {
		this.remain_time = remain_time;
	}
	public void setExmno(int exmno) {
		this.exmno = exmno;
	}

	public void setYn_sametime(String yn_sametime) {
		this.yn_sametime = yn_sametime;
	}
	public void setExam_start1(String exam_start1) {
		this.exam_start1 = exam_start1;
	}
	public void setExam_end1(String exam_end1) {
		this.exam_end1 = exam_end1;
	}	
	public void setLogin_start(String login_start) {
		this.login_start = login_start;
	}
	public void setLogin_end(String login_end) {
		this.login_end = login_end;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public void setName(String name) {
		this.name = name;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
		
	public String getStart_time() {
		return start_time;
	}
	public String getEnd_time() {
		return end_time;
	}
	public long getRemain_time() {
		return remain_time;
	}
	public int getExmno() {
		return exmno;
	}

	public String getYn_sametime() {
		return yn_sametime;
	}
	public String getExam_start1() {
		return exam_start1;
	}
	public String getExam_end1() {
		return exam_end1;
	}
	public String getLogin_start() {
		return login_start;
	}
	public String getLogin_end() {
		return login_end;
	}

	public String getUserid() {
		return userid;
	}
	public String getName() {
		return name;
	}
	public String getRegdate() {
		return regdate;
	}
}
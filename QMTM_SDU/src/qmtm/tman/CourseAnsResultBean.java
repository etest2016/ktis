package qmtm.tman;

public class CourseAnsResultBean {
	private String userid;
	private String username;
	private String sosok1;
	private String sosok2;
	private int total;
	private String success;
	private String exam_title;
	
	public CourseAnsResultBean() {
	}

	public String getUserid() {
		return userid;
	}

	public String getUsername() {
		return username;
	}

	public String getSosok1() {
		return sosok1;
	}

	public String getSosok2() {
		return sosok2;
	}

	public int getTotal() {
		return total;
	}

	public String getSuccess() {
		return success;
	}

	public String getExam_title() {
		return exam_title;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public void setSosok1(String sosok1) {
		this.sosok1 = sosok1;
	}

	public void setSosok2(String sosok2) {
		this.sosok2 = sosok2;
	}

	public void setTotal(int total) {
		this.total = total;
	}

	public void setSuccess(String success) {
		this.success = success;
	}

	public void setExam_title(String exam_title) {
		this.exam_title = exam_title;
	}

	@Override
	public String toString() {
		return "CourseAnsResultBean [userid=" + userid + ", username="
				+ username + ", sosok1=" + sosok1 + ", sosok2=" + sosok2
				+ ", total=" + total + ", pass=" + success + ", exam_title="
				+ exam_title + "]";
	}
	
	
}

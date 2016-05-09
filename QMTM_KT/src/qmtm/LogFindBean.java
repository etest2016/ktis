package qmtm;

public class LogFindBean {
		
	private String userid;
	private String answer;
	private int nr_set;
	private String nr_q;
	private String userans1;
	private String userans2;
	private String userans3;
	
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public void setAnswer(String answer) {
		this.answer = answer;
	}
	public void setNr_set(int nr_set) {
		this.nr_set = nr_set;
	}
	public void setNr_q(String nr_q) {
		this.nr_q = nr_q;
	}
	public void setUserans1(String userans1) {
		this.userans1 = userans1;
	}
	public void setUserans2(String userans2) {
		this.userans2 = userans2;
	}
	public void setUserans3(String userans3) {
		this.userans3 = userans3;
	}
	
	public String getUserid() {
		return userid;
	}
	public String getAnswer() {
		return answer;
	}
	public int getNr_set() {
		return nr_set;
	}
	public String getNr_q() {
		return nr_q;
	}
	public String getUserans1() {
		return userans1;
	}
	public String getUserans2() {
		return userans2;
	}
	public String getUserans3() {
		return userans3;
	}
}
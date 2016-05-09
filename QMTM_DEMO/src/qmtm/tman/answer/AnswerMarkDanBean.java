package qmtm.tman.answer;

public class AnswerMarkDanBean {
	private int nr_q;	
	private double allotting;
	private String q;
	private String ca;
	private String answers;
	private String oxs;
	private String points;
	private String userid;
	private double score;
	
	public void setNr_q(int nr_q) {
		this.nr_q = nr_q;
	}
	public void setAllotting(double allotting) {
		this.allotting = allotting;
	}
	public void setQ(String q) {
		this.q = q;
	}
	public void setCa(String ca) {
		this.ca = ca;
	}
	public void setAnswers(String answers) {
		this.answers = answers;
	}
	public void setOxs(String oxs) {
		this.oxs = oxs;
	}
	public void setPoints(String points) {
		this.points = points;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public void setScore(double score) {
		this.score = score;
	}
	
	public int getNr_q() {
		return nr_q;
	}
	public double getAllotting() {
		return allotting;
	}
	public String getQ() {
		return q;
	}
	public String getCa() {
		return ca;
	}
	public String getAnswers() {
		return answers;
	}
	public String getOxs() {
		return oxs;
	}
	public String getPoints() {
		return points;
	}
	public String getUserid() {
		return userid;
	}
	public double getScore() {
		return score;
	}
}	
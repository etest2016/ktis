package qmtm.tman.answer;

public class UserQScoreBean {

	private long id_q;
	private int nr_set;
	private String answers;
	private String oxs;
	private String title;
	private String userid;
	private String points;
	private int nr_q;	
	private double allotting;
	private int qcount;
	private String name;
	
	public UserQScoreBean() {
	}
	
	public void setId_q(long id_q) {
		this.id_q = id_q;
	}	
	public void setNr_set(int nr_set) {
		this.nr_set = nr_set;
	}
	public void setAnswers(String answers) {
		this.answers = answers;
	}
	public void setOxs(String oxs) {
		this.oxs = oxs;
	}	
	public void setTitle(String title) {
		this.title = title;
	}	
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public void setPoints(String points) {
		this.points = points;
	}
	public void setNr_q(int nr_q) {
		this.nr_q = nr_q;
	}	
	public void setAllotting(double allotting) {
		this.allotting = allotting;
	}
	public void setQcount(int qcount) {
		this.qcount = qcount;
	}
	public void setName(String name) {
		this.name = name;
	}
		
	public long getId_q() {
		return id_q;
	}	
	public int getNr_set() {
		return nr_set;
	}
	public String getAnswers() {
		return answers;
	}
	public String getOxs() {
		return oxs;
	}	
	public String getTitle() {
		return title;
	}
	public String getUserid() {
		return userid;
	}
	public String getPoints() {
		return points;
	}
	public int getNr_q() {
		return nr_q;
	}
	public double getAllotting() {
		return allotting;
	}
	public int getQcount() {
		return qcount;
	}
	public String getName() {
		return name;
	}	
}	
package qmtm.admin;

import java.sql.Timestamp;

public class MemberStaticBean {

	private String userid;
	private String name;
	private String sosok2;
	private String sosok3;
	private String sosok4;
	private String title;
	private double p_score;
	private double t_avg;
	private int p_rank;
		
	public MemberStaticBean() {
	}
		
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public void setName(String name) {
		this.name = name;
	}	
	public void setSosok2(String sosok2) {
		this.sosok2 = sosok2;
	}
	public void setSosok3(String sosok3) {
		this.sosok3 = sosok3;
	}
	public void setSosok4(String sosok4) {
		this.sosok4 = sosok4;
	}	
	public void setTitle(String title) {
		this.title = title;
	}
	public void setP_score(double p_score) {
		this.p_score = p_score;
	}
	public void setT_avg(double t_avg) {
		this.t_avg = t_avg;
	}
	public void setP_rank(int p_rank) {
		this.p_rank = p_rank;
	}

	public String getUserid() {
		return userid;
	}	
	public String getName() {
		return name;
	}
	public String getSosok2() {
		return sosok2;
	}
	public String getSosok3() {
		return sosok3;
	}
	public String getSosok4() {
		return sosok4;
	}
	public String getTitle() {
		return title;
	}
	public double getP_score() {
		return p_score;
	}
	public double getT_avg() {
		return t_avg;
	}
	public int getP_rank() {
		return p_rank;
	}	
}
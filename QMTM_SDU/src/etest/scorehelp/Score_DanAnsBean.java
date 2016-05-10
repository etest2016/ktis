package etest.scorehelp;

import java.sql.*;

// for exam/myTest.jsp

public class Score_DanAnsBean
{
	private String q;
	private String ca;
	private double allotting;
	private String answer;
	private int cnt;
	private double score;
	private int cacount;
	private String userid;
	private String name;

    public Score_DanAnsBean()
    {
		q = "";
		ca = "";
		allotting = 0.0;
		answer = "";
		cnt = 0;
		score = 0;
		cacount = 0;
		userid = "";
		name = "";
    }

    public void setQ(String pQ) {
        this.q = pQ;
    }
	public void setCa(String pCa) {
		this.ca = pCa;
	}
	public void setAllotting(double pAllotting) {
		this.allotting = pAllotting;
	}
	public void setAnswer(String pAnswer) {
		this.answer = pAnswer;
	}
	public void setCnt(int pCnt) {
		this.cnt = pCnt;
	}
	public void setScore(double pscore) {
		this.score = pscore;
	}
	public void setCacount(int cacount) {
		this.cacount = cacount;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public void setName(String name) {
		this.name = name;
	}

	public String getQ() {
        return q;
    }
	public String getCa() {
		return ca;
	}
	public double getAllotting() {
		return allotting;
	}	
	public String getAnswer() {
		return answer;
	}
	public int getCnt() {
		return cnt;
	}	
	public double getScore() {
		return score;
	}
	public double getCacount() {
		return cacount;
	}
	public String getUserid() {
		return userid;
	}		
	public String getName() {
		return name;
	}
	
}

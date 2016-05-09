package etest.scorehelp;

import java.sql.*;

// for exam/myTest.jsp

public class Score_DanAnsBean3
{
	private String q;
	private String ca;
	private double allotting;
	private String answer;
	private int cnt;
	private double score;
	private int usercount;

    public Score_DanAnsBean3()
    {
		q = "";
		ca = "";
		allotting = 0.0;
		answer = "";
		cnt = 0;
		score = 0;
		usercount = 0;
    }

    public void setQ(String pQ) {
        q = pQ;
    }

	public String getQ() {
        return q;
    }

	public void setCa(String pCa) {
		ca = pCa;
	}

	public String getCa() {
		return ca;
	}

	public void setAllotting(double pAllotting) {
		allotting = pAllotting;
	}

	public double getAllotting() {
		return allotting;
	}

	public void setAnswer(String pAnswer) {
		answer = pAnswer;
	}

	public String getAnswer() {
		return answer;
	}

	public void setCnt(int pCnt) {
		cnt = pCnt;
	}

	public int getCnt() {
		return cnt;
	}

	public void setScore(double pscore) {
		score = pscore;
	}

	public double getScore() {
		return score;
	}

	public void setUsercount(int pusercount) {
		usercount = pusercount;
	}

	public int getUsercount() {
		return usercount;
	}

	
}

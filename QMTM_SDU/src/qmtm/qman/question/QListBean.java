package qmtm.qman.question;

import java.sql.Timestamp;

public class QListBean {

	private String q_subject;
	private String id_q;
	private String id_qtype;
	private String qtype;
	private String q;
	private String ca;
	private String allotting;
	private String refs;
	private String regdate;
	private int cnt;
	private String difficulty;
	
	private int excount;
	private int cacount;	
	private double correct_pct;
	
	private String id_subject;
	private String id_chapter;

	public QListBean() {
	}

	public void setQ_subject(String q_subject) {
		this.q_subject = q_subject;
	}
	public void setId_q(String id_q) {
		this.id_q = id_q;
	}
	public void setId_qtype(String id_qtype) {
		this.id_qtype = id_qtype;
	}
	public void setQtype(String qtype) {
		this.qtype = qtype;
	}
	public void setQ(String q) {
		this.q = q;
	}
	public void setCa(String ca) {
		this.ca = ca;
	}
	public void setAllotting(String allotting) {
		this.allotting = allotting;
	}
	public void setRefs(String refs) {
		this.refs = refs;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	public void setDifficulty(String difficulty) {
		this.difficulty = difficulty;
	}	
	public void setExcount(int excount) {
		this.excount = excount;
	}
	public void setCacount(int cacount) {
		this.cacount = cacount;
	}	
	public void setCorrect_pct(double correct_pct) {
		this.correct_pct = correct_pct;
	}	
	public void setId_subject(String id_subject) {
		this.id_subject = id_subject;
	}
	public void setId_chapter(String id_chapter) {
		this.id_chapter = id_chapter;
	}
	
	public String getQ_subject() {
		return q_subject;
	}
	public String getId_q() {
		return id_q;
	}
	public String getId_qtype() {
		return id_qtype;
	}
	public String getQtype() {
		return qtype;
	}
	public String getQ() {
		return q;
	}
	public String getCa() {
		return ca;
	}
	public String getAllotting() {
		return allotting;
	}
	public String getRefs() {
		return refs;
	}
	public String getRegdate() {
		return regdate;
	}
	public int getCnt() {
		return cnt;
	}
	public String getDifficulty() {
		return difficulty;
	}	
	public int getExcount() {
		return excount;
	}
	public int getCacount() {
		return cacount;
	}	
	public double getCorrect_pct() {
		return correct_pct;
	}	
	public String getId_subject() {
		return id_subject;
	}
	public String getId_chapter() {
		return id_chapter;
	}
}
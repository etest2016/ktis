package qmtm.tman.exam;

import java.sql.Timestamp;

public class QchangeBean {

	private String q_subject;
	private String id_q;
	private String id_qtype;
	private String qtype;
	private String q;
	private String ex1;
	private String ex2;
	private String ex3;
	private String ex4;
	private String ex5;
	private String ca;
	private String allotting;
	private String refs;
	private String regdate;
	private String cnt;
	private String difficulty;
	
	private String excount;
	private String cacount;	
	private String correct_pct;
	private String rownum;

	public QchangeBean() {
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
	public void setEx1(String ex1) {
		this.ex1 = ex1;
	}
	public void setEx2(String ex2) {
		this.ex2 = ex2;
	}
	public void setEx3(String ex3) {
		this.ex3 = ex3;
	}
	public void setEx4(String ex4) {
		this.ex4 = ex4;
	}
	public void setEx5(String ex5) {
		this.ex5 = ex5;
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
	public void setCnt(String cnt) {
		this.cnt = cnt;
	}
	public void setDifficulty(String difficulty) {
		this.difficulty = difficulty;
	}	
	public void setExcount(String excount) {
		this.excount = excount;
	}
	public void setCacount(String cacount) {
		this.cacount = cacount;
	}	
	public void setCorrect_pct(String correct_pct) {
		this.correct_pct = correct_pct;
	}	
	public void setRownum(String rownum) {
		this.rownum = rownum;
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
	public String getEx1() {
		return ex1;
	}
	public String getEx2() {
		return ex2;
	}
	public String getEx3() {
		return ex3;
	}
	public String getEx4() {
		return ex4;
	}
	public String getEx5() {
		return ex5;
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
	public String getCnt() {
		return cnt;
	}
	public String getDifficulty() {
		return difficulty;
	}	
	public String getExcount() {
		return excount;
	}
	public String getCacount() {
		return cacount;
	}	
	public String getCorrect_pct() {
		return correct_pct;
	}	
	public String getRownum() {
		return rownum;
	}	
}
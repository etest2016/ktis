package qmtm.tman.paper;

public class ExamOrderQBean
{
	private String id_q;
	private String id_subject;
	private String id_chapter;
	private String id_ref;
	private String id_qtype;
	private double allotting;
	private String excount;
	private int ch_qs;
	private double ch_score;
	
	public void setId_q(String id_q) {
		this.id_q = id_q;
	}
	public void setId_subject(String id_subject) {
		this.id_subject = id_subject;
	}
	public void setId_chapter(String id_chapter) {
		this.id_chapter = id_chapter;
	}
	public void setId_ref(String id_ref) {
		this.id_ref = id_ref;
	}
	public void setId_qtype(String id_qtype) {
		this.id_qtype = id_qtype;
	}
	public void setAllotting(double allotting) {
		this.allotting = allotting;
	}
	public void setExcount(String excount) {
		this.excount = excount;
	}
	public void setCh_qs(int ch_qs) {
		this.ch_qs = ch_qs;
	}
	public void setCh_score(double ch_score) {
		this.ch_score = ch_score;
	}

	public String getId_q() {
		return id_q;
	}
	public String getId_subject() {
		return id_subject;
	}
	public String getId_chapter() {
		return id_chapter;
	}
	public String getId_ref() {
		return id_ref;
	}
	public String getId_qtype() {
		return id_qtype;
	}
	public double getAllotting() {
		return allotting;
	}
	public String getExcount() {
		return excount;
	}
	public int getCh_qs() {
		return ch_qs;
	}
	public double getCh_score() {
		return ch_score;
	}
}
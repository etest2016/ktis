package qmtm.tman.paper;

public class ExamPaperQBean {

	private String id_q;
	private String id_subject;
	private String id_chapter;
	private String id_ref;
	private int id_qtype;
	private int id_difficulty;
	private double allotting;
	private int excount;

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
	public void setId_qtype(int id_qtype) {
		this.id_qtype = id_qtype;
	}
	public void setId_difficulty(int id_difficulty) {
		this.id_difficulty = id_difficulty;
	}
	public void setAllotting(double allotting) {
		this.allotting = allotting;
	}
	public void setExcount(int excount) {
		this.excount = excount;
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
	public int getId_qtype() {
		return id_qtype;
	}	
	public int getId_difficulty() {
		return id_difficulty;
	}
	public double getAllotting() {
		return allotting;
	}
	public int getExcount() {
		return excount;
	}
}
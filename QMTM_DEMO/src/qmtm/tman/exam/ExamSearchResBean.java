package qmtm.tman.exam;

public class ExamSearchResBean {

	private int id_q;
	private String id_subject;
	private String id_ref;
	private int id_qtype;
	private double allotting;
	private int id_difficulty1;
	private String q;
	private int make_cnt;
	
	public void setId_q(int id_q) {
		this.id_q = id_q;
	}
	public void setId_subject(String id_subject) {
		this.id_subject = id_subject;
	}
	public void setId_ref(String id_ref) {
		this.id_ref = id_ref;
	}
	public void setId_qtype(int id_qtype) {
		this.id_qtype = id_qtype;
	}
	public void setAllotting(double allotting) {
		this.allotting = allotting;
	}
	public void setId_difficulty1(int id_difficulty1) {
		this.id_difficulty1 = id_difficulty1;
	}
	public void setQ(String q) {
		this.q = q;
	}
	public void setMake_cnt(int make_cnt) {
		this.make_cnt = make_cnt;
	}
	
	public int getId_q() {
		return id_q;
	}
	public String getId_subject() {
		return id_subject;
	}
	public String getId_ref() {
		return id_ref;
	}
	public int getId_qtype() {
		return id_qtype;
	}
	public double getAllotting() {
		return allotting;
	}
	public int getId_difficulty1() {
		return id_difficulty1;
	}
	public String getQ() {
		return q;
	}
	public int getMake_cnt() {
		return make_cnt;
	}
}
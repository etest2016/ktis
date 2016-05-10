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
	private String yn_practice;

	private String explains;
	private String explain1;

	private String find_kwds;
	private String find_kwd1;
	
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
	public void setYn_practice(String yn_practice) {
		this.yn_practice = yn_practice;
	}
	public void setExplains(String explains) {
		this.explains = explains;
	}
	public void setExplain1(String explain1) {
		this.explain1 = explain1;
	}

	public void setFind_kwds(String find_kwds) {
		this.find_kwds = find_kwds;
	}
	public void setFind_kwd1(String find_kwd1) {
		this.find_kwd1 = find_kwd1;
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
	public String getYn_practice() {
		return yn_practice;
	}

	public String getExplains() {
		return explains;
	}
	public String getExplain1() {
		return explain1;
	}
	public String getFind_kwds() {
		return find_kwds;
	}
	public String getFind_kwd1() {
		return find_kwd1;
	}
}
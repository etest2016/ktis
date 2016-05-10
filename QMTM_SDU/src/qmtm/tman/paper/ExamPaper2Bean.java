package qmtm.tman.paper;

public class ExamPaper2Bean 
{
	private String id_exam;
	private int nr_set;
	private int nr_q;
	private int id_q;
	private String ex_order;
	private double allotting;
	private int page;
	private int q_no1;
	private int q_no2;

	public void setId_exam(String id_exam) {
		this.id_exam = id_exam;
	}
	public void setNr_set(int nr_set) {
		this.nr_set = nr_set;
	}
	public void setNr_q(int nr_q) {
		this.nr_q = nr_q;
	}
	public void setId_q(int id_q) {
		this.id_q = id_q;
	}
	public void setEx_order(String ex_order) {
		this.ex_order = ex_order;
	}
	public void setAllotting(double allotting) {
		this.allotting = allotting;
	}
	public void setPage(int page) {
		this.page = page;
	}
	public void setQ_no1(int q_no1) {
		this.q_no1 = q_no1;
	}
	public void setQ_no2(int q_no2) {
		this.q_no2 = q_no2;
	}

	public String getId_exam() {
		return id_exam;
	}
	public int getNr_set() {
		return nr_set;
	}
	public int getNr_q() {
		return nr_q;
	}
	public int getId_q() {
		return id_q;
	}
	public String getEx_order() {
		return ex_order;
	}
	public double getAllotting() {
		return allotting;
	}
	public int getPage() {
		return page;
	}
	public int getQ_no1() {
		return q_no1;
	}
	public int getQ_no2() {
		return q_no2;
	}
}
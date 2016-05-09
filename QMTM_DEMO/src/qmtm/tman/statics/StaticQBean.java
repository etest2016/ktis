package qmtm.tman.statics;

import java.text.DecimalFormat;

public class ExamStaticBean {

	private long id_q;
	private int id_qtype;
	private int id_valid_type;
	private long id_qs;
	private int nr_set;
	private String answers;
	private String oxs;
	private int o_cnt;
	private int x_cnt;
	private int ex1_cnt;
	private int ex2_cnt;
	private int ex3_cnt;
	private int ex4_cnt;
	private int ex5_cnt;
	private int ex6_cnt;
	private int ex7_cnt;
	private int ex8_cnt;
	private String qtype;
	private int excount;
	private int cacount;
	private int all_sum;
	private double o_rate;
	private String title;
	private String id_exam;
	DecimalFormat df;
	private String userid;
	private String points;
	private int nr_q;
	private String id_chapter;
	private double allotting;

	public ExamStaticBean() {
		df = new DecimalFormat(",##0.0"); 
	}
	
	public void setId_q(long id_q) {
		this.id_q = id_q;
	}
	public void setId_qtype(int id_qtype) {
		this.id_qtype = id_qtype;
	}
	public void setId_valid_type(int id_valid_type) {
		this.id_valid_type = id_valid_type;
	}
	public void setId_qs(long id_qs) {
		this.id_qs = id_qs;
	}
	public void setNr_set(int nr_set) {
		this.nr_set = nr_set;
	}
	public void setAnswers(String answers) {
		this.answers = answers;
	}
	public void setOxs(String oxs) {
		this.oxs = oxs;
	}
	public void setO_cnt(int o_cnt) {
		this.o_cnt = o_cnt;
	}
	public void setX_cnt(int x_cnt) {
		this.x_cnt = x_cnt;
	}
	public void setEx1_cnt(int ex1_cnt) {
		this.ex1_cnt = ex1_cnt;
	}
	public void setEx2_cnt(int ex2_cnt) {
		this.ex2_cnt = ex2_cnt;
	}
	public void setEx3_cnt(int ex3_cnt) {
		this.ex3_cnt = ex3_cnt;
	}
	public void setEx4_cnt(int ex4_cnt) {
		this.ex4_cnt = ex4_cnt;
	}
	public void setEx5_cnt(int ex5_cnt) {
		this.ex5_cnt = ex5_cnt;
	}
	public void setEx6_cnt(int ex6_cnt) {
		this.ex6_cnt = ex6_cnt;
	}
	public void setEx7_cnt(int ex7_cnt) {
		this.ex7_cnt = ex7_cnt;
	}
	public void setEx8_cnt(int ex8_cnt) {
		this.ex8_cnt = ex8_cnt;
	}
	public void setQtype(String qtype) {
		this.qtype = qtype;
	}
	public void setExcount(int excount) {
		this.excount = excount;
	}
	public void setCacount(int cacount) {
		this.cacount = cacount;
	}
	public void setAll_sum(int all_sum) {
		this.all_sum = all_sum;
	}
	public void setO_rate(double o_rate) {
		this.o_rate = o_rate;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public void setId_exam(String id_exam) {
		this.id_exam = id_exam;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public void setPoints(String points) {
		this.points = points;
	}
	public void setNr_q(int nr_q) {
		this.nr_q = nr_q;
	}
	public void setId_chapter(String id_chapter) {
		this.id_chapter = id_chapter;
	}
	public void setAllotting(double allotting) {
		this.allotting = allotting;
	}
	
	public long getId_q() {
		return id_q;
	}
	public int getId_qtype() {
		return id_qtype;
	}
	public int getId_valid_type() {
		return id_valid_type;
	}
	public long getId_qs() {
		return id_qs;
	}
	public int getNr_set() {
		return nr_set;
	}
	public String getAnswers() {
		return answers;
	}
	public String getOxs() {
		return oxs;
	}
	public int getO_cnt() {
		return o_cnt;
	}
	public int getX_cnt() {
		return x_cnt;
	}
	public int getEx1_cnt() {
		return ex1_cnt;
	}
	public int getEx2_cnt() {
		return ex2_cnt;
	}
	public int getEx3_cnt() {
		return ex3_cnt;
	}
	public int getEx4_cnt() {
		return ex4_cnt;
	}
	public int getEx5_cnt() {
		return ex5_cnt;
	}
	public int getEx6_cnt() {
		return ex6_cnt;
	}
	public int getEx7_cnt() {
		return ex7_cnt;
	}
	public int getEx8_cnt() {
		return ex8_cnt;
	}
	public String getQtype() {
		return qtype;
	}
	public int getExcount() {
		return excount;
	}
	public int getCacount() {
		return cacount;
	}
	public int getAll_sum() {
		return all_sum;
	}
	public double getO_rate() {
		return o_rate;
	}
	public String getTitle() {
		return title;
	}
	public String getId_exam() {
		return id_exam;
	}
	public String getUserid() {
		return userid;
	}
	public String getPoints() {
		return points;
	}
	public int getNr_q() {
		return nr_q;
	}
	public String getId_chapter() {
		return id_chapter;
	}
	public double getAllotting() {
		return allotting;
	}
}	
package qmtm.tman.exam;

public class QuizJuchaBean {
	private String id_q_subject;	
	private String id_q_chapter;	
	private int jucha;
	private String chapter;
	private String quiz_start;
	private String quiz_end;
	private int jucha_cnt;
	private double jucha_allotting;
	private String id_exam;
	private String title;
	private int qcount;
	private double allotting;
	private long limittime;

	public void setId_q_subject(String id_q_subject) {
		this.id_q_subject = id_q_subject;
	}
	public void setId_q_chapter(String id_q_chapter) {
		this.id_q_chapter = id_q_chapter;
	}
	public void setJucha(int jucha) {
		this.jucha = jucha;
	}
	public void setChapter(String chapter) {
		this.chapter = chapter;
	}
	public void setQuiz_start(String quiz_start) {
		this.quiz_start = quiz_start;
	}
	public void setQuiz_end(String quiz_end) {
		this.quiz_end = quiz_end;
	}
	public void setJucha_cnt(int jucha_cnt) {
		this.jucha_cnt = jucha_cnt;
	}
	public void setJucha_allotting(double jucha_allotting) {
		this.jucha_allotting = jucha_allotting;
	}
	public void setId_exam(String id_exam) {
		this.id_exam = id_exam;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public void setQcount(int qcount) {
		this.qcount = qcount;
	}
	public void setAllotting(double allotting) {
		this.allotting = allotting;
	}
	public void setLimittime(long limittime) {
		this.limittime = limittime;
	}

	public String getId_q_subject() {
		return id_q_subject;
	}	
	public String getId_q_chapter() {
		return id_q_chapter;
	}
	public int getJucha() {
		return jucha;
	}
	public String getChapter() {
		return chapter;
	}
	public String getQuiz_start() {
		return quiz_start;
	}
	public String getQuiz_end() {
		return quiz_end;
	}
	public int getJucha_cnt() {
		return jucha_cnt;
	}
	public double getJucha_allotting() {
		return jucha_allotting;
	}
	public String getId_exam() {
		return id_exam;
	}
	public String getTitle() {
		return title;
	}
	public int getQcount() {
		return qcount;
	}
	public double getAllotting() {
		return allotting;
	}
	public long getLimittime() {
		return limittime;
	}
}

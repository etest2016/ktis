package qmtm.paper;

import java.sql.Timestamp;

public class ExamAnsNonBean 
{
	private long id_q;
	private String userid;
	private String id_exam;
	private int nr_set;
	private String userans1;
	private String userans2;
	private String userans3;
	private String correction1;
	private String correction2;
	private String correction3;
	private double score;
	private Timestamp scoredate;
	private String score_comment;
	
	public void setId_q(long id_q) {
		this.id_q = id_q;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public void setId_exam(String id_exam) {
		this.id_exam = id_exam;
	}
	public void setNr_set(int nr_set) {
		this.nr_set = nr_set;
	}
	public void setUserans1(String userans1) {
		this.userans1 = userans1;
	}
	public void setUserans2(String userans2) {
		this.userans2 = userans2;
	}
	public void setUserans3(String userans3) {
		this.userans3 = userans3;
	}
	public void setCorrection1(String correction1) {
		this.correction1 = correction1;
	}
	public void setCorrection2(String correction2) {
		this.correction2 = correction2;
	}
	public void setCorrection3(String correction3) {
		this.correction3 = correction3;
	}
	public void setScore(double score) {
		this.score = score;
	}
	public void setScoredate(Timestamp scoredate) {
		this.scoredate = scoredate;
	}
	public void setScore_comment(String score_comment) {
		this.score_comment = score_comment;
	}
	
	public long getId_q() {
		return id_q;
	}
	public String getUserid() {
		return userid;
	}
	public String getId_exam() {
		return id_exam;
	}
	public int getNr_set() {
		return nr_set;
	}
	public String getUserans1() {
		return userans1;
	}
	public String getUserans2() {
		return userans2;
	}
	public String getUserans3() {
		return userans3;
	}
	public String getCorrection1() {
		return correction1;
	}
	public String getCorrection2() {
		return correction2;
	}
	public String getCorrection3() {
		return correction3;
	}
	public double getScore() {
		return score;
	}
	public Timestamp getScoredate() {
		return scoredate;
	}
	public String getScore_comment() {
		return score_comment;
	}	
}
package qmtm.paper;

import java.sql.Timestamp;

public class ExamAnsBean
{
	private String userid;
	private String id_exam;
	private int nr_set;
	private Timestamp start_time;
	private Timestamp end_time;
	private long remain_time;
	private String yn_end;
	private String answers;
	private String oxs;
	private String points;
	private double score;
	private double score_bak;
	private String score_log;
	
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public void setId_exam(String id_exam) {
		this.id_exam = id_exam;
	}
	public void setNr_set(int nr_set) {
		this.nr_set = nr_set;
	}
	public void setStart_time(Timestamp start_time) {
		this.start_time = start_time;
	}
	public void setEnd_time(Timestamp end_time) {
		this.end_time = end_time;
	}
	public void setRemain_time(long remain_time) {
		this.remain_time = remain_time;
	}
	public void setYn_end(String yn_end) {
		this.yn_end = yn_end;
	}
	public void setAnswers(String answers) {
		this.answers = answers;
	}
	public void setOxs(String oxs) {
		this.oxs = oxs;
	}
	public void setPoints(String points) {
		this.points = points;
	}
	public void setScore(double score) {
		this.score = score;
	}
	public void setScore_bak(double score_bak) {
		this.score_bak = score_bak;
	}
	public void setScore_log(String score_log) {
		this.score_log = score_log;
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
	public Timestamp getStart_time() {
		return start_time;
	}
	public Timestamp getEnd_time() {
		return end_time;
	}
	public long getRemain_time() {
		return remain_time;
	}
	public String getYn_end() {
		return yn_end;
	}
	public String getAnswers() {
		return answers;
	}
	public String getOxs() {
		return oxs;
	}
	public String getPoints() {
		return points;
	}
	public double getScore() {
		return score;
	}
	public double getScore_bak() {
		return score_bak;
	}
	public String getScore_log() {
		return score_log;
	}	
}
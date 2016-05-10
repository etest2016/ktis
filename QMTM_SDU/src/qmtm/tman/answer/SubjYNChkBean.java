package qmtm.tman.answer;

import java.sql.Timestamp;

public class SubjYNChkBean {

	private String id_exam;
	private String userid;
	private String name;
	private String score1;
	private String score2;
	private String success_score1;
	private String success_score2;
	private String success_yn;
	
	public void setId_exam(String id_exam) {
		this.id_exam = id_exam;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public void setName(String name) {
		this.name = name;
	}
	public void setScore1(String score1) {
		this.score1 = score1;
	}
	public void setScore2(String score2) {
		this.score2 = score2;
	}
	public void setSuccess_score1(String success_score1) {
		this.success_score1 = success_score1;
	}
	public void setSuccess_score2(String success_score2) {
		this.success_score2 = success_score2;
	}
	public void setSuccess_yn(String success_yn) {
		this.success_yn = success_yn;
	}
	
	public String getId_exam() {
		return id_exam;
	}
	public String getUserid() {
		return userid;
	}
	public String getName() {
		return name;
	}
	public String getScore1() {
		return score1;
	}
	public String getScore2() {
		return score2;
	}
	public String getSuccess_score1() {
		return success_score1;
	}
	public String getSuccess_score2() {
		return success_score2;
	}	
	public String getSuccess_yn() {
		return success_yn;
	}	
}

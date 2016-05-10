package qmtm.tman.answer;

import java.sql.Timestamp;

public class ImsiAnswerMarkBean {
	private int all_score;
	private int no_score;
	private int yes_score;
	private int all_q;

	public void setAll_score(int all_score) {
		this.all_score = all_score;
	}
	public void setNo_score(int no_score) {
		this.no_score = no_score;
	}
	public void setYes_score(int yes_score) {
		this.yes_score = yes_score;
	}
	public void setAll_q(int all_q) {
		this.all_q = all_q;
	}
	
	public int getAll_score() {
		return all_score;
	}
	public int getNo_score() {
		return no_score;
	}
	public int getYes_score() {
		return yes_score;
	}
	public int getAll_q() {
		return all_q;
	}
}

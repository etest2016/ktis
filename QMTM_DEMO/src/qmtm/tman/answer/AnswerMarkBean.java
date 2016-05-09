package qmtm.tman.answer;

import java.sql.Timestamp;

public class AnswerMarkBean {
	private long id_q;	
	private int id_qtype;
	private int cacount;
	private String q;
	private String yn_caorder;
	private String yn_case;
	private String yn_blank;

	public void setId_q(long id_q) {
		this.id_q = id_q;
	}
	public void setId_qtype(int id_qtype) {
		this.id_qtype = id_qtype;
	}
	public void setCacount(int cacount) {
		this.cacount = cacount;
	}
	public void setQ(String q) {
		this.q = q;
	}
	public void setYn_caorder(String yn_caorder) {
		this.yn_caorder = yn_caorder;
	}
	public void setYn_case(String yn_case) {
		this.yn_case = yn_case;
	}
	public void setYn_blank(String yn_blank) {
		this.yn_blank = yn_blank;
	}

	public long getId_q() {
		return id_q;
	}	
	public int getId_qtype() {
		return id_qtype;
	}
	public int getCacount() {
		return cacount;
	}
	public String getQ() {
		return q;
	}
	public String getYn_caorder() {
		return yn_caorder;
	}
	public String getYn_case() {
		return yn_case;
	}
	public String getYn_blank() {
		return yn_blank;
	}
}

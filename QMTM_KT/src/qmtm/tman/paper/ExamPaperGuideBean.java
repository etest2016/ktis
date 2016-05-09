package qmtm.tman.paper;

import java.sql.Timestamp;

public class ExamPaperGuideBean {
	
	private String id_exam;
	private int nr_q;
	private String guide_msg;

	public ExamPaperGuideBean() {
	}
		
	public void setId_exam(String id_exam) {
		this.id_exam = id_exam;
	}
	public void setNr_q(int nr_q) {
		this.nr_q = nr_q;
	}
	public void setGuide_msg(String guide_msg) {
		this.guide_msg = guide_msg;
	}
		
	public String getId_exam() {
		return id_exam;
	}
	public int getNr_q() {
		return nr_q;
	}
	public String getGuide_msg() {
		return guide_msg;
	}
}
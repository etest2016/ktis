package qmtm.admin.etc;

import java.sql.Timestamp;

public class ExamKindBean {
	
	private String id_exam_kind;
	private String exam_kind;
	private String rmk;

	public ExamKindBean() {
	}
		
	public void setId_exam_kind(String id_exam_kind) {
		this.id_exam_kind = id_exam_kind;
	}
	public void setExam_kind(String exam_kind) {
		this.exam_kind = exam_kind;
	}
	public void setRmk(String rmk) {
		this.rmk = rmk;
	}
		
	public String getId_exam_kind() {
		return id_exam_kind;
	}
	public String getExam_kind() {
		return exam_kind;
	}
	public String getRmk() {
		return rmk;
	}
}
package qmtm;

public class LoginProcBean {
	
	// 시험관련 권한
	private String pt_exam_edit;
	private String pt_exam_delete;
	private String pt_answer_edit;
	private String pt_score_edit;
	private String pt_static_edit;
	
	// 문제출제 권한
	private String pt_q_edit;
	private String pt_q_delete;

	public LoginProcBean() {
		pt_exam_edit = "Y";
		pt_exam_delete = "Y";
		pt_answer_edit = "Y";
		pt_score_edit = "Y";
		pt_static_edit = "Y";

		pt_q_edit = "Y";
		pt_q_delete = "Y";
	}
	
	public void setPt_exam_edit(String pt_exam_edit) {
		this.pt_exam_edit = pt_exam_edit;
	}
	public void setPt_exam_delete(String pt_exam_delete) {
		this.pt_exam_delete = pt_exam_delete;
	}
	public void setPt_answer_edit(String pt_answer_edit) {
		this.pt_answer_edit = pt_answer_edit;
	}
	public void setPt_score_edit(String pt_score_edit) {
		this.pt_score_edit = pt_score_edit;
	}
	public void setPt_static_edit(String pt_static_edit) {
		this.pt_static_edit = pt_static_edit;
	}
	public void setPt_q_edit(String pt_q_edit) {
		this.pt_q_edit = pt_q_edit;
	}
	public void setPt_q_delete(String pt_q_delete) {
		this.pt_q_delete = pt_q_delete;
	}
	
	public String getPt_exam_edit() {
		return pt_exam_edit;
	}
	public String getPt_exam_delete() {
		return pt_exam_delete;
	}
	public String getPt_answer_edit() {
		return pt_answer_edit;
	}
	public String getPt_score_edit() {
		return pt_score_edit;
	}
	public String getPt_static_edit() {
		return pt_static_edit;
	}
	public String getPt_q_edit() {
		return pt_q_edit;
	}
	public String getPt_q_delete() {
		return pt_q_delete;
	}		
}	
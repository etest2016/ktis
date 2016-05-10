package qmtm.admin.manager;

import java.sql.Timestamp;

public class ManagerSubjBean {
	
	private String userid;
	private String id_course;
	private String course;
	private String pt_exam_edit;
	private String pt_exam_delete;
	private String pt_answer_edit;
	private String pt_score_edit;
	private String pt_static_edit;
	private String pt_q_edit;
	private String pt_q_delete;
	private String regdate;

	public ManagerSubjBean() {
	}
		
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public void setId_course(String id_course) {
		this.id_course = id_course;
	}
	public void setCourse(String course) {
		this.course = course;
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
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	public void setPt_q_edit(String pt_q_edit) {
		this.pt_q_edit = pt_q_edit;
	}
	public void setPt_q_delete(String pt_q_delete) {
		this.pt_q_delete = pt_q_delete;
	}
		
	public String getUserid() {
		return userid;
	}
	public String getId_course() {
		return id_course;
	}
	public String getCourse() {
		return course;
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
	public String getRegdate() {
		return regdate;
	}	
}
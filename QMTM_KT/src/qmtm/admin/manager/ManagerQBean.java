package qmtm.admin.manager;

import java.sql.Timestamp;

public class ManagerQBean {
	
	private String userid;
	private String id_subject;
	private String q_subject;
	private String subject;
	private String pt_q_edit;
	private String pt_q_delete;
	private String regdate;
	private String cnt;

	public ManagerQBean() {
	}
		
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public void setId_subject(String id_subject) {
		this.id_subject = id_subject;
	}
	public void setQ_subject(String q_subject) {
		this.q_subject = q_subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public void setPt_q_edit(String pt_q_edit) {
		this.pt_q_edit = pt_q_edit;
	}
	public void setPt_q_delete(String pt_q_delete) {
		this.pt_q_delete = pt_q_delete;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;		
	}
	public void setCnt(String cnt) {
		this.cnt = cnt;
	}	
		
	public String getUserid() {
		return userid;
	}
	public String getId_subject() {
		return id_subject;
	}
	public String getQ_subject() {
		return q_subject;
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
	public String getCnt() {
		return cnt;
	}	
}
package qmtm.admin.etc;    

import java.sql.Timestamp;

public class QuseBean {
	
	private String id_q_use;
	private String q_use;
	private String rmk;

	public QuseBean() {
	}
		
	public void setId_q_use(String id_q_use) {
		this.id_q_use = id_q_use;
	}
	public void setQ_use(String q_use) {    
		this.q_use = q_use;
	}
	public void setRmk(String rmk) {
		this.rmk = rmk;
	}
		
	public String getId_q_use() {
		return id_q_use;
	}
	public String getQ_use() {
		return q_use;
	}
	public String getRmk() {
		return rmk;
	}
}
package etest.scorehelp;

import java.sql.*;

public class Score_AnsEqualBean {
	private String id_q;	
	private String q;
	private String allotting;

	public void setId_q(String id_q) {
		this.id_q = id_q;
	}
	public void setQ(String q) {
		this.q = q;
	}
	public void setAllotting(String allotting) {
		this.allotting = allotting;
	}

	public String getId_q() {
		return id_q;
	}	
	public String getQ() {
		return q;
	}
	public String getAllotting() {
		return allotting;
	}
}

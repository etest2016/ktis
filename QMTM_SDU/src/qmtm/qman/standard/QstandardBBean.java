package qmtm.qman.standard;

import java.sql.Timestamp;

public class QstandardBBean {
	
	private String id_standardb;
	private String standardb;
	private String yn_valid;
	private String regdate;
	private String id_standarda;
	
	public QstandardBBean() {
	}
		
	public void setId_standardb(String id_standardb) {
		this.id_standardb = id_standardb;
	}
	public void setStandardb(String standardb) {
		this.standardb = standardb;
	}
	public void setYn_valid(String yn_valid) {
		this.yn_valid = yn_valid;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	public void setId_standarda(String id_standarda) {
		this.id_standarda = id_standarda;
	}
			
	public String getId_standardb() {
		return id_standardb;
	}
	public String getStandardb() {
		return standardb;
	}
	public String getYn_valid() {
		return yn_valid;
	}
	public String getRegdate() {
		return regdate;
	}
	public String getId_standarda() {
		return id_standarda;
	}
}
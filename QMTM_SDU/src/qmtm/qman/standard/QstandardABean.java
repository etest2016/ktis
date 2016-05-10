package qmtm.qman.standard;

import java.sql.Timestamp;

public class QstandardABean {
	
	private String id_standarda;
	private String standarda;
	private String yn_valid;
	private String regdate;
	private String id_chapter;
	
	public QstandardABean() {
	}
		
	public void setId_standarda(String id_standarda) {
		this.id_standarda = id_standarda;
	}
	public void setStandarda(String standarda) {
		this.standarda = standarda;
	}
	public void setYn_valid(String yn_valid) {
		this.yn_valid = yn_valid;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	public void setId_chapter(String id_chapter) {
		this.id_chapter = id_chapter;
	}
			
	public String getId_standarda() {
		return id_standarda;
	}
	public String getStandarda() {
		return standarda;
	}
	public String getYn_valid() {
		return yn_valid;
	}
	public String getRegdate() {
		return regdate;
	}
	public String getId_chapter() {
		return id_chapter;
	}
}
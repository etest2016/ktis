package qmtm.admin.etc;

import java.sql.Timestamp;

public class CategoryBean {
	
	private String id_category;
	private String category;
	private String regdate;
	private String yn_valid;

	public CategoryBean() {
	}
		
	public void setId_category(String id_category) {
		this.id_category = id_category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	public void setYn_valid(String yn_valid) {
		this.yn_valid = yn_valid;
	}
		
	public String getId_category() {
		return id_category;
	}
	public String getCategory() {
		return category;
	}
	public String getRegdate() {
		return regdate;
	}
	public String getYn_valid() {
		return yn_valid;
	}
}
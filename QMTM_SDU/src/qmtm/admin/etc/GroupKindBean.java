package qmtm.admin.etc;

import java.sql.Timestamp;

public class GroupKindBean {
	
	private String id_category;
	private String category;
	private String regdate;
	private String id_midcategory;
	private String midcategory;
	private String yn_valid;

	public GroupKindBean() {
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
	public void setId_midcategory(String id_midcategory) {
		this.id_midcategory = id_midcategory;
	}
	public void setMidcategory(String midcategory) {
		this.midcategory = midcategory;
	}
	public void setYn_valid(String yn_valid) {
		if(yn_valid.equals("Y")) { 
			yn_valid = "공개";
		} else {
			yn_valid = "비공개";
		}
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
	public String getId_midcategory() {
		return id_midcategory;
	}
	public String getMidcategory() {
		return midcategory;
	}
	public String getYn_valid() {
		return yn_valid;
	}
}
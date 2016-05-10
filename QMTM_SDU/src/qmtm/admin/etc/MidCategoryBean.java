package qmtm.admin.etc;

import java.sql.Timestamp;

public class MidCategoryBean {
	
	private String id_midcategory;
	private String midcategory;
	private String regdate;
	private String yn_valid;
	private int orders;
	private String id_category;
	private String category;

	public MidCategoryBean() {
	}
		
	public void setId_midcategory(String id_midcategory) {
		this.id_midcategory = id_midcategory;
	}
	public void setMidcategory(String midcategory) {
		this.midcategory = midcategory;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	public void setYn_valid(String yn_valid) {
		this.yn_valid = yn_valid;
	}
	public void setOrders(int orders) {
		this.orders = orders;
	}
	public void setId_category(String id_category) {
		this.id_category = id_category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
		
	public String getId_midcategory() {
		return id_midcategory;
	}
	public String getMidcategory() {
		return midcategory;
	}
	public String getRegdate() {
		return regdate;
	}
	public String getYn_valid() {
		return yn_valid;
	}
	public int getOrders() {
		return orders;
	}
	public String getId_category() {
		return id_category;
	}
	public String getCategory() {
		return category;
	}
}
package qmtm.admin.etc;

public class CourseKindBean {
	
	private String id_course;
	private String course;
	private String yn_valid;
	private String regdate;
	private String id_category;
	private String id_midcategory;
	private String category;
	private String midcategory;
	private String years;
	private int orders;
	
	public CourseKindBean() {
	}
		
	public void setId_course(String id_course) {
		this.id_course = id_course;
	}
	public void setCourse(String course) {
		this.course = course;
	}
	public void setYn_valid(String yn_valid) {		
		this.yn_valid = yn_valid;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	public void setId_category(String id_category) {
		this.id_category = id_category;
	}
	public void setId_midcategory(String id_midcategory) {  
		this.id_midcategory = id_midcategory;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public void setMidcategory(String midcategory) {
		this.midcategory = midcategory;
	}
	public void setYears(String years) {
		this.years = years;
	}
	public void setOrders(int orders) {
		this.orders = orders;
	}
			
	public String getId_course() {
		return id_course;
	}
	public String getCourse() {
		return course;
	}
	public String getYn_valid() {
		return yn_valid;
	}
	public String getRegdate() {
		return regdate;
	}
	public String getId_category() {
		return id_category;
	}
	public String getId_midcategory() {
		return id_midcategory;
	}
	public String getCategory() {
		return category;
	}
	public String getMidcategory() {
		return midcategory;
	}
	public String getYears() {
		return years;
	}
	public int getOrders() {
		return orders;
	}
}
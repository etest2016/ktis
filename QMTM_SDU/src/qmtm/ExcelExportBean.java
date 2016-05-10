package qmtm;

import java.sql.Timestamp;

public class ExcelExportBean {

	private String lecture_name;
	private String q;
	private String ex1;
	private String ex2;
	private String ex3;
	private String ex4;
	private String ex5;
	private String ca;
	private String explain;
	
	public ExcelExportBean() {
	}
		
	public void setLecture_name(String lecture_name) {
		this.lecture_name = lecture_name;
	}
	public void setQ(String q) {
		this.q = q;
	}	
	public void setEx1(String ex1) {
		this.ex1 = ex1;
	}	
	public void setEx2(String ex2) {
		this.ex2 = ex2;
	}	
	public void setEx3(String ex3) {
		this.ex3 = ex3;
	}	
	public void setEx4(String ex4) {
		this.ex4 = ex4;
	}	
	public void setEx5(String ex5) {
		this.ex5 = ex5;
	}	
	public void setCa(String ca) {
		this.ca = ca;
	}	
	
	public String getLecture_name() {
		return lecture_name;
	}
	public String getQ() {
		return q;
	}
	public String getEx1() {
		return ex1;
	}
	public String getEx2() {
		return ex2;
	}
	public String getEx3() {
		return ex3;
	}
	public String getEx4() {
		return ex4;
	}
	public String getEx5() {
		return ex5;
	}
	public String getCa() {
		return ca;
	}
}
package qmtm.admin.etc;

public class LectureTermBean {
	
	private String term_id;
	private String term_year;
	private String term_type_code;
	private String term_name;
	private String yn_enable;

	public LectureTermBean() {
	}
		
	public void setTerm_id(String term_id) {
		this.term_id = term_id;
	}
	public void setTerm_year(String term_year) {
		this.term_year = term_year;
	}
	public void setTerm_type_code(String term_type_code) {
		this.term_type_code = term_type_code;
	}

	public void setTerm_name(String term_name) {
		this.term_name = term_name;
	}

	public void setYn_enable(String yn_enable) {
		this.yn_enable = yn_enable;
	}
		
	public String getTerm_id() {
		return term_id;
	}

	public String getTerm_year() {
		return term_year;
	}

	public String getTerm_type_code() {
		return term_type_code;
	}

	public String getTerm_name() {
		return term_name;
	}

	public String getYn_enable() {
		return yn_enable;
	}

}
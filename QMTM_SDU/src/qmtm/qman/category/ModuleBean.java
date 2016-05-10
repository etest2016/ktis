package qmtm.qman.category;

public class ModuleBean {
	
	private String id_chapter;
	private String chapter;
	private int chapter_order;
	private String regdate;
	private String yn_valid;
	private String id_subject;
	
	public ModuleBean() {
	}
		
	public void setId_chapter(String id_chapter) {
		this.id_chapter = id_chapter;
	}
	public void setChapter(String chapter) {
		this.chapter = chapter;
	}	
	public void setChapter_order(int chapter_order) {
		this.chapter_order = chapter_order;
	}	
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	public void setYn_valid(String yn_valid) {
		this.yn_valid = yn_valid;
	}
	public void setId_subject(String id_subject) {
		this.id_subject = id_subject;
	}

	public String getId_chapter() {
		return id_chapter;
	}
	public String getChapter() {
		return chapter;
	}
	public int getChapter_order() {
		return chapter_order;
	}
	public String getRegdate() {
		return regdate;
	}	
	public String getYn_valid() {
		return yn_valid;
	}
	public String getId_subject() {
		return id_subject;
	}
}
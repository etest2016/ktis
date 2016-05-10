package qmtm.common;

public class WorkQLogBean
{
    private String id_subject;
	private String id_chapter;
	private String id_chapter2;
	private String id_chapter3;
	private String id_chapter4;
	private String userid;
	private String gubun;
    private String id_q;    
    private String bigo;
	private String regdate;

	private String name;
	private String subject;

	private int sid;

    public WorkQLogBean() {        
    }

    public void setId_subject(String id_subject) {
        this.id_subject = id_subject;
    }

	public void setId_chapter(String id_chapter) {
        this.id_chapter = id_chapter;
    }

	public void setId_chapter2(String id_chapter2) {
        this.id_chapter2 = id_chapter2;
    }

	public void setId_chapter3(String id_chapter3) {
        this.id_chapter3 = id_chapter3;
    }

	public void setId_chapter4(String id_chapter4) {
        this.id_chapter4 = id_chapter4;
    }

	public void setUserid(String userid) {
        this.userid = userid;
    }

	public void setGubun(String gubun) {
        this.gubun = gubun;
    }

    public void setId_q(String id_q) {
        this.id_q = id_q;
    }

    public void setBigo(String bigo) {
        this.bigo = bigo;
    }

	public void setRegdate(String regdate) {
        this.regdate = regdate;
    }

	public void setSubject(String subject) {
        this.subject = subject;
    }

	public void setName(String name) {
        this.name = name;
    }

	public void setSid(int sid) {
        this.sid = sid;
    }

    public String getId_subject() {
        return id_subject;
    }

	public String getId_chapter() {
        return id_chapter;
    }

	public String getId_chapter2() {
        return id_chapter2;
    }

	public String getId_chapter3() {
        return id_chapter3;
    }

	public String getId_chapter4() {
        return id_chapter4;
    }

	public String getUserid() {
        return userid;
    }

	public String getGubun() {
        return gubun;
    }

    public String getId_q() {
        return id_q;
    }

    public String getBigo() {
        return bigo;
    }

	public String getRegdate() {
        return regdate;
    }

	public String getSubject() {
		return subject;
	}

	public String getName() {
		return name;
	}

	public int getSid() {
		return sid;
	}
}

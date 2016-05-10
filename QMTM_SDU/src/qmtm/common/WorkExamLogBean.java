package qmtm.common;

public class WorkExamLogBean
{
    private String id_exam;
	private String userid;
	private String gubun;
    private String id_q;    
    private String bigo;
	private String regdate;
	private int sid;
	private String title;
	private String name;
	private String course;

    public WorkExamLogBean() {        
    }

    public void setId_exam(String id_exam) {
        this.id_exam = id_exam;
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

	public void setSid(int sid) {
        this.sid = sid;
    }

	public void setTitle(String title) {
        this.title = title;
    }

	public void setName(String name) {
        this.name = name;
    }

	public void setCourse(String course) {
        this.course = course;
    }

    public String getId_exam() {
        return id_exam;
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

	public int getSid() {
        return sid;
    }

	public String getTitle() {
        return title;
    }

	public String getName() {
        return name;
    }

	public String getCourse() {
		return course;
	}
}

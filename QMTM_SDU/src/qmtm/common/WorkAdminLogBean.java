package qmtm.common;

public class WorkAdminLogBean
{
	private String userid;
	private String gubun;
    private String bigo;
	private String regdate;
	private int sid;
	private String name;

    public WorkAdminLogBean() {        
    }

	public void setUserid(String userid) {
        this.userid = userid;
    }

	public void setGubun(String gubun) {
        this.gubun = gubun;
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

	public void setName(String name) {
        this.name = name;
    }

	public String getUserid() {
        return userid;
    }

	public String getGubun() {
        return gubun;
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

	public String getName() {
        return name;
    }

}

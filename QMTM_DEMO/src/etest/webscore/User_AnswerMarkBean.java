package etest.webscore;

public class User_AnswerMarkBean
{
    private String userid;
    private String yn_mark;
	private String names;
	private String oxs;
	
    public User_AnswerMarkBean() {
    }

    public void setUserid(String userid) {
        if (userid == null) userid = "";
        this.userid = userid;
    }

    public void setYn_mark(String yn_mark) {
        if (yn_mark == null) yn_mark = "";
        this.yn_mark = yn_mark;
    }

	public void setNames(String names) {
        if (names == null) names = "";
        this.names = names;
    }

	public void setOxs(String oxs) {
        if (oxs == null) oxs = "";
        this.oxs = oxs;
    }

    public String getUserid() {
        return userid;
    }

    public String getYn_mark() {
        return yn_mark;
    }
	
	public String getNames() {
		return names;
	}

	public String getOxs() {
		return oxs;
	}
}

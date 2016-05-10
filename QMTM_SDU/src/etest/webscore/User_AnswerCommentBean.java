package etest.webscore;

public class User_AnswerCommentBean
{
    private String id_exam;
	private String userid;
    private long id_q;
	private String score_comment;
	private String reg_id;
	private String up_id;
	
    public User_AnswerCommentBean() {
		this.score_comment = "";
    }

     public void setId_exam(String id_exam) {
        if (id_exam == null) id_exam = "";
        this.id_exam = id_exam;
    }

	public void setUserid(String userid) {
        if (userid == null) userid = "";
        this.userid = userid;
    }

	public void setId_q(long id_q) {
        this.id_q = id_q;
    }

    public void setScore_comment(String score_comment) {
        if (score_comment == null) score_comment = "";
        this.score_comment = score_comment;
    }

	public void setReg_id(String reg_id) {
        if (reg_id == null) reg_id = "";
        this.reg_id = reg_id;
    }

	public void setUp_id(String up_id) {
        if (up_id == null) up_id = "";
        this.up_id = up_id;
    }

    public String getId_exam() {
        return id_exam;
    }

	public String getUserid() {
        return userid;
    }

	public long getId_q() {
        return id_q;
    }

    public String getScore_comment() {
        return score_comment;
    }	

	public String getReg_id() {
        return reg_id;
    }	

	public String getUp_id() {
        return up_id;
    }	
}

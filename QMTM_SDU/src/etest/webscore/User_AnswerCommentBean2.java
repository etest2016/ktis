package etest.webscore;

public class User_AnswerCommentBean2
{
    private String id_exam;
	private String userid;
    private long id_q;
	private String score_comment;
		
    public User_AnswerCommentBean2() {
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
}

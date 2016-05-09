package etest.scorehelp;
import java.sql.*;

public class Score_EqualUserBean
{

	private String o_userid;
	private String equal_reason;
	private double score;

    public Score_EqualUserBean()
    {
		o_userid = "";
		equal_reason = "";
		score = 0;
    }

    public void setO_userid(String p_o_userid) {
        o_userid = p_o_userid;
    }

	public String getO_userid() {
        return o_userid;
    }

    public void setEqual_reason(String p_equal_reason) {
        equal_reason = p_equal_reason;
    }

	public String getEqual_reason() {
        return equal_reason;
    }

    public void setScore(double p_score) {
        score = p_score;
    }

	public double getScore() {
        return score;
    }
}

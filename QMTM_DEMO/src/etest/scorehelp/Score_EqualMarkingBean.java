package etest.scorehelp;
import java.sql.*;

public class Score_EqualMarkingBean
{
	private String userans;
	private String end_time;
	private String t_userid;
	private String o_t_res_rate;
	private String t_o_res_rate;
	private String equal_ans;
	private String equal_reason;
	private double score;

    public Score_EqualMarkingBean()
    {
		userans = "";
		end_time = "";
		t_userid = "";
		o_t_res_rate = "";
		t_o_res_rate = "";
		equal_ans = "";
		equal_reason = "";
		score = 0;
    }

    public void setUserans(String p_userans) {
        userans = p_userans;
    }

	public String getUserans() {
        return userans;
    }

    public void setEnd_time(String p_end_time) {
        end_time = p_end_time;
    }

	public String getEnd_time() {
        return end_time;
    }

    public void setT_userid(String p_t_userid) {
        t_userid = p_t_userid;
    }

	public String getT_userid() {
        return t_userid;
    }

    public void setO_t_res_rate(String p_o_t_res_rate) {
        o_t_res_rate = p_o_t_res_rate;
    }

	public String getO_t_res_rate() {
        return o_t_res_rate;
    }

    public void setT_o_res_rate(String p_t_o_res_rate) {
        t_o_res_rate = p_t_o_res_rate;
    }

	public String getT_o_res_rate() {
        return t_o_res_rate;
    }

	public void setEqual_ans(String p_equal_ans) {
		equal_ans = p_equal_ans;
	}

	public String getEqual_ans() {
		return equal_ans;
	}

	public void setScore(double p_score) {
		score = p_score;
	}

	public double getScore() {
		return score;
	}

	public void setEqual_reason(String p_equal_reason) {
		equal_reason = p_equal_reason;
	}

	public String getEqual_reason() {
		return equal_reason;
	}

}
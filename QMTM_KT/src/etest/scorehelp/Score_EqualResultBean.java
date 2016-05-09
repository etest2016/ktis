package etest.scorehelp;
import java.sql.*;

public class Score_EqualResultBean
{
	private String o_userid;
	private String t_userid;
	private String o_t_res_rate;
	private String t_o_res_rate;
	private String userans;
	private String end_time;

    public Score_EqualResultBean()
    {
		o_userid = "";
		t_userid = "";
		o_t_res_rate = "";
		t_o_res_rate = "";
		userans = "";
		end_time = "";
    }

    public void setO_userid(String p_o_userid) {
        o_userid = p_o_userid;
    }

	public String getO_userid() {
        return o_userid;
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

}

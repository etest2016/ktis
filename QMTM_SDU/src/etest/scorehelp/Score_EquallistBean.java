package etest.scorehelp;
import java.sql.*;

public class Score_EquallistBean
{
	private String userid;
	private double search_result_rate;
	private double ans_result_rate;
	private double ans_result_rate2;
	private int userid_ans_len;

    public Score_EquallistBean()
    {
		userid = "";
		search_result_rate = 0;
		ans_result_rate = 0;
		ans_result_rate2 = 0;
		userid_ans_len = 0;
    }

    public void setUserid(String p_userid) {
        userid = p_userid;
    }

	public String getUserid() {
        return userid;
    }

    public void setSearch_result_rate(double p_search_result_rate) {
        search_result_rate = p_search_result_rate;
    }

	public double getSearch_result_rate() {
        return search_result_rate;
    }

    public void setAns_result_rate(double p_ans_result_rate) {
        ans_result_rate = p_ans_result_rate;
    }

	public double getAns_result_rate() {
        return ans_result_rate;
    }

    public void setAns_result_rate2(double p_ans_result_rate2) {
        ans_result_rate2 = p_ans_result_rate2;
    }

	public double getAns_result_rate2() {
        return ans_result_rate2;
    }

    public void setUserid_ans_len(int p_userid_ans_len) {
        userid_ans_len = p_userid_ans_len;
    }

	public int getUserid_ans_len() {
        return userid_ans_len;
    }
}

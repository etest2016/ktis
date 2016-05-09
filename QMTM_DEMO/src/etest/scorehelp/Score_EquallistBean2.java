package etest.scorehelp;
import java.sql.*;

public class Score_EquallistBean2
{
	private String points;
	private int nr_q;
	private double allotting;
	private String equal_chk;
	private double score;
	private String equal_ans;

    public Score_EquallistBean2()
    {
		points = "";
		nr_q = 0;
		allotting = 0;
		equal_chk = "";
		score = 0;
		equal_ans = "";
    }

    public void setPoints(String p_points) {
        points = p_points;
    }

	public String getPoints() {
        return points;
    }

    public void setNr_q(int p_nr_q) {
        nr_q = p_nr_q;
    }

	public int getNr_q() {
        return nr_q;
    }

    public void setAllotting(double p_allotting) {
        allotting = p_allotting;
    }

	public double getAllotting() {
        return allotting;
    }

    public void setEqual_chk(String p_equal_chk) {
        equal_chk = p_equal_chk;
    }

	public String getEqual_chk() {
        return equal_chk;
    }

    public void setScore(double p_score) {
        score = p_score;
    }

	public double getScore() {
        return score;
    }

	public void setEqual_ans(String equal_ans) {
		this.equal_ans = equal_ans;
	}

	public String getEqual_ans() {
        return equal_ans;
    }

}

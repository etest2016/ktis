package etest.scorehelp;
import java.sql.*;

public class Score_EquallistBean3
{
	private int qcount;
	private double allotting;
	private String q;

    public Score_EquallistBean3()
    {
		qcount = 0;
		allotting = 0;
		q = "";
    }

    public void setQcount(int p_qcount) {
        qcount = p_qcount;
    }

	public int getQcount() {
        return qcount;
    }

    public void setAllotting(double p_allotting) {
        allotting = p_allotting;
    }

	public double getAllotting() {
        return allotting;
    }

    public void setQ(String p_q) {
        q = p_q;
    }

	public String getQ() {
        return q;
    }
}

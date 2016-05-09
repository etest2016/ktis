package etest.score;

public class User_StatPersonBean
{
    private double p_score;
    private double p_score_pct;
    private int p_rank;
    private double p_rank_pct;

    public User_StatPersonBean() {
    }

    public void setP_score(double p_score) {
        this.p_score = p_score;
    }

    public void setP_score_pct(double p_score_pct) {
        this.p_score_pct = p_score_pct;
    }

    public void setP_rank(int p_rank) {
        this.p_rank = p_rank;
    }

    public void setP_rank_pct(double p_rank_pct) {
        this.p_rank_pct = p_rank_pct;
    }

    public double getP_score() {
        return p_score;
    }

    public double getP_score_pct() {
        return p_score_pct;
    }

    public int getP_rank() {
        return p_rank;
    }

    public double getP_rank_pct() {
        return p_rank_pct;
    }
}

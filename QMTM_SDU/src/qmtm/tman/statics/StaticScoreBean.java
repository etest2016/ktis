package qmtm.tman.statics;

public class StaticScoreBean {
   
	private double allotting;
	private int qcount;
	private int all_inwon;
	private double score;
	private double avg_score;
	private double top_score;
	private double max_score;
	private double min_score;
	private int u_rank;
	private double pct_score;
	private double pct_rank;
	private double pct_score2;
	private double pct_rank2;
	private int inwon1;
	private int inwon2;
	private int inwon3;
	private int inwon4;
	private int inwon5;
	private int inwon6;
	private int inwon7;
	private int inwon8;
	private int inwon9;
	private int inwon10;
	private String title;
	private String userid;
	private String name;

	public void setAllotting(double allotting) {
		this.allotting = allotting;
	}
	public void setQcount(int qcount) {
		this.qcount = qcount;
	}
	public void setAll_inwon(int all_inwon) {
		this.all_inwon = all_inwon;
	}
	public void setScore(double score) {
		this.score = score;
	}
	public void setAvg_score(double avg_score) {
		this.avg_score = avg_score;
	}
	public void setTop_score(double top_score) {
		this.top_score = top_score;
	}
	public void setMax_score(double max_score) {
		this.max_score = max_score;
	}
	public void setMin_score(double min_score) {
		this.min_score = min_score;
	}
	public void setU_rank(int u_rank) {
		this.u_rank = u_rank;
	}
	public void setPct_score(double pct_score) {
		this.pct_score = pct_score;
	}
	public void setPct_rank(double pct_rank) {
		this.pct_rank = pct_rank;
	}
	public void setInwon1(int inwon1) {
		this.inwon1 = inwon1;
	}
	public void setInwon2(int inwon2) {
		this.inwon2 = inwon2;
	}
	public void setInwon3(int inwon3) {
		this.inwon3 = inwon3;
	}
	public void setInwon4(int inwon4) {
		this.inwon4 = inwon4;
	}
	public void setInwon5(int inwon5) {
		this.inwon5 = inwon5;
	}
	public void setInwon6(int inwon6) {
		this.inwon6 = inwon6;
	}
	public void setInwon7(int inwon7) {
		this.inwon7 = inwon7;
	}
	public void setInwon8(int inwon8) {
		this.inwon8 = inwon8;
	}
	public void setInwon9(int inwon9) {
		this.inwon9 = inwon9;
	}
	public void setInwon10(int inwon10) {
		this.inwon10 = inwon10;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public void setName(String name) {
		this.name = name;
	}

	public double getAllotting() {
		return allotting;
	}
	public int getQcount() {
		return qcount;
	}
	public int getAll_inwon() {
		return all_inwon;
	}
	public double getScore() {
		return score;
	}
	public double getAvg_score() {
		return avg_score;
	}
	public double getTop_score() {
		return top_score;
	}
	public double getMax_score() {
		return max_score;
	}
	public double getMin_score() {
		return min_score;
	}
	public int getU_rank() {
		return u_rank;
	}
	public double getPct_score() {
		return pct_score;
	}
	public double getPct_rank() {
		return pct_rank;
	}
	public double getPct_score2() {
		// 100점 환산점수
		pct_score2 = (score / allotting) * 100; 
		return pct_score2;
	}
	public double getPct_rank2() {
		// 석차 백분위
		pct_rank2 = (u_rank / all_inwon) * 100;
		return pct_rank2;
	}
	public int getInwon1() {
		return inwon1;
	}
	public int getInwon2() {
		return inwon2;
	}
	public int getInwon3() {
		return inwon3;
	}
	public int getInwon4() {
		return inwon4;
	}
	public int getInwon5() {
		return inwon5;
	}
	public int getInwon6() {
		return inwon6;
	}
	public int getInwon7() {
		return inwon7;
	}
	public int getInwon8() {
		return inwon8;
	}
	public int getInwon9() {
		return inwon9;
	}
	public int getInwon10() {
		return inwon10;
	}
	public String getTitle() {
		return title;
	}
	public String getUserid() {
		return userid;
	}
	public String getName() {
		return name;
	}
}	
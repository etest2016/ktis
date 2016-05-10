package etest.score;

import java.sql.Timestamp;

public class User_ScoreListBean
{
    private String id_exam;
    private String title;
    private String yn_sametime;
    private Timestamp stat_start;
    private Timestamp stat_end;
    private String yn_open_score_direct;
    private String yn_open_qa;
    private String course;
    private String yn_stat;
	private double score;
    private String yn_end;	
    private Timestamp exam_start;
    private Timestamp exam_end;    
	private long limittime;
    private int qcount;
    private double allotting;
    private String yn_stat_day;

    public User_ScoreListBean()
    {
        this.id_exam = "";
        this.title = "";
        this.yn_sametime = "";
        this.stat_start = null;
        this.stat_end = null;
        this.yn_open_score_direct = "";
        this.yn_open_qa = "";
        this.course = "";
        this.yn_stat = "";
		this.score = 0.0;
		this.yn_end = "";
		this.exam_start = null;
		this.exam_end = null;
		this.limittime = 0;
		this.qcount = 0;
		this.allotting = 0.0;
		this.yn_stat_day = "";
    }

    public void setId_exam(String id_exam) {
        this.id_exam = id_exam;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public void setYn_sametime(String yn_sametime) {
        this.yn_sametime = yn_sametime;
    }

    public void setStat_start(Timestamp stat_start) {
        this.stat_start = stat_start;
    }

    public void setStat_end(Timestamp stat_end) {
        this.stat_end = stat_end;
    }

    public void setYn_open_score_direct(String yn_open_score_direct) {
        this.yn_open_score_direct = yn_open_score_direct;
    }

    public void setYn_open_qa(String yn_open_qa) {
        this.yn_open_qa = yn_open_qa;
    }

    public void setCourse(String course) {
        this.course = course;
    }

    public void setYn_stat(String yn_stat) {
        this.yn_stat = yn_stat;
    }

    public void setScore(double score) {
        this.score = score;
    }

    public void setYn_end(String yn_end) {
        this.yn_end = yn_end;
    }

	public void setExam_start(Timestamp exam_start) {
        this.exam_start = exam_start;
    }

    public void setExam_end(Timestamp exam_end) {
        this.exam_end = exam_end;
    }

    public void setLimittime(long limittime) {
        this.limittime = limittime;
    }

    public void setQcount(int qcount) {
        this.qcount = qcount;
    }

    public void setAllotting(double allotting) {
        this.allotting = allotting;
    }

    public void setYn_stat_day(String yn_stat_day) {
        this.yn_stat_day = yn_stat_day;
    }

    public String getId_exam() {
        return id_exam;
    }

    public String getTitle() {
        return title;
    }

    public String getYn_sametime() {
        return yn_sametime;
    }

    public Timestamp getStat_start() {
        return stat_start;
    }

    public Timestamp getStat_end() {
        return stat_end;
    }

    public String getYn_open_score_direct() {
        return yn_open_score_direct;
    }

    public String getYn_open_qa() {
        return yn_open_qa;
    }

    public String getCourse() {
        return course;
    }

    public String getYn_stat() {
        return yn_stat;
    }

	public double getScore() {
        return score;
    }

    public String getYn_end() {
        return yn_end;
    }

	public Timestamp getExam_start() {
        return exam_start;
    }

    public Timestamp getExam_end() {
        return exam_end;
    }

    public long getLimittime() {
        return limittime;
    }

    public int getQcount() {
        return qcount;
    }

    public double getAllotting() {
        return allotting;
    }

    public String getYn_stat_day() {
        return yn_stat_day;
    }
}

package etest.paper;

import java.sql.*;

public class User_ExamAnsBean
{
    private String userid;
    private String id_exam;
    private int nr_set;
    private Timestamp start_time;
    private Timestamp end_time;
    private long remain_time;
    private String yn_end;
    private String answers;
    private String oxs;
    private String points;
    private double score;
    private double score_bak;
    private String score_log;
	private String user_ip;
    private String yn_mark;
	private String retry_exam;

    public User_ExamAnsBean()
    {
        this.userid = "";
        this.id_exam = "";
        this.nr_set = 0;
        this.start_time = new Timestamp(System.currentTimeMillis());
        this.end_time = new Timestamp(System.currentTimeMillis());
        this.remain_time = 0;
        this.yn_end = "N";
        this.answers = "";
        this.oxs = "";
        this.points = "";        
        this.score = 0;
        this.score_bak = -1;
        this.score_log = "-1";
		this.user_ip = "";
        this.yn_mark = "N";
		this.retry_exam = "N";
    }
    
    public void setUserid(String userid) {
        if (userid != null) this.userid = userid;
    }

    public void setId_exam(String id_exam) {
        if (id_exam != null) this.id_exam = id_exam;
    }

    public void setNr_set(int nr_set) {
        this.nr_set = nr_set;
    }

    public void setStart_time(Timestamp start_time) {
       if (start_time != null)  this.start_time = start_time;
    }

    public void setEnd_time(Timestamp end_time) {
        if (end_time != null) this.end_time = end_time;
    }

    public void setRemain_time(long remain_time) {
        this.remain_time = remain_time;
    }

    public void setYn_end(String yn_end) {
        if (yn_end != null) this.yn_end = yn_end;
    }

    public void setAnswers(String answers) {
        if (answers != null) this.answers = answers;
    }

    public void setOxs(String oxs) {
        if (oxs != null) this.oxs = oxs;
    }

    public void setPoints(String points) {
        if (points != null) this.points = points;
    }

    public void setScore(double score) {
        this.score = score;
    }

    public void setScore_bak(double score_bak) {
        this.score_bak = score_bak;
    }

    public void setScore_log(String score_log) {
        if (score_log != null) this.score_log = score_log;
    }

    public void setUser_ip(String user_ip) {
        if (user_ip != null) this.user_ip = user_ip;
    }
	
	public void setYn_mark(String yn_mark) {
        if (yn_mark != null) this.yn_mark = yn_mark;
    }

	public void setRetry_exam(String retry_exam) {
		if (retry_exam != null) this.retry_exam = retry_exam;
	}

    public String getUserid() {
        return userid;
    }

    public String getId_exam() {
        return id_exam;
    }
  
    public int getNr_set() {
        return nr_set;
    }

    public Timestamp getStart_time() {
        return start_time;
    }

    public Timestamp getEnd_time() {
        return end_time;
    }

    public long getRemain_time() {
        return remain_time;
    }

    public String getYn_end() {
        return yn_end;
    }

    public String getAnswers() {
        return answers;
    }

    public String getOxs() {
        return oxs;
    }

    public String getPoints() {
        return points;
    }

    public double getScore() {
        return score;
    }

    public double getScore_bak() {
        return score_bak;
    }

    public String getScore_log() {
        return score_log;
    }

    public String getUser_ip() {
        return user_ip;
    }
	
	public String getYn_mark() {
        return yn_mark;
    }

	public String getRetry_exam() {
		return retry_exam;
	}
}

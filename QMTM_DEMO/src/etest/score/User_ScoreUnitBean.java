package etest.score;

import etest.User_CJH;
import java.sql.Timestamp;

public class User_ScoreUnitBean
{
    private double score;
    private String yn_end;
    private String title;
    private Timestamp exam_start;
    private Timestamp exam_end;
    private String yn_sametime;
    private String yn_open_score_direct;
    private String yn_open_qa;
    private String yn_stat;
    private Timestamp stat_start;
    private Timestamp stat_end;
    private int qcount;
    private double allotting;
    private String yn_stat_day;
	private String id_exam;

    public User_ScoreUnitBean() {
    }
    
    public void setScore(double score) {
        this.score = score;
    }

    public void setYn_end(String yn_end) {
        this.yn_end = yn_end;
    }

    public void setTitle(String title) {
        if (title == null) title = "";
        this.title = title;
    }

    public void setExam_start(Timestamp exam_start) {
        this.exam_start = exam_start;
    }

    public void setExam_end(Timestamp exam_end) {
        this.exam_end = exam_end;
    }
   
    public void setYn_open_score_direct(String yn_open_score_direct) {
        this.yn_open_score_direct = yn_open_score_direct;
    }

    public void setYn_open_qa(String yn_open_qa) {
        this.yn_open_qa = yn_open_qa;
    }

    public void setYn_stat(String yn_stat) {
        this.yn_stat = yn_stat;
    }

    public void setStat_start(Timestamp stat_start) {
        this.stat_start = stat_start;
    }

    public void setStat_end(Timestamp stat_end)
    {
        this.stat_end = stat_end;
        if (User_CJH.isNowBetween(this.getStat_start(), this.getStat_end())) {
            this.yn_stat_day = "Y";
        } else {
            this.yn_stat_day = "N";
        }
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

	public void setId_exam(String id_exam) {
        this.id_exam = id_exam;
    }

    public double getScore() {
        return score;
    }

    public String getYn_end() {
        return yn_end;
    }

    public String getTitle() {
        return title;
    }

    public Timestamp getExam_start() {
        return exam_start;
    }

    public Timestamp getExam_end() {
        return exam_end;
    }

    public String getYn_open_score_direct() {
        return yn_open_score_direct;
    }

    public String getYn_open_qa() {
        return yn_open_qa;
    }

    public String getYn_stat() {
        return yn_stat;
    }

    public Timestamp getStat_start() {
        return stat_start;
    }

    public Timestamp getStat_end() {
        return stat_end;
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

	public String getId_exam() {
        return id_exam;
    }

}

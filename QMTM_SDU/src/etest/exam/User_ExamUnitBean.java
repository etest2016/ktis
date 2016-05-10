package etest.exam;

import java.sql.Timestamp;

public class User_ExamUnitBean
{
    private String title;
    private String course;
    private Timestamp exam_start;
    private Timestamp exam_end;
    private String id_exam_type;
    private long limitTime;
    private String guide;
	private String exam_pwd_yn;
	private String yn_sametime;
	private int web_window_mode;

    public User_ExamUnitBean() {
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public void setCourse(String course) {
        this.course = course;
    }

    public void setExam_start(Timestamp exam_start) {
        this.exam_start = exam_start;
    }

    public void setExam_end(Timestamp exam_end) {
        this.exam_end = exam_end;
    }

    public void setId_exam_type(String id_exam_type) {
        this.id_exam_type = id_exam_type;
    }

    public void setLimitTime(long limitTime) {
        this.limitTime = limitTime;
    }

    public void setGuide(String guide) {
        if (guide == null) { guide = ""; }
        this.guide = guide;
    }
    
	public void setExam_pwd_yn(String exam_pwd_yn) {
		this.exam_pwd_yn = exam_pwd_yn;
	}
	
	public void setYn_sametime(String yn_sametime) {
        this.yn_sametime = yn_sametime;
    }

    public void setWeb_window_mode(int web_window_mode) {
		this.web_window_mode = web_window_mode;
	}

	public String getTitle() {
        return title;
    }

    public String getCourse() {
        return course;
    }

    public Timestamp getExam_start() {
        return exam_start;
    }

    public Timestamp getExam_end() {
        return exam_end;
    }

    public String getId_exam_type() {
        return id_exam_type;
    }

    public long getLimitTime() {
        return limitTime;
    }

    public String getGuide() {
        return guide;
    }

	public String getExam_pwd_yn() {
		return exam_pwd_yn;
	}

	public String getYn_sametime() {
		return yn_sametime;
	}

	public int getWeb_window_mode() {
		return web_window_mode;
	}
	
}

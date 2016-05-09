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
}

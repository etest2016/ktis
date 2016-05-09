package etest.exam;

import java.sql.Timestamp;

// for exam/myTest.jsp

public class User_ExamListBean
{
    private String id_exam;
    private String title;
    private Timestamp exam_start;
    private Timestamp exam_end;
    private String course;

    public User_ExamListBean()
    {
        this.id_exam = "";
        this.title = "";
        this.exam_start = null; // new Timestamp(System.currentTimeMillis())
        this.exam_end = null;
        this.course = "";
    }

    public void setId_exam(String id_exam) {
        this.id_exam = id_exam;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public void setExam_start(Timestamp exam_start) {
        this.exam_start = exam_start;
    }

    public void setExam_end(Timestamp exam_end) {
        this.exam_end = exam_end;
    }

    public void setCourse(String course) {
        this.course = course;
    }

    public String getId_exam() {
        return id_exam;
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

    public String getCourse() {
        return course;
    }
}

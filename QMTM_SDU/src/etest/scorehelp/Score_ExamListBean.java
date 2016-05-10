package etest.scorehelp;

import java.sql.*;

// for exam/myTest.jsp

public class Score_ExamListBean
{
    private String title;
    private String id_exam;
    private String exam_start;
    private String exam_end;
    private String nums1;
    private String nums2;
	private String userid;

    public Score_ExamListBean()
    {
        this.title = "";
        this.id_exam = "";
		this.exam_start = "";
		this.exam_end = "";
        this.nums1 = "";
        this.nums2 = "";
		this.userid = "";
    }

    public void setId_exam(String id_exam) {
        this.id_exam = id_exam;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public void setExam_start(String exam_start) {
        this.exam_start = exam_start;
    }

    public void setExam_end(String exam_end) {
        this.exam_end = exam_end;
    }

    public void setNums1(String nums1) {
        this.nums1 = nums1;
    }

    public void setNums2(String nums2) {
        this.nums2 = nums2;
    }

    public void setUserid(String userid) {
        this.userid = userid;
    }

	public String getTitle() {
        return title;
    }

    public String getId_exam() {
        return id_exam;
    }

    public String getExam_start() {
        return exam_start;
    }

    public String getExam_end() {
        return exam_end;
    }

    public String getNums1() {
        return nums1;
    }

    public String getNums2() {
        return nums2;
    }

    public String getUserid() {
        return userid;
    }

}

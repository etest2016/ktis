package qmtm.tman.exam;

public class ExamScheduleBean {
		
	private String id_exam;	
	private String title;
	private String course;
	private String exam_start;
	private String exam_end;

	private int tot_inwon;
	private int ans_inwon;
	
	public void setId_exam(String id_exam) {
		this.id_exam = id_exam;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public void setCourse(String course) {
		this.course = course;
	}
	public void setExam_start(String exam_start) {
		this.exam_start = exam_start;
	}
	public void setExam_end(String exam_end) {
		this.exam_end = exam_end;
	}
	public void setTot_inwon(int tot_inwon) {
		this.tot_inwon = tot_inwon;
	}
	public void setAns_inwon(int ans_inwon) {
		this.ans_inwon = ans_inwon;
	}

	public String getId_exam() {
		return id_exam;
	}
	public String getTitle() {
		return title;
	}
	public String getCourse() {
		return course;
	}
	public String getExam_start() {
		return exam_start;
	}
	public String getExam_end() {
		return exam_end;
	}
	public int getTot_inwon() {
		return tot_inwon;
	}
	public int getAns_inwon() {
		return ans_inwon;
	}
}
package qmtm.common;

public class ExamInfoBean
{
    private String id_exam;
	private String title;
    private int qcount;
    private double allotting;
    private String exlabel;
	private int id_auth_type;

    public ExamInfoBean() {
        this.exlabel = "¨ç,¨è,¨é,¨ê,¨ë,¨ì,¨í,¨î,";
    }

    public void setId_exam(String id_exam) {
        this.id_exam = id_exam;
    }

	public void setTitle(String title) {
        this.title = title;
    }

    public void setQcount(int qcount) {
        this.qcount = qcount;
    }

    public void setAllotting(double allotting) {
        this.allotting = allotting;
    }

    public void setExlabel(String exlabel) {
        if (exlabel != null) this.exlabel = exlabel;
    }

	public void setId_auth_type(int id_auth_type) {
        this.id_auth_type = id_auth_type;
    }

    public String getId_exam() {
        return id_exam;
    }

	public String getTitle() {
        return title;
    }

    public int getQcount() {
        return qcount;
    }

    public double getAllotting() {
        return allotting;
    }

    public String getExlabel() {
        return exlabel;
    }

	public int getId_auth_type() {
        return id_auth_type;
    }
}

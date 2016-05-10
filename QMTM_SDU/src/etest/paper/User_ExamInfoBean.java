package etest.paper;

import java.sql.Timestamp;

public class User_ExamInfoBean
{
    private String title;
    private String yn_open_qa;
    private String yn_open_score_direct;
    private Timestamp exam_start1;
    private Timestamp exam_end1;
    private String log_option;
    private int id_exam_type;
    private String id_ltimetype;
    private String id_movepage;
    private int qcntperpage;
    private String yn_viewas;
    private int id_exlabel;
    private String fontname;
    private int fontsize;
    private int paper_type;
    private int qcount;
    private double allotting;
    private int setcount;
    private long limittime;           // [sec]    
    private String yn_sametime;
    private int id_auth_type;
    private String id_course;
    private int web_window_mode;
    private Timestamp login_start;
    private Timestamp login_end;

    private Timestamp system_now;
    private long to_exam_start1;      // [sec]
    private long to_exam_end1;        // [sec]
    private long to_end1_from_start1; // [sec]
    private long to_login_start;      // [sec]
    private long to_login_end;        // [sec]
    private String exlabel;
	private String retry_exam;

	private int id_exam_kind;
	
	private String yn_activex;

    public User_ExamInfoBean() {
        this.system_now = new Timestamp(System.currentTimeMillis());
        this.exlabel = "¨ç,¨è,¨é,¨ê,¨ë";
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public void setYn_open_qa(String yn_open_qa) {
        this.yn_open_qa = yn_open_qa;
    }

    public void setYn_open_score_direct(String yn_open_score_direct) {
        this.yn_open_score_direct = yn_open_score_direct;
    }

    public void setExam_start1(Timestamp exam_start1) {
        this.exam_start1 = exam_start1;
        this.to_exam_start1 = (this.exam_start1.getTime() - this.system_now.getTime()) / 1000;
    }

    public void setExam_end1(Timestamp exam_end1) {
        this.exam_end1 = exam_end1;
        this.to_exam_end1 = (this.exam_end1.getTime() - this.system_now.getTime()) / 1000;
        this.to_end1_from_start1 = (this.exam_end1.getTime() - this.exam_start1.getTime()) / 1000;
    }

    public void setLog_option(String log_option) {
        this.log_option = log_option;
    }

    public void setId_exam_type(int id_exam_type) {
        this.id_exam_type = id_exam_type;
    }

    public void setId_ltimetype(String id_ltimetype) {
        this.id_ltimetype = id_ltimetype;
    }

    public void setId_movepage(String id_movepage) {
        this.id_movepage = id_movepage;
    }

    public void setQcntperpage(int qcntperpage) {
        this.qcntperpage = qcntperpage;
    }

    public void setYn_viewas(String yn_viewas) {
        this.yn_viewas = yn_viewas;
    }

    public void setId_exlabel(int id_exlabel) {
        this.id_exlabel = id_exlabel;
    }

    public void setFontname(String fontname) {
        this.fontname = fontname;
    }

    public void setFontsize(int fontsize) {
        this.fontsize = fontsize;
    }

    public void setPaper_type(int paper_type) {
        this.paper_type = paper_type;
    }

    public void setQcount(int qcount) {
        this.qcount = qcount;
    }

    public void setAllotting(double allotting) {
        this.allotting = allotting;
    }

    public void setSetcount(int setcount) {
        this.setcount = setcount;
    }

    public void setLimittime(long limittime) {
        this.limittime = limittime;
    }

    public void setYn_sametime(String yn_sametime) {
        this.yn_sametime = yn_sametime;
    }

    public void setId_auth_type(int id_auth_type) {
        this.id_auth_type = id_auth_type;
    }

    public void setId_course(String id_course) {
        this.id_course = id_course;
    }

    public void setWeb_window_mode(int web_window_mode) {
        this.web_window_mode = web_window_mode;
    }

    public void setLogin_start(Timestamp login_start)
    {
        if (login_start == null) login_start = this.exam_start1;
        this.login_start = login_start;
        this.to_login_start = (this.login_start.getTime() - this.system_now.getTime()) / 1000;
    }

    public void setSystem_now(Timestamp system_now) {
        this.system_now = system_now;
    }

    public void setTo_exam_start1(long to_exam_start1) {
        this.to_exam_start1 = to_exam_start1;
    }

    public void setTo_exam_end1(long to_exam_end1) {
        this.to_exam_end1 = to_exam_end1;
    }

    public void setTo_end1_from_start1(long to_end1_from_start1) {
        this.to_end1_from_start1 = to_end1_from_start1;
    }

    public void setTo_login_start(long to_login_start) {
        this.to_login_start = to_login_start;
    }

    public void setTo_login_end(long to_login_end) {
        this.to_login_end = to_login_end;
    }

    public void setLogin_end(Timestamp login_end)
    {
        if (login_end == null) login_end = this.exam_end1;
        this.login_end = login_end;
        this.to_login_end = (this.login_end.getTime() - this.system_now.getTime()) / 1000;
    }

    public void setExlabel(String exlabel) {
        if (exlabel != null) this.exlabel = exlabel;
    }

	public void setId_exam_kind(int id_exam_kind) {
        this.id_exam_kind = id_exam_kind;
    }

    public void setYn_activex(String yn_activex) {
		this.yn_activex = yn_activex;
	}

	public String getTitle() {
        return title;
    }

    public String getYn_open_qa() {
        return yn_open_qa;
    }

    public String getYn_open_score_direct() {
        return yn_open_score_direct;
    }

    public Timestamp getExam_start1() {

        return exam_start1;
    }

    public Timestamp getExam_end1() {

        return exam_end1;
    }

    public String getLog_option() {
        return log_option;
    }

    public int getId_exam_type() {
        return id_exam_type;
    }

    public String getId_ltimetype() {
        return id_ltimetype;
    }

    public String getId_movepage() {
        return id_movepage;
    }

    public int getQcntperpage() {
        return qcntperpage;
    }

    public String getYn_viewas() {
        return yn_viewas;
    }

    public int getId_exlabel() {
        return id_exlabel;
    }

    public String getFontname() {
        return fontname;
    }

    public int getFontsize() {
        return fontsize;
    }

    public int getPaper_type() {
        return paper_type;
    }
	
    public int getQcount() {
        return qcount;
    }

    public double getAllotting() {
        return allotting;
    }

    public int getSetcount() {
        return setcount;
    }

    public long getLimittime() {
        return limittime;
    }

	public String getYn_sametime() {
        return yn_sametime;
    }

    public int getId_auth_type() {
        return id_auth_type;
    }

    public String getId_course() {
        return id_course;
    }

    public int getWeb_window_mode() {
        return web_window_mode;
    }

    public Timestamp getLogin_start() {
        return login_start;
    }

    public Timestamp getSystem_now() {
        return system_now;
    }

    public long getTo_exam_start1() {
        return to_exam_start1;
    }

    public long getTo_exam_end1() {
        return to_exam_end1;
    }

    public long getTo_end1_from_start1() {
        return to_end1_from_start1;
    }

    public long getTo_login_start() {
        return to_login_start;
    }

    public long getTo_login_end() {
        return to_login_end;
    }

    public Timestamp getLogin_end() {
        return login_end;
    }

    public String getExlabel() {
        return exlabel;
    }

	public String getRetry_exam() {
        return retry_exam;
    }

	public int getId_exam_kind() {
		return id_exam_kind;
	}

	public String getYn_activex() {
		return yn_activex;
	}

}

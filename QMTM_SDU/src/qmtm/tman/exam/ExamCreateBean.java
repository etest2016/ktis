package qmtm.tman.exam;

import java.sql.Timestamp;

public class ExamCreateBean {
	private String id_exam;
	private String id_course;
	private String id_subject;
	private String course_year;
	private String course_no;
	private String course_class_no;
	private String course_study_seq;
	private String title;
	private String guide;
	private int id_exam_kind;
	private String yn_enable;
	private Timestamp exam_start1;
	private Timestamp exam_end1;
	private Timestamp receipt_start;
	private Timestamp receipt_end;
	private Timestamp login_start;
	private Timestamp login_end;
	private int id_exam_type;
	private int id_auth_type;
	private String yn_stat;
	private Timestamp stat_start;
	private Timestamp stat_end;
	private String yn_p_rank;
	private String yn_p_rank_pct;
	private String yn_t_avg;
	private String yn_t_u_avg;
	private int u_avg_basis;
	private String yn_t_max;
	private String yn_t_min;
	private String yn_t_user_cnt;
	private String yn_score_dis;
	private String yn_opt_subj;
	private String yn_open_qa;
	private String yn_open_score_direct;
	private int failure_score;
	private String yn_exam_result_msg;
	private String log_option;
	private int web_window_mode;
	private String yn_sametime;
	private long limittime;
	private int qcount; 
	private double allotting;
	private String id_randomtype;
	private int setcount;
	private String id_ltimetype;
	private String id_movepage;
	private String yn_viewas;
	private int qcntperpage;
	private int id_exlabel;
	private String fontname;
	private int fontsize;
	private int paper_type;
	private String userid;
	private Timestamp cal_stat_date;
	private Timestamp regdate;
	private Timestamp up_date;	
	private String exam_pwd_yn;
	private String exam_pwd_str;	
	private String id_category;	
	private String yn_activex;
	private double success_score;
	private String yn_success_score;
	private String exam_method;

	public void setExam_method(String exam_method) {
		this.exam_method = exam_method;
	}
	public void setId_exam(String id_exam) {
		this.id_exam = id_exam;
	}
	public void setId_course(String id_course) {
		this.id_course = id_course;
	}
	public void setId_subject(String id_subject) {
		this.id_subject = id_subject;
	}
	public void setCourse_year(String course_year) {
		this.course_year = course_year;
	}
	public void setCourse_no(String course_no) {
		this.course_no = course_no;
	}
	public void setCourse_class_no(String course_class_no) {
		this.course_class_no = course_class_no;
	}
	public void setCourse_study_seq(String course_study_seq) {
		this.course_study_seq = course_study_seq;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public void setGuide(String guide) {
		this.guide = guide;
	}
	public void setId_exam_kind(int id_exam_kind) {
		this.id_exam_kind = id_exam_kind;
	}
	public void setYn_enable(String yn_enable) {
		this.yn_enable = yn_enable;
	}
	public void setExam_start1(Timestamp exam_start1) {
		this.exam_start1 = exam_start1;
	}
	public void setExam_end1(Timestamp exam_end1) {
		this.exam_end1 = exam_end1;
	}
	public void setReceipt_start(Timestamp receipt_start) {
		this.receipt_start = receipt_start;
	}
	public void setReceipt_end(Timestamp receipt_end) {
		this.receipt_end = receipt_end;
	}
	public void setLogin_start(Timestamp login_start) {
		this.login_start = login_start;
	}
	public void setLogin_end(Timestamp login_end) {
		this.login_end = login_end;
	}
	public void setId_exam_type(int id_exam_type) {
		this.id_exam_type = id_exam_type;
	}
	public void setId_auth_type(int id_auth_type) {
		this.id_auth_type = id_auth_type;
	}
	public void setYn_stat(String yn_stat) {
		this.yn_stat = yn_stat;
	}
	public void setStat_start(Timestamp stat_start) {
		this.stat_start = stat_start;
	}
	public void setStat_end(Timestamp stat_end) {
		this.stat_end = stat_end;
	}
	public void setYn_p_rank(String yn_p_rank) {
		this.yn_p_rank = yn_p_rank;
	}
	public void setYn_p_rank_pct(String yn_p_rank_pct) {
		this.yn_p_rank_pct = yn_p_rank_pct;
	}
	public void setYn_t_avg(String yn_t_avg) {
		this.yn_t_avg = yn_t_avg;
	}
	public void setYn_t_u_avg(String yn_t_u_avg) {
		this.yn_t_u_avg = yn_t_u_avg;
	}
	public void setU_avg_basis(int u_avg_basis) {
		this.u_avg_basis = u_avg_basis;
	}
	public void setYn_t_max(String yn_t_max) {
		this.yn_t_max = yn_t_max;
	}
	public void setYn_t_min(String yn_t_min) {
		this.yn_t_min = yn_t_min;
	}
	public void setYn_t_user_cnt(String yn_t_user_cnt) {
		this.yn_t_user_cnt = yn_t_user_cnt;
	}
	public void setYn_score_dis(String yn_score_dis) {
		this.yn_score_dis = yn_score_dis;
	}
	public void setYn_opt_subj(String yn_opt_subj) {
		this.yn_opt_subj = yn_opt_subj;
	}
	public void setYn_open_qa(String yn_open_qa) {
		this.yn_open_qa = yn_open_qa;
	}
	public void setYn_open_score_direct(String yn_open_score_direct) {
		this.yn_open_score_direct = yn_open_score_direct;
	}
	public void setFailure_score(int failure_score) {
		this.failure_score = failure_score;
	}
	public void setYn_exam_result_msg(String yn_exam_result_msg) {
		this.yn_exam_result_msg = yn_exam_result_msg;
	}
	public void setLog_option(String log_option) {
		this.log_option = log_option;
	}
	public void setWeb_window_mode(int web_window_mode) {
		this.web_window_mode = web_window_mode;
	}
	public void setYn_sametime(String yn_sametime) {
		this.yn_sametime = yn_sametime;
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
	public void setId_randomtype(String id_randomtype) {
		this.id_randomtype = id_randomtype;
	}
	public void setSetcount(int setcount) {
		this.setcount = setcount;
	}
	public void setId_ltimetype(String id_ltimetype) {
		this.id_ltimetype = id_ltimetype;
	}
	public void setId_movepage(String id_movepage) {
		this.id_movepage = id_movepage;
	}
	public void setYn_viewas(String yn_viewas) {
		this.yn_viewas = yn_viewas;
	}
	public void setQcntperpage(int qcntperpage) {
		this.qcntperpage = qcntperpage;
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
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public void setCal_stat_date(Timestamp cal_stat_date) {
		this.cal_stat_date = cal_stat_date;
	}
	public void setRegdate(Timestamp regdate) {
		this.regdate = regdate;
	}
	public void setUp_date(Timestamp up_date) {
		this.up_date = up_date;
	}	
	public void setExam_pwd_yn(String exam_pwd_yn) {
		this.exam_pwd_yn = exam_pwd_yn;
	}
	public void setExam_pwd_str(String exam_pwd_str) {
		this.exam_pwd_str = exam_pwd_str;
	}
	public void setId_category(String id_category) {
		this.id_category = id_category;
	}	
	public void setYn_activex(String yn_activex) {
		this.yn_activex = yn_activex;
	}
	public void setSuccess_score(double success_score) {
		this.success_score = success_score;
	}
	public void setYn_success_score(String yn_success_score) {
		this.yn_success_score = yn_success_score;
	}
		
	public String getExam_method() {
		return exam_method;
	}
	public String getId_exam() {
		return id_exam;
	}
	public String getId_course() {
		return id_course;
	}
	public String getId_subject() {
		return id_subject;
	}
	public String getCourse_year() {
		return course_year;
	}
	public String getCourse_no() {
		return course_no;
	}
	public String getCourse_class_no() {
		return course_class_no;
	}
	public String getCourse_study_seq() {
		return course_study_seq;
	}
	public String getTitle() {
		return title;
	}
	public String getGuide() {
		return guide;
	}
	public int getId_exam_kind() {
		return id_exam_kind;
	}
	public String getYn_enable() {
		return yn_enable;
	}
	public Timestamp getExam_start1() {
		return exam_start1;
	}
	public Timestamp getExam_end1() {
		return exam_end1;
	}
	public Timestamp getReceipt_start() {
		return receipt_start;
	}
	public Timestamp getReceipt_end() {
		return receipt_end;
	}
	public Timestamp getLogin_start() {
		return login_start;
	}
	public Timestamp getLogin_end() {
		return login_end;
	}
	public int getId_exam_type() {
		return id_exam_type;
	}
	public int getId_auth_type() {
		return id_auth_type;
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
	public String getYn_p_rank() {
		return yn_p_rank;
	}
	public String getYn_p_rank_pct() {
		return yn_p_rank_pct;
	}
	public String getYn_t_avg() {
		return yn_t_avg;
	}
	public String getYn_t_u_avg() {
		return yn_t_u_avg;
	}
	public int getU_avg_basis() {
		return u_avg_basis;
	}
	public String getYn_t_max() {
		return yn_t_max;
	}
	public String getYn_t_min() {
		return yn_t_min;
	}
	public String getYn_t_user_cnt() {
		return yn_t_user_cnt;
	}
	public String getYn_score_dis() {
		return yn_score_dis;
	}
	public String getYn_opt_subj() {
		return yn_opt_subj;
	}
	public String getYn_open_qa() {
		return yn_open_qa;
	}
	public String getYn_open_score_direct() {
		return yn_open_score_direct;
	}
	public int getFailure_score() {
		return failure_score;
	}
	public String getYn_exam_result_msg() {
		return yn_exam_result_msg;
	}
	public String getLog_option() {
		return log_option;
	}
	public int getWeb_window_mode() {
		return web_window_mode;
	}
	public String getYn_sametime() {
		return yn_sametime;
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
	public String getId_randomtype() {
		return id_randomtype;
	}
	public int getSetcount() {
		return setcount;
	}
	public String getId_ltimetype() {
		return id_ltimetype;
	}
	public String getId_movepage() {
		return id_movepage;
	}
	public String getYn_viewas() {
		return yn_viewas;
	}
	public int getQcntperpage() {
		return qcntperpage;
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
	public String getUserid() {
		return userid;
	}
	public Timestamp getCal_stat_date() {
		return cal_stat_date;
	}
	public Timestamp getRegdate() {
		return regdate;
	}
	public Timestamp getUp_date() {
		return up_date;
	}	
	public String getExam_pwd_yn() {
		return exam_pwd_yn;
	}
	public String getExam_pwd_str() {
		return exam_pwd_str;
	}
	public String getId_category() {
		return id_category;
	}	
	public String getYn_activex() {
		return yn_activex;
	}
	public double getSuccess_score() {
		return success_score;
	}
	public String getYn_success_score() {
		return yn_success_score;
	}	
}

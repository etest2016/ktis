package qmtm.qman.editor;

import java.sql.*;

public class QBean {
	
	private long id_q;
	private String id_subject;
	private String id_chapter;
	private String id_chapter2;
	private String id_chapter3;
	private String id_chapter4;
	private String id_ref;
	private int id_qtype;
	private int excount;
	private int cacount;
	private double allotting;
	private int limittime;
	private int id_difficulty1;
	private int id_difficulty2;
	private String q;
	private String ex1;
	private String ex2;
	private String ex3;
	private String ex4;
	private String ex5;
	private String ex6;
	private String ex7;
	private String ex8;
	private String ca;
	private String yn_caorder;
	private String yn_case;
	private String yn_blank;
	private String explain;
	private String hint;
	private String src_book;
	private String src_author;
	private String src_page;
	private String src_pub_comp;
	private String src_pub_year;
	private String src_misc;
	private String find_kwd;
	private String userid;
	private int id_valid_type;
	private String regdate;
	private int id_q_use;
	private String q_use_detail;
	private int ex_rowcnt;
	private String yn_single_line;
	private String q_chapter;
	private String q_gubun;
	private String q_media;
	private String q_media_point;
	private String q_sound;
	private String reftitle;
	private String refbody1;
	private String refbody2;
	private String refbody3;
	private Timestamp up_date;
	private String subject_id;
	private String week_time;
	private int make_cnt;
	
	public void setId_q(long id_q) {
		this.id_q = id_q;
	}
	public void setId_subject(String id_subject) {
		this.id_subject = id_subject;
	}
	public void setId_chapter(String id_chapter) {
		this.id_chapter = id_chapter;
	}
	public void setId_chapter2(String id_chapter2) {
		this.id_chapter2 = id_chapter2;
	}
	public void setId_chapter3(String id_chapter3) {
		this.id_chapter3 = id_chapter3;
	}
	public void setId_chapter4(String id_chapter4) {
		this.id_chapter4 = id_chapter4;
	}
	public void setId_ref(String id_ref) {
		this.id_ref = id_ref;
	}
	public void setId_qtype(int id_qtype) {
		this.id_qtype = id_qtype;
	}
	public void setExcount(int excount) {
		this.excount = excount;
	}
	public void setCacount(int cacount) {
		this.cacount = cacount;
	}
	public void setAllotting(double allotting) {
		this.allotting = allotting;
	}
	public void setLimittime(int limittime) {
		this.limittime = limittime;
	}
	public void setId_difficulty1(int id_difficulty1) {
		this.id_difficulty1 = id_difficulty1;
	}
	public void setId_difficulty2(int id_difficulty2) {
		this.id_difficulty2 = id_difficulty2;
	}
	public void setQ(String q) {
		this.q = q;
	}
	public void setEx1(String ex1) {
		this.ex1 = ex1;
	}
	public void setEx2(String ex2) {
		this.ex2 = ex2;
	}
	public void setEx3(String ex3) {
		this.ex3 = ex3;
	}
	public void setEx4(String ex4) {
		this.ex4 = ex4;
	}
	public void setEx5(String ex5) {
		this.ex5 = ex5;
	}
	public void setEx6(String ex6) {
		this.ex6 = ex6;
	}
	public void setEx7(String ex7) {
		this.ex7 = ex7;
	}
	public void setEx8(String ex8) {
		this.ex8 = ex8;
	}
	public void setCa(String ca) {
		this.ca = ca;
	}
	public void setYn_caorder(String yn_caorder) {
		this.yn_caorder = yn_caorder;
	}
	public void setYn_case(String yn_case) {
		this.yn_case = yn_case;
	}
	public void setYn_blank(String yn_blank) {
		this.yn_blank = yn_blank;
	}
	public void setExplain(String explain) {
		this.explain = explain;
	}
	public void setHint(String hint) {
		this.hint = hint;
	}
	public void setSrc_book(String src_book) {
		this.src_book = src_book;
	}
	public void setSrc_author(String src_author) {
		this.src_author = src_author;
	}
	public void setSrc_page(String src_page) {
		this.src_page = src_page;
	}
	public void setSrc_pub_comp(String src_pub_comp) {
		this.src_pub_comp = src_pub_comp;
	}
	public void setSrc_pub_year(String src_pub_year) {
		this.src_pub_year = src_pub_year;
	}
	public void setSrc_misc(String src_misc) {
		this.src_misc = src_misc;
	}
	public void setFind_kwd(String find_kwd) {
		this.find_kwd = find_kwd;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public void setId_valid_type(int id_valid_type) {
		this.id_valid_type = id_valid_type;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	public void setId_q_use(int id_q_use) {
		this.id_q_use = id_q_use;
	}
	public void setQ_use_detail(String q_use_detail) {
		this.q_use_detail = q_use_detail;
	}
	public void setEx_rowcnt(int ex_rowcnt) {
		this.ex_rowcnt = ex_rowcnt;
	}
	public void setYn_single_line(String yn_single_line) {
		this.yn_single_line = yn_single_line;
	}
	public void setQ_chapter(String q_chapter) {
		this.q_chapter = q_chapter;
	}
	public void setQ_gubun(String q_gubun) {
		this.q_gubun = q_gubun;
	}
	public void setQ_media(String q_media) {
		this.q_media = q_media;
	}
	public void setQ_media_point(String q_media_point) {
		this.q_media_point = q_media_point;
	}
	public void setQ_sound(String q_sound) {
		this.q_sound = q_sound;
	}
	public void setReftitle(String reftitle) {
		this.reftitle = reftitle;
	}
	public void setRefbody1(String refbody1) {
		this.refbody1 = refbody1;
	}
	public void setRefbody2(String refbody2) {
		this.refbody2 = refbody2;
	}
	public void setRefbody3(String refbody3) {
		this.refbody3 = refbody3;
	}
	public void setUp_date(Timestamp up_date) {
		this.up_date = up_date;
	}
	public void setSubject_id(String subject_id) {
		this.subject_id = subject_id;
	}
	public void setWeek_time(String week_time) {
		this.week_time = week_time;
	}
	public void setMake_cnt(int make_cnt) {
		this.make_cnt = make_cnt;
	}
	
	public long getId_q() {
		return id_q;
	}
	public String getId_subject() {
		return id_subject;
	}
	public String getId_chapter() {
		return id_chapter;
	}
	public String getId_chapter2() {
		return id_chapter2;
	}
	public String getId_chapter3() {
		return id_chapter3;
	}
	public String getId_chapter4() {
		return id_chapter4;
	}
	public String getId_ref() {
		return id_ref;
	}
	public int getId_qtype() {
		return id_qtype;
	}
	public int getExcount() {
		return excount;
	}
	public int getCacount() {
		return cacount;
	}
	public double getAllotting() {
		return allotting;
	}
	public int getLimittime() {
		return limittime;
	}
	public int getId_difficulty1() {
		return id_difficulty1;
	}
	public int getId_difficulty2() {
		return id_difficulty2;
	}
	public String getQ() {
		return q;
	}
	public String getEx1() {
		return ex1;
	}
	public String getEx2() {
		return ex2;
	}
	public String getEx3() {
		return ex3;
	}
	public String getEx4() {
		return ex4;
	}
	public String getEx5() {
		return ex5;
	}
	public String getEx6() {
		return ex6;
	}
	public String getEx7() {
		return ex7;
	}
	public String getEx8() {
		return ex8;
	}
	public String getCa() {
		return ca;
	}
	public String getYn_caorder() {
		return yn_caorder;
	}
	public String getYn_case() {
		return yn_case;
	}
	public String getYn_blank() {
		return yn_blank;
	}
	public String getExplain() {
		return explain;
	}
	public String getHint() {
		return hint;
	}
	public String getSrc_book() {
		return src_book;
	}
	public String getSrc_author() {
		return src_author;
	}
	public String getSrc_page() {
		return src_page;
	}
	public String getSrc_pub_comp() {
		return src_pub_comp;
	}
	public String getSrc_pub_year() {
		return src_pub_year;
	}
	public String getSrc_misc() {
		return src_misc;
	}
	public String getFind_kwd() {
		return find_kwd;
	}
	public String getUserid() {
		return userid;
	}
	public int getId_valid_type() {
		return id_valid_type;
	}
	public String getRegdate() {
		return regdate;
	}
	public int getId_q_use() {
		return id_q_use;
	}
	public String getQ_use_detail() {
		return q_use_detail;
	}
	public int getEx_rowcnt() {
		return ex_rowcnt;
	}
	public String getYn_single_line() {
		return yn_single_line;
	}
	public String getQ_chapter() {
		return q_chapter;
	}
	public String getQ_gubun() {
		return q_gubun;
	}
	public String getQ_media() {
		return q_media;
	}
	public String getQ_media_point() {
		return q_media_point;
	}
	public String getQ_sound() {
		return q_sound;
	}		
	public String getReftitle() {
		return reftitle;
	}
	public String getRefbody1() {
		return refbody1;
	}
	public String getRefbody2() {
		return refbody2;
	}
	public String getRefbody3() {
		return refbody3;
	}
	public Timestamp getUp_date() {
		return up_date;
	}
	public String getSubject_id() {
		return subject_id;
	}
	public String getWeek_time() {
		return week_time;
	}
	public int getMake_cnt() {
		return make_cnt;
	}
}	
package qmtm.monitor;

import java.sql.Timestamp;

public class ExamMonitorBean
{
	private String userid;
	private String password;
	private String name;
	private String social_no;
	private String email;
	private String home_postcode;
	private String home_addr1;
	private String home_addr2;
	private String home_phone;
	private String mobile_phone;
	private String sosok1;
	private String sosok2;
	private Timestamp regdate;		
	private int nr_set;
	private Timestamp start_time;
	private Timestamp end_time;
	private String yn_end;
	private double score;
	private double score_bak;
	private String sscore_log;
	private String user_ip;
	
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public void setName(String name) {
		this.name = name;
	}
	public void setSocial_no(String social_no) {
		this.social_no = social_no;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public void setHome_postcode(String home_postcode) {
		this.home_postcode = home_postcode;
	}
	public void setHome_addr1(String home_addr1) {
		this.home_addr1 = home_addr1;
	}
	public void setHome_addr2(String home_addr2) {
		this.home_addr2 = home_addr2;
	}
	public void setHome_phone(String home_phone) {
		this.home_phone = home_phone;
	}
	public void setMobile_phone(String mobile_phone) {
		this.mobile_phone = mobile_phone;
	}
	public void setSosok1(String sosok1) {
		this.sosok1 = sosok1;
	}
	public void setSosok2(String sosok2) {
		this.sosok2 = sosok2;
	}
	public void setRegdate(Timestamp regdate) {
		this.regdate = regdate;
	}
	public void setNr_set(int nr_set) {
		this.nr_set = nr_set;
	}
	public void setStart_time(Timestamp start_time) {
		this.start_time = start_time;
	}
	public void setEnd_time(Timestamp end_time) {
		this.end_time = end_time;
	}
	public void setYn_end(String yn_end) {
		this.yn_end = yn_end;
	}
	public void setScore(double score) {
		this.score = score;
	}
	public void setScore_bak(double score_bak) {
		this.score_bak = score_bak;
	}
	public void setSscore_log(String sscore_log) {
		this.sscore_log = sscore_log;
	}
	public void setUser_ip(String user_ip) {
		this.user_ip = user_ip;
	}
	public String getUserid() {
		return userid;
	}
	public String getPassword() {
		return password;
	}
	public String getName() {
		return name;
	}
	public String getSocial_no() {
		return social_no;
	}
	public String getEmail() {
		return email;
	}
	public String getHome_postcode() {
		return home_postcode;
	}
	public String getHome_addr1() {
		return home_addr1;
	}
	public String getHome_addr2() {
		return home_addr2;
	}
	public String getHome_phone() {
		return home_phone;
	}
	public String getMobile_phone() {
		return mobile_phone;
	}
	public String getSosok1() {
		return sosok1;
	}
	public String getSosok2() {
		return sosok2;
	}
	public Timestamp getRegdate() {
		return regdate;
	}
	public int getNr_set() {
		return nr_set;
	}
	public Timestamp getStart_time() {
		return start_time;
	}
	public Timestamp getEnd_time() {
		return end_time;
	}
	public String getYn_end() {
		return yn_end;
	}
	public double getScore() {
		return score;
	}
	public double getScore_bak() {
		return score_bak;
	}
	public String getSscore_log() {
		return sscore_log;
	}
	public String getUser_ip() {
		return user_ip;
	}	
}
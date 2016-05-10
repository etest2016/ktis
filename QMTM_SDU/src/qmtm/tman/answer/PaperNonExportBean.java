package qmtm.tman.answer;

public class PaperNonExportBean {
	
	private String userid;
	private String name;
	private String q;
	private double allotting;
	private String userans1;
	private String userans2;
	private String userans3;
	private String userans4;
	private String userans5;	
	private int nr_q;
	private long id_q;
	
	public PaperNonExportBean() {
	}
		
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public void setName(String name) {
		this.name = name;
	}	
	public void setQ(String q) {
		this.q = q;
	}	
	public void setAllotting(double allotting) {
		this.allotting = allotting;
	}	
	public void setUserans1(String userans1) {
		this.userans1 = userans1;
	}	
	public void setUserans2(String userans2) {
		this.userans2 = userans2;
	}	
	public void setUserans3(String userans3) {
		this.userans3 = userans3;
	}	
	public void setUserans4(String userans4) {
		this.userans4 = userans4;
	}	
	public void setUserans5(String userans5) {
		this.userans5 = userans5;
	}	
	public void setNr_q(int nr_q) {
		this.nr_q = nr_q;
	}
	public void setId_q(long id_q) {
		this.id_q = id_q;
	}
	
	public String getUserid() {
		return userid;
	}
	public String getName() {
		return name;
	}
	public String getQ() {
		return q;
	}
	public double getAllotting() {
		return allotting;
	}
	public String getUserans1() {
		return userans1;
	}
	public String getUserans2() {
		return userans2;
	}
	public String getUserans3() {
		return userans3;
	}
	public String getUserans4() {
		return userans4;
	}
	public String getUserans5() {
		return userans5;
	}
	public int getNr_q() {
		return nr_q;
	}
	public long getId_q() {
		return id_q;
	}
}
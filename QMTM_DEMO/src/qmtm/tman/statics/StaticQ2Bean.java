package qmtm.tman.statics;

public class StaticQ2Bean {

	private long id_q;	
	private int nr_q;
	private double allotting;

	public StaticQ2Bean() {	
	}
	
	public void setId_q(long id_q) {
		this.id_q = id_q;
	}	
	public void setNr_q(int nr_q) {
		this.nr_q = nr_q;
	}
	public void setAllotting(double allotting) {
		this.allotting = allotting;
	}
	
	public long getId_q() {
		return id_q;
	}
	public int getNr_q() {
		return nr_q;
	}
	public double getAllotting() {
		return allotting;
	}
}	
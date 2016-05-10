package etest.paper;

public class User_PaperList2Bean {
	private int nr_q;
	private String guide_msg;

	public User_PaperList2Bean() {
		this.nr_q = 0;
		this.guide_msg = "";
	}

	public void setNr_q(int nr_q) {
		this.nr_q = nr_q;
	}

	public void setGuide_msg(String guide_msg) {
		this.guide_msg = guide_msg;
	}

	public int getNr_q() {
		return nr_q;
	}

	public String getGuide_msg() {
		return guide_msg;
	}

}

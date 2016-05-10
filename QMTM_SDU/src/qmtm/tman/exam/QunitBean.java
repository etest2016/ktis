package qmtm.tman.exam;

import qmtm.*;

public class QunitBean {
	
	private long id_q;
	private int id_qtype;
	private String ex_order;
	private int excount;
	private int cacount;
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
	private String explain;
	private int id_valid_type;
    private int[] arrEx_order;
    private String[] arrEx;
	private String id_ref;
	private String reftitle;
    private String refbody1;
    private String refbody2;
    private String refbody3;
	private String refbody;
	private String userid;
	private String regdate;
	private String up_date;
	private String qtype;
	private String difficulty;
	private int make_cnt;
	
	public QunitBean()
    {
        this.id_q = 0;
        this.id_qtype = 0;
		this.ex_order = "";
        this.excount = 0;
        this.cacount = 0;
        this.q = "";
        this.ex1 = "";
        this.ex2 = "";
        this.ex3 = "";
        this.ex4 = "";
        this.ex5 = "";
		this.ex6 = "";
		this.ex7 = "";
		this.ex8 = "";
        this.ca = "";
	    this.explain = "";
        this.id_valid_type = 0;
        this.arrEx = new String[] {"", "", "", "", "", "", "", ""};
        this.arrEx_order = new int[] {0, 0, 0, 0, 0, 0, 0, 0};
		this.id_ref = "0";
		this.reftitle = "";
        this.refbody1 = "";
        this.refbody2 = "";
        this.refbody3 = "";
		this.refbody = "";
		this.userid = "";
		this.regdate = "";
		this.up_date = "";
		this.qtype = "";
		this.difficulty = "";
		this.make_cnt = 0;		
	}
	
	public void setId_q(long id_q) {
		this.id_q = id_q;
	}
	public void setId_qtype(int id_qtype) {
		this.id_qtype = id_qtype;
	}
	public void setEx_order(String ex_order)
    {
        if (ex_order != null) { this.ex_order = ex_order; }
        if (this.ex_order.length() > 0) {
            String[] arr = this.ex_order.split(",");
            for (int i = 0; i < arr.length; i++) {
                if (arr[i].length() == 0) { arr[i] = "0"; }
                this.arrEx_order[i] = Integer.parseInt(arr[i]);
            }
        }
    }
	public void setQ(String q) {
        if (q == null) q = "";
        this.q = q;
    }
	public void setExcount(int excount) {
		this.excount = excount;
	}
	public void setCacount(int cacount) {
		this.cacount = cacount;
	}
	public void setEx1(String ex1) {
        if (ex1 == null) ex1 = "";
        this.ex1 = ex1;
        int j = 0;
        for (j = 0; j < arrEx_order.length; j++) {
            if (arrEx_order[j] == 1) {
                arrEx[j] = this.ex1;
            }
        }
    }

    public void setEx2(String ex2) {
        if (ex2 == null) ex2 = "";
        this.ex2 = ex2;
        int j = 0;
        for (j = 0; j < arrEx_order.length; j++) {
            if (arrEx_order[j] == 2) {
                arrEx[j] = this.ex2;
            }
        }
    }

    public void setEx3(String ex3) {
        if (ex3 == null) ex3 = "";
        this.ex3 = ex3;
        int j = 0;
        for (j = 0; j < arrEx_order.length; j++) {
            if (arrEx_order[j] == 3) {
                arrEx[j] = this.ex3;
            }
        }
    }

    public void setEx4(String ex4) {
        if (ex4 == null) ex4 = "";
        this.ex4 = ex4;
        int j = 0;
        for (j = 0; j < arrEx_order.length; j++) {
            if (arrEx_order[j] == 4) {
                arrEx[j] = this.ex4;
            }
        }
    }

    public void setEx5(String ex5) {
        if (ex5 == null) ex5 = "";
        this.ex5 = ex5;
        int j = 0;
        for (j = 0; j < arrEx_order.length; j++) {
            if (arrEx_order[j] == 5) {
                arrEx[j] = this.ex5;
            }
        }
    }

	public void setEx6(String ex6) {
        if (ex6 == null) ex6 = "";
        this.ex6 = ex6;
        int j = 0;
        for (j = 0; j < arrEx_order.length; j++) {
            if (arrEx_order[j] == 6) {
                arrEx[j] = this.ex6;
            }
        }
    }

	public void setEx7(String ex7) {
        if (ex7 == null) ex7 = "";
        this.ex7 = ex7;
        int j = 0;
        for (j = 0; j < arrEx_order.length; j++) {
            if (arrEx_order[j] == 7) {
                arrEx[j] = this.ex7;
            }
        }
    }

	public void setEx8(String ex8) {
        if (ex8 == null) ex8 = "";
        this.ex8 = ex8;
        int j = 0;
        for (j = 0; j < arrEx_order.length; j++) {
            if (arrEx_order[j] == 8) {
                arrEx[j] = this.ex8;
            }
        }
    }
	public void setCa(String ca) {
		this.ca = ca;
	}
	public void setExplain(String explain) {
		this.explain = explain;
	}

	public void setId_valid_type(int id_valid_type) {
        this.id_valid_type = id_valid_type;
    }

	public void setId_ref(String id_ref) {
		this.id_ref = id_ref;
	}

	public void setReftitle(String reftitle) {
        if (reftitle == null) reftitle = "";
        this.reftitle = reftitle;
    }

    public void setRefbody1(String refbody1) {
        if (refbody1 == null) refbody1 = "";
        this.refbody1 = refbody1;
    }

    public void setRefbody2(String refbody2) {
        if (refbody2 == null) refbody2 = "";
        this.refbody2 = refbody2;
    }

    public void setRefbody3(String refbody3) {
        if (refbody3 == null) refbody3 = "";
        this.refbody3 = refbody3;
        this.refbody = this.refbody1 + this.refbody2 + this.refbody3;
    }
		
	public void setUserid(String userid) {
		this.userid = userid;
	}

	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}

	public void setUp_date(String up_date) {
		this.up_date = up_date;
	}

	public void setQtype(String qtype) {
		this.qtype = qtype;
	}

	public void setDifficulty(String difficulty) {
		this.difficulty = difficulty;
	}

	public void setMake_cnt(int make_cnt) {
		this.make_cnt = make_cnt;
	}
	
	public long getId_q() {
		return id_q;
	}
	public int getId_qtype() {
		return id_qtype;
	}
	public String getQ() {
		return q;
	}
	public int getExcount() {
		return excount;
	}
	public int getCacount() {
		return cacount;
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
	public String getExplain() {
		return explain;
	}

	public int getId_valid_type() {
        return id_valid_type;
    }
	
	public int[] getArrEx_order() {
        return arrEx_order;
    }

    public String[] getArrEx() {
        return arrEx;
    }

	public String getId_ref() {
		return id_ref;
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

	public String getRefbody() {
        return refbody;
    }

	public String getUserid() {
		return userid;
	}

	public String getRegdate() {
		return regdate;
	}

	public String getUp_date() {
		return up_date;
	}

	public String getQtype() {
		return qtype;
	}

	public String getDifficulty() {
		return difficulty;
	}

	public int getMake_cnt() {
		return make_cnt;
	}
	
}	
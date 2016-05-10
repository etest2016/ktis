package qmtm.common;

import qmtm.*;

public class ExamPaper3Bean
{
    private int nr_q;
    private long id_q;
    private String ex_order;
    private double allotting;
    private int page;
    private int q_no1;
    private int q_no2;
    private String id_ref;
    private int id_qtype;
    private int excount;
    private int cacount;
    private String q;
    private String ex1;
    private String ex2;
    private String ex3;
    private String ex4;
    private String ex5;
    private String ca;
    private String hint;
    private String explain;
	private String q_chapter;
    private int id_valid_type;
    private String reftitle;
    private String refbody1;
    private String refbody2;
    private String refbody3;
    private String userans1;
    private String userans2;
    private String userans3;
    private String nonCheck;
    private String refbody;
    private String userans;
    private int[] arrEx_order;
    private String[] arrEx;
	private String yn_single_line;
	private int ex_rowcnt;
	private String q_sound;

    public ExamPaper3Bean()
    {
        this.nr_q = 0;
        this.id_q = 0;
        this.ex_order = "";
        this.allotting = 0;
        this.page = 0;
        this.q_no1 = 0;
        this.q_no2 = 0;
        this.id_ref = "";
        this.id_qtype = 0;
        this.excount = 0;
        this.cacount = 0;
        this.q = "";
        this.ex1 = "";
        this.ex2 = "";
        this.ex3 = "";
        this.ex4 = "";
        this.ex5 = "";
        this.ca = "";
        this.hint = "";
        this.explain = "";
		this.q_chapter = "";
        this.id_valid_type = 0;
        this.reftitle = "";
        this.refbody1 = "";
        this.refbody2 = "";
        this.refbody3 = "";
        this.userans1 = "";
        this.userans2 = "";
        this.userans3 = "";
        this.nonCheck = "";
        this.refbody = "";
        this.userans = "";
        this.arrEx = new String[] {"", "", "", "", ""};
        this.arrEx_order = new int[] {0, 0, 0, 0, 0};
		this.yn_single_line = "N";
		this.ex_rowcnt = 1;
		this.q_sound = "";
    }

    public void setNr_q(int nr_q) {
        this.nr_q = nr_q;
    }

    public void setId_q(long id_q) {
        this.id_q = id_q;
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

    public void setAllotting(double allotting) {
        this.allotting = allotting;
    }

    public void setPage(int page) {
        this.page = page;
    }

    public void setQ_no1(int q_no1) {
        this.q_no1 = q_no1;
    }

    public void setQ_no2(int q_no2) {
        this.q_no2 = q_no2;
    }

    public void setId_ref(String id_ref) {
        if (id_ref == null) id_ref = "";
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

    public void setQ(String q) {
        if (q == null) q = "";
        this.q = QmTm.delTag(q);
    }

    public void setEx1(String ex1) {
        if (ex1 == null) ex1 = "";
        this.ex1 = QmTm.delTag(ex1);
        int j = 0;
        for (j = 0; j < arrEx_order.length; j++) {
            if (arrEx_order[j] == 1) {
                arrEx[j] = this.ex1;
            }
        }
    }

    public void setEx2(String ex2) {
        if (ex2 == null) ex2 = "";
        this.ex2 = QmTm.delTag(ex2);
        int j = 0;
        for (j = 0; j < arrEx_order.length; j++) {
            if (arrEx_order[j] == 2) {
                arrEx[j] = this.ex2;
            }
        }
    }

    public void setEx3(String ex3) {
        if (ex3 == null) ex3 = "";
        this.ex3 = QmTm.delTag(ex3);
        int j = 0;
        for (j = 0; j < arrEx_order.length; j++) {
            if (arrEx_order[j] == 3) {
                arrEx[j] = this.ex3;
            }
        }
    }

    public void setEx4(String ex4) {
        if (ex4 == null) ex4 = "";
        this.ex4 = QmTm.delTag(ex4);
        int j = 0;
        for (j = 0; j < arrEx_order.length; j++) {
            if (arrEx_order[j] == 4) {
                arrEx[j] = this.ex4;
            }
        }
    }

    public void setEx5(String ex5) {
        if (ex5 == null) ex5 = "";
        this.ex5 = QmTm.delTag(ex5);
        int j = 0;
        for (j = 0; j < arrEx_order.length; j++) {
            if (arrEx_order[j] == 5) {
                arrEx[j] = this.ex5;
            }
        }
    }

    public void setCa(String ca) {
        if (ca == null) ca = "";
        this.ca = ca;
    }

    public void setHint(String hint) {
        if (hint == null) hint = "";
        this.hint = hint;
    }

    public void setExplain(String explain) {
        if (explain == null) explain = "";
        this.explain = explain;
    }

	public void setQ_chapter(String q_chapter) {
        if (q_chapter == null) q_chapter = "";
        this.q_chapter = q_chapter;
    }

    public void setId_valid_type(int id_valid_type) {
        this.id_valid_type = id_valid_type;
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

    public void setRefbody3(String refbody3)
    {
        if (refbody3 == null) refbody3 = "";
        this.refbody3 = refbody3;
        this.refbody = this.refbody1 + this.refbody2 + this.refbody3;
    }

    public void setUserans1(String userans1)
    {
        if (userans1 == null) userans1 = "";
        this.userans1 = userans1;
    }

    public void setUserans2(String userans2) {
        if (userans2 == null) userans2 = "";
        this.userans2 = userans2;
    }

    public void setUserans3(String userans3)
    {
        if (userans3 == null) userans3 = "";
        this.userans3 = userans3;

        this.userans = this.userans1 + this.userans2 + this.userans3;

        if (this.id_qtype == 5) {
            if (this.userans.length() > 0) { this.nonCheck = "Y"; }
            else { this.nonCheck = "N"; }
        } else { this.nonCheck = ""; }
    }
	
	public void setYn_single_line(String yn_single_line)
	{
		this.yn_single_line = yn_single_line;
	}

	public void setEx_rowcnt(int ex_rowcnt)
	{
		this.ex_rowcnt = ex_rowcnt;
	}

	public void setQ_sound(String q_sound)
	{
		this.q_sound = q_sound;
	}

    public int getNr_q() {
        return nr_q;
    }

    public long getId_q() {
        return id_q;
    }

    public String getEx_order() {
        return ex_order;
    }

    public double getAllotting() {
        return allotting;
    }

    public int getPage() {
        return page;
    }

    public int getQ_no1() {
        return q_no1;
    }

    public int getQ_no2() {
        return q_no2;
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

    public String getCa() {
        return ca;
    }

    public String getHint() {
        return hint;
    }

    public String getExplain() {
        return explain;
    }

	public String getQ_chapter() {
        return q_chapter;
    }

    public int getId_valid_type() {
        return id_valid_type;
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

    public String getUserans1() {
        return userans1;
    }

    public String getUserans2() {
        return userans2;
    }

    public String getUserans3() {
        return userans3;
    }

    public String getNonCheck() {
        return nonCheck;
    }

    public String getRefbody() {
        return refbody;
    }

    public String getUserans() {
        return userans;
    }

    public int[] getArrEx_order() {
        return arrEx_order;
    }

    public String[] getArrEx() {
        return arrEx;
    }
	
	public String getYn_single_line() {
		return yn_single_line;
	}

	public int getEx_rowcnt() {
		return ex_rowcnt;
	}

	public String getQ_sound() {
		return q_sound;
	}
}

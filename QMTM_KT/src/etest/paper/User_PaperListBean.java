package etest.paper;

import java.sql.*;

public class User_PaperListBean
{
    private int id_q;
    private String front_msg;
	private String back_msg;
	private String box_size;
    
    public User_PaperListBean()
    {
        this.id_q = 0;
		this.front_msg = "";
		this.back_msg = "";
		this.box_size = "20";
	}

    public void setId_q(int id_q) {
        this.id_q = id_q;
    }

    public void setFront_msg(String front_msg) {
        this.front_msg = front_msg;
    }

	public void setBack_msg(String back_msg) {
        this.back_msg = back_msg;
    }

	public void setBox_size(String box_size) {
        this.box_size = box_size;
    }
    
    public int getId_q() {
        return id_q;
    }

    public String getFront_msg() {
        return front_msg;
    }

	public String getBack_msg() {
        return back_msg;
    }

	public String getBox_size() {
		return box_size;
	}
}

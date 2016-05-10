package qmtm.qman.editor;

public class QMsgBean {	
	
	private String front_msg;
	private String back_msg;
	private String box_size;

	public void setFront_msg(String front_msg) {
		this.front_msg = front_msg;
	}
	public void setBack_msg(String back_msg) {
		this.back_msg = back_msg;
	}
	public void setBox_size(String box_size) {
		this.box_size = box_size;
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
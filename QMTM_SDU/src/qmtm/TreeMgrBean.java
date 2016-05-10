package qmtm;

import java.sql.Timestamp;

public class TreeMgrBean {
	
	private String id_midcategory;
	private String midcategory;

	private String id_node;
	private String id_parentnode;
	private String node_name;
	private String node_gubun;
	private Timestamp regdate;
	private int chapter_order;
	private String terms;

	public TreeMgrBean() {
	}
		
	public void setId_midcategory(String id_midcategory) {
		this.id_midcategory = id_midcategory;
	}
	public void setMidcategory(String midcategory) {
		this.midcategory = midcategory;
	}
	public void setId_node(String id_node) {
		this.id_node = id_node;
	}
	public void setId_parentnode(String id_parentnode) {
		this.id_parentnode = id_parentnode;
	}
	public void setNode_name(String node_name) {
		this.node_name = node_name;
	}	
	public void setNode_gubun(String node_gubun) {
		this.node_gubun = node_gubun;
	}	
	public void setRegdate(Timestamp regdate) {
		this.regdate = regdate;
	}
	public void setChapter_order(int chapter_order) {
		this.chapter_order = chapter_order;
	}
	public void setTerms(String terms) {
		this.terms = terms;
	}
	
	public String getId_midcategory() {
		return id_midcategory;
	}
	public String getMidcategory() {
		return midcategory;
	}
	public String getId_node() {
		return id_node;
	}
	public String getId_parentnode() {
		return id_parentnode;
	}
	public String getNode_name() {
		return node_name;
	}	
	public String getNode_gubun() {
		return node_gubun;
	}	
	public Timestamp getRegdate() {
		return regdate;
	}
	public int getChapter_order() {
		return chapter_order;
	}
	public String getTerms() {
		return terms;
	}	
}
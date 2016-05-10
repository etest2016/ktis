package qmtm;

import java.sql.Timestamp;

public class TreeBean {
	
	private String id_node;
	private String id_parentnode;
	private int node_order;
	private String node_name;
	private String node_gubun;
	private Timestamp regdate;
	private String term_id;
	private String subject_id;
	private int chapter_order;

	public TreeBean() {
	}
	
	public void setId_node(String id_node) {
		this.id_node = id_node;
	}
	public void setId_parentnode(String id_parentnode) {
		this.id_parentnode = id_parentnode;
	}
	public void setNode_order(int node_order) {
		this.node_order = node_order;
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
	public void setTerm_id(String term_id) {
		this.term_id = term_id;
	}	
	public void setSubject_id(String subject_id) {
		this.subject_id = subject_id;
	}
	public void setChapter_order(int chapter_order) {
		this.chapter_order = chapter_order;
	}
	
	public String getId_node() {
		return id_node;
	}
	public String getId_parentnode() {
		return id_parentnode;
	}
	public int getNode_order() {
		return node_order;
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
	public String getTerm_id() {
		return term_id;
	}	
	public String getSubject_id() {
		return subject_id;
	}
	public int getChapter_order() {
		return chapter_order;
	}
}

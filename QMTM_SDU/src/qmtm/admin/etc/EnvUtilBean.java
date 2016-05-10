package qmtm.admin.etc;

import java.sql.Timestamp;

public class EnvUtilBean {
	
	private String http_files_url;
	private String qmtm_web_home;
	private String ftp_host_ip;
	private String ftp_port;
	private String ftp_files_dir;
	private String ftp_id;
	private String ftp_password;

	public EnvUtilBean() {
	}
		
	public void setHttp_files_url(String http_files_url) {
		this.http_files_url = http_files_url;
	}
	public void setQmtm_web_home(String qmtm_web_home) {
		this.qmtm_web_home = qmtm_web_home;
	}
	public void setFtp_host_ip(String ftp_host_ip) {
		this.ftp_host_ip = ftp_host_ip;
	}	
	public void setFtp_port(String ftp_port) {
		this.ftp_port = ftp_port;
	}
	public void setFtp_files_dir(String ftp_files_dir) {
		this.ftp_files_dir = ftp_files_dir;
	}
	public void setFtp_id(String ftp_id) {
		this.ftp_id = ftp_id;
	}
	public void setFtp_password(String ftp_password) {
		this.ftp_password = ftp_password;
	}
		
	public String getHttp_files_url() {
		return http_files_url;
	}
	public String getQmtm_web_home() {
		return qmtm_web_home;
	}
	public String getFtp_host_ip() {
		return ftp_host_ip;
	}	
	public String getFtp_port() {
		return ftp_port;
	}
	public String getFtp_files_dir() {
		return ftp_files_dir;
	}
	public String getFtp_id() {
		return ftp_id;
	}
	public String getFtp_password() {
		return ftp_password;
	}
}
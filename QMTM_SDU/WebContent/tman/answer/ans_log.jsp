<%
//******************************************************************************
//   프로그램 : ans_log.jsp
//   모 듈 명 : 응시자 답안 로그
//   설    명 : 응시자 답안 로그
//   테 이 블 : 
//   자바파일 : 
//   작 성 일 : 2008-05-30
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, etest.*, qmtm.tman.exam.*, java.sql.*, java.util.*, java.net.*, java.io.*, qmtm.admin.etc.EnvUtil, qmtm.admin.etc.EnvUtilBean, org.apache.commons.net.ftp.*" %>
<%@ include file = "/common/login_chk.jsp" %>
<%
    response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }

	String userid = request.getParameter("userid");
	if (userid == null) { userid = ""; } else { userid = userid.trim(); }
	
	if (id_exam.length() == 0 || userid.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

    int                  i_tot_cnt  = 0;
    String               exlabel    = "①,②,③,④,⑤,⑥,⑦,⑧,";
    String[] ArrExlabel             = exlabel.split(",");

	EnvUtilBean evbean = null;
	
	try {
		evbean = EnvUtil.getSetInfo();
	} catch(Exception ex) {		
		out.println(ComLib.getExceptionMsg(ex, "close"));

	    if(true) return;
	}
	
	String web_path = evbean.getQmtm_web_home();
	String ftp_path = evbean.getHttp_files_url();
		
	String ftp_url = evbean.getFtp_host_ip();
	String ftp_port = evbean.getFtp_port();
	String ftp_dir = evbean.getFtp_files_dir();
	String ftp_username = evbean.getFtp_id();
	String ftp_pwd = evbean.getFtp_password();
	
	FTPClient ftpClient = null;
	
	boolean result = false;
	
	try {
		//******************* FTP 연결시작 *********************
		int port = Integer.parseInt(ftp_port);
						
		ftpClient = new FTPClient();
							
		ftpClient.setControlEncoding("euc-kr");		
		ftpClient.connect(ftp_url,port);
							
		int reply = ftpClient.getReplyCode();
	
		if(!FTPReply.isPositiveCompletion(reply)) {
			ftpClient.disconnect();
			out.println("FTP server에 접속이 되지 않습니다.");
			if(true) return;
		}
									
		ftpClient.setSoTimeout(10000);
		ftpClient.login(ftp_username, ftp_pwd);
	
		// default FTP.ASCII_FILE_TYPE 
		ftpClient.setFileType(FTP.BINARY_FILE_TYPE); //FTP.ASCII_FILE_TYPE, FTP.EBCDIC_FILE_TYPE, FTP.IMAGE_FILE_TYPE , FTP.LOCAL_FILE_TYPE 
		// default FTP.STREAM_TRANSFER_MODE 
		ftpClient.setFileTransferMode(FTP.STREAM_TRANSFER_MODE); //FTP.BLOCK_TRANSFER_MODE, FTP.COMPRESSED_TRANSFER_MODE
						
		ftpClient.makeDirectory("/ROOT/ansUserLog/"+id_exam);				
		//******************* FTP 연결종료 *********************
		
		String strSavePath = "D:/QMTM/WebContent/logs/"+id_exam;
				
		String downPath = strSavePath+"/"+userid+"_ans.txt";
		String upPath = "/ROOT/ansUserLog/"+id_exam+"/"+userid+"_ans.txt";
		File put_file = new File(downPath);
				
		InputStream inputStream = new FileInputStream(put_file);
		result = ftpClient.storeFile(upPath, inputStream);
							
		inputStream.close();
	
		if (result) {
		} else {
			out.println("파일 업로드에 실패하였습니다.");
			ftpClient.logout();	
			ftpClient.disconnect();
			if(true) return;		
		}		
	
		ftpClient.logout();
		//******************* FTP 업로드 종료 **********************

	} catch(Exception ex) {
		out.println("파일  업로드 중 문제가 발생하였습니다.");
		if(true) return;
	} finally {
		if (ftpClient != null && ftpClient.isConnected()) {
			try {
				ftpClient.disconnect();
			} catch (Exception ex) {				
			}
		}
	}
    
    
    String[] ArrUrls = new String[1];

    ArrUrls[0] = "http://182.252.0.173:2010/ansUserLog/"+id_exam+"/"+userid+"_ans.txt";

    String[] logs = new String[1];
    int svr_no = 1;

	LogAnswerBean[] log = null;
			
	try {
		log = Log.getBeans(id_exam, userid);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

		if(true) return;
	}
	
	if(log.length == 0) {
		i_tot_cnt = 0;
	} else {
		i_tot_cnt = log.length;
	}

	String[] tmpAns = new String[i_tot_cnt];
%>

<html>
<head><title>답안로그 조회</title>
<style type="text/css">
  body      { font-size: 10pt; font-family: 굴림체; }
  table     { font-size: 10pt; font-family: 굴림체; line-height: 150%; }
</style>
<script type="text/javascript" src="../../js/tablesort.js"></script>
<script type="text/javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/jquery.etest.poster.js"></script>
<script language="javascript">
function ftnRecovery(svr_no, pidx, pid_q) {

	var mywin;
	if (confirm("선택한 답안을 복구 하시겠습니까?") == true) {
		mywin = window.open("", "recovery", "width=300, height=200, toolbar=no, location=no, status=no, scrollbars=no, resizable=no");
		mywin.focus();
		eval("document.frmSend.recovery_ans.value = document.frmData.recovery" + svr_no + pidx + ".value;");
		document.frmSend.id_q.value = pid_q;
		document.frmSend.method = "post";
		document.frmSend.target = "recovery";
		document.frmSend.action = "ans_log_recovery.jsp";
		document.frmSend.submit();
	}
}
</script>
</head>
<BODY id="tman">
<form name="frmSend">
	<input type="hidden" name="id_exam" value="<%= id_exam %>">
	<input type="hidden" name="userid" value="<%= userid %>">
	<input type="hidden" name="id_q">
 <textarea name="recovery_ans" style="display:none"></textarea>  
</form>

<form name="frmData">
<table border="0" width="900">
	<tr>
		<td><font color="green"><B>* 남은시간(초)을 클릭하면 오름/내림차순으로 정렬됩니다.</B></font></td>
	</tr>
</table>
<table border="0" cellspacing="1" width="900" cellpadding="5" bgcolor="#7cb4d6" onclick="sortColumn(event)">
<THEAD>
	<tr align="center" >
  <td bgcolor="#E0E0E0">NO</td>
		<td bgcolor="#F7F7E8">저장시간</td>
		<td bgcolor="#F7F7E8" type="Number">남은시간(초)</td>
		<td bgcolor="#F7F7E8" type="Number">서버</td>
		<td bgcolor="#F7F7E8" type="Number">문제번호</td>
		<td bgcolor="#F7F7E8">답안</td>
		<td bgcolor="#F7F7E8">답안복구</td>
	</tr>
</THEAD>

<%
	int chk = 0;
	for(int i = 0; i < ArrUrls.length; i++) 
   {
	   File f = new File(DBPool.LOG_PATH+id_exam+"/"+userid+"_ans.txt");

	   if(f.exists()) {

		  chk = chk + 1;
	   }
   }

   if(chk <= 0) {
%>
<TBODY>
	<tr align="center">
        <td bgcolor="#F7F7E8" colspan="6">데이타가 없습니다.</td>
</TBODY>
<%
   } else {
%>
<TBODY>
<%
   for(int k = 0; k < ArrUrls.length; k++) 
   {
      URL url = new URL(ArrUrls[k]);

      //String files = url.getFile();
 
      InputStream in = url.openStream();
      Reader reader = new InputStreamReader(in);
      BufferedReader br = new BufferedReader(reader);
      StringWriter output = new StringWriter();
      BufferedWriter bw = new BufferedWriter(output);
      String line = br.readLine(); // read the first line      
      
      while(line != null) {
         
         bw.write(line, 0, line.length());
         bw.newLine();
         line = br.readLine();         
      }  

      br.close();
      bw.close();

      logs[k] = output.toString() + logs[k];

      String[] arrRecord = logs[k].split(DBPool.NL);

      Collection beans = new ArrayList();

      int idx = 0; 

      for (int i = 0; i < arrRecord.length-1; i++)
      {
         String[] arr = arrRecord[i].split(DBPool.FLD_KB, -1);

         idx = idx + 1;
%>
			<tr align="center" bgcolor="#FFFFFF">
              <td><%= idx %></td>
              <td><%= arr[6] %></td>
              <td><%= arr[5] %></td>
              <td><%=svr_no%></td>
              <% if(arr[2].equals("")) { %>
              <td>&nbsp;</td>
              <% } else { %>
              <td><%= arr[2] %></td>
              <% } %>
              <%
                 if(arr[2].equals("")) {
                   tmpAns = arr[4].split(QmTm.Q_GUBUN_re,-1);
                   
                   double lngMok = tmpAns.length / 10;
                   double lngSegment = tmpAns.length % 10;
                   
                   if(lngSegment > 0) {
                      lngMok = lngMok + 1;
                   }                   
              %>
              <td>
                  <table width="100%" border="1" cellspacing="0" cellpadding="3">
                     <tr align='center' bgcolor='#FFCC66' >
                        <td width="20%"><b>문제번호</b></td><td><b>1</b></td><td><b>2</b></td><td><b>3</b></td><td><b>4</b></td>
                        <td><b>5</b></td><td><b>6</b></td><td><b>7</b></td><td><b>8</b></td><td><b>9</b></td><td><b>10</b></td>
                     </tr>

              <%
                   int midx = 0;
					
                   for(int n = 0; n < lngMok; n++) {
              %> 
                   
                     <tr align=center>
                        <td bgcolor=#FFCC66 width="20%">
                        <b><%= n * 10 + 1 %> ~ <%= n * 10 + 10 %></b>
                        </td>
              <%
                      for(int m = 0; m < 10; m++) {
              %>
                        <td >
              <%
                      if(midx+1 > tmpAns.length)  { 
						  out.println("*");
                      } else {
                          int id_qtype = log[midx].getId_qtype(); 

                          if(id_qtype < 4) {
                             String ex_order = log[midx].getEx_order(); 

                             String[] ArrOrder = ex_order.split(",");

                                for (int p = 0; p < ArrOrder.length; p++) {
                                    if(tmpAns[midx].equals("")) {
              %>
                                    &nbsp;
              <%
                                    } else {
                                       
                                       if(ArrOrder[p].trim().equals(tmpAns[midx].trim())) {                                                    
              %>
                                           <%=ArrExlabel[p]%>
              <%                            
                                           break;
                                       }
                                    }        
                                } 
                            } else if(id_qtype == 4) {
                               if(tmpAns[midx].equals("")) { 
              %>
                               &nbsp;
              <%           
                               } else {
              %>
                               ☞ <%= tmpAns[midx].replaceAll(QmTm.LIKE_GUBUN_re, " 또는 ").replaceAll(QmTm.OR_GUBUN_re, "<BR>") %>
              <% 
                               } 
                           } else if(id_qtype == 5) {
              %>
                               논술              
              <% 
                           }  
                       }                       
              %>


                        </td>   
              <%             
							midx = midx + 1;
                      }

                   }
              %>
                    </tr> 
                  </table>
              </td>
              <% } else { %>
              <td align=left>&nbsp;<%= arr[4].replaceAll("│", "<br>") %></td>
              <% } %> 
              
			  <td><textarea name="recovery<%=svr_no%><%=idx%>" style="display:none"><%=arr[4]%></textarea><input type="button" value="복구하기" onclick="javascript:ftnRecovery(<%=svr_no%>, <%=idx%>,'<%=arr[3]%>');"></td>
        </tr>           
<%
      }
        svr_no = svr_no + 1;
	} 
}

%>

</TBODY>
</table>
</form>
</body>
</html>
<%
//******************************************************************************
//   ���α׷� : ans_event.jsp
//   �� �� �� : ������ �̺�Ʈ �α�
//   ��    �� : ������ �̺�Ʈ �α�
//   �� �� �� : 
//   �ڹ����� : 
//   �� �� �� : 2008-05-30
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="qmtm.*, qmtm.tman.exam.*, java.sql.*, java.util.*, java.net.*, java.io.*" %>

<%
    response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("euc-kr");

	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }

	if (id_exam.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

   String userid = request.getParameter("userid");

   String[] ArrUrls = new String[1];

   ArrUrls[0] = "http://10.18.152.24:9090/logs/"+id_exam+"/"+userid+"_evt.txt";

   String[] logs = new String[1];
   int svr_no = 1;
%>

<html>
<head>
<title>Event �α� ��ȸ</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<meta http-equiv="Pragma" content="no-cache">

<style type="text/css">
  body      { font-size: 10pt; font-family: ����ü; }
  table     { font-size: 10pt; font-family: ����ü; line-height: 150%; }
</style>
<script type="text/javascript" src="../../js/tablesort.js"></script>

</head>

<BODY id="tman">

<br><br>
<center><b>[�α��̺�Ʈ] ����ID : <%= id_exam %> , �����ID : <%= userid %></b></center>
<br>
<div align="center"><font color="green"><b>(�α׹߻��Ͻø� Ŭ���ϸ� �α׹߻��ð����� �����ؼ� Ȯ���� �� �ֽ��ϴ�.)</b></font></div>
<br>
<table align="center" border="0" cellspacing="1" cellpadding="3" bgcolor="#7cb4d6" width="90%">
  <thead>
    <tr align="center" bgcolor="#EEEEEE" style="height: 29px; text-align: center; background-image: url(../../images/tablea_top3_exmake_yj1.gif);">
      <td width="18%"><B><a href="javascript:" onclick="sortColumn(event)">�α׹߻��Ͻ�</a></B></td>
      <td width="18%"><B>�α׳���</B></td>      
      <td width="15%"><B>IP</B></td>
      <td ><B>������</B></td>
      <td width="10%"><B>���Ӽ���</B></td>
    </tr>
  </thead>
  <tbody>

<%

   for(int k = 0; k < ArrUrls.length; k++) 
   {
      URL url = new URL(ArrUrls[k]);

   try {
      
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

      for (int i = 0; i < arrRecord.length-1; i++)
      {
         String[] arr = arrRecord[i].split(DBPool.FLD_KB, -1);
%>
		<tr align="center" bgcolor="#FFFFFF">    
              <td><%= arr[5] %></td>          
              <td><%= Log.getEvent(arr[2]) %></td>              
              <td><%= arr[3] %></td>
              <td><%= arr[4] %></td>
              <td><%=svr_no%></td>
        </tr>
<%
      }

      } catch(Exception ex) {

      } finally {}  

      svr_no = svr_no + 1;  
   }       
%>
<%
//******************************************************************************
//   ���α׷� : ans_log.jsp
//   �� �� �� : ������ ��� �α�
//   ��    �� : ������ ��� �α�
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
<%@ page import="qmtm.*, etest.*, qmtm.tman.exam.*, java.sql.*, java.util.*, java.net.*, java.io.*" %>

<%
    response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("euc-kr");

	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }

	String userid = request.getParameter("userid");
	if (userid == null) { userid = ""; } else { userid = userid.trim(); }
	
	if (id_exam.length() == 0 || userid.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

    int                  i_tot_cnt  = 0;
    String               exlabel    = "��,��,��,��,��,��,��,��,";
    String[] ArrExlabel             = exlabel.split(",");

    String[] ArrUrls = new String[1];

    ArrUrls[0] = "http://10.18.152.24:9090/logs/"+id_exam+"/"+userid+"_ans.txt";

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
<head><title>��ȷα� ��ȸ</title>
<style type="text/css">
  body      { font-size: 10pt; font-family: ����ü; }
  table     { font-size: 10pt; font-family: ����ü; line-height: 150%; }
</style>
<script type="text/javascript" src="../../js/tablesort.js"></script>
<script language="javascript">
	function ftnRecovery(svr_no, pidx, pid_q) {

		var mywin;
		if (confirm("������ ����� ���� �Ͻðڽ��ϱ�?") == true) {
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
		<td><font color="green"><B>* �����ð�(��)�� Ŭ���ϸ� ����/������������ ���ĵ˴ϴ�.</B></font></td>
	</tr>
</table>
<table border="0" cellspacing="1" width="900" cellpadding="5" bgcolor="#7cb4d6" onclick="sortColumn(event)">
<THEAD>
	<tr align="center" >
  <td bgcolor="#E0E0E0">NO</td>
		<td bgcolor="#F7F7E8">����ð�</td>
		<td bgcolor="#F7F7E8" type="Number">�����ð�(��)</td>
		<td bgcolor="#F7F7E8" type="Number">����</td>
		<td bgcolor="#F7F7E8" type="Number">������ȣ</td>
		<td bgcolor="#F7F7E8">���</td>
		<td bgcolor="#F7F7E8">��Ⱥ���</td>
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
        <td bgcolor="#F7F7E8" colspan="6">����Ÿ�� �����ϴ�.</td>
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
                        <td width="20%"><b>������ȣ</b></td><td><b>1</b></td><td><b>2</b></td><td><b>3</b></td><td><b>4</b></td>
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
                               �� <%= tmpAns[midx].replaceAll(QmTm.LIKE_GUBUN_re, " �Ǵ� ").replaceAll(QmTm.OR_GUBUN_re, "<BR>") %>
              <% 
                               } 
                           } else if(id_qtype == 5) {
              %>
                               ���              
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
              <td align=left>&nbsp;<%= arr[4].replaceAll("��", "<br>") %></td>
              <% } %> 
              
			  <td><textarea name="recovery<%=svr_no%><%=idx%>" style="display:none"><%=arr[4]%></textarea><input type="button" value="�����ϱ�" onclick="javascript:ftnRecovery(<%=svr_no%>, <%=idx%>,'<%=arr[3]%>');"></td>
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
<%
//******************************************************************************
//   프로그램 : ans_event_import.jsp
//   모 듈 명 : 응시자 이벤트 로그 Import
//   설    명 : 응시자 이벤트 로그 Import
//   테 이 블 : 
//   자바파일 : 
//   작 성 일 : 2008-06-20
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="qmtm.*, qmtm.tman.exam.*, qmtm.tman.answer.*, java.sql.*, java.util.*, java.net.*, java.io.*" %>

<%
    response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("euc-kr");

	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }

	if (id_exam.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

   // 이전에 저장한 로그 데이타를 삭제한다.
   try {
	   LogImport.delete(id_exam);
   } catch(Exception ex) {
	   out.println(ComLib.getExceptionMsg(ex, "back"));

	   if(true) return;
   }
   
   AnsInwonListBean[] rst = null;
	
	// 완료자/미완료자 가지고오기
    try {
	    rst = AnsInwonList.getUserids(id_exam);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

		if(true) return;
    }

%>

<html>

<head>
	<title>이벤트 로그 Import</title>
	
	<script>

		function go(ing,end){
			document.all.div1.style.width = (ing+1)/end*100+"%";
			document.all.div2.innerHTML = parseInt((ing+1)/end*100,10)+"%진행중";
			//ing+1 하는이유는 (ing+1)/end*100  =0 이되면 에러가 나기 때문
		}

		function excel_save() {
			location.href="ans_event_excel.jsp?id_exam=<%=id_exam%>";
		}

	</script>

</head>
<!-- 상태진행바가 위치할 HTMl소스 -->

<body  style="font: normal 12px gulim, dotum; margin: 0px; background-image: url(../../images/popup_bg.gif); padding: 5px 5px 5px 5px;" id="tman">
<TABLE width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
		<TR style="height: 12px; background-color: #ffffff;">
			<TD width="8"><img src="../../images/top_left_yj1.gif"></TD>
			<TD></TD>
			<TD width="7"><img src="../../images/top_right_yj1.gif"></TD>
		</TR>
		
		<TR style="background-color: #ffffff;">
			<TD></TD>
			<TD>
<center>
<Table width="450" height="50" border="0" >

<tr>
 <td valign="middle">
  <div id ="div2" align="center" style="margin-top:10;width:100%;height:30px;color:#000000;font-size:11px;"></div>
  <div id ="div1" style="whdth:0px;height:30px;background-color:#0022a4;"></div>
 </td>
</tr>
<tr>
	<td height="15"></td>
</tr>
<tr>
	<td align="center"><input type="image" value="엑셀파일로 저장" onClick="excel_save();" name="button" src="../../images/siatic_exsave_yj1.gif">&nbsp;&nbsp;&nbsp;<input type="image" value="창닫기" onClick="window.close();" name="button" src="../../images/siatic_close_yj1.gif"></td>
</tr>

</table> 
</TD>
			<TD></TD>
		</TR>
		<TR style="height: 12px; background-color: #ffffff;">
			<TD width="8"><img src="../../images/bottom_left_yj2.gif"></TD>
			<TD></TD>
			<TD width="7"><img src="../../images/bottom_right_yj2.gif"></TD>
		</TR>
	</TABLE>

<%
   for(int j = 0; j < rst.length; j++) 
   {
	   String Urls = "http://119.194.200.83:2010/logs/"+id_exam+"/"+rst[j].getUserid()+"_evt.txt";

	   String logs = "";
	   int svr_no = 1;

	   URL url = new URL(Urls);

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

		  logs = output.toString() + logs;

		  String[] arrRecord = logs.split(DBPool.NL);

		  Collection beans = new ArrayList();

		  for (int i = 0; i < arrRecord.length-1; i++)
		  {
			 String[] arr = arrRecord[i].split(DBPool.FLD_KB, -1);

			 Timestamp log_date = Timestamp.valueOf(arr[5]);
			 
			 try {
				 LogImport.insert(arr[0], arr[1], arr[3], arr[2], arr[4], log_date, "1");
			 } catch(Exception ex) {
		   	     out.println(ComLib.getExceptionMsg(ex, "back"));

				if(true) return;
			 }

			 Thread.sleep(200);
		  }

		} catch(Exception ex) {
			 out.println(ex.getMessage());
		}
	}
%>
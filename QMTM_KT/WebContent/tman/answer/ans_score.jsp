<%
//******************************************************************************
//   ���α׷� : ans_score.jsp
//   �� �� �� : ������ ������ ���ä��
//   ��    �� : ������ ������ ���ä��
//   �� �� �� : 
//   �ڹ����� : qmtm.tman.answer.ExamAnswer, qmtm.tman.answer.ExamAnswerNon
//   �� �� �� : 2008-05-27
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="qmtm.*, qmtm.common.*, qmtm.tman.answer.*, java.sql.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("euc-kr");

	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }

	String userids = request.getParameter("userids");
	if (userids == null) { userids = ""; } else { userids = userids.trim(); }

	if (id_exam.length() == 0 || userids.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	String[] arrUserid;
	arrUserid = userids.split(",");

	ExamAnswerBean ans = null;
%>

<html>

<head>

<title>������ ������ ä������</title>

<script>

function go(ing,end){

  document.all.div1.style.width = (ing+1)/end*100+"%";
  document.all.div2.innerHTML = parseInt((ing+1)/end*100,10)+"%������";
 //ing+1 �ϴ������� (ing+1)/end*100  =0 �̵Ǹ� ������ ���� ����
}

</script>

</head>
<!-- ��������ٰ� ��ġ�� HTMl�ҽ� -->

<BODY id="tman">
<center>
<Table width="450" height="50" border="0" >

<tr>
 <td valign="middle">
  <div id ="div2" align="center" style="margin-top:10;width:100%;height:30px;color:#FF00FF;font-size:11px;"></div>
  <div id ="div1" style="whdth:0px;height:30px;background-color:#6666FF;"></div>
 </td>
</tr>

</table> 

<%
	for(int i=0; i<arrUserid.length; i++) {
	
		try {
			ans = ExamAnswer.getBean(arrUserid[i], id_exam);
		} catch (Exception ex) {
			out.println(ComLib.getExceptionMsg(ex, "back"));

			if(true) return;
		}
		
		try {
			ExamAnswer.setScoreOxs(ans);
		} catch(Exception ex) {
			out.println(ComLib.getExceptionMsg(ex, "back"));

			if(true) return;
		}

		out.println("<script>go("+i+","+arrUserid.length+")</script>");

		Thread.sleep(300);
		out.flush() ;
	}
%>

<script language="javascript">
	window.opener.get_answer_score();
	window.close();
</script>

</body>
</html>
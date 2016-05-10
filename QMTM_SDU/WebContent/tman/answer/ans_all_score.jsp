<%
//******************************************************************************
//   ���α׷� : ans_all_score.jsp
//   �� �� �� : ��� ������ ���ä��
//   ��    �� : ��� ������ ���ä��
//   �� �� �� : 
//   �ڹ����� : qmtm.tman.answer.ExamAnswer, qmtm.tman.answer.ExamAnswerNon
//   �� �� �� : 2008-05-27
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.common.*, qmtm.tman.answer.*, java.sql.*" %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }

	if (id_exam.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	String adm_userid = (String)session.getAttribute("userid");
	if (adm_userid == null) { adm_userid = ""; } else { adm_userid = adm_userid.trim(); }

	if (adm_userid.length() == 0) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

	String btns = request.getParameter("btns");

	ExamAnswerBean[] rst = null;

	if(btns.equals("btn1")) {
		try {
			rst = ExamAnswer.getBeans(id_exam, "Y");
		} catch(Exception ex) {
			out.println(ComLib.getExceptionMsg(ex, "back"));

			if(true) return;
		}
	} else if(btns.equals("btn2")) {
		try {
			rst = ExamAnswer.getBeans(id_exam, "N");
		} catch(Exception ex) {
			out.println(ComLib.getExceptionMsg(ex, "back"));

			if(true) return;
		}
	}

	if(rst == null) {
%>
	<script type="text/javascript">
		alert("ä�� ������ �����ڰ� �����ϴ�.");
		window.close();
	</script>
<%
		if(true) return;
	}
%>

<html>

<head>

<title>��� ������ ä������</title>

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

<Table width="450" height="50" border="0" >

<tr>
 <td valign="middle">
  <div id ="div2" align="center" style="margin-top:10;width:100%;height:30px;color:#FF00FF;font-size:11px;"></div>
  <div id ="div1" style="whdth:0px;height:30px;background-color:#6666FF;"></div>
 </td>
</tr>

</table> 

<%
	for(int i=0; i<rst.length; i++) {

		try {
			ExamAnswer.setScoreOxs(rst[i]);
		} catch(Exception ex) {
			out.println(ComLib.getExceptionMsg(ex, "back"));

			if(true) return;
		}

		out.println("<script>go("+i+","+rst.length+")</script>");	
	}

	WorkExamLogBean logbean = new WorkExamLogBean();

	logbean.setId_exam(id_exam);	
	logbean.setUserid(adm_userid);
	logbean.setGubun("���������ä��");
	logbean.setId_q("");
	logbean.setBigo("");

	try {
		WorkExamLog.insert(logbean);
	} catch(Exception ex) {
	    out.println(ex.getMessage());

	    if(true) return;
    }
%>

<script type="text/javascript">
	window.opener.get_answer_score();
	window.close();
</script>


</body>
</html>
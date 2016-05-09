<%
//******************************************************************************
//   프로그램 : ans_all_score.jsp
//   모 듈 명 : 모든 응시자 답안채점
//   설    명 : 모든 응시자 답안채점
//   테 이 블 : 
//   자바파일 : qmtm.tman.answer.ExamAnswer, qmtm.tman.answer.ExamAnswerNon
//   작 성 일 : 2008-05-27
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="qmtm.*, qmtm.common.*, qmtm.tman.answer.*, java.sql.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("euc-kr");

	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }

	if (id_exam.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

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
	<script language="JavaScript">
		alert("채점 진행할 응시자가 없습니다.");
		window.close();
	</script>
<%
		if(true) return;
	}
%>

<html>

<head>

<title>모든 응시자 채점진행</title>

<script>

function go(ing,end){

  document.all.div1.style.width = (ing+1)/end*100+"%";
  document.all.div2.innerHTML = parseInt((ing+1)/end*100,10)+"%진행중";
 //ing+1 하는이유는 (ing+1)/end*100  =0 이되면 에러가 나기 때문
}

</script>

</head>
<!-- 상태진행바가 위치할 HTMl소스 -->

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
	for(int i=0; i<rst.length; i++) {

		try {
			ExamAnswer.setScoreOxs(rst[i]);
		} catch(Exception ex) {
			out.println(ComLib.getExceptionMsg(ex, "back"));

			if(true) return;
		}

		out.println("<script>go("+i+","+rst.length+")</script>");	
	}
%>

<script language="javascript">
	window.opener.get_answer_score();
	window.close();
</script>

</body>
</html>
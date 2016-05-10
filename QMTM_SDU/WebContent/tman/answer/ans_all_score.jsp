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
	logbean.setGubun("모든응시자채점");
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
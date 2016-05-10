<%
//******************************************************************************
//   프로그램 : excel_lists2.jsp
//   모 듈 명 : 응시 미완료자 리스트
//   설    명 : 응시 미완료자 리스트
//   테 이 블 : exam_ans, qt_userid
//   자바파일 : qmtm.tman.answer.AnsInwonList, qmtm.tman.answer.AnsInwonListBean
//   작 성 일 : 2008-06-19
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="application/vnd.ms-excel; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.common.*, qmtm.tman.answer.*, java.sql.*" %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	response.setHeader("Content-Disposition", "attachment; filename=Inwon2.xls"); 
    response.setHeader("Content-Description", "JSP Generated Data");

	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }

	if (id_exam.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	String bigos = "N";

	AnsInwonListBean[] rst = null;

	// 완료자/미완료자 가지고오기
    try {
	    rst = AnsInwonList.getExcelBeans(id_exam, bigos);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

		if(true) return;
    }
%>

<html>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">

	<body>
	
	<table border="1" cellpadding="0" cellspacing="0" >
		<tr align="center" height="30" >
			<td bgcolor="#9DBFFF">아이디</td>
			<td bgcolor="#9DBFFF">성명</td>
			<td bgcolor="#9DBFFF">소속1</td>
			<td bgcolor="#9DBFFF">소속2</td>
			<td bgcolor="#9DBFFF">직급</td>
			<td bgcolor="#9DBFFF">시험지</td>
			<td bgcolor="#9DBFFF">시험시작시간</td>
			<td bgcolor="#9DBFFF">답안제출시간</td>
			<td bgcolor="#9DBFFF">득점</td>
			<td bgcolor="#9DBFFF">원득점</td>
			<td bgcolor="#9DBFFF">가감내용</td>
			<td bgcolor="#9DBFFF">응시자 IP</td>
			<td bgcolor="#9DBFFF">합격점수</td>
			<td bgcolor="#9DBFFF">통과여부</td>			
		</tr>
<%
	if(rst == null) {
%>
		<tr height="40">
			<td colspan="14">&nbsp;</td>
		</tr>
<%
	} else {
		for(int i=0; i<rst.length; i++) { 
			String score_bak = "";
			String score_log = "";
			if(rst[i].getScore_bak() > -1.0) {
				score_bak = String.valueOf(rst[i].getScore_bak());
			}

			if(!rst[i].getScore_log().equals("-1")) {
					score_log = rst[i].getScore_log();
			}

			String pass_yn = "";
			
			if(rst[i].getScore() >= rst[i].getSuccess_score()) {
				pass_yn = "Y";
			} else {
				pass_yn = "N";
			}						
%>

		<tr height="27" align="center">
			<td ><%=rst[i].getUserid()%></td>
			<td ><%=rst[i].getName()%></td>			
			<td ><%=ComLib.nullChk(rst[i].getSosok1())%></td>
			<td ><%=ComLib.nullChk(rst[i].getSosok2())%></td>
			<td ><%=ComLib.nullChk(rst[i].getLevel())%></td>
			<td ><%=rst[i].getNr_set()%></td>
			<td ><%=rst[i].getStart_time()%></td>
			<td ><%=rst[i].getEnd_time()%></td>
			<td ><%=rst[i].getScore()%></td>
			<td ><%=score_bak%></td>
			<td ><%=score_log%></td>
			<td ><%=rst[i].getUser_ip()%></td>
			<td ><%=rst[i].getSuccess_score()%></td>
			<td ><%=pass_yn%></td>			
		</tr>
<%
		}
	}
%>
	</table>

</body>
</html>
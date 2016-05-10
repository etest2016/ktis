<%
//******************************************************************************
//   프로그램 : excel_lists3.jsp
//   모 듈 명 : 미응시자 리스트
//   설    명 : 미응시자 리스트
//   테 이 블 : exam_ans, qt_userid
//   자바파일 : qmtm.tman.answer.AnsInwonList, qmtm.tman.answer.AnsInwonListBean
//   작 성 일 : 2008-06-19
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.tman.answer.*, java.sql.*" %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	response.setHeader("Content-Disposition", "attachment; filename=Inwon3.xls"); 
    response.setHeader("Content-Description", "JSP Generated Data");

	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }

	if (id_exam.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	String bigos = "X";

	AnsInwonListBean[] rst = null;
	
	// 미응시자 가지고오기
    try {
	    rst = AnsInwonList.getExcelBeans2(id_exam);
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
		</tr>
<%
	if(rst == null) {
%>
		<tr height="40">
			<td colspan="5">&nbsp;</td>
		</tr>
<%
	} else {
		for(int i=0; i<rst.length; i++) { 
%>
		<tr height="27" align="center">
			<td><%=rst[i].getUserid()%></td>
			<td><%=rst[i].getName()%></td>
			<td ><%=ComLib.nullChk(rst[i].getSosok1())%></td>
			<td ><%=ComLib.nullChk(rst[i].getSosok2())%></td>
			<td ><%=ComLib.nullChk(rst[i].getLevel())%></td>
		</tr>
<%
		}
	}
%>
	</table>

</body>
</html>
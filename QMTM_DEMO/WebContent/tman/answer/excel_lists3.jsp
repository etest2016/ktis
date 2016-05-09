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

<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="qmtm.*, qmtm.tman.answer.*, java.sql.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("euc-kr");

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
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">

	<body>

	<table border="0" cellpadding="1" cellspacing="1" bgcolor="#CCCCCC"  width="150">
		<tr height="40" bgcolor="#FFFFFF">
			<td align="center" bgcolor="#D9D9D9">아이디</td>
			<td align="center" bgcolor="#D9D9D9">성명</td>
		</tr>
<%
	if(rst == null) {
%>
		<tr>
			<td colspan="2">&nbsp;</td>
		</tr>
<%
	} else {
		for(int i=0; i<rst.length; i++) { 
%>
		<tr bgcolor="#FFFFFF" height="30">
			<td align="center"><%=rst[i].getUserid()%></td>
			<td align="center"><%=rst[i].getName()%></td>
		</tr>
<%
		}
	}
%>
	</table>

</body>
</html>
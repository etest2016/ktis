<%
//******************************************************************************
//   프로그램 : q_excel_save.jsp
//   모 듈 명 : 문제 엑셀저장
//   설    명 : 문제 엑셀저장
//   테 이 블 : q
//   자바파일 : qmtm.ComLib, qmtm.QmTm, qmtm.qman.question.QListGrid, qmtm.qman.question.QListGridBean
//   작 성 일 : 2013-02-08
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************

%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.QmTm, qmtm.qman.question.QListGrid, qmtm.qman.question.QListGridBean, org.apache.commons.lang3.StringEscapeUtils " %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	response.setHeader("Content-Disposition", "attachment; filename=q_excel.xls"); 
    response.setHeader("Content-Description", "JSP Generated Data");

	String id_qs = request.getParameter("q_excels");
	if (id_qs == null) { id_qs = ""; } else { id_qs = id_qs.trim(); }
	
	if (id_qs.length() == 0) {
%>
	<script language="javascript">
		alert("엑셀로 저장 할 문제가 없습니다.");
		window.close();
	</script>
<%	
		if(true) return;
	}

	// 데이타 가져오기
	QListGridBean[] rst = null;

	try {
		rst = QListGrid.getExcelBeans(id_qs);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "close"));

		if(true) return;
	}
%>	

<html>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">

	<body>
	
	<table border="1" cellpadding ="0" cellspacing="0" >
		<tr height="40" align="center">
			<td align="center" bgcolor="#9DBFFF">과정명</td>
			<td align="center" bgcolor="#9DBFFF">과목명</td>
			<td align="center" bgcolor="#9DBFFF">단원명</td>
			<td align="center" bgcolor="#9DBFFF">문제코드</td>
			<td align="center" bgcolor="#9DBFFF">문제</td>
			<td align="center" bgcolor="#9DBFFF">보기1</td>
			<td align="center" bgcolor="#9DBFFF">보기2</td>
			<td align="center" bgcolor="#9DBFFF">보기3</td>
			<td align="center" bgcolor="#9DBFFF">보기4</td>
			<td align="center" bgcolor="#9DBFFF">보기5</td>
			<td align="center" bgcolor="#9DBFFF">정답</td>
			<td align="center" bgcolor="#9DBFFF">해설</td>
			<td align="center" bgcolor="#9DBFFF">문제유형</td>
			<td align="center" bgcolor="#9DBFFF">보기갯수</td>
			<td align="center" bgcolor="#9DBFFF">정답갯수</td>
			<td align="center" bgcolor="#9DBFFF">난이도</td>			
			<td align="center" bgcolor="#9DBFFF">출제횟수</td>
			<td align="center" bgcolor="#9DBFFF">입력자</td>
			<td align="center" bgcolor="#9DBFFF">등록일자</td>
		</tr>
<%
	if(rst == null) {
%>
		<tr height="40">
			<td colspan="19">&nbsp;</td>
		</tr>
<%
	} else {

		for(int i=0; i<rst.length; i++) { 
			String qtype = rst[i].getQtype();
			String id_valid_type = "";

			if(rst[i].getId_valid_type().equals("0")) {
				id_valid_type = "정상문제";
			} else if(rst[i].getId_valid_type().equals("1")) {
				id_valid_type = "오류문제";
			} else {
				id_valid_type = "모두정답처리";
			}

%>
		<tr bgcolor="#FFFFFF" height="30">
			<td ><%=rst[i].getCourse()%></td>
			<td ><%=rst[i].getQ_subject()%></td>
			<td ><%=rst[i].getChapter()%></td>
			<td ><%=rst[i].getId_q()%></td>
			<td ><%=StringEscapeUtils.escapeHtml3(ComLib.removeAndDel(ComLib.htmlDel(rst[i].getQ())))%></td>			
			<td ><%=StringEscapeUtils.escapeHtml3(ComLib.removeAndDel(ComLib.htmlDel(ComLib.nullChk(rst[i].getEx1()))))%></td>
			<td ><%=StringEscapeUtils.escapeHtml3(ComLib.removeAndDel(ComLib.htmlDel(ComLib.nullChk(rst[i].getEx2()))))%></td>
			<td ><%=StringEscapeUtils.escapeHtml3(ComLib.removeAndDel(ComLib.htmlDel(ComLib.nullChk(rst[i].getEx3()))))%></td>
			<td ><%=StringEscapeUtils.escapeHtml3(ComLib.removeAndDel(ComLib.htmlDel(ComLib.nullChk(rst[i].getEx4()))))%></td>
			<td ><%=StringEscapeUtils.escapeHtml3(ComLib.removeAndDel(ComLib.htmlDel(ComLib.nullChk(rst[i].getEx5()))))%></td>
			<td ><%=StringEscapeUtils.escapeHtml3(ComLib.nullChk(rst[i].getCa()))%></td>
			<td ><%=StringEscapeUtils.escapeHtml3(ComLib.nullChk(rst[i].getExplain()))%></td>
			<td ><%=qtype%></td>
			<td ><%=rst[i].getExcount()%></td>
			<td ><%=rst[i].getCacount()%></td>
			<td ><%=rst[i].getDifficulty()%></td>
			<td ><%=rst[i].getCnt()%></td>
			<td ><%=rst[i].getUserid()%></td>
			<td ><%=rst[i].getRegdate()%></td>
		</tr>
<%
		}
	}
%>
	</table>

</body>
</html>
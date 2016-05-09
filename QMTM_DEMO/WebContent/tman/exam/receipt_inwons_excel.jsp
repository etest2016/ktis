<%
//******************************************************************************
//   프로그램 : receipt_inwons.jsp
//   모 듈 명 : 접수인원
//   설    명 : 접수인원 페이지
//   테 이 블 : exam_receipt, qt_userid
//   자바파일 : qmtm.tman.exam.ExamCreateBean, qmtm.admin.etc.ExamKindUtil,
//              qmtm.admin.etc.ExamKindSubUtil, qmtm.admin.etc.StdGradeUtil,
//              qmtm.admin.etc.StdLevelUtil, qmtm.tman.TreeUtil, 
//              qmtm.tman.exam.RexlabelBean, qmtm.tman.exam.RexlabelUtil
//   작 성 일 : 2008-06-23
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.admin.etc.*, qmtm.tman.*, qmtm.tman.exam.*, java.sql.*, java.util.*" %>

<%@ include file="../../common/paging.jsp" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	response.setHeader("Content-Disposition", "attachment; filename=MemberList.xls"); 
    response.setHeader("Content-Description", "JSP Generated Data");

	String id_exam = request.getParameter("id_exam");	
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }	
	
	if (id_exam.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}
	
	String field = request.getParameter("field");
	if (field == null) { field = ""; } else { field = field.trim(); }

	String str = request.getParameter("str");
	if (str == null) { str = ""; } else { str = str.trim(); }
	
	str = new String(str.getBytes("8859_1"),"euc-kr");

	ReceiptBean[] rst = null;
	
	try {
		rst = ReceiptUtil.getAllBeans(id_exam, field, str);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "close"));

	    if(true) return;
	}
%>


		<table border="1" cellpadding ="0" cellspacing="0" bordercolor="#e1e1e1">
			<tr align="center">					
				<td width="4%" bgcolor="#D8D8D8">NO</td>
				<td width="10%" bgcolor="#D8D8D8">아이디</td>
				<td width="10%" bgcolor="#D8D8D8">비밀번호</td>
				<td width="10%" bgcolor="#D8D8D8">성명</td>
				<td bgcolor="#D8D8D8" width="12%">소속1</td>
				<td bgcolor="#D8D8D8" width="12%">소속2</td>
				<td bgcolor="#D8D8D8" width="12%">소속3</td>
				<td width="10%" bgcolor="#D8D8D8">직위</td>
				<td width="10%" bgcolor="#D8D8D8">직무</td>
				<td width="10%" bgcolor="#D8D8D8">등록일자</td>
			</tr>
				
				<%
					if(rst == null) {
				%>
				<tr>
					<td colspan="10">등록된 대상자가 없습니다.</td>
				</tr>
				<%
					} else { 
						for(int i = 0; i < rst.length; i++) {							
				%>
				<tr >					
					<td width="4%"><%=i+1%></td>
					<td width="10%"><%=rst[i].getUserid()%></td>
					<td width="10%">----</td>
					<td width="10%"><%=rst[i].getName()%></td>
					<td width="12%"><%=ComLib.nullChk(rst[i].getSosok2())%></td>
					<td width="12%"><%=ComLib.nullChk(rst[i].getSosok3())%></td>
					<td width="12%"><%=ComLib.nullChk(rst[i].getSosok4())%></td>
					<td width="10%"><%=ComLib.nullChk(rst[i].getJikwi())%></td>
					<td width="10%"><%=ComLib.nullChk(rst[i].getJikmu())%></td>
					<td width="10%"><%=rst[i].getRegdate()%></td>
				</tr>
				<%
						}
					}
				%>
			</table>
			
		
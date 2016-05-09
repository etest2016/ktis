<%
//******************************************************************************
//   프로그램 : member_static_list_excel.jsp
//   모 듈 명 : 시험진행 관리 페이지
//   설    명 : 시험진행 관리 페이지
//   테 이 블 : exam_m, qt_userid, qt_course_user, exam_receipt, exam_ans
//   자바파일 : qmtm.CommonUtil, qmtm.ComLib, qmtm.tman.exam.IngInwonBean, qmtm.tman.exam.IngInwon
//   작 성 일 : 2008-06-23
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="application/vnd.ms-excel; charset=euc-kr" %>
<%@ page import="qmtm.CommonUtil, qmtm.ComLib, qmtm.admin.MemberStatic, qmtm.admin.MemberStaticBean " %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	response.setHeader("Content-Disposition", "attachment; filename=member_static.xls"); 
    response.setHeader("Content-Description", "JSP Generated Data");

	String userid = (String)session.getAttribute("userid");    
	if (userid == null) { userid= ""; } else { userid = userid.trim(); }

	String id_category = request.getParameter("id_category");    
	if (id_category == null) { id_category= ""; } else { id_category = id_category.trim(); }
	
	if (userid.length() == 0 || id_category.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}
	
	String exam_start = request.getParameter("exam_start");
	if (exam_start == null) { exam_start = ""; } else { exam_start = exam_start.trim(); }

	String exam_end = request.getParameter("exam_end");
	if (exam_end == null) { exam_end = ""; } else { exam_end = exam_end.trim(); }

	MemberStaticBean[] rst = null;

	try {
		rst = MemberStatic.getAllBeans(id_category, exam_start, exam_end);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));		    

	    if(true) return;
	}	 
%>

<html>
<head>
	<title></title>
	<link rel="StyleSheet" href="../../css/style.css" type="text/css">
 	
</head>
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr bgcolor="#FFFFFF" align="center" height="30">
				<td bgcolor="#D8D8D8">시험명</td>
				<td bgcolor="#D8D8D8">아이디</td>
				<td bgcolor="#D8D8D8">성명</td>
				<td bgcolor="#D8D8D8">소속</td>
				<td bgcolor="#D8D8D8">소속2</td>
				<td bgcolor="#D8D8D8">소속3</td>
				<td bgcolor="#D8D8D8">점수</td>
				<td bgcolor="#D8D8D8">평균점수</td>
				<td bgcolor="#D8D8D8">순위</td>
			</tr>
<% if(rst == null) {%>
			<tr bgcolor="#FFFFFF" height="40">
				<td class="blank" align="center" colspan="9">검색일자를 입력하세요..</td>
			</tr>
<% 
	} else { 
				
		for(int i=0; i<rst.length; i++) {		
%>
			<tr bgcolor="#FFFFFF" height="27" align="center">
				<td><%=rst[i].getTitle()%></td>
				<td><%=rst[i].getUserid()%></td>
				<td><%=rst[i].getName()%></td>
				<td><%=ComLib.nullChk(rst[i].getSosok2())%></td>
				<td><%=ComLib.nullChk(rst[i].getSosok3())%></td>
				<td><%=ComLib.nullChk(rst[i].getSosok4())%></td>
				<td><%=rst[i].getP_score()%></td>
				<td><%=rst[i].getT_avg()%></td>
				<td><%=rst[i].getP_rank()%></td>
			</tr>
<%
		}
	}
%>
		</table>
		
		
</body>

</html>
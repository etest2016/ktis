<%
//******************************************************************************
//   프로그램 : course_mgr.jsp
//   모 듈 명 : 과정관리
//   설    명 : 과정관리 페이지
//   테 이 블 : c_course
//   자바파일 : qmtm.admin.course.CourseBean,
//              qmtm.admin.course.CourseUtil 
//   작 성 일 : 2008-03-31
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%> 

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.admin.course.*, qmtm.admin.subject.*, java.sql.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");


    // 과정목록 가지고오기
	CourseBean[] rst = null;
   
	try {
		rst = CourseUtil.getBeans();
	} catch(Exception ex) {
		out.println(ex.getMessage());
	}

%>

<HTML>
 <HEAD>
  <TITLE> Admin Main </TITLE>

 </HEAD>

 <BODY id="admin">	
    <br>
    <TABLE width="720" border="0">
	<tr>
	<td width="30"></td>
	<td align="right">	

	<TABLE width="690">
		<TR>
			<TD>과정 목록</TD>
			<TD align="right"><a href="course_create.jsp">신규 과정 등록</a></TD>
		</TR>
	</TABLE>
	<table border="0" width="690" cellpadding ="3" cellspacing="1" bgcolor="#CCCCCC" align="center">
		<tr height="30" bgcolor="#DBDBDB">
			<td width="7%" align="center" bgcolor="#DBDBDB">NO</td>
			<td bgcolor="#DBDBDB">과정코드</td>
			<td bgcolor="#DBDBDB">과정명</td>
			<td bgcolor="#DBDBDB">유효여부</td>
			<td bgcolor="#DBDBDB">등록일자</td>
			<td bgcolor="#DBDBDB">담당자확인</td>
		</tr>
		<% if(rst == null) { %>
		<tr height="30" bgcolor="#FFFFFF">
			<td align="center" colspan="6">등록되어진 과정이 없습니다.</td>
		</tr>
		<%
		   } else {
			   for(int i = 0; i < rst.length; i++) {
		%>
		<tr height="30" bgcolor="#FFFFFF">
			<td align="center"><%=i+1%></td>
			<td align="center"><%=rst[i].getId_course()%></td>
			<td align="center"><%=rst[i].getCourse()%></td>
			<td align="center"><%=rst[i].getYn_valid()%></td>
			<td align="center"><%=rst[i].getRegdate()%></td>
			<td align="center">담당자확인</td>
		</tr>
		<%
			   }
			}
		%>
	</table>

	</td>
	</tr>
	</table>
		
 </BODY>
</HTML>
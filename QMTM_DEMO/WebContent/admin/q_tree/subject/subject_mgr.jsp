<%
//******************************************************************************
//   프로그램 : course_mgr.jsp
//   모 듈 명 : 과목관리
//   설    명 : 문제은행 과목관리 페이지
//   테 이 블 : q_subject, q_chapter
//   자바파일 : 
//   작 성 일 : 2008-04-03
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

    String id_node = request.getParameter("id_node"); // 트리 ID
	if (id_node == null) { id_node = ""; } else { id_node = id_node.trim(); }	
	
	if (id_node.length() == 0) { 
		response.sendRedirect("/error/page_error.jsp");
	
		if(true) return ;
	}	

	// 과목정보 가지고오기
	QmanTreeBean c = null;

    try {
	    c = QmanTree.getBean(id_node);
    } catch(Exception ex) {
	    response.sendRedirect("/error/db_error.jsp?err_msg="+ex.getMessage());

		if(true) return;
    }

	// 해당 과목에 속한 단원리스트 가지고오기
	Bean[] rst = null;

	try {
		rst = SubjectUtil.getBeans(id_node);
	} catch(Exception ex) {
		response.sendRedirect("/error/db_error.jsp?err_msg="+ex.getMessage());

		if(true) return;
	}
%>

<script language="javascript">
    
	function Subject_insert() {
		window.open("../subject/subject_write.jsp?id_node=<%=id_node%>","insert","width=500, height=270");
	}

	function Subject_edit(id_subject) {
		window.open("../subject/subject_edit.jsp?id_node=<%=id_node%>&id_subject="+id_subject,"edit","width=500, height=270");
	}

	function Course_edit()  {
       window.open("course_edit.jsp?id_node=<%=id_node%>","edit","width=500, height=200");
    }
	
	//--  과정 삭제체크
    function Course_delete()  {
       var st = confirm("*주의* 과정정보를 삭제하시겠습니까? " );
       if (st == true) {
           document.location = "course_delete.jsp?id_node=<%=id_node%>";
       }
    }

	//--  과목 삭제체크
    function Subject_delete(id_subject)  {
       var st = confirm("*주의* 과목정보를 삭제하시겠습니까? " );
       if (st == true) {
           document.location = "../subject/subject_delete.jsp?id_node=<%=id_node%>&id_subject="+id_subject;
       }
    }

</script>

<center>

<br><br>
과목 리스트&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" value="과목추가하기" onClick="Subject_insert()">
<br>

<table border="0" width="650" cellpadding ="3" cellspacing="1" bgcolor="#CCCCCC">
	<tr height="30" bgcolor="#FFFFFF">
		<td width="7%" align="center" bgcolor="#DBDBDB">NO</td>
		<td align="center" bgcolor="#DBDBDB">과목명</td>
		<td width="20%" align="center" bgcolor="#DBDBDB">등록일자</td>
		<td width="15%" align="center" bgcolor="#DBDBDB">수정하기</td>
		<td width="15%" align="center" bgcolor="#DBDBDB">삭제하기</td>
	</tr>
	<% if(rst == null) { %>
	<tr height="30" bgcolor="#FFFFFF">
		<td align="center" colspan="5">등록되어진 과목이 없습니다.</td>
	</tr>
	<%
	   } else {
		   for(int i = 0; i < rst.length; i++) {
	%>
	<tr height="30" bgcolor="#FFFFFF">
		<td align="center"><%=i+1%></td>
		<td align="center"><%=rst[i].getSubject()%></td>
		<td align="center"><%=rst[i].getRegdate()%></td>
		<td align="center"><input type="button" value="수정하기" onClick="Subject_edit('<%=rst[i].getId_subject()%>')"></td>
		<td align="center"><input type="button" value="삭제하기" onClick="Subject_delete('<%=rst[i].getId_subject()%>')"></td>
	</tr>
	<%
		   }
		}
	%>
</table>

<br><br>
과정정보
<br>

<table border="0" width="650" cellpadding ="3" cellspacing="1" bgcolor="#CCCCCC">
	<tr height="30" bgcolor="#FFFFFF">
		<td align="center" bgcolor="#DBDBDB">과정명</td>
		<td width="15%" align="center" bgcolor="#DBDBDB">유효여부</td>
		<td width="15%" align="center" bgcolor="#DBDBDB">수정하기</td>
		<td width="15%" align="center" bgcolor="#DBDBDB">삭제하기</td>
	</tr>
	<tr height="30" bgcolor="#FFFFFF">
		<td bgcolor="#FFFFFF" align="center"><%=c.getCourse()%></td>
		<td width="15%" bgcolor="#FFFFFF" align="center"><%=yn_valid%></td>
		<td width="15%" align="center" bgcolor="#FFFFFF"><input type="button" value="수정하기" onClick="Course_edit()"></td>
		<td width="15%" align="center" bgcolor="#FFFFFF"><input type="button" value="삭제하기" onClick="Course_delete()"></td>
	</tr>
</table>

<center>
<br><br>
담당자 리스트&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" value="담당자추가하기" onClick="Subject_insert()">
<br>

<table border="0" width="650" cellpadding ="3" cellspacing="1" bgcolor="#CCCCCC">
	<tr height="30" bgcolor="#FFFFFF">
		<td width="6%" align="center" bgcolor="#DBDBDB">NO</td>
		<td align="center" bgcolor="#DBDBDB">성명</td>
		<td width="20%" align="center" bgcolor="#DBDBDB">문제관리</td>
		<td width="20%" align="center" bgcolor="#DBDBDB">시험관리</td>
		<td width="20%" align="center" bgcolor="#DBDBDB">성적관리</td>
		<td width="20%" align="center" bgcolor="#DBDBDB">유효여부</td>
	</tr>
</table>
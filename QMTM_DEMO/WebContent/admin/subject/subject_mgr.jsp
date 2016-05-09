<%
//******************************************************************************
//   프로그램 : subject_mgr.jsp
//   모 듈 명 : 과목관리
//   설    명 : 과목관리 페이지
//   테 이 블 : c_subject
//   자바파일 : qmtm.admin.subject.SubjectBean,
//              qmtm.admin.subject.SubjectUtil 
//   작 성 일 : 2008-03-31
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.admin.subject.*, qmtm.admin.chapter.*, java.sql.*" %>

<%
	response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("EUC-KR");

    String id_node = request.getParameter("id_node"); // 트리 ID

	if (id_node == null) { id_node = ""; } else { id_node = id_node.trim(); }	
	
	if (id_node.length() == 0) { 
%>
	<script language="javascript">
		alert("해당 화면에 대한 권한이 없습니다.");
		history.back();
	</script>
<%	
	}	
	
	// 과목정보 가지고오기
	SubjectBean s = null;

    try {
	    s = SubjectUtil.getBean(id_node);
    } catch(Exception ex) {
	    out.println(ex.getMessage());
    }

	String yn_valid = "";
	if(s.getYn_valid().equalsIgnoreCase("Y")) {
		yn_valid = "사용";
	} else {
		yn_valid = "미사용";
	}

	// 해당 과목에 속한 Chapter리스트 가지고오기
	ChapterBean[] rst = null;

	try {
		rst = ChapterUtil.getBeans(id_node);
	} catch(Exception ex) {
		out.println(ex.getMessage());
	}
%>

<script language="javascript">
    
	function chapter_insert() {
		window.open("../chapter/chapter_write.jsp?id_node=<%=id_node%>","insert","width=500, height=270");
	}

	function chapter_edit(id_subject) {
		window.open("../chapter/chapter_edit.jsp?id_node=<%=id_node%>&id_chapter="+id_chapter,"edit","width=500, height=270");
	}

	function subject_edit()  {
       window.open("subject_edit.jsp?id_node=<%=id_node%>","edit","width=500, height=200");
    }
	
	//--  과목 삭제체크
    function subject_delete()  {
       var st = confirm("*주의* 과목정보를 삭제하시겠습니까? " );
       if (st == true) {
           document.location = "subject_delete.jsp?id_node=<%=id_node%>";
       }
    }

	//--  단원 삭제체크
    function chapter_delete(id_chapter)  {
       var st = confirm("*주의* 단원을 삭제하시겠습니까? " );
       if (st == true) {
           document.location = "../chapter/chapter_delete.jsp?id_node=<%=id_node%>&id_chapter="+id_chapter;
       }
    }

</script>

<center>

단원 리스트&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" value="단원추가하기" onClick="chapter_insert()">
<br>

<table border="0" width="650" cellpadding ="3" cellspacing="1" bgcolor="#CCCCCC">
	<tr height="30" bgcolor="#FFFFFF">
		<td width="7%" align="center" bgcolor="#DBDBDB">NO</td>
		<td align="center" bgcolor="#DBDBDB">단원명</td>
		<td width="20%" align="center" bgcolor="#DBDBDB">등록일자</td>
		<td width="15%" align="center" bgcolor="#DBDBDB">수정하기</td>
		<td width="15%" align="center" bgcolor="#DBDBDB">삭제하기</td>
	</tr>
	<% if(rst == null) { %>
	<tr height="30" bgcolor="#FFFFFF">
		<td align="center" colspan="5">등록되어진 단원이 없습니다.</td>
	</tr>
	<%
	   } else {
		   for(int i = 0; i < rst.length; i++) {
	%>
	<tr height="30" bgcolor="#FFFFFF">
		<td align="center"><%=i+1%></td>
		<td align="center"><%=rst[i].getChapter()%></td>
		<td align="center"><%=rst[i].getRegdate()%></td>
		<td align="center"><input type="button" value="수정하기" onClick="subject_edit('<%=rst[i].getId_chapter()%>')"></td>
		<td align="center"><input type="button" value="삭제하기" onClick="subject_delete('<%=rst[i].getId_chapter()%>')"></td>
	</tr>
	<%
		   }
		}
	%>
</table>

<br><br>
과목정보
<br>

<table border="0" width="650" cellpadding ="3" cellspacing="1" bgcolor="#CCCCCC">
	<tr height="30" bgcolor="#FFFFFF">
		<td align="center" bgcolor="#DBDBDB">과목명</td>
		<td width="15%" align="center" bgcolor="#DBDBDB">유효여부</td>
		<td width="15%" align="center" bgcolor="#DBDBDB">수정하기</td>
		<td width="15%" align="center" bgcolor="#DBDBDB">삭제하기</td>
	</tr>
	<tr height="30" bgcolor="#FFFFFF">
		<td bgcolor="#FFFFFF" align="center"><%=s.getSubject()%></td>
		<td width="15%" bgcolor="#FFFFFF" align="center"><%=yn_valid%></td>
		<td width="15%" align="center" bgcolor="#FFFFFF"><input type="button" value="수정하기" onClick="subject_edit()"></td>
		<td width="15%" align="center" bgcolor="#FFFFFF"><input type="button" value="삭제하기" onClick="subject_delete()"></td>
	</tr>
</table>

</center>
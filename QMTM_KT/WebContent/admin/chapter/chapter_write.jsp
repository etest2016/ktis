<%
//******************************************************************************
//   프로그램 : chapter_write.jsp
//   모 듈 명 : 단원 등록
//   설    명 : 해당 과목 아래 단원등록하기
//   테 이 블 : c_chapter
//   자바파일 : qmtm.admin.chapter.ChapterUtil
//   작 성 일 : 2008-03-31
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.admin.chapter.*, java.sql.*" %>

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

	int chapter_order = 0;

	// 과목순서 가지고오기
	try {
		chapter_order = 1 + ChapterUtil.getCnt(id_node);
	} catch(Exception ex) {
		out.println(ex.getMessage());
	}
%>

<center>
단원등록
<br>
<form name="frmdata" method="post" action="chapter_insert.jsp">
<input type="hidden" name="id_node" value="<%=id_node%>">
<table border="0" width="500" cellpadding ="3" cellspacing="1" bgcolor="#CCCCCC">
	<tr height="40">
		<td width="30%" align="right">단원명&nbsp;</td>
		<td bgcolor="#FFFFFF">&nbsp;&nbsp;<input type="text" class="input" name="subject" size="20"></td>
	</tr>
	<tr height="40">
		<td align="right">정렬순서&nbsp;</td>
		<td bgcolor="#FFFFFF">&nbsp;&nbsp;<select name="subject_order">
		<% for(int i = 1; i <= 10; i++) { %>	
			<option value="<%=i%>" <%if(chapter_order == i) {%>selected<% } %>><%=i%></option>
		<% } %>
		</td>
	</tr>
</table>
<p>
<input type="submit" value="단원생성하기">

</form>
<%
//******************************************************************************
//   프로그램 : course_edit.jsp
//   모 듈 명 : 과정 수정
//   설    명 : 과정수정하기
//   테 이 블 : c_course
//   자바파일 : qmtm.admin.course.CourseUtil
//   작 성 일 : 2008-03-31
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.admin.course.*, java.sql.*" %>

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

    CourseBean rst = null;

    // 과정정보 가지고오기
	try {
	    rst = CourseUtil.getBean(id_node);
    } catch(Exception ex) {
	    out.println(ex.getMessage());
    }
%>

<center>

과정수정
<br>
<form name="frmdata" method="post" action="course_update.jsp">
<input type="hidden" name="id_node" value="<%=id_node%>">
<table border="0" width="450" cellpadding ="3" cellspacing="1" bgcolor="#CCCCCC">
	<tr height="40">
		<td width="30%" align="right">과정명&nbsp;</td>
		<td bgcolor="#FFFFFF">&nbsp;&nbsp;<input type="text" class="input" name="course" size="20" value="<%=rst.getCourse()%>"></td>
	</tr>
	<tr height="40">
		<td align="right">사용유무&nbsp;</td>
		<td bgcolor="#FFFFFF">&nbsp;&nbsp;<input type="radio" name="yn_valid" value="Y" <%if(rst.getYn_valid().equals("Y")) { %>checked<% } %>> 사용가능&nbsp;&nbsp;<input type="radio" name="yn_valid" value="N" <%if(rst.getYn_valid().equals("N")) { %>checked<% } %>> 사용불가</td>
	</tr>
</table>
<p>
<input type="submit" value="과정생성하기">

</form>
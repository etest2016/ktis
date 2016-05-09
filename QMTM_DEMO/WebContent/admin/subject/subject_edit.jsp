<%
//******************************************************************************
//   프로그램 : subject_edit.jsp
//   모 듈 명 : 과목 수정
//   설    명 : 해당 과정 아래 과목 수정하기
//   테 이 블 : c_subject
//   자바파일 : qmtm.admin.subject.SubjectUtil
//   작 성 일 : 2008-03-31
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.admin.subject.*, java.sql.*" %>

<%
	response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("EUC-KR");

    String id_node = request.getParameter("id_node"); // 트리 ID
    String id_subject = request.getParameter("id_subject"); // 과목 코드

	if (id_node == null) { id_node = ""; } else { id_node = id_node.trim(); }	
	
	if (id_node.length() == 0) { 
%>
	<script language="javascript">
		alert("해당 화면에 대한 권한이 없습니다.");
		history.back();
	</script>
<%	
	}	

	SubjectBean rst = null;

	// 과목정보 가지고오기
	try {
	    rst = SubjectUtil.getBean(id_subject);
    } catch(Exception ex) {
	    out.println(ex.getMessage());
    }
%>

<center>
과목수정
<br>
<form name="frmdata" method="post" action="subject_update.jsp">
<input type="hidden" name="id_node" value="<%=id_node%>">
<input type="hidden" name="id_subject" value="<%=id_subject%>">
<table border="0" width="500" cellpadding ="3" cellspacing="1" bgcolor="#CCCCCC">
	<tr height="40">
		<td width="30%" align="right">과목명&nbsp;</td>
		<td bgcolor="#FFFFFF">&nbsp;&nbsp;<input type="text" class="input" name="subject" size="20" value="<%=rst.getSubject()%>"></td>
	</tr>
	<tr height="40">
		<td align="right">정렬순서&nbsp;</td>
		<td bgcolor="#FFFFFF">&nbsp;&nbsp;<select name="subject_order">
		<% for(int i = 1; i <= 10; i++) { %>	
			<option value="<%=i%>" <%if(rst.getSubject_order()==i) { %>selected<% } %>><%=i%></option>
		<% } %>
		</td>
	</tr>
	<tr height="40">	
		<td align="right">사용유무&nbsp;</td>
		<td bgcolor="#FFFFFF">&nbsp;&nbsp;<input type="radio" name="yn_valid" value="Y" <%if(rst.getYn_valid().equals("Y")) { %>checked<% } %>> 사용가능&nbsp;&nbsp;<input type="radio" name="yn_valid" value="N" <%if(rst.getYn_valid().equals("N")) { %>checked<% } %>> 사용불능</td>
	</tr>
</table>
<p>
<input type="submit" value="과목수정하기">

</form>
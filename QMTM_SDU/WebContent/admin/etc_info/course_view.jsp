<%
//******************************************************************************
//   ���α׷� : course_view.jsp
//   �� �� �� : ����Ȯ��
//   ��    �� : ����Ȯ�� �˾� ������
//   �� �� �� : c_course
//   �ڹ����� : qmtm.ComLib, qmtm.admin.etc.CourseKindUtil, qmtm.admin.etc.CourseKindBean
//   �� �� �� : 2013-02-06
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.admin.etc.CourseKindUtil, qmtm.admin.etc.CourseKindBean" %>
<%@ include file = "/common/admin_chk.jsp" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_course = request.getParameter("id_course");
	if (id_course == null) { id_course= ""; } else { id_course = id_course.trim(); }

	String id_category = request.getParameter("id_category");
	if (id_category == null) { id_category = ""; } else { id_category = id_category.trim(); }

	String id_midcategory = request.getParameter("id_midcategory");
	if (id_midcategory == null) { id_midcategory = ""; } else { id_midcategory = id_midcategory.trim(); }

	if (id_course.length() == 0 || id_midcategory.length() == 0 || id_category.length() == 0) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

	if(!chk_usergrade.equals("S")) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

	CourseKindBean rst = null; 

	try {
		rst = CourseKindUtil.getBean(id_midcategory, id_course);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "close"));

	    if(true) return;
	}

	String yn_valid = "";
	if(rst.getYn_valid().equals("Y")) {
		yn_valid = "����";
	} else {
		yn_valid = "�����";
	}
%>

<script language="javascript">
	
	function edits() {
		location.href = "course_edit.jsp?id_category=<%=id_category%>&id_midcategory=<%=id_midcategory%>&id_course=<%=id_course%>";
	}

	function dels() {
		location.href = "course_delete.jsp?id_course=<%=id_course%>";
	}

</script>

<HTML>
<HEAD>
<TITLE> �������� Ȯ�� </TITLE>
<link rel="StyleSheet" href="../../css/style.css" type="text/css">
</HEAD>

<BODY id="popup2">

<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">�������� Ȯ�� <span>����Ȯ�� �� ����,����</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>

<div id="contents">

	<table border="0" cellpadding ="0" cellspacing="0" id="tableD">
			<tr>
				<td id="left">�뿵����</td>
				<td width="220"><%=rst.getCategory()%></td>
			</tr>
			<tr>
				<td id="left">�ҿ�����</td>
				<td width="220"><%=rst.getMidcategory()%></td>
			</tr>
			<tr>
				<td id="left">������</td>
				<td width="220"><%=rst.getCourse()%></td>
			</tr>
			<tr>
				<td id="left">���ļ���</td>
				<td width="220"><%=rst.getOrders()%></td>
			</tr>
			<tr>
				<td id="left">��������</td>
				<td><%=yn_valid%></td>
			</tr>
			<tr>
				<td id="left">�������</td>
				<td><%=rst.getRegdate()%></td>
			</tr>
	</table>
	</div>

<div id="button">
	<input type="button" value="�����ϱ�" class="form" onClick="edits();">&nbsp;&nbsp;<input type="button" value="�����ϱ�" class="form" onClick="dels();">&nbsp;&nbsp;<input type="button" value="â�ݱ�" class="form" onClick="window.close();">
</div>

	</form>

</BODY>
</HTML>
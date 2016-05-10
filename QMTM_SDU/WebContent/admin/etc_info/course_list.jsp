<%
//******************************************************************************
//   ���α׷� : course_list.jsp
//   �� �� �� : ���� ����Ʈ
//   ��    �� : ���� ����Ʈ ������
//   �� �� �� : id_category, id_midcategory, c_course
//   �ڹ����� : qmtm.ComLib, qmtm.CommonUtil, qmtm.admin.etc.CourseKindBean, qmtm.admin.etc.CourseKindUtil
//   �� �� �� : 2013-01-28
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� :    
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>
 
<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.CommonUtil, qmtm.ComLib, qmtm.admin.etc.CourseKindBean, qmtm.admin.etc.CourseKindUtil" %>
<%@ include file = "/common/adminAuth_chk.jsp" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String userid = (String)session.getAttribute("userid");
	if (userid == null) { userid= ""; } else { userid = userid.trim(); }	

	if (userid.length() == 0) {
	   out.println(ComLib.getParameterChk("close"));

	   if(true) return;
	}

	if(!chk_usergrade.equals("S")) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}
	
    // ������� ���������
	CourseKindBean[] rst = null; 

	try {
		rst = CourseKindUtil.getBeansAll();
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "close"));

	    if(true) return;
	}
	
%>

<HTML>
 <HEAD>
  <TITLE> Admin Main </TITLE>
  <link rel="StyleSheet" href="../../css/style.css" type="text/css">
  <script type="text/javascript" src="../../js/jquery.js"></script>
  <script type="text/javascript" src="../../js/jquery.etest.poster.js"></script>
  <script language="JavaScript">
	function insert() {
		$.posterPopup('course_insert.jsp','insert','width=400, height=300, scrollbars=no, top='+(screen.height-300)/2+', left='+(screen.width-400)/2);
    }

	function view(id_category, id_midcategory, id_course) {
		
		$.posterPopup('course_view.jsp?id_category='+id_category+'&id_midcategory='+id_midcategory+'&id_course='+id_course,'view','width=400, height=350, scrollbars=no, top='+(screen.height-350)/2+', left='+(screen.width-400)/2);
    }
 </script>

 </HEAD>

 <BODY id="admin">	
   <div id="main">		
		<div id="mainTop">
			<div class="title">�����ڵ����</div>
			<div class="location">ADMIN > �ڵ��������� > <span>�����ڵ����</span></div>
		</div>

	<table border="0" cellpadding ="0" cellspacing="0" id="tableA">
		<!--<tr id="bt">
			<TD colspan="9"><input type="button" value="�����ڵ���" class="form5" onClick="insert();">&nbsp;&nbsp;<b>�������� Ŭ���ϸ� ������ ����/������ �� �ֽ��ϴ�</b></TD>
		</TR>-->
		<tr id="tr">
			<td width="7%" align="center" bgcolor="#DBDBDB">NO</td>
			<td bgcolor="#DBDBDB">�뿵����</td>
			<td bgcolor="#DBDBDB">�ҿ�����</td>
			<td bgcolor="#DBDBDB">�����ڵ�</td>
			<td bgcolor="#DBDBDB">������</td>
			<td bgcolor="#DBDBDB">���ļ���</td>
			<td bgcolor="#DBDBDB">��������</td>			
			<td bgcolor="#DBDBDB">�������</td>
		</tr>
		<% if(rst == null) { %>
		<tr> 
			<td class="blank" colspan="8">��ϵǾ��� ���� �ڵ尡 �����ϴ�.</td>
		</tr>
		<%
		   } else {
			   for(int i = 0; i < rst.length; i++) {

				   String yn_valid = "";
				   if(rst[i].getYn_valid().equals("Y")) {
					  yn_valid = "����";  
				   } else {
					  yn_valid = "�����";
				   }
				   
		%>
		<tr id="td" align="center">
			<td><%=i+1%></td>
			<td><%=rst[i].getCategory()%></td>
			<td><%=rst[i].getMidcategory()%></td>
			<td><%=rst[i].getId_course()%></td> 
			<td><%=rst[i].getCourse()%></td> 
			<td><%=rst[i].getOrders()%></td>
			<td><%=yn_valid%></td>			
			<td><%=rst[i].getRegdate()%></td>
		</tr>
		<%
			   }
			}  
		%>
	</table>
	</div>

	<jsp:include page="../../copyright.jsp"/>
		
		
 </BODY>
</HTML>
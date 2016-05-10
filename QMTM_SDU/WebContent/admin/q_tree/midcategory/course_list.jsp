<%
//******************************************************************************
//   ���α׷� : category_list.jsp
//   �� �� �� : ���� ����Ʈ
//   ��    �� : ���� ����Ʈ ������
//   �� �� �� : id_category, id_midcategory, c_course
//   �ڹ����� : qmtm.admin.etc.CourseKindBean, qmtm.admin.etc.CourseKindUtil
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

	String id_midcategory = request.getParameter("id_midcategory");
	if (id_midcategory == null) { id_midcategory = ""; } else { id_midcategory = id_midcategory.trim(); }

	if (userid.length() == 0 || id_midcategory.length() == 0) {
	   out.println(ComLib.getParameterChk("back"));

	   if(true) return;
	}
	
    // ������� ���������
	CourseKindBean[] rst = null; 

	try {
		rst = CourseKindUtil.getBeans(id_midcategory);   
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
	}
	
%>
<HTML>
 <HEAD>
  <TITLE> Admin Main </TITLE>
  <link rel="StyleSheet" href="../../../css/style.css" type="text/css">
 
 <script language="JavaScript">
	
 </script>

 </HEAD>

 <BODY id="admin">	

	<div id="main">
		<div id="mainTop">
			<div class="title">ī�װ� ��ȸ ����Ʈ</span></div>
			<div class="location">ī�װ� ��ȸ > ī�װ� ��ȸ > <span>������ȸ</span></div>
		</div>
		<table border="0" cellpadding ="0" cellspacing="0" id="tablea">
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
	
 </BODY>
</HTML>
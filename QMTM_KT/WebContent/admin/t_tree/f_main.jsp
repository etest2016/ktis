<%
//******************************************************************************
//   ���α׷� : f_main.jsp
//   �� �� �� : ��������
//   ��    �� : �������� ������
//   �� �� �� : c_course
//   �ڹ����� : qmtm.CommonUtil, qmtm.ComLib, qmtm.admin.TmanTree, qmtm.admin.TmanTreeBean 
//   �� �� �� : 2008-04-11
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� :    
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.CommonUtil, qmtm.ComLib, qmtm.admin.TmanTree, qmtm.admin.TmanTreeBean, qmtm.admin.etc.GroupKindBean, qmtm.admin.etc.GroupKindUtil" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String userid = (String)session.getAttribute("userid");
	if (userid == null) { userid= ""; } else { userid = userid.trim(); }

	String id_category = request.getParameter("id_category");
	if (id_category == null) { id_category = ""; } else { id_category = id_category.trim(); }

	if (userid.length() == 0 || id_category.length() == 0) {
	   out.println(ComLib.getParameterChk("back"));

	   if(true) return;
	}

    // ������� ���������	
	TmanTreeBean[] rst = null; 

	try {
		rst = TmanTree.getBeans(id_category);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
	}

	GroupKindBean rst2 = null;

    try {
	    rst2 = GroupKindUtil.getBean(id_category);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
    }
   
%>

<HTML>
 <HEAD>
  <TITLE> Admin Main </TITLE>
  <link rel="StyleSheet" href="../../css/style.css" type="text/css">
 
 <script language="JavaScript">
	function sub_insert() {
		window.open("course_insert.jsp?id_category=<%=id_category%>","insert","width=400, height=250, scrollbars=no");
    }

	function sub_view(id_course) {
		window.open("course/course_view.jsp?id_category=<%=id_category%>&id_course="+id_course,"view","width=400, height=250, scrollbars=no");
    }
 </script>

 </HEAD>

 <BODY id="admin">	
	<div id="main">

		<div id="mainTop">
			<div class="title">ī�װ� ����<span>: ī�װ� ����Ʈ</span></div>
			<div class="location">ī�װ� ���� > <span><%=rst2.getCategory()%></span></div>
		</div>

		<table border="0" cellpadding ="0" cellspacing="0" id="tableA">
			<tr id="bt">
				<TD  colspan="6"><a onfocus="this.blur();" href="javascript:sub_insert();"><img src="../../images/bt_a_newcourse.gif"></a></TD>
			</TR>
			<tr id="tr">
				<td align="center" bgcolor="#DBDBDB">NO</td>
				<td bgcolor="#DBDBDB" align="center">�����⵵</td>
				<td bgcolor="#DBDBDB" align="center">�����ڵ�</td>
				<td bgcolor="#DBDBDB" align="center">������</td>
				<td bgcolor="#DBDBDB" align="center">��ȿ����</td>
				<td bgcolor="#DBDBDB">�������</td>
			</tr>
			<% if(rst == null) { %>
			<tr height="30" bgcolor="#FFFFFF">
				<td class="blank" colspan="6">��ϵǾ��� ������ �����ϴ�.</td>
			</tr>
			<%
			   } else {
				   for(int i = 0; i < rst.length; i++) {
			%>
			<tr id="td" height="30" bgcolor="#FFFFFF">
				<td align="center"><%=i+1%></td>
				<td align="center"><%=rst[i].getYears()%></td>
				<td align="center"><a onfocus="this.blur();" href="javascript:sub_view('<%=rst[i].getId_course()%>');"><%=rst[i].getId_course()%></a></td>
				<td align="center"><a onfocus="this.blur();" href="../q_tree/category_list.jsp?id_course=<%=rst[i].getId_course()%>"><%=rst[i].getCourse()%></a></td>
				<td align="center"><%=rst[i].getYn_valid()%></td>
				<td align="center"><%=rst[i].getRegdate()%></td>
				<!--<td align="center"><a onfocus="this.blur();" href="javascript:sub_group_insert('<%=rst[i].getId_course()%>');"><img src="../../images/bt_ttree_fmain_yj2.gif"></a></td>-->
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
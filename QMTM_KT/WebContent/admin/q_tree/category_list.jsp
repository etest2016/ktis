<%
//******************************************************************************
//   ���α׷� : f_main.jsp
//   �� �� �� : �������
//   ��    �� : ������� ������
//   �� �� �� : q_subject
//   �ڹ����� : qmtm.admin.QmanTreeBean, qmtm.admin.QmanTree
//   �� �� �� : 2008-04-03
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� :    
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>
 
<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.CommonUtil, qmtm.ComLib, qmtm.admin.QmanTree, qmtm.admin.QmanTreeBean, qmtm.admin.etc.GroupKindBean, qmtm.admin.etc.GroupKindUtil" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String userid = CommonUtil.get_Cookie(request, "userid");
	if (userid == null) { userid= ""; } else { userid = userid.trim(); }	

	String id_course = request.getParameter("id_course");
	if (id_course == null) { id_course = ""; } else { id_course = id_course.trim(); }

	if (userid.length() == 0 || id_course.length() == 0) {
	   out.println(ComLib.getParameterChk("back"));

	   if(true) return;
	}
	
    // ������ ���������
	QmanTreeBean[] rst = null; 

	try {
		rst = QmanTree.getBeans(id_course);   
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
	}

	GroupKindBean rst2 = null;

    try {
	    rst2 = GroupKindUtil.getBean2(id_course);
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
		window.open("subject_insert.jsp?id_category=<%=rst2.getId_category()%>&id_course=<%=id_course%>","insert","top=0, left=0, width=400, height=255, scrollbars=no");
    }

	function sub_view(id_q_subject) {
		
		window.open("subject/subject_view.jsp?id_q_subject="+id_q_subject,"view","top=0, left=0, width=400, height=255, scrollbars=no");
    }
 </script>

 </HEAD>

 <BODY id="admin">	

	<div id="main">
		<div id="mainTop">
			<div class="title">ī�װ� ����<span>: ī�װ� ����Ʈ</span></div>
			<div class="location">ī�װ� ���� > <%=rst2.getCategory()%> > <span><%=rst2.getCourse()%></span></div>
		</div>
		<table border="0" cellpadding ="0" cellspacing="0" id="tablea">
			<tr id="bt">
				<td colspan="5"><a href="javascript:sub_insert();" onfocus="this.blur();"><img src="../../images/bt_a_news.gif"></a></td>
			</tr>
			<tr id="tr">
				<td width="7%" align="center" bgcolor="#DBDBDB">NO</td>
				<td bgcolor="#DBDBDB" align="center">�����⵵</td>
				<td bgcolor="#DBDBDB" align="center">�����ڵ�</td>
				<td bgcolor="#DBDBDB" style="text-align: left;">�����</td>
				<td bgcolor="#DBDBDB">�������</td>
				<!--<td bgcolor="#DBDBDB">�����Ȯ��</td>-->
			</tr>
			<% if(rst == null) { %>
			<tr> 
				<td class="blank" colspan="5">��ϵǾ��� ������ �����ϴ�.</td>
			</tr>
			<%
			   } else {
				   for(int i = 0; i < rst.length; i++) {
			%>
			<tr id="td" align="center" <% if((i%2)==1){%>bgcolor="#fafaf5"<%}else{%>bgcolor="#ffffff"<%}%>>
				<td><%=i+1%></td>
				<td><%=rst[i].getYears()%>��</td>
				<!--td><a href="javascript:sub_view('<%=rst[i].getId_q_subject()%>');" onfocus="this.blur();"><%=rst[i].getId_q_subject()%></a></td-->
				<td><%=rst[i].getId_q_subject()%></td>
				<td style="text-align: left;"><div style="float: left; cursor: hand;"><a href="subject/subject_list.jsp?id_q_subject=<%=rst[i].getId_q_subject()%>" onfocus="this.blur();"><%=rst[i].getQ_subject()%></a></div> <div style="float: left; padding-top: 1px; padding-left: 6px; cursor: hand;"><a href="subject/subject_list.jsp?id_q_subject=<%=rst[i].getId_q_subject()%>" onfocus="this.blur();"><img src="../../images/info2.gif"></a></div></td>
				<td><%=rst[i].getRegdate()%></td>
				<!--<td align="center">[����� Ȯ��]</td>-->
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
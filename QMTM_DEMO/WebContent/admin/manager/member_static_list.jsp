<%
//******************************************************************************
//   ���α׷� : exam_ing_list.jsp
//   �� �� �� : �������� ���� ������
//   ��    �� : �������� ���� ������
//   �� �� �� : exam_m, qt_userid, qt_course_user, exam_receipt, exam_ans
//   �ڹ����� : qmtm.CommonUtil, qmtm.ComLib, qmtm.tman.exam.IngInwonBean, qmtm.tman.exam.IngInwon
//   �� �� �� : 2008-06-23
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.CommonUtil, qmtm.ComLib, qmtm.admin.MemberStatic, qmtm.admin.MemberStaticBean, java.util.Date, java.util.Calendar, qmtm.admin.etc.GroupKindBean, qmtm.admin.etc.GroupKindUtil " %>
<%@ include file = "../../common/calendar.jsp" %>
<%@ include file = "../../common/paging.jsp" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String userid = (String)session.getAttribute("userid");    
	if (userid == null) { userid= ""; } else { userid = userid.trim(); }
	
	if (userid.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}
	
	String exam_start = request.getParameter("exam_start");
	if (exam_start == null) { exam_start = ""; } else { exam_start = exam_start.trim(); }

	String exam_end = request.getParameter("exam_end");
	if (exam_end == null) { exam_end = ""; } else { exam_end = exam_end.trim(); }

	// �׷챸�и�� ���������
	GroupKindBean[] rst2 = null;

	try {
		rst2 = GroupKindUtil.getBeans();
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
	}

	String id_category = request.getParameter("id_category");
	if (id_category == null) { id_category= ""; } else { id_category = id_category.trim(); }

	if(id_category.length() == 0) {
		id_category = rst2[0].getId_category();
	}

	String tmp_page = request.getParameter("page");
	if (tmp_page == null) { tmp_page= ""; } else { tmp_page = tmp_page.trim(); }

	String url = "member_static_list.jsp";	

	String add_tag = "&id_category="+id_category+"&exam_start="+exam_start+"&exam_end="+exam_end;
    	
	int total_page = 0; // �� ������
    int total_count = 0; // �� ���ڵ� ��
	int current_page = 0; // ���� ������
	int page_scale = 20; // �� ȭ�鿡 �������� �Խù� ��
	int remain = 0; // ������ ����� ���� �������� ���.
	int start_rnum = 0; // ���� ������ �Խù� ���۹�ȣ
	int end_rnum = 0; // ���� ������ �Խù� ����ȣ

	if(tmp_page.length() == 0) {
		current_page = 1;
	} else {
		current_page = Integer.parseInt(tmp_page);
	}
	
	MemberStaticBean[] rst = null;

	if(exam_start.length() > 0 && exam_end.length() > 0) {

		try {
			total_count = MemberStatic.getCounts(id_category, exam_start, exam_end);
		} catch(Exception ex) {
			out.println(ComLib.getExceptionMsg(ex, "close"));

			if(true) return;
		}

		remain = total_count % page_scale;
		
		if(remain == 0) {
			total_page = total_count / page_scale;
		} else {
			total_page = total_count / page_scale + 1;
		}

		int lists = (current_page - 1) * page_scale;
		
		try {
			rst = MemberStatic.getBeans(page_scale, lists, id_category, exam_start, exam_end);
		} catch(Exception ex) {
			out.println(ComLib.getExceptionMsg(ex, "back"));		    

		    if(true) return;
		}
	} 
%>

<html>
<head>
	<title></title>
	<link rel="StyleSheet" href="../../css/style.css" type="text/css">
 
	<script language="JavaScript">
		function send() {
			var frm = document.form1;
			
			if(frm.exam_start.value == "") {
				alert("�˻����ڸ� �Է��ϼ���");
				frm.exam_start.focus();
				return;
			} else if(frm.exam_end.value == "") {
				alert("�˻����ڸ� �Է��ϼ���");
				frm.exam_end.focus();
				return;
			} else {
				frm.submit();
			}
		}

		function excel_down() {
			location.href="member_static_list_excel.jsp?id_category=<%=id_category%>&exam_start=<%=exam_start%>&exam_end=<%=exam_end%>";
		}
	</script>

</head>

<BODY id="tman">
	<form name="form1" method="post" action="member_static_list.jsp">

	<div id="main">

		<div id="mainTop">
			<div class="title">���κ� ����������� <span>�˻��� �������ڸ� �Է��ϸ� ���κ� �������� ��踦 Ȯ���� �� �ֽ��ϴ�.</span></div>
			<div class="location">������� ><span> ����ڰ��� > ���κ� �����������</span></div>
		</div>

		<table border="0" cellpadding="0" cellspacing="0" width="100%" id="tableA">
			<tr id="bt3">
				<td colspan="7">
					�о߼��� : <Select name="id_category">
				<% if(rst2 == null) { %>
					<option value="">�о߾���</option>
				<%
					} else {
						for(int i=0; i<rst2.length; i++) {
				%>
						<option value="<%=rst2[i].getId_category()%>" <%if(rst2[i].getId_category().equals(id_category)) { %>selected<% } %>><%=rst2[i].getCategory()%></option>
				<%
						}
					}
				%>
				</select>&nbsp;&nbsp;
					<input type="text" class="input" name="exam_start" size="12" readonly onClick="MiniCal(this)" value="<%=exam_start%>"> ~ <input type="text" class="input" name="exam_end" size="12" readonly onClick="MiniCal(this)" value="<%=exam_end%>">&nbsp;&nbsp;<!--<input type="button" value="Ȯ���ϱ�" onClick="send();">--><a href="javascript:send();"><img src="../../images/bt_exam_search_list_yj2.gif" align="absmiddle"></a>
				</td>
				<td colspan="3" align="right"><input type="button" value="�������� �ٿ�ε�" class="form5" onClick="excel_down();"></td>
			</tr>
			<tr bgcolor="#FFFFFF" align="center" height="30" id="tr">
				<td bgcolor="#D8D8D8">NO</td>
				<td bgcolor="#D8D8D8">�����</td>
				<td bgcolor="#D8D8D8">���̵�</td>
				<td bgcolor="#D8D8D8">����</td>
				<td bgcolor="#D8D8D8">�Ҽ�</td>
				<td bgcolor="#D8D8D8">�Ҽ�2</td>
				<!--<td bgcolor="#D8D8D8">�Ҽ�3</td>-->
				<td bgcolor="#D8D8D8">����</td>
				<td bgcolor="#D8D8D8">�������</td>
				<td bgcolor="#D8D8D8">����</td>
			</tr>
<% if(rst == null) {%>
			<tr bgcolor="#FFFFFF" height="40">
				<td class="blank" align="center" colspan="9">�˻����ڸ� �Է��ϼ���..</td>
			</tr>
<% 
	} else { 
				
		for(int i=0; i<rst.length; i++) {	
			int list_num = total_count - (current_page - 1) * page_scale - i;
%>
			<tr id="td" bgcolor="#FFFFFF" height="27" align="center">
				<td><%=list_num%></td>
				<td><%=rst[i].getTitle()%></td>
				<td><%=rst[i].getUserid()%></td>
				<td><%=rst[i].getName()%></td>
				<td><%=ComLib.nullChk(rst[i].getSosok2())%></td>
				<td><%=ComLib.nullChk(rst[i].getSosok3())%></td>
				<!--<td><%=ComLib.nullChk(rst[i].getSosok4())%></td>-->
				<td><%=rst[i].getP_score()%></td>
				<td><%=rst[i].getT_avg()%></td>
				<td><%=rst[i].getP_rank()%></td>
			</tr>
<%
		}
	}
%>
		</table>
		
		<P>

		<table border="0" width="100%">
			<tr>
				<td align="center"><%= PageNumber(current_page, total_page, url, add_tag) %></td>
			</tr>
		</table>
		
	</form>

	</div>
	<jsp:include page="../../copyright.jsp"/>

</body>

</html>
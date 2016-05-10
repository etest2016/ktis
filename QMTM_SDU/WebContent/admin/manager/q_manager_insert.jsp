<%
//******************************************************************************
//   ���α׷� : q_manager_insert.jsp
//   �� �� �� : ����� �������
//   ��    �� : ����� ������� �˾� ������
//   �� �� �� : t_worker_subj, c_course
//   �ڹ����� : qmtm.ComLib, qmtm.admin.manager.ManagerTBean, qmtm.admin.manager.ManagerTUtil,
//              qmtm.admin.etc.GroupKindBean, qmtm.admin.etc.GroupKindUtil, 
//              qmtm.admin.etc.MidCategoryBean, qmtm.admin.etc.MidCategoryUtil 
//   �� �� �� : 2013-02-01
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.admin.manager.ManagerTBean, qmtm.admin.manager.ManagerTUtil, qmtm.admin.etc.GroupKindBean, qmtm.admin.etc.GroupKindUtil" %>
<%@ include file = "/common/admin_chk.jsp" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String userid = request.getParameter("userid");
	if (userid == null) { userid= ""; } else { userid = userid.trim(); }

	if (userid.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	String id_category = request.getParameter("id_category");
	if (id_category == null) { id_category = ""; } else { id_category = id_category.trim(); }

	String mid_category = request.getParameter("mid_category");
	if (mid_category == null) { mid_category = ""; } else { mid_category = mid_category.trim(); }

    // �뿵����� ���������
	GroupKindBean[] cst = null;

	try {
		cst = GroupKindUtil.getBeans();
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "close"));

	    if(true) return;
	}
	
	// ����� ������ ��� ���������
	ManagerTBean[] rst = null;

	if(!(id_category.equals("") && mid_category.equals(""))) {
		
		try {
			rst = ManagerTUtil.getAddBeans(userid, mid_category);
		} catch(Exception ex) {
			out.println(ComLib.getExceptionMsg(ex, "close"));

			if(true) return;
		}	
	}
%>

<HTML>
 <HEAD>
  <TITLE> :: ������ �߰� :: </TITLE>
  <link rel="StyleSheet" href="../../css/style.css" type="text/css">
  
  <script language="JavaScript">
	function checks() {
		var frm = document.form1;
		var cnt = 0;

		if (frm.courses.length == undefined) { //�Ѱ��϶� üũ
			if(frm.courses.checked==true ) {
			   cnt = cnt + 1;
			} 
		}else{

			for(i=0;i<frm.courses.length;i++) {
				if(frm.courses[i].checked) {
					cnt = cnt + 1;
				}
			}
		}
			
		if(cnt == 0) {
			alert("������ �����ϼ���.!!!");
			return;
		}

		frm.submit();
    }

	var category1;

	// �ҿ��� �����ڵ����� ���������
	function get_category_list(strs) {
		
		category1 = new ActiveXObject("Microsoft.XMLHTTP");
		category1.onreadystatechange = get_category_list_callback;
		category1.open("GET", "category.jsp?mid_category=<%=mid_category%>&id_category="+strs, true);
		category1.send();
	}

	function get_category_list_callback() {

		if(category1.readyState == 4) {
			if(category1.status == 200) {
				if(typeof(document.all.div_category) == "object") {
					document.all.div_category.innerHTML = category1.responseText;
				}
			}
		}
	}

 </script>

 </HEAD>

 <BODY id="popup2" onLoad="get_category_list('<%=id_category%>');">
	<form name="formdata" method="post">	
	<input type="hidden" name="userid" value="<%=userid%>">
	<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">������ �߰� <span>���� ����ڿ��� ������ �ο��� ���� �� ���� ����</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>
	
	<div id="contents" style="text-align: center;">

		<TABLE width="95%" cellpadding="0" cellspacing="0" border="0" >
			<tr>
				<td><div style="float: left;">�������� : <select name="id_category" style="width:200" onChange="get_category_list(this.value);">
				<% if(cst == null) { %>
					<option value="">��ϵ� �뿵���� ����</option>
				<% } else { %>
					<option value="">�뿵���� �����ϼ���</option>
				<%	  for(int i=0; i<cst.length; i++) { %>
						<option value="<%=cst[i].getId_category()%>" <% if(id_category.equals(cst[i].getId_category())) { %>selected<% } %>><%=cst[i].getCategory()%></option>
				<%    
					   } 
				   }
				%>
				</select>&nbsp;&nbsp;</div><div  style="float: left;" id="div_category"><select name="mid_category" style="width:200">
					<option value="">�ҿ����� �����ϼ���</option>
				</select></div><div style="float: left;">&nbsp;&nbsp;<input type="submit" value="�˻��ϱ�" ></div></td>
			</tr>
		</table>
		</form>

		<form name="form1" method="post" action="q_manager_insert_ok.jsp">
		<input type="hidden" name="userid" value="<%=userid%>">
		
		<TABLE width="95%" cellpadding="3" cellspacing="0" border="0" id="tableA">
			<tr id="tr4">
				<td width="5%" height="40" align="center" bgcolor="#DBDBDB">����</td>
				<td>������</td>
				<td width="10%">������������</td>
				<td width="10%">������������</td>
				<td width="10%">������������</td>
				<td width="10%">�����������</td>
				<td width="10%">���������</td>
				<td width="10%">ä������</td>
				<td width="10%">������</td>
			</tr>
			<% if(id_category.equals("") && mid_category.equals("")) {	%>
				<tr>
					<td class="blank" colspan="9">������ �����ϼ���.</td>
				</tr>
			<% } else { %>
				<% if(rst == null) { %>
				<tr>
					<td class="blank" colspan="9">�߰��Ͻ� ������ �����ϴ�.</td>
				</tr>
				
				<%
				   } else {
					   for(int i = 0; i < rst.length; i++) {
				%>

				<tr id="td" align="center">
					<td><input type="checkbox" name="courses" value="<%=rst[i].getId_course()%>"></td>
					<td><%=rst[i].getCourse()%></td>
					<td><input type="checkbox" name="q_edit<%=rst[i].getId_course()%>" value="Y" checked></td>
					<td><input type="checkbox" name="q_del<%=rst[i].getId_course()%>" value="Y" checked></td>
					<td><input type="checkbox" name="exam_edit<%=rst[i].getId_course()%>" value="Y" checked></td>
					<td><input type="checkbox" name="exam_del<%=rst[i].getId_course()%>" value="Y" checked></td>
					<td><input type="checkbox" name="answer_edit<%=rst[i].getId_course()%>" value="Y" checked></td>
					<td><input type="checkbox" name="score_edit<%=rst[i].getId_course()%>" value="Y" checked></td>
					<td><input type="checkbox" name="static_edit<%=rst[i].getId_course()%>" value="Y" checked></td>
				</tr>
			<%
					   }
					}
				}
			%>
		</table>

	</div>

	<div id="button">
		<% if(rst != null) { %><a href="javascript:checks();" onfocus="this.blur();"><img src="../../images/bt_t_insertyj_1.gif"></a><% } %>&nbsp;&nbsp;<img src="../../images/bt_close_1.gif" onclick="javascript:window.close();" style="cursor: pointer;" onfocus="this.blur();">
	</div>	
	
 </BODY>
</HTML>
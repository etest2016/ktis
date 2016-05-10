<%
//******************************************************************************
//   ���α׷� : course_edit.jsp
//   �� �� �� : ���� ����
//   ��    �� : ���������ϱ�
//   �� �� �� : c_course
//   �ڹ����� : qmtm.ComLib, qmtm.admin.etc.CategoryBean, qmtm.admin.etc.CategoryUtil, 
//              qmtm.admin.etc.CourseKindUtil, qmtm.admin.etc.CourseKindBean
//   �� �� �� : 2013-02-04
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.admin.etc.CategoryBean, qmtm.admin.etc.CategoryUtil, qmtm.admin.etc.CourseKindUtil, qmtm.admin.etc.CourseKindBean " %>
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

    CourseKindBean bean = null; 

	try {
		bean = CourseKindUtil.getBean(id_midcategory, id_course);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "close"));

	    if(true) return;
	}

	// �뿵����� ���������
	CategoryBean[] rst = null;

	// �뿵���ڵ� ���� ��������
	try {
		rst = CategoryUtil.getParentCategory();
	} catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "close"));

	    if(true) return;
    }
%>
<HTML>
<HEAD>
<TITLE> �������� ���� </TITLE>
<link rel="StyleSheet" href="../../css/style.css" type="text/css">

<script language="JavaScript">

		function Sends() {
			var frm = document.frmdata;
			
			if(frm.id_category.value == "") {
				alert("�뿵���� �����ϼ���");				
				return;
			} else if(frm.id_midcategory.value == "") {
				alert("�ҿ����� �����ϼ���");				
				return;
			} else if(frm.course.value == "") {
				alert("�������� �Է��ϼ���");
				frm.course.focus();
				return;
			} else if(frm.orders.value == "") {
				alert("���ļ����� �����ϼ���");				
				return;
			} else {
				frm.submit();
			}
		}

		var category1;

		// �ҿ��� �����ڵ����� ���������
		function get_category_list(strs) {	

			category1 = new ActiveXObject("Microsoft.XMLHTTP");
			category1.onreadystatechange = get_category_list_callback;
			category1.open("GET", "midcategory.jsp?id_category="+strs+"&id_midcategory=<%=id_midcategory%>", true);
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

</head>

<BODY id="popup2" onLoad="get_category_list('<%=id_category%>');">

<form name="frmdata" method="post" action="course_update.jsp">
<input type="hidden" name="id_course" value="<%=id_course%>">

<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">���� �������� <span> ���������� �����մϴ�.</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>

<div id="contents">

	<table border="0" cellpadding ="0" cellspacing="0" id="tableD">
		<tr>
			<td id="left">�뿵������</td>
			<td width="200">
			<select name="id_category" style="width:200" onChange="get_category_list(this.value);">
			<% if(rst == null) { %>
				<option value=""></option>
			<% 
				} else { 
			%>
				<option value="">�뿵���� �����ϼ���</option>
			<%
					for(int i = 0; i < rst.length; i++) {
			%>
				<option value="<%=rst[i].getId_category()%>" <%if(rst[i].getId_category().equals(id_category)) { %>selected<% } %>><%=rst[i].getCategory()%></option>
			<% 
					}
				} 
			%>
			</select>
			</td>
		</tr>
		<tr>
			<td id="left">�ҿ�������</td>
			<td width="200">
			<div  style="float: left;" id="div_category"><select name="id_midcategory" style="width:200" >
				<option value="">�ҿ����� �����ϼ���</option>
			</select></div>
			</td>
		</tr>			
		<tr>
			<td id="left">������</td>
			<td><input type="text" class="input" name="course" size="32" style="ime-mode:active;" value="<%=bean.getCourse()%>"></td>
		</tr>		
		<tr>
			<td id="left">���ļ���</td>
			<td>
			<select name="orders">
				<option value="">����</option>
				<% for(int i = 1; i <= 15; i++) { %>	
				<option value="<%=i%>" <%if(bean.getOrders() == i) {%>selected<% } %>><%=i%></option>
				<% } %>
			</select>
			</td>
		</tr>
		<tr>
			<td id="left">��������</td>
			<td><input type="radio" name="yn_valid" value="Y" <%if(bean.getYn_valid().equals("Y")) {%>checked<%}%>> ����&nbsp;&nbsp;<input type="radio" name="yn_valid" value="N" <%if(bean.getYn_valid().equals("N")) {%>checked<%}%>> �����</td>
		</tr>
	</table>
</div>

<div id="button">
	<input type="button" value="�����ϱ�" class="form" onClick="Sends();">&nbsp;&nbsp;<input type="button" value="â�ݱ�" class="form" onClick="window.close();">
</div>

	</form>

</BODY>
</HTML>
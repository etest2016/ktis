<%
//******************************************************************************
//   ���α׷� : subject_insert.jsp
//   �� �� �� : ���µ��
//   ��    �� : ������� ���µ�� �˾� ������
//   �� �� �� : c_subject
//   �ڹ����� : qmtm.ComLib, qmtm.admin.tman.SubjectTmanUtil
//   �� �� �� : 2013-02-12
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.admin.tman.SubjectTmanUtil, java.sql.Timestamp, java.util.Calendar" %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_course = request.getParameter("id_course");
	if (id_course == null) { id_course= ""; } else { id_course = id_course.trim(); }

	if (id_course.length() == 0) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}

	Calendar cal = Calendar.getInstance();
	String years = String.valueOf(cal.get(Calendar.YEAR));
	int month = cal.get(Calendar.MONTH);

	String months = String.valueOf(month+1);

	if(String.valueOf(months).length() == 1) {
		months = "0"+months;
	}

	// ���ļ���
	int order_cnt = 0;

	try {
		order_cnt = SubjectTmanUtil.getOrderCnt(id_course);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "close"));

	    if(true) return;
	}
%>

<HTML>
 <HEAD>
  <TITLE> :: ���� ���� ��� :: </TITLE>
  <link rel="StyleSheet" href="../../css/style.css" type="text/css">
  
  <Script language="JavaScript">
  	function send() {
  		if(document.frmdata.subject.value == "") {
  			alert("���¸��� ����ϼ���.");
  			document.frmdata.subject.focus();
  			return;
  		} else {
  			document.frmdata.submit();
  		}  		
  	}
  </Script>
  
 </HEAD>

 <BODY id="popup2">

<form name="frmdata" method="post" action="subject_insert_ok.jsp">
<input type="hidden" name="id_course" value="<%=id_course%>">
<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">���� ���� ��� <span>�ű� ���¸� ����մϴ�.</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>

	<div id="contents">
		<table border="0" cellpadding ="0" cellspacing="0" id="tableD">
			<tr>
				<td width="90" id="left">���¸�</td>
				<td width="200"><input type="text" class="input" name="subject" size="30" style="ime-mode:active;">&nbsp;</td>
			</tr>
			<tr>
			<td id="left">���ļ���</td>
				<td><select name="subject_order">
				<% for(int i = 1; i <= 15; i++) { %>	
					<option value="<%=i%>" <%if(order_cnt == i) {%>selected<% } %>><%=i%></option>
				<% } %></td>
			</tr>
			<tr>
				<td id="left">����������</td>
				<td><select name="open_year">
				<%
					String open_year = "";
					for(int i = 2008; i<=2025; i++) { 
						open_year = String.valueOf(i);
				%>
					<option value="<%=i%>" <% if(open_year.equals(years)) { %>selected<% } %>><%=i%></option>
				<%}%>
				</select>&nbsp;/&nbsp;<Select name="open_month">
				<%
					for(int i = 1; i<=12; i++) { 
						String open_month = "";
						if(String.valueOf(i).length() == 1) {
							open_month = "0"+String.valueOf(i);
						} else {
							open_month = String.valueOf(i);
						}
				%>
					<option value="<%=open_month%>" <% if(open_month.equals(months)) { %>selected<% } %>><%=open_month%></option>
				<%}%>
				</td>
			</tr>
		</table>
		
	</div>

	<div id="button">
		<input type="button" value="����ϱ�" class="form" onClick="send();">&nbsp;&nbsp;<input type="button" value="â�ݱ�" class="form" onClick="window.close();">		
	</div>

	</form>

 </BODY>
</HTML>
<%
//******************************************************************************
//   ���α׷� : incorrect.jsp
//   �� �� �� : �������� ó��
//   ��    �� : �������� ó��
//   �� �� �� : q
//   �ڹ����� : qmtm.*, qmtm.qman.question.*
//   �� �� �� : 2010-06-05
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************

%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.tman.exam.*, qmtm.common.* " %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_q = request.getParameter("id_q");
	if (id_q == null) { id_q = ""; } else { id_q = id_q.trim(); }	

	String s_id_qtype = request.getParameter("id_qtype");
	if (s_id_qtype == null) { s_id_qtype = ""; } else { s_id_qtype = s_id_qtype.trim(); }	

	String ca = request.getParameter("ca");
	if (ca == null) { ca = ""; } else { ca = ca.trim(); }	

	String s_excount = request.getParameter("excount");
	if (s_excount == null) { s_excount = ""; } else { s_excount = s_excount.trim(); }	

	String s_cacount = request.getParameter("cacount");
	if (s_cacount == null) { s_cacount = ""; } else { s_cacount = s_cacount.trim(); }	

	String s_id_valid_type = request.getParameter("id_valid_type");
	if (s_id_valid_type == null) { s_id_valid_type = ""; } else { s_id_valid_type = s_id_valid_type.trim(); }	
		
	if (id_q.length() == 0 || s_id_qtype.length() == 0 || s_excount.length() == 0 || s_cacount.length() == 0 || s_id_valid_type.length() == 0) {
		out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}	

	int id_qtype = Integer.parseInt(s_id_qtype);
	int excount = Integer.parseInt(s_excount);
	int cacount = Integer.parseInt(s_cacount);
	int id_valid_type = Integer.parseInt(s_id_valid_type);
%>

<HTML>
<HEAD>
	<TITLE> :: �������� ó�� :: </TITLE>
	<link rel="StyleSheet" href="../../css/style.css" type="text/css">

	<script language="javascript">

		var id_qtype = <%=id_qtype%>;
		var ca = "<%=ca%>";
		var excount = <%=excount%>;
		var cacount = <%=cacount%>;
		var id_valid_type = <%=id_valid_type%>;
		
		function inits() {

			var ArrCa = new Array();
			var ArrCa2 = new Array();

			var frm = document.form1;

			eval("frm.id_valid_type[" +id_valid_type+ "].checked = true;");			
			
			if(id_qtype == 2) {				
				for(var i = 0; i < excount; i++) {
					
				
						ArrCa = ca.split("{^}");

						for (var k = 0; k < ArrCa.length; k++) { 
							if(i+1 == parseInt(ArrCa[k])) {					
								frm.ex[i].checked = true;
							}
						}
					
				}

				types(id_valid_type);
			} 	
		}

		function types(types) {

			var frm = document.form1;
			if(types == 0) {
				frm.strs.value = "������ 1���� �����ϼ���.";
				for(var i=0; i<excount; i++) {
					frm.ex[i].disabled = false;
				}
			} else if(types == 1) {
				frm.strs.value = "������ ��� �����ϼ���.";
				for(var i=0; i<excount; i++) {
					frm.ex[i].disabled = false;
				}
			} else if(types == 2) {
				frm.strs.value = "������ ������ �ʿ䰡 �����ϴ�.";
				for(var i=0; i<excount; i++) {
					frm.ex[i].disabled = true;
				}
			}
		}

		function Send() {

			var frm = document.form1;

			var ca_cnt = 0;

			if((id_qtype == 2) || (id_qtype == 3)) {
			
			if(frm.id_valid_type[0].checked == true) {
				for(var i=0; i<excount; i++) {
					if(frm.ex[i].checked == true) {
						ca_cnt = ca_cnt + 1;
					}
				}

				if(ca_cnt == 0) {
					alert("������ �����ϼž� �մϴ�.");
					return false;
				} else if(ca_cnt > 1) {
					alert("������ 1���� �����ϼž� �մϴ�.");
					return false;
				}
			}

			}
			
			frm.submit();
		}

	</script>
</HEAD>

<BODY onLoad="inits();" id="popup2">

	<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">�������� ���� ó�� <span>���������� ä�� ������ �ο��մϴ�</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>
	<div id="contents">
		<form name="form1" method="post" action="incorrect_ok.jsp">
	
		<input type="hidden" name="id_q" value="<%=id_q%>">
		<input type="hidden" name="id_qtype" value="<%=id_qtype%>">

		<table border="0" width="100%" cellpadding="1" cellspacing="1" bgcolor="#CCCCCC">
			<tr bgcolor="#FFFFFF">
				<td width="88%">
					<table border="0">
					<% if(id_qtype == 2 ) { %>
						<tr>
							<td>&nbsp;&nbsp;<input type="radio" name="id_valid_type" value="0" onClick="types(0)"> ���� ����</td>
						</tr>
						<tr>
							<td>&nbsp;&nbsp;<input type="radio" name="id_valid_type" value="1" onClick="types(1)"> ���� ������ ó��</td>
						</tr>
						<tr>
							<td>&nbsp;&nbsp;<input type="radio" name="id_valid_type" value="2" onClick="types(2)"> ��� ���� ó��</td>
						</tr>												
					<% } else { %>
						<tr>
							<td>&nbsp;&nbsp;<input type="checkbox" name="id_valid_type" value="2" > ��� ���� ó��</td>
						</tr>
					<% } %>
					</table>
					</td>
					<td>
					<table border="0">
						<% if(id_qtype == 2) { %>
						<tr>
							<td><input type="text" name="strs" size="50" readonly></td>
						</tr>
						<% } %>
						<tr>
							<td>
							<% 
								if(id_qtype == 2) {
									for(int i=1; i<=excount; i++) { 
							%>
									<input type="checkbox" name="ex" value="<%=i%>">&nbsp;<%=i%>��&nbsp;
							<% 
									}
								} 
							%>
							</td>
						</tr>						
					</table>
				</td>
				<td valign="top" width="12%" align="center"><input type="button" value="Ȯ���ϱ�" onClick="Send();" class="form"><br><input type="button" value="����ϱ�" onClick="window.close();" class="form"></td>
			</tr>
		</table>
		
		<br>
		<div class="box" style="overflow-y:scroll; height:250"> 
			&lt;���� ����&gt;<br>
			���� ������ �°� ���� ������ ���� �����Դϴ�. ���������� ó���� �����մϴ�.<br><br>
			&lt;���� ����&gt;<br>
			������ 1���� �����ϴ� �������� ��쿡�� �ش�˴ϴ�.<br>
			���� ������ 1�������� ���� �Ŀ� ������ ���信 ������ �߰ߵǾ ���� ����� �ٸ� ���� ������ �������� ������ �ȴٸ�<br>
			�ش� ���� ������ �������� �����ؼ� ä���մϴ�.<br>
			���� ��� ������ 1���ε� 3���� �������� �� �� �ִٸ� 1��, 3�� ��� üũ�س����� TMan����ä���� �ݿ��� �˴ϴ�.
			<br><br>
			&lt;��� ���� ó��&gt;<br>
			���� ��ü�� ������ �־ ��� �������� ����� ��� ���� ������ ������� �������� ó���մϴ�.<br>
			--------------------------------------------------------------------------------------------------------------------<br><br>
			&lt;���� ����&gt; �� &lt;��� ���� ó��&gt; �ΰ��� ���� ���� ������ �� �� ������ ����� �� �����ϴ�. <br>
			�ݵ�� �����ؾ� �Ѵٸ� �� ������ �����ؼ� ���� ������ ������ �����ؼ� ����Ͻñ� �ٶ��ϴ�.<br><br>

			���� ���¸� ������ ��� �̹� ä���� ����Ǿ��ٸ� TMan���� ä���� ��� ó���� �ٽ� �ؾ� ������ �ݿ��� �˴ϴ�.<br>
			���� Ƚ���� 1ȸ �̻��̶�� ���� ���¸� ������ ��� ���� ���迡�� ��Ȯ�� ���� ��ȸ�� �ʿ��ϴٸ� �ʿ��� ��� ���迡��<br>
			ä���� ��� ó���� �ٽ� �ؾ� �˴ϴ�.<br>
			--------------------------------------------------------------------------------------------------------------------
		</div>
	
	</form>
	</div>
	<div id="button">
		
	</div>
	
</BODY>

</HTML>
	
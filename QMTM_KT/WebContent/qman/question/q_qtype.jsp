<%
//******************************************************************************
//   ���α׷� : q_qtype.jsp
//   �� �� �� : ���� ���� ����
//   ��    �� : �ű� ���� ����(QTYPE) ����
//   �� �� �� : q
//   �ڹ����� : qmtm.*, qmtm.qman.question.*, qmtm.admin.*
//   �� �� �� : 2008-04-17
//   �� �� �� : ���׽�Ʈ ������
//   �� �� �� : 2008-08-18
//   �� �� �� : ���׽�Ʈ ����ȣ
//	 �������� : ��������, ���⼳�� �κ� ����
//******************************************************************************
%>

<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="qmtm.*, qmtm.qman.question.*, qmtm.admin.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("euc-kr");

	String id_q_subject = request.getParameter("id_q_subject");
	if (id_q_subject == null) { id_q_subject = "0"; } else { id_q_subject = id_q_subject.trim(); }	

	if (id_q_subject.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	String id_q_chapter = request.getParameter("id_q_chapter"); // �ܿ� 1
	if (id_q_chapter == null) { id_q_chapter = "-1"; } else { id_q_chapter = id_q_chapter.trim(); }

	String id_q_chapter2 = request.getParameter("id_q_chapter2"); // �ܿ� 2
	if (id_q_chapter2 == null) { id_q_chapter2 = "-1"; } else { id_q_chapter2 = id_q_chapter2.trim(); }

	String id_q_chapter3 = request.getParameter("id_q_chapter3"); // �ܿ� 3
	if (id_q_chapter3 == null) { id_q_chapter3 = "-1"; } else { id_q_chapter3 = id_q_chapter3.trim(); }

	String id_q_chapter4 = request.getParameter("id_q_chapter4"); // �ܿ� 4
	if (id_q_chapter4 == null) { id_q_chapter4 = "-1"; } else { id_q_chapter4 = id_q_chapter4.trim(); }

	String qtype = (String)session.getAttribute("qtype"); // ��������
	if (qtype == null) { qtype= "2"; } else { qtype = qtype.trim(); }

	String excounts = (String)session.getAttribute("excounts"); // ���ⰹ��	
	if (excounts == null) { excounts= "4"; } else { excounts = excounts.trim(); }
%>

<HTML>
 <HEAD>
  <TITLE>:: ���� ���� ���� ::</TITLE>
  <link rel="StyleSheet" href="../../css/style.css" type="text/css">
  <SCRIPT LANGUAGE="JavaScript">
  <!--

	var excounts = "<%=excounts%>";
	
	function ChkQtype(qtype) {

		var qtype, i, ex_type, ca_type;	

		var frm = document.frmdata;

		if(qtype==1){
			ex = 2;
			ca = 1;
			k1 = 2;
			l1 = 1;
			frm.explains.value = "������ ������ ������ ��, �ƴϿ� �� �� �ϳ��� ������ �䱸�ϴ� ���������Դϴ�.";
		} else if(qtype==2){
			ex = 5;
			ca = 1;		
			k1 = 3;
			l1 = 1;
			frm.explains.value = "���� ���� 3 ~ 5�� �� �ϳ��� ������ ���� ���������Դϴ�.";
		} else if(qtype==3){
			ex = 5;
			ca = 5;
			k1 = 3;
			l1 = 2;
			frm.explains.value = "���� ���� 3 ~ 5�� �� �ΰ� �̻��� ������ ���� ���������Դϴ�.";
		} else if(qtype==4){
			ex = 0;
			ca = 5;
			k1 = 0;
			l1 = 1;
			frm.explains.value = "���� ���� ���� ������ ������ �ϳ� �Ǵ� �� �̻��� ������ �����ڰ� ���� �����ϵ��� �ϴ� ���������Դϴ�.";
		} else if(qtype==5){
			ex = 0;
			ca = 0;
			k1 = 0;
			l1 = 0;
			frm.explains.value = "������ ������ �䱸�ϴ� ����� �����ڰ� ���������� ����� �ۼ��ϵ��� �ϴ� ���������Դϴ�. �� ���������� �ڵ� ä���� �������� �ʽ��ϴ�.";
		}

		var str = "";
		str += "<select name=excount>";

		var sels = "";
		
		for(var i = k1; i <= ex; i++){
			if(excounts == i) {
				sels = "selected";
			} else {
				sels = "";
			}
			str += "<OPTION VALUE=" + i + " " + sels + " >" + i + "</option>";
		}

		str += "</SELECT>";
		
		document.all.qex.innerHTML = str;

		var str2 = "";

		str2 += "<SELECT NAME=cacount>";   
		
		for(var j = l1; j <= ca; j++){
			str2 += "<OPTION VALUE=" + j + ">" + j + "</option>";
		}

		str2 += "</SELECT>";
		
		document.all.qca.innerHTML = str2;		
	}

	function aaa()
	{
		document.frmdata.action = "../editor/write_form.jsp";
		document.frmdata.method = "";
		document.frmdata.submit();

	}

	function bbb()
	{
		document.frmdata.action = "../editor/write_form_text.jsp";
		document.frmdata.method = "";
		document.frmdata.submit();

	}

  //-->
  </SCRIPT>
 </HEAD>

 <BODY onLoad = "ChkQtype(<%=qtype%>)" id="popup2">
	
	<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">�������� ����<span>�űԹ����� ������ �����մϴ�.</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>	

	<FORM name="frmdata" method="post">

	<div id="contents">		
	
		<INPUT TYPE="hidden" NAME="id_q_subject" value="<%=id_q_subject%>">
		<INPUT TYPE="hidden" NAME="id_q_chapter" value="<%=id_q_chapter%>">
		<INPUT TYPE="hidden" NAME="id_q_chapter2" value="<%=id_q_chapter2%>">
		<INPUT TYPE="hidden" NAME="id_q_chapter3" value="<%=id_q_chapter3%>">
		<INPUT TYPE="hidden" NAME="id_q_chapter4" value="<%=id_q_chapter4%>">

		<TABLE width="100%" border="0" cellpadding ="0" cellspacing="0" id="tableD">
			<tr>
				<td id="left">���� ����</td>
				<td style="padding: 15px 10px 15px 10px;" align="center">
					<TABLE border="0" cellpadding ="0" cellspacing="0" id="tableA" style="margin-bottom: 10px;">
						<tr align="center" id="tr">
							<td>OX��</TD>
							<td>������</TD>
							<td>���������</TD>
							<td>�ܴ���</TD>
							<td>�����</TD>
						</TR>
						<tr align="center" id="td">
							<TD><INPUT TYPE="radio" NAME="qtype" ONCLICK="ChkQtype('1');" VALUE="1" <%if(qtype.equals("1")) { %>checked<% } %>></TD>
							<TD><INPUT TYPE="radio" NAME="qtype" ONCLICK="ChkQtype('2');" VALUE="2" <%if(qtype.equals("2")) { %>checked<% } %>></TD>
							<TD><INPUT TYPE="radio" NAME="qtype" ONCLICK="ChkQtype('3');" VALUE="3" <%if(qtype.equals("3")) { %>checked<% } %>></TD>
							<TD><INPUT TYPE="radio" NAME="qtype" ONCLICK="ChkQtype('4');" VALUE="4" <%if(qtype.equals("4")) { %>checked<% } %>></TD>
							<TD><INPUT TYPE="radio" NAME="qtype" ONCLICK="ChkQtype('5');" VALUE="5" <%if(qtype.equals("5")) { %>checked<% } %>></TD>
						</TR>
					</TABLE>
					<textarea name="explains" rows="4" readonly style="width: 310px; padding: 10px;"></textarea>
				</td>
			</tr>
			<tr>
				<td id="left">���� ����</td>
				<td id="qex"></td>
			</tr>
			<tr>
				<td id="left">���� ����</td>
				<td id="qca"></td>
			</tr>
		</table>
				
		</FORM>

	</div>

	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>* <font color=red>��Ƽ�̵�� �������</font> : ��Ƽ�̵��(ǥ, �̹���, ������ ��)�� ���Ե� &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;���� ��Ͻ� ����
	<br>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;* <font color=red>�ؽ�Ʈ �������</font> : �ؽ�Ʈ�θ� ���� ��Ͻ� ����</b>

	<DIV id="button"><a href="javascript:aaa();" style="cursor: hand;">[��Ƽ�̵�� �������]</a>&nbsp;&nbsp;<a href="javascript:bbb();" style="cursor: hand;">[�ؽ�Ʈ �������]</a>&nbsp;&nbsp;<a href="javascript:window.close();" style="cursor: hand;">[â�ݱ�]</a></DIV>
 
 </BODY>
</HTML>
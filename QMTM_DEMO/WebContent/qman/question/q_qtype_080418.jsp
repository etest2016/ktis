<%
//******************************************************************************
//   ���α׷� : q_qtype.jsp
//   �� �� �� : ���� ���� ����
//   ��    �� : �ű� ���� ����(QTYPE) ����
//   �� �� �� : q
//   �ڹ����� : qmtm.*, qmtm.qman.question.*, qmtm.admin.*
//   �� �� �� : 2008-04-17
//   �� �� �� : ���׽�Ʈ ������
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************

%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.qman.question.*, qmtm.admin.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_q_subject = request.getParameter("id_q_subject");
	if (id_q_subject == null) { id_q_subject = ""; } else { id_q_subject = id_q_subject.trim(); }	

	if (id_q_subject.length() == 0) {
%>
	<script language="javascript">
		alert("�ش� ȭ�鿡 ���� ������ �����ϴ�.");
		history.back();
	</script>
<%	
	}
	
	String id_q_chapter = request.getParameter("id_q_chapter");
	if (id_q_chapter == null) { id_q_chapter = ""; } else { id_q_chapter = id_q_chapter.trim(); }

	String qtype = request.getParameter("qtype");
	if (qtype == null) { qtype = ""; } else { qtype = qtype.trim(); }	

	/* ������ ���� ����Ʈ */
	QmanTreeBean[] rst = null;

	try {
		rst = QmanTree.getBeans();
	} catch(Exception ex) {
		out.println(ex.getMessage());
	}

	/* ������ �ܿ� ����Ʈ */
	QmanTreeBean[] rst2 = null;

	try {
		rst2 = QmanTree.getBeans2(id_q_subject);
	} catch(Exception ex) {
		out.println(ex.getMessage());
	}
	

%>

<HTML>
 <HEAD>
  <TITLE>���� ���� ���� </TITLE>
  <link rel="StyleSheet" href="../../css/style.css" type="text/css">
  <SCRIPT LANGUAGE="JavaScript">
  <!--
	
	function FrmCheck(){

		document.frmdata.action = "q_qtype.jsp";
		document.frmdata.submit();
	}

	function ChkQtype(){

		var qtype, i;	

		for(i=0; i<document.frmdata.qtype.length; i++){
			if(document.frmdata.qtype[i].checked==true){
			   qtype = document.frmdata.qtype[i].value;//���� ����
			}
		}

		document.frmdata.action = "q_qtype.jsp";
		document.frmdata.submit();

	}

	function fntDisplay(qtype){
		
		var qtype;

		if(qtype=="1"||qtype==""){
			document.all.A1.style.display == "";
			document.all.B1.style.display == "";
			document.all.a2.style.display = "none";
			document.all.B2.style.display == "none";
			document.all.A3.style.display == "none";
			document.all.B3.style.display == "none";
			document.all.A4.style.display == "none";
			document.all.B4.style.display == "none";
			document.all.A5.style.display == "none";
			document.all.B5.style.display == "none";
		}else if(qtype=="2"){
			document.all.A1.style.display == "none";
			document.all.B1.style.display == "none";
			document.all.A2.style.display == "";
			document.all.B2.style.display == "";
			document.all.A3.style.display == "none";
			document.all.B3.style.display == "none";
			document.all.A4.style.display == "none";
			document.all.B4.style.display == "none";
			document.all.A5.style.display == "none";
			document.all.B5.style.display == "none";
		}
	}


  //-->
  </SCRIPT>
 </HEAD>

 <BODY onload="fntDisplay('<%=qtype%>');">
 <FORM name="frmdata">
    <TABLE width="100%" border="0">
	<tr>
	<td align="left">
	
	<input type="text" class="input" NAME="" value="<%=id_q_subject%>">
	<input type="text" class="input" NAME="" value="<%=id_q_chapter%>"><br>

	:: ���� ��ġ
	<TABLE width="100%" border="1" cellpadding="5">
	<TR>
		<TD>����</TD>
		<TD>
			<SELECT NAME="id_q_subject" onchange="FrmCheck();">
			<% if(rst == null) { %>
			<OPTION VALUE="" SELECTED>������ ������ �����ϴ�.
			<% 
				} else { 
					for(int i = 0; i < rst.length; i++) {
						
			%>
					<OPTION VALUE="<%=rst[i].getId_q_subject()%>" <%if(id_q_subject.equals(rst[i].getId_q_subject())){%>selected<%}%>><%=rst[i].getQ_subject()%>
			<%
					}
				}
			%>
		</SELECT>
		</TD>
	</TR>
	<TR>
		<TD>�ܿ�</TD>
		<TD>
			<SELECT NAME="id_q_chapter">
				<% if(rst2 == null) { %>
				<OPTION VALUE="" SELECTED>���� ���� ������ �ܿ��� �����ϴ�.
				<% } else { 
				%>
					<OPTION VALUE="">�ܿ� ���� ����
				<%
						for(int j = 0; j < rst2.length; j++) {
				%>
					<OPTION VALUE="" <%if(id_q_chapter.equals(rst2[j].getId_q_chapter())){%>selected<%}%>><%=rst2[j].getChapter()%>
				<% }}%>
			</SELECT>	
		</TD>
	</TR>
	</TABLE>
	<BR>

	:: ���� ����
	<TABLE width="100%" border="1" cellpadding="5">
	<TR ALIGN="CENTER">
		<TD>OX��</TD>
		<TD>������</TD>
		<TD>���������</TD>
		<TD>�ܴ���</TD>
		<TD>�����</TD>
	</TR>
	<TR ALIGN="CENTER">
		<TD><INPUT TYPE="radio" NAME="qtype" ONCLICK="ChkQtype();" VALUE="1" <%if(qtype.equals("1")||qtype==null||qtype==""){%>CHECKED<%}%>></TD>
		<TD><INPUT TYPE="radio" NAME="qtype" ONCLICK="ChkQtype();" VALUE="2" <%if(qtype.equals("2")){%>CHECKED<%}%>></TD>
		<TD><INPUT TYPE="radio" NAME="qtype" ONCLICK="ChkQtype();" VALUE="3" <%if(qtype.equals("3")){%>CHECKED<%}%>></TD>
		<TD><INPUT TYPE="radio" NAME="qtype" ONCLICK="ChkQtype();" VALUE="4" <%if(qtype.equals("4")){%>CHECKED<%}%>></TD>
		<TD><INPUT TYPE="radio" NAME="qtype" ONCLICK="ChkQtype();" VALUE="5" <%if(qtype.equals("5")){%>CHECKED<%}%>></TD>
	</TR>
	</TABLE>
	<BR>

	:: ���� ����
	<TABLE width="100%" border="1" cellpadding="5" ALIGN="CENTER">
	<TR>
		<TD>���ⰹ��</TD>
		<TD>
			<div id="A1">
			<SELECT NAME="">
				<OPTION VALUE="" SELECTED>2
			</SELECT>
			</div>
			<div id="A2" style="display:;">
			<SELECT NAME="">
				<OPTION VALUE="">1
				<OPTION VALUE="">2
				<OPTION VALUE="">3
				<OPTION VALUE="" SELECTED>4
				<OPTION VALUE="">5
				<OPTION VALUE="">6
				<OPTION VALUE="">7
				<OPTION VALUE="">8
			</SELECT>
			</div>
			<SELECT NAME="A3" style="display:;">
				<OPTION VALUE="">1
				<OPTION VALUE="">2
				<OPTION VALUE="">3
				<OPTION VALUE="" SELECTED>4
				<OPTION VALUE="">5
				<OPTION VALUE="">6
				<OPTION VALUE="">7
				<OPTION VALUE="">8
			</SELECT>
			<SELECT NAME="A4" style="display:;">
				<OPTION VALUE="" SELECTED>0
			</SELECT>
			<SELECT NAME="A5" style="display:;">
				<OPTION VALUE="" SELECTED>0
			</SELECT>
		</TD>
	</TR>
	<TR>
		<TD>���䰹��</TD>
		<TD>
			<SELECT NAME="B1" style="display:;">
				<OPTION VALUE="" SELECTED>1
			</SELECT>
			<SELECT NAME="B2" style="display:;">
				<OPTION VALUE="" SELECTED>1
			</SELECT>
			<SELECT NAME="B3" style="display:;">
				<OPTION VALUE="">1
				<OPTION VALUE="">2
				<OPTION VALUE="">3
				<OPTION VALUE="" SELECTED>4
				<OPTION VALUE="">5
				<OPTION VALUE="">6
				<OPTION VALUE="">7
				<OPTION VALUE="">8
			</SELECT>
			<SELECT NAME="B4" style="display:;">
				<OPTION VALUE="" SELECTED>1
				<OPTION VALUE="">2
				<OPTION VALUE="">3
				<OPTION VALUE="">4
				<OPTION VALUE="">5
				<OPTION VALUE="">6
				<OPTION VALUE="">7
				<OPTION VALUE="">8
				<OPTION VALUE="">9
				<OPTION VALUE="">10
			</SELECT>
			<SELECT NAME="B5" style="display:;">
				<OPTION VALUE="" SELECTED>0
			</SELECT>
		</TD>
	</TR>
	</TABLE>



	</td>
	</tr>
	</table>
	
 </FORM>
 </BODY>
</HTML>
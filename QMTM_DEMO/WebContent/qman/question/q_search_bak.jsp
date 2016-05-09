<%
//******************************************************************************
//   ���α׷� : q_search.jsp
//   �� �� �� : ���� �˻�
//   ��    �� : ������ �־� ������ �˻��Ѵ�.
//   �� �� �� : q
//   �ڹ����� : qmtm.*, qmtm.qman.question.*
//   �� �� �� : 2008-04-16
//   �� �� �� : ���׽�Ʈ ������
//   �� �� �� : 2008-07-02
//   �� �� �� : ���׽�Ʈ ����ȣ
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
  <TITLE>���� �˻�</TITLE>
  <link rel="StyleSheet" href="../../css/style.css" type="text/css">
  <SCRIPT LANGUAGE="JavaScript">
  <!--
	
	function FrmCheck(){

		document.frmdata.action = "q_search.jsp";
		document.frmdata.submit();
	}


  //-->
  </SCRIPT>
 </HEAD>

 <BODY>
 <FORM name="frmdata" method="post" action="../editor/q_write.jsp">
	
	<INPUT TYPE="hidden" NAME="" value="<%=id_q_subject%>">
	<INPUT TYPE="hidden" NAME="" value="<%=id_q_chapter%>">

    <TABLE width="100%" border="0">
	<tr>
	<td align="left">
	
	

	<div style="padding: 2px 0px 5px 22px; background-image: url(../../../images/title_list_yj_1.gif); background-repeat: no-repeat; font: bold 14px dotum; color: #000;"> ���� �˻�</div>

	<TABLE width="100%" border="0" cellpadding ="5" cellspacing="1" bgcolor="#CCCCCC" style="width: 100%; margin-bottom: 20px; margin-top: 10px; border-top: 1px; solid #ffffff; font-size: 9pt;">
	<TR>
		<TD width="10%" align="right" style="background-color: #FCFCFC; text-align: center; border-top: 1px solid #ddfca6; border-bottom: 1px solid #ddfca6; border-right: 1px solid #ddfca6; border-left: 1px solid #ddfca6;"><INPUT TYPE="checkbox" NAME="OP1"></TD>
		<TD width="20%" align="right" style="background-color: #FCFCFC; text-align: center; border-top: 1px solid #ddfca6; border-bottom: 1px solid #ddfca6;">����</TD>
		<TD bgcolor="#FFFFFF" style="border-bottom: 1px solid #ddfca6; border-top: 1px solid #ddfca6; border-right: 1px solid #ddfca6; border-left: 1px solid #ddfca6;">
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
		<TD width="10%" align="right" style="background-color: #FCFCFC; text-align: center; border-top: 0px solid #ddfca6; border-bottom: 1px solid #ddfca6; border-right: 1px solid #ddfca6; border-left: 1px solid #ddfca6;"><INPUT TYPE="checkbox" NAME=""></TD>
		<TD width="20%" align="right" style="background-color: #FCFCFC; text-align: center; border-top: 0px solid #ddfca6; border-bottom: 1px solid #ddfca6; border-left: 0px solid #ddfca6;">�ܿ�</TD>
		<TD bgcolor="#FFFFFF" style="border-bottom: 1px solid #ddfca6; border-top: 0px solid #ddfca6; border-right: 1px solid #ddfca6; border-left: 1px solid #ddfca6;">
			<SELECT NAME="id_q_chapter" onchange="FrmCheck();">
				<% if(rst2 == null) { %>
				<OPTION VALUE="" SELECTED>���� ���� ������ �ܿ��� �����ϴ�.
				<% } else { 
				%>
					<OPTION VALUE="" <%if(id_q_chapter.equals("")){%>selected<%}%>>�ܿ� ���� ����
				<%
						for(int j = 0; j < rst2.length; j++) {
				%>
					<OPTION VALUE="<%=rst2[j].getId_q_chapter()%>" <%if(id_q_chapter.equals(rst2[j].getId_q_chapter())){%>selected<%}%>><%=rst2[j].getChapter()%>
				<% }}%>
			</SELECT>
		</TD>
	</TR>
	<TR>
		<TD width="10%" align="right" style="background-color: #FCFCFC; text-align: center; border-top: 0px solid #ddfca6; border-bottom: 1px solid #ddfca6; border-right: 1px solid #ddfca6; border-left: 1px solid #ddfca6;"><INPUT TYPE="checkbox" NAME=""></TD>
		<TD width="20%" align="right" style="background-color: #FCFCFC; text-align: center; border-top: 0px solid #ddfca6; border-bottom: 1px solid #ddfca6; border-left: 0px solid #ddfca6;">�����ڵ�</TD>
		<TD bgcolor="#FFFFFF" style="border-bottom: 1px solid #ddfca6; border-top: 0px solid #ddfca6; border-right: 1px solid #ddfca6; border-left: 1px solid #ddfca6;"><input type="text" class="input" NAME=""></TD>
	</TR>
	<TR>
		<TD width="10%" align="right" style="background-color: #FCFCFC; text-align: center; border-top: 0px solid #ddfca6; border-bottom: 1px solid #ddfca6; border-right: 1px solid #ddfca6; border-left: 1px solid #ddfca6;"><INPUT TYPE="checkbox" NAME=""></TD>
		<TD width="20%" align="right" style="background-color: #FCFCFC; text-align: center; border-top: 0px solid #ddfca6; border-bottom: 1px solid #ddfca6; border-left: 0px solid #ddfca6;">���� ����</TD>
		<TD bgcolor="#FFFFFF" style="border-bottom: 1px solid #ddfca6; border-top: 0px solid #ddfca6; border-right: 1px solid #ddfca6; border-left: 1px solid #ddfca6;">
			<INPUT TYPE="radio" NAME="qtype" ONCLICK="ChkQtype();" VALUE="1" <%if(qtype.equals("1")||qtype==null||qtype==""){%>CHECKED<%}%>>OX��
			<INPUT TYPE="radio" NAME="qtype" ONCLICK="ChkQtype();" VALUE="2" <%if(qtype.equals("2")){%>CHECKED<%}%>>������
			<INPUT TYPE="radio" NAME="qtype" ONCLICK="ChkQtype();" VALUE="3" <%if(qtype.equals("3")){%>CHECKED<%}%>>���������
			<INPUT TYPE="radio" NAME="qtype" ONCLICK="ChkQtype();" VALUE="4" <%if(qtype.equals("4")){%>CHECKED<%}%>>�ܴ���
			<INPUT TYPE="radio" NAME="qtype" ONCLICK="ChkQtype();" VALUE="5" <%if(qtype.equals("5")){%>CHECKED<%}%>>�����
		</TD>
	</TR>
	<TR>
		<TD width="10%" align="right" style="background-color: #FCFCFC; text-align: center; border-top: 0px solid #ddfca6; border-bottom: 1px solid #ddfca6; border-right: 1px solid #ddfca6; border-left: 1px solid #ddfca6;"><INPUT TYPE="checkbox" NAME=""></TD>
		<TD width="20%" align="right" style="background-color: #FCFCFC; text-align: center; border-top: 0px solid #ddfca6; border-bottom: 1px solid #ddfca6; border-left: 0px solid #ddfca6;">���̵�</TD>
		<TD bgcolor="#FFFFFF" style="border-bottom: 1px solid #ddfca6; border-top: 0px solid #ddfca6; border-right: 1px solid #ddfca6; border-left: 1px solid #ddfca6;">&nbsp;</TD>
	</TR>
	<TR>
		<TD  width="10%" align="right" style="background-color: #FCFCFC; text-align: center; border-top: 0px solid #ddfca6; border-bottom: 1px solid #ddfca6; border-right: 1px solid #ddfca6; border-left: 1px solid #ddfca6;"><INPUT TYPE="checkbox" NAME=""></TD>
		<TD  width="20%" align="right" style="background-color: #FCFCFC; text-align: center; border-top: 0px solid #ddfca6; border-bottom: 1px solid #ddfca6; border-left: 0px solid #ddfca6;">����Ƚ��</TD>
		<TD bgcolor="#FFFFFF" style="border-bottom: 1px solid #ddfca6; border-top: 0px solid #ddfca6; border-right: 1px solid #ddfca6; border-left: 1px solid #ddfca6;">&nbsp;</TD>
	</TR>
	<TR>
		<TD  width="10%" align="right" style="background-color: #FCFCFC; text-align: center; border-top: 0px solid #ddfca6; border-bottom: 1px solid #ddfca6; border-right: 1px solid #ddfca6; border-left: 1px solid #ddfca6;"><INPUT TYPE="checkbox" NAME=""></TD>
		<TD  width="20%" align="right" style="background-color: #FCFCFC; text-align: center; border-top: 0px solid #ddfca6; border-bottom: 1px solid #ddfca6; border-left: 0px solid #ddfca6;">������</TD>
		<TD bgcolor="#FFFFFF" style="border-bottom: 1px solid #ddfca6; border-top: 0px solid #ddfca6; border-right: 1px solid #ddfca6; border-left: 1px solid #ddfca6;">&nbsp;</TD>
	</TR>
	<TR>
		<TD  width="10%" align="right" style="background-color: #FCFCFC; text-align: center; border-top: 0px solid #ddfca6; border-bottom: 1px solid #ddfca6; border-right: 1px solid #ddfca6; border-left: 1px solid #ddfca6;"><INPUT TYPE="checkbox" NAME=""></TD>
		<TD  width="20%" align="right" style="background-color: #FCFCFC; text-align: center; border-top: 0px solid #ddfca6; border-bottom: 1px solid #ddfca6; border-left: 0px solid #ddfca6;">����,����,�ؼ�</TD>
		<TD bgcolor="#FFFFFF" style="border-bottom: 1px solid #ddfca6; border-top: 0px solid #ddfca6; border-right: 1px solid #ddfca6; border-left: 1px solid #ddfca6;">&nbsp;</TD>
	</TR>
	<TR>
		<TD  width="10%" align="right" style="background-color: #FCFCFC; text-align: center; border-top: 0px solid #ddfca6; border-bottom: 1px solid #ddfca6; border-right: 1px solid #ddfca6; border-left: 1px solid #ddfca6;"><INPUT TYPE="checkbox" NAME=""></TD>
		<TD  width="20%" align="right" style="background-color: #FCFCFC; text-align: center; border-top: 0px solid #ddfca6; border-bottom: 1px solid #ddfca6; border-left: 0px solid #ddfca6;">������</TD>
		<TD bgcolor="#FFFFFF" style="border-bottom: 1px solid #ddfca6; border-top: 0px solid #ddfca6; border-right: 1px solid #ddfca6; border-left: 1px solid #ddfca6;">&nbsp;</TD>
	</TR>
	<TR>
		<TD  width="10%" align="right" style="background-color: #FCFCFC; text-align: center; border-top: 0px solid #ddfca6; border-bottom: 1px solid #ddfca6; border-right: 1px solid #ddfca6; border-left: 1px solid #ddfca6;"><INPUT TYPE="checkbox" NAME=""></TD>
		<TD  width="20%" align="right" style="background-color: #FCFCFC; text-align: center; border-top: 0px solid #ddfca6; border-bottom: 1px solid #ddfca6; border-left: 0px solid #ddfca6;">������������</TD>
		<TD bgcolor="#FFFFFF" style="border-bottom: 1px solid #ddfca6; border-top: 0px solid #ddfca6; border-right: 1px solid #ddfca6; border-left: 1px solid #ddfca6;">&nbsp;</TD>
	</TR>
	</TABLE>
	<BR>

	<DIV align="center"><INPUT TYPE="image" value="�˻�" name="submit" src="../../../images/bt_qsearch_yj1.gif">&nbsp;&nbsp;&nbsp;<a href="javascript:window.close();"><img border="0" src="../../../images/bt_qtype_yj2.gif"></DIV>



	</td>
	</tr>
	</table>
	
 </FORM>
 </BODY>
</HTML>
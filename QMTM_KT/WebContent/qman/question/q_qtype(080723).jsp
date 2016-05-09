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

	String aaex = request.getParameter("aaex");
	if (aaex == null) { aaex = "2"; } else { aaex = aaex.trim(); }

	String ca = request.getParameter("ca");
	if (ca == null) { ca = "1"; } else { ca = ca.trim(); }

	String ex_type = request.getParameter("ex_type");
	if (ex_type == null) { ex_type = "disabled"; } else { ex_type = ex_type.trim(); }

	String ca_type = request.getParameter("ca_type");
	if (ca_type == null) { ca_type = "disabled"; } else { ca_type = ca_type.trim(); }

	String ex_default = request.getParameter("ex_default");
	if (ex_default == null) { ex_default = "1"; } else { ex_default = ex_default.trim(); }

	String ca_default = request.getParameter("ca_default");
	if (ca_default == null) { ca_default = "1"; } else { ca_default = ca_default.trim(); }

	String k1 = request.getParameter("k1");
	if (k1 == null) { k1 = "2"; } else { k1 = k1.trim(); }

	String l1 = request.getParameter("l1");
	if (l1 == null) { l1 = "1"; } else { l1 = l1.trim(); }


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

		var qtype, i, ex_type, ca_type;	

		for(i=0; i<document.frmdata.qtype.length; i++){
			if(document.frmdata.qtype[i].checked==true){
			   qtype = document.frmdata.qtype[i].value;//���� ����
			}
		}
		
		if(qtype==1){
			ex = 2;
			ca = 1;
			ex_type = "disabled";
			ca_type = "disabled";
			ex_default = 2
			ca_default = 1
			k1 = 1
			l1 = 1
		}else if(qtype==2){
			ex = 8;
			ca = 1;		
			ex_type = "";
			ca_type = "disabled";
			ex_default = 3
			ca_default = 1
			k1 = 3
			l1 = 1
		}else if(qtype==3){
			ex = 8;
			ca = 8;
			ex_type = "";
			ca_type = "";
			ex_default = 3
			ca_default = 2
			k1 = 3
			l1 = 2
		}else if(qtype==4){
			ex = 1;
			ca = 5;
			ex_type = "disabled";
			ca_type = "";
			ex_default = 0
			ca_default = 1
			k1 = 0
			l1 = 1
		}else if(qtype==5){
			ex = 1;
			ca = 1;
			ex_type = "disabled";
			ca_type = "disabled";
			ex_default = 0
			ca_default = 0
			k1 = 0
			l1 = 0
		}
		
		document.frmdata.aaex.value = ex;
		document.frmdata.ca.value = ca;
		document.frmdata.ex_type.value = ex_type;
		document.frmdata.ca_type.value = ca_type;
		document.frmdata.ex_default.value = ex_default;
		document.frmdata.ca_default.value = ca_default;
		document.frmdata.k1.value = k1;
		document.frmdata.l1.value = l1;

		document.frmdata.action = "q_qtype.jsp";
		document.frmdata.submit();

	}


  //-->
  </SCRIPT>
 </HEAD>

 <BODY>
 <FORM name="frmdata" method="post" action="../editor/q_write.jsp">
	
	<INPUT TYPE="hidden" NAME="aaex" value="<%=aaex%>">
	<INPUT TYPE="hidden" NAME="ca" value="<%=ca%>">
	<INPUT TYPE="hidden" NAME="ex_type" value="<%=ex_type%>">
	<INPUT TYPE="hidden" NAME="ca_type" value="<%=ca_type%>">
	<INPUT TYPE="hidden" NAME="ex_default" value="<%=ex_default%>">
	<INPUT TYPE="hidden" NAME="ca_default" value="<%=ca_default%>">
	<INPUT TYPE="hidden" NAME="k1" value="<%=k1%>">
	<INPUT TYPE="hidden" NAME="l1" value="<%=l1%>">

	<INPUT TYPE="hidden" NAME="" value="<%=id_q_subject%>">
	<INPUT TYPE="hidden" NAME="" value="<%=id_q_chapter%>">

    <TABLE width="100%" border="0">
	<tr>
	<td align="left">
	
	

	<div style="padding: 2px 0px 5px 22px; background-image: url(../../../images/title_list_yj_1.gif); background-repeat: no-repeat; font: bold 14px dotum; color: #000;">���� ��ġ</div>

	<TABLE width="100%" border="0" cellpadding ="3" cellspacing="1" bgcolor="#CCCCCC" style="width: 100%; margin-bottom: 20px; margin-top: 10px; border-top: 2px; solid #ffffff; font-size: 9pt;">
	<TR>
		<td width="30%" align="right" style="background-color: #FCFCFC; text-align: center; border-top: 1px solid #ddfca6; border-bottom: 1px solid #ddfca6; border-right: 1px solid #ddfca6; border-left: 1px solid #ddfca6;">����</TD>
		<td bgcolor="#FFFFFF" style="border-bottom: 1px solid #ddfca6; border-top: 1px solid #ddfca6; border-right: 1px solid #ddfca6;">
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
		<td width="30%" align="right" style="background-color: #FCFCFC; text-align: center; border-bottom: 1px solid #ddfca6; border-right: 1px solid #ddfca6;  border-left: 1px solid #ddfca6;">�ܿ�</TD>
		<td bgcolor="#FFFFFF" style="border-bottom: 1px solid #ddfca6;  border-right: 1px solid #ddfca6;">
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
	</TABLE>
	<BR>

	<div style="padding: 2px 0px 5px 22px; background-image: url(../../../images/title_list_yj_1.gif); background-repeat: no-repeat; font: bold 14px dotum; color: #000;">���� ����</div>

	<TABLE width="100%" border="0" cellpadding ="3" cellspacing="1" bgcolor="#CCCCCC" style="width: 100%; margin-bottom: 20px; margin-top: 10px; border-top: 2px; solid #ffffff; font-size: 9pt;">

		<tr height="30" style="height: 30px; text-align: center; background-image: url(../../../images/tableyj_top2.gif); background-repeat: repeat-x; font-size: 10pt;">
			<td width="20%" style="border-left: 1px solid #ddfca6;  border-right: 1px solid #ddfca6;">OX��</TD>
			<td width="20%" style="border-right: 1px solid #ddfca6;">������</TD>
			<td width="20%" style="border-right: 1px solid #ddfca6;">���������</TD>
			<td width="20%" style="border-right: 1px solid #ddfca6;">�ܴ���</TD>
			<td width="20%" style="border-right: 1px solid #ddfca6;">�����</TD>
		</TR>
	<tr width="30%" align="center" style="background-color: #FCFCFC; text-align: center;">
		<TD style="border-left: 1px solid #ddfca6;  border-right: 1px solid #ddfca6; border-bottom: 1px solid #ddfca6;"><INPUT TYPE="radio" NAME="qtype" ONCLICK="ChkQtype();" VALUE="1" <%if(qtype.equals("1")||qtype==null||qtype==""){%>CHECKED<%}%>></TD>
		<TD style="border-right: 1px solid #ddfca6; border-bottom: 1px solid #ddfca6;"><INPUT TYPE="radio" NAME="qtype" ONCLICK="ChkQtype();" VALUE="2" <%if(qtype.equals("2")){%>CHECKED<%}%>></TD>
		<TD style="border-right: 1px solid #ddfca6; border-bottom: 1px solid #ddfca6;"><INPUT TYPE="radio" NAME="qtype" ONCLICK="ChkQtype();" VALUE="3" <%if(qtype.equals("3")){%>CHECKED<%}%>></TD>
		<TD style="border-right: 1px solid #ddfca6; border-bottom: 1px solid #ddfca6;"><INPUT TYPE="radio" NAME="qtype" ONCLICK="ChkQtype();" VALUE="4" <%if(qtype.equals("4")){%>CHECKED<%}%>></TD>
		<TD style="border-right: 1px solid #ddfca6; border-bottom: 1px solid #ddfca6;"><INPUT TYPE="radio" NAME="qtype" ONCLICK="ChkQtype();" VALUE="5" <%if(qtype.equals("5")){%>CHECKED<%}%>></TD>
	</TR>
	</TABLE>
	<BR>

	<div style="padding: 2px 0px 5px 22px; background-image: url(../../../images/title_list_yj_1.gif); background-repeat: no-repeat; font: bold 14px dotum; color: #000;">�� ����</div>

	<TABLE width="100%" border="0" cellpadding ="3" cellspacing="1" bgcolor="#CCCCCC" style="width: 100%; margin-bottom: 20px; margin-top: 10px; border-top: 2px; solid #ffffff; font-size: 9pt;">
	<TR>
		<td width="30%" align="right" style="background-color: #FCFCFC; text-align: center; border-top: 1px solid #ddfca6; border-bottom: 1px solid #ddfca6; border-left: 1px solid #ddfca6; border-right: 1px solid #ddfca6;">���ⰹ��</TD>
		<td bgcolor="#FFFFFF" style="border-top: 1px solid #ddfca6; border-right: 1px solid #ddfca6; border-bottom: 1px solid #ddfca6;">
			<SELECT NAME="QEX" <%=ex_type%>>
			<%
				for(int k = Integer.parseInt(k1); k <= Integer.parseInt(aaex); k++){
			%>
				<OPTION VALUE="<%=k%>" <%if(k==Integer.parseInt(ex_default)){%>selected<%}%>><%=k%>
			<%
				}	
			%>
			</SELECT>
		</TD>
	</TR>
	<TR>
		<td width="30%" align="right" style="background-color: #FCFCFC; text-align: center; border-bottom: 1px solid #ddfca6; border-right: 1px solid #ddfca6; border-left: 1px solid #ddfca6;">���䰹��</TD>
		<td bgcolor="#FFFFFF" style="border-bottom: 1px solid #ddfca6; border-right: 1px solid #ddfca6;">
			<SELECT NAME="QCA" <%=ca_type%>>
			<%
				for(int l = Integer.parseInt(l1); l <= Integer.parseInt(ca); l++){
			%>
				<OPTION VALUE="<%=l%>" <%if(l==Integer.parseInt(ca_default)){%>selected<%}%>><%=l%>
			<%
				}	
			%>
			</SELECT>
		</TD>
	</TR>
	</TABLE>
	<BR>

	<DIV align="center"><INPUT TYPE="image" value="Ȯ��" name="submit" src="../../../images/bt_qtype_yj1.gif">&nbsp;&nbsp;&nbsp;<a href="javascript:window.close();"><img border="0" src="../../../images/bt_qtype_yj2.gif"></DIV>



	</td>
	</tr>
	</table>
	
 </FORM>
 </BODY>
</HTML>
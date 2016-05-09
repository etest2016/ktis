<%
//******************************************************************************
//   ���α׷� : chapter_list.jsp
//   �� �� �� : ù��° �ܿ�����
//   ��    �� : �������� Ʈ������ ù��° �ܿ� ���ý� �����ִ� ������
//   �� �� �� : q_chapter, q_chapter2
//   �ڹ����� : qmtm.ComLib, qmtm.CommonUtil, qmtm.admin.qman.ChapterQmanBean, 
//             qmtm.admin.qman.ChapterQmanUtil, qmtm.admin.Chapter2QmanBean, qmtm.admin.Chapter2QmanUtil
//   �� �� �� : 2010-06-07
//   �� �� �� : ���׽�Ʈ ����ȣ    
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>  

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.CommonUtil, qmtm.admin.qman.ChapterQmanBean, qmtm.admin.qman.ChapterQmanUtil, qmtm.admin.qman.Chapter2QmanBean, qmtm.admin.qman.Chapter2QmanUtil" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String userid = (String)session.getAttribute("userid");
	if (userid == null) { userid= ""; } else { userid = userid.trim(); }

	String id_q_chapter = request.getParameter("id_q_chapter");
	if (id_q_chapter == null) { id_q_chapter= ""; } else { id_q_chapter = id_q_chapter.trim(); }

	if (userid.length() == 0 || id_q_chapter.length() == 0) {
	    out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

    // �ܿ�1 ���� ���������
	ChapterQmanBean rst = null;

    try {
	    rst = ChapterQmanUtil.getBean(id_q_chapter);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
    }
	
	// �ܿ���� ���������
	Chapter2QmanBean[] rst2 = null; 

	try {
		rst2 = Chapter2QmanUtil.getBeans(id_q_chapter);
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
	}
%>

<HTML>
 <HEAD>
  <TITLE> Admin Main </TITLE>
  <link rel="StyleSheet" href="../../../css/style.css" type="text/css">
 
 <script language="JavaScript">
	function sub_edit() {
		window.open("chapter_edit.jsp?id_q_subject=<%=rst.getId_q_subject()%>&id_q_chapter=<%=id_q_chapter%>","edit","width=400, height=260, scrollbars=no");
	}
	
	//--  �ܿ� ����üũ
    function sub_delete()  {
       var st = confirm("*����* �ܿ������� �����Ͻðڽ��ϱ�? \n\n���� �� �����ܿ��� ���� �����ϼž� �մϴ�." );
       if (st == true) {
           window.open("chapter_delete.jsp?id_q_subject=<%=rst.getId_q_subject()%>&id_q_chapter=<%=id_q_chapter%>&bigos=Y","edit","width=400, height=260, scrollbars=no");
       }
    }
	
	function cpt_insert() {
		window.open("../chapter2/chapter_insert.jsp?id_q_subject=<%=rst.getId_q_subject()%>&id_q_chapter=<%=id_q_chapter%>","insert","width=400, height=260, scrollbars=no");
    }

	function cpt_view(id_q_chapter) {
		
		window.open("../chapter2/chapter_view.jsp?id_q_chapter="+id_q_chapter,"view","width=400, height=260, scrollbars=no");
    }
 </script>

 </HEAD>

 <BODY id="admin">	

	<div id="main">

		<div id="mainTop">
			<div class="title">���� �ܿ�1 ���� <span>������ �ܿ�1�� ������ �� �� ���� �ܿ��� ��ȸ �� ����, ���� �� �� �ֽ��ϴ�</span></div>
			<div class="location">������ > ����������� > <span>[<%=rst.getChapter()%>]</span></div>
		</div>
		
		<TABLE cellpadding="0" cellspacing="0" border="0" id="tableC" width="100%">
			<TR id="top">
				<TD id="left"></TD>
				<TD id="center"></TD>
				<TD id="right"></TD>
			</TR>
			<TR id="middle">
				<TD id="left"></TD>
				<TD id="center">
	
					<table border="0" cellpadding ="0" cellspacing="0" id="tableA">
						<tr id="tr2">
							<td>�ܿ�1�ڵ�</td>
							<td>�ܿ�1��</td>
							<td>�������</td>
							<td>�����ϱ�</td>
							<td>�����ϱ�</td>
						</tr>
						<tr id="td" align="center">
							<td><%=id_q_chapter%></td>
							<td><%=rst.getChapter()%></td>
							<td><%=rst.getRegdate()%></td>
							<td><a href="javascript:sub_edit();" onfocus="this.blur();"><img src="../../../images/bt5_edit.gif"></a></td>
							<td><a href="javascript:sub_delete();" onfocus="this.blur();"><img src="../../../images/bt5_delete.gif"></a></td>
						</tr>
					</table>
				
				</TD>
			<TD id="right"></TD>
		</TR>
		<TR id="bottom">
			<TD id="left"></TD>
			<TD id="center"></TD>
			<TD id="right"></TD>
		</TR>
		</TABLE>

		<div class="title">�ܿ�2����Ʈ</span></div>

		<table border="0" cellpadding ="0" cellspacing="0" id="tableA">
			<tr id="bt"><td colspan="4"><a href="javascript:cpt_insert();" onfocus="this.blur();"><img src="../../../images/bt_a_q_newc2.gif"></a></td></tr>
			<tr id="tr">
				<td width="7%">NO</td>
				<td>�ܿ�2�ڵ�</td>
				<td style="text-align: left;">�ܿ�2��</td>
				<td>�������</td>
			</tr>
			<% if(rst2 == null) { %>
			<tr>
				<td colspan="4" class="blank">��ϵǾ��� �ܿ�2�� �����ϴ�.</td>
			</tr>
			<%
			   } else {
				   for(int i = 0; i < rst2.length; i++) {
			%>
			<tr id="td" align="center">
				<td><%=i+1%></td>
				<!--td><a href="javascript:cpt_view('<%=rst2[i].getId_q_chapter2()%>');" onfocus="this.blur();"><%=rst2[i].getId_q_chapter2()%></a></td-->
				<td><%=rst2[i].getId_q_chapter2()%></td>
				<td style="text-align: left;"><div style="float: left;"><a href="../chapter2/chapter_list.jsp?id_q_chapter=<%=rst2[i].getId_q_chapter2()%>" onfocus="this.blur();"><%=rst2[i].getChapter()%></a></div> <div style="float: left; padding-top: 1px; padding-left: 6px;"><a href="../chapter2/chapter_list.jsp?id_q_chapter=<%=rst2[i].getId_q_chapter2()%>" onfocus="this.blur();"><img src="../../../images/info2.gif"></a></div></td>
				<td><%=rst2[i].getRegdate()%></td>
			</tr>
			<%
				   }
				}
			%>
		</table>


	</div>
	<jsp:include page="../../../copyright.jsp"/>



	
 </BODY>
</HTML>
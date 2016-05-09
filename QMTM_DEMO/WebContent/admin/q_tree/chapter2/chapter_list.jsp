<%
//******************************************************************************
//   ���α׷� : chapter_list.jsp
//   �� �� �� : �ι�° �ܿ�����
//   ��    �� : �������� Ʈ������ �ι�° �ܿ� ���ý� �����ִ� ������
//   �� �� �� : q_chapter, q_chapter
//   �ڹ����� : qmtm.admin.ChapterQmanBean, qmtm.admin.ChapterQmanUtil
//              qmtm.admin.Chapter2QmanBean, qmtm.admin.Chapter2QmanUtil 
//   �� �� �� : 2008-04-03
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� :  
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>
   
<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.admin.*, qmtm.admin.qman.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_q_chapter = request.getParameter("id_q_chapter");
	if (id_q_chapter == null) { id_q_chapter= ""; } else { id_q_chapter = id_q_chapter.trim(); }

	if (id_q_chapter.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	   if(true) return;
	}

    // �ܿ�2 ���� ���������
	Chapter2QmanBean rst = null;

    try {
	    rst = Chapter2QmanUtil.getBean(id_q_chapter);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
    }
	
	// �ܿ���� ���������
	Chapter3QmanBean[] rst2 = null; 

	try {
		rst2 = Chapter3QmanUtil.getBeans(id_q_chapter);
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
		window.open("chapter_edit.jsp?id_subject=<%=rst.getId_q_subject()%>&id_q_subject=<%=rst.getId_q_chapter()%>&id_q_chapter=<%=id_q_chapter%>","edit","width=400, height=250, scrollbars=no");
	}
	
	//--  �ܿ� ����üũ
    function sub_delete()  {
       var st = confirm("*����* �ܿ������� �����Ͻðڽ��ϱ�? \n\n���� �� �����ܿ��� ���� �����ϼž� �մϴ�." );
       if (st == true) {
           window.open("chapter_delete.jsp?id_subject=<%=rst.getId_q_subject()%>&id_q_subject=<%=rst.getId_q_chapter()%>&id_q_chapter=<%=id_q_chapter%>&bigos=Y","edit","width=400, height=250, scrollbars=no");
       }
    }
	
	function cpt_insert() {
		window.open("../chapter3/chapter_insert.jsp?id_q_chapter=<%=id_q_chapter%>","insert","width=400, height=250, scrollbars=no");
    }

	function cpt_view(id_q_chapter) {
		
		window.open("../chapter3/chapter_view.jsp?id_q_chapter="+id_q_chapter,"view","width=400, height=250, scrollbars=no");
    }
 </script>

 </HEAD>

 <BODY id="admin">	
    <div id="main">

		<div id="mainTop">
			<div class="title">���� �ܿ�2 ���� <span>������ �ܿ�2�� ������ �� �� ���� �ܿ��� ��ȸ �� ����, ���� �� �� �ֽ��ϴ�</span></div>
			<div class="location">������ > ����������� > <span>[<%=rst.getChapter()%>] </span></div>
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
							<td bgcolor="#DBDBDB" align="center">�ܿ�2�ڵ�</td>
							<td bgcolor="#DBDBDB">�ܿ�2��</td>
							<td bgcolor="#DBDBDB">�������</td>
							<td bgcolor="#DBDBDB">�����ϱ�</td>
							<td bgcolor="#DBDBDB">�����ϱ�</td>
						</tr>
						<tr id="td" align="center">
							<td align="center"><%=id_q_chapter%></td>
							<td align="center"><%=rst.getChapter()%></td>
							<td align="center"><%=rst.getRegdate()%></td>
							<td align="center"><a href="javascript:sub_edit();" onfocus="this.blur();"><img src="../../../images/bt5_edit.gif"></a></td>
							<td align="center"><a href="javascript:sub_delete();" onfocus="this.blur();"><img src="../../../images/bt5_delete.gif"></a></td>
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
	
		<div class="title">�ܿ�3 ����Ʈ</span></div>
			
		<table border="0" cellpadding ="0" cellspacing="0" id="tableA">	
			<tr id="bt"><td colspan="4"><a href="javascript:cpt_insert();"><img src="../../../images/bt_a_q_newc3.gif"></a></TD>
			</TR>

			<tr id="tr">
				<td width="7%" align="center" bgcolor="#DBDBDB">NO</td>
				<td bgcolor="#DBDBDB" align="center">�ܿ�3�ڵ�</td>
				<td bgcolor="#DBDBDB" style="text-align: left;">�ܿ�3��</td>
				<td bgcolor="#DBDBDB">�������</td>
			</tr>
			<% if(rst2 == null) { %>
			<tr>
				<td colspan="4" class="blank">��ϵǾ��� �ܿ�3�� �����ϴ�.</td>
			</tr>
			<%
			   } else {
				   for(int i = 0; i < rst2.length; i++) {
			%>
			<tr id="td" align="center">
				<td><%=i+1%></td>
				<!--td><a href="javascript:cpt_view('<%=rst2[i].getId_q_chapter3()%>');"><%=rst2[i].getId_q_chapter3()%></a></td-->
				<td><%=rst2[i].getId_q_chapter3()%></td>
				<td style="text-align: left;"><div style="float: left;"><a href="../chapter3/chapter_list.jsp?id_q_chapter=<%=rst2[i].getId_q_chapter3()%>" onfocus="this.blur();"><%=rst2[i].getChapter()%></a> </div> <div style="float: left; padding-top: 1px; padding-left: 6px;"><a href="../chapter3/chapter_list.jsp?id_q_chapter=<%=rst2[i].getId_q_chapter3()%>" onfocus="this.blur();"><img src="../../../images/info2.gif"></a></div></td>
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
<%
//******************************************************************************
//   ���α׷� : chapter_list.jsp
//   �� �� �� : ����° �ܿ�����
//   ��    �� : �������� Ʈ������ ����° �ܿ� ���ý� �����ִ� ������
//   �� �� �� : q_chapter3, q_chapter4  
//   �ڹ����� : qmtm.admin.Chapter3QmanBean, qmtm.admin.Chapter3QmanUtil
//              qmtm.admin.Chapter4QmanBean, qmtm.admin.Chapter4QmanUtil
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

    // �ܿ�3 ���� ���������
	Chapter3QmanBean rst = null;

    try {
	    rst = Chapter3QmanUtil.getBean(id_q_chapter);
    } catch(Exception ex) {
	    out.println(ComLib.getExceptionMsg(ex, "back"));

	    if(true) return;
    }
	
	// �ܿ���� ���������
	Chapter4QmanBean[] rst2 = null; 

	try {
		rst2 = Chapter4QmanUtil.getBeans(id_q_chapter);
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
		window.open("chapter_edit.jsp?id_subject=<%=rst.getId_q_subject()%>&id_chapter1=<%=rst.getId_q_chapter()%>&id_chapter2=<%=rst.getId_q_chapter2()%>&id_q_chapter=<%=id_q_chapter%>","edit","width=400, height=250, scrollbars=no");
	}
	
	//--  �ܿ� ����üũ
    function sub_delete()  {
       var st = confirm("*����* �ܿ������� �����Ͻðڽ��ϱ�? \n\n���� �� �����ܿ��� ���� �����ϼž� �մϴ�." );
       if (st == true) {
           window.open("chapter_delete.jsp?id_subject=<%=rst.getId_q_subject()%>&id_chapter1=<%=rst.getId_q_chapter()%>&id_chapter2=<%=rst.getId_q_chapter2()%>&id_q_chapter=<%=id_q_chapter%>&bigos=Y","edit","width=400, height=250, scrollbars=no");
       }
    }
	
	function cpt_insert() {
		window.open("../chapter4/chapter_insert.jsp?id_q_chapter=<%=id_q_chapter%>","insert","width=400, height=250, scrollbars=no");
    }

	function cpt_view(id_q_chapter) {
		
		window.open("../chapter4/chapter_view.jsp?id_q_chapter="+id_q_chapter,"view","width=400, height=250, scrollbars=no");
    }
 </script>

 </HEAD>

 <BODY id="admin">	
   <div id="main">

		<div id="mainTop">
			<div class="title">���� �ܿ�3 ���� <span>������ �ܿ�3�� ������ �� �� ���� �ܿ��� ��ȸ �� ����, ���� �� �� �ֽ��ϴ�</span></div>
		<div class="location"> ������ > ����������� > <span><%=rst.getChapter()%> </span></div>
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
			<td>�ܿ�3�ڵ�</td>
			<td>�ܿ�3��</td>
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

	
	<div class="title">�ܿ�4 ����Ʈ</span></div>
			<table border="0" cellpadding ="0" cellspacing="0" id="tableA">
			<tr id="bt"><td colspan="4"><a href="javascript:cpt_insert();" onfocus="this.blur();"><img src="../../../images/bt_a_q_newc4.gif"></a></td></tr>
		<tr id="tr">
			<td width="7%">NO</td>
			<td>�ܿ�4�ڵ�</td>
			<td style="text-align: left;">�ܿ�4��</td>
			<td>�������</td>
		</tr>
		<% if(rst2 == null) { %>
		<tr>
			<td colspan="4" class="blank">��ϵǾ��� �ܿ�4 �� �����ϴ�.</td>
		</tr>
		<%
		   } else {
			   for(int i = 0; i < rst2.length; i++) {
		%>
		<tr id="td" align="center">
			<td><%=i+1%></td>
			<!--td><a href="javascript:cpt_view('<%=rst2[i].getId_q_chapter4()%>');"><%=rst2[i].getId_q_chapter4()%></a></td-->
			<td><%=rst2[i].getId_q_chapter4()%></td>
			<td style="text-align: left;"><div style="float: left;"><a href="../chapter4/chapter_list.jsp?id_q_chapter=<%=rst2[i].getId_q_chapter4()%>" onfocus="this.blur();"><%=rst2[i].getChapter()%></a></div> <div style="float: left; padding-top: 1px; padding-left: 6px;"><a href="../chapter4/chapter_list.jsp?id_q_chapter=<%=rst2[i].getId_q_chapter4()%>" onfocus="this.blur();"><img src="../../../images/info2.gif"></a></div></td>
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
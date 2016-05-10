<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.common.*, etest.scorehelp.*, java.sql.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }

	if (id_exam.length() == 0) {
		response.sendRedirect("/error/page_error.jsp");
	
		if(true) return ;	
	}

	String id_q = request.getParameter("id_q");
	if (id_q == null) { id_q= ""; } else { id_q = id_q.trim(); }

	if (id_q.length() == 0) {
		response.sendRedirect("/error/page_error.jsp");
	
		if(true) return ;	
	}

	String userid = request.getParameter("userid");
	if (userid == null) { userid= ""; } else { userid = userid.trim(); }

	if (userid.length() == 0) {
		response.sendRedirect("/error/page_error.jsp");
	
		if(true) return ;	
	}


	Score_EquallistBean3 mBean = null;
	try {
		mBean = Score_Equallist.getQ(id_exam, Integer.parseInt(id_q));
	} catch(Exception ex) {
		//response.sendRedirect("/error/db_error.jsp?err_msg="+ex.getMessage());
		out.println(ex.getMessage());

		if(true) return;
	}

	double allotting = mBean.getAllotting();
	String q = mBean.getQ();

	q = q.replace("<BR>", "");
	q = q.replace("</BR>", "");
	q = q.replace("<P>", "");
	q = q.replace("</P>", "");


	Score_EqualMarkingBean myBean = null;
	try {
		myBean = Score_EqualMarking.getAns2(id_exam, Integer.parseInt(id_q), userid);
	} catch(Exception ex) {
		//response.sendRedirect("/error/db_error.jsp?err_msg="+ex.getMessage());
		out.println(ex.getMessage());

		if(true) return;
	}

	String sAns = "";
	sAns = myBean.getUserans();

	sAns = sAns.replace(")","");
	sAns = sAns.replace("(","");
	sAns = sAns.replace(",","");
	sAns = sAns.replace(".","");
	sAns = sAns.replace("*","");
	sAns = sAns.replace("[","");
	sAns = sAns.replace("\r\n"," ");

	int ans_len = sAns.length();
	String end_time = myBean.getEnd_time();
	String equal_reason = myBean.getEqual_reason();
	double score = myBean.getScore();
%>
<html>
<head>
<title>���� ������ ���� �� ä��</title>
<link rel="stylesheet" href="../css/style.css" type="text/css">

<script language="JavaScript">
	function chk_send() {
		var frm = document.form1;
		if(frm.ans_score.value == "") {
			alert("������ �Է��ϼ���.");
			frm.ans_score.focus();
		} else {
			frm.submit();
		}
	}

	function change(v,n) {
		if(window.parent.main.forms.t_userid.checked == true)
		{
			for(k = 0; k < document.form1.equal_ans_list.length; k++) {				
				if(document.form1.equal_ans_list.options[k].value == v)
				{
					alert("������ �����ڴ� �ѹ��� ��ϵ˴ϴ�.");
					
					return false;
				}
			}
			i = document.form1.equal_ans_list.length;
		    document.form1.equal_ans_list.options[i] = new Option(v,v);	
		} else {
			for(k = 0; k < document.form1.equal_ans_list.length; k++) {
				if(document.form1.equal_ans_list.options[k].value == v)
				{
					var del = confirm("�ش� �����ڸ� ����Ʈ���� �����Ͻðڽ��ϱ�?");
					if(del)
					{	
						document.form1.equal_ans_list.options[k] = null;	
					}
					return false;
				}
			}
		}		
	}

	function del_sel(values) {
		for(k = 0; k < document.form1.equal_ans_list.length; k++) {				
			document.form1.equal_ans_list.option[k] = selected;
		}
	}
</script>

</head>

<table border="0" width="100%" cellpadding="5">
	<tr>
	<td align="center">

	<table width='95%' bgcolor="#FFFFFF">
		<tr>
			<td><font color="#336600"><B>��</font> ����� ��������</B></td>
		</tr>
	</table>

	<table border='0' cellspacing='1' cellpadding='3' width='95%' bgcolor='#EEEEEE'>
		<tr height="30">    
		    <td width="15%" align="center" bgcolor="#E0E0E0"><B>������ȣ</B></td>  
		    <td bgcolor="#FFFFFF">&nbsp;<%=id_q%></td>
		    <td width="15%" align="center" bgcolor="#E0E0E0"><B>����</B></td> 
			<td bgcolor="#FFFFFF">&nbsp;<%=allotting%> ��</td>	
	    </tr>

	    <tr height="30">    
		    <td width="15%" align="center" bgcolor="#E0E0E0"><B>����</B></td>  
		    <td height="30" bgcolor="#FFFFFF" colspan="3">&nbsp;<%=q%></td>
	    </tr>
	</table>
	
    <br>
	<table border='0' width='95%'>
		<tr>
			<td><font color="#336600"><B>��</font> ���������� ���� �� ä���ϱ�</B></td>
		</tr>
		<tr>
			<td align='left' width="50%" valign='top'>
	<table border='0' cellspacing='1' cellpadding='3' width='100%' bgcolor='#EEEEEE'>
	    <tr height="34">    
		    <td width="35%" align="center" bgcolor="#E0E0E0"><B>������</B></td>  
		    <td  bgcolor="#FFFFFF"><%=userid%></td>
		</tr>
		<tr height="34">
		    <td width="35%" align="center" bgcolor="#E0E0E0"><B>��ȱ���</B></td> 
			<td bgcolor="#FFFFFF"><%=ans_len%> Len</td>	
	    </tr>

	    <tr height="34">    
		    <td width="35%" align="center" bgcolor="#E0E0E0"><B>�������ð�</B></td>  
		    <td  bgcolor="#FFFFFF" colspan="3"><%=end_time%></td>
		</tr>
	</table>

		</td>
		<td width="50%" valign=top>
		<table border='0' width='100%' >
		<tr height="20">  
		    <td align='left' >&nbsp;&nbsp;<B>������</B></td>  
			<td align='right' >&nbsp;&nbsp;���� : <%=score%> ��</td>  
		</tr>		
		<tr>
		    <td align='left' height="10" colspan="2">
				<table border='0' cellspacing='1' cellpadding='3' width='100%' bgcolor='#EEEEEE'>
			<tr>
				<td bgcolor='#FFFFFF' height="77" width="500"><%=equal_reason%></td>
			</tr>
		</table>
			</td>
		</tr>
	</table>
			
		</td>
		</tr>
	</table>

	</td>
	</tr>
</table>

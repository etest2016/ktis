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
		myBean = Score_EqualMarking.getAns(id_exam, Integer.parseInt(id_q), userid);
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
			return;
		} else if(frm.equal_reason.value == "") {
			alert("�������� �Է� �ϼ���.");
			frm.equal_reason.focus();
			return;
		} else {
			if (frm.ans_score.value > <%= allotting %>) {
				alert("������ �ִ� <%= allotting %>�� �̳��� �Է� �ϼž� �մϴ�.");
				return;
			}

		    for(k = 0; k < frm.equal_ans_list.length; k++) {				
				frm.equal_ans_list.options[k].selected = true;
			}
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

<body>
	
	<div class="title">����� ��������</div>

	<table border='0' cellspacing='0' cellpadding='3' width='100%' id="tableD">
		<tr height="30">    
			<td width="15%" id="left"><B><li>������ȣ</B></td>  
			<td bgcolor="#FFFFFF">&nbsp;<%=id_q%></td>
			<td width="15%" id="left"><B><li>����</B></td> 
			<td bgcolor="#FFFFFF">&nbsp;<%=allotting%> ��</td>	
		</tr>

		<tr height="30">    
			<td width="15%" id="left"><B><li>����</B></td>  
			<td height="30" bgcolor="#FFFFFF" colspan="3">&nbsp;<%=q%></td>
		</tr>
	</table>

	<br>
	<div class="title">���������� ���� �� ä���ϱ�</div>

		
				
	<table border='0' width='100%'>
		<tr>
			<td align='left' width="55%" valign='middle'>

				<table border='0' cellspacing='0' cellpadding='3' width='100%' id="tableD">
					<tr height="34">    
						<td width="35%" id="left"><li><B>������</B></td>  
						<td  bgcolor="#FFFFFF"><%=userid%></td>
					</tr>
					<tr height="34">
						<td width="35%" id="left"><li><B>��ȱ���</B></td> 
						<td bgcolor="#FFFFFF"><%=ans_len%> Len</td>	
					</tr>

					<tr height="34">    
						<td width="35%" id="left"><li><B>�������ð�</B></td>  
						<td  bgcolor="#FFFFFF" colspan="3"><%=end_time%></td>
					</tr>
				</table>
			</td>
			<td width="40%" valign="middle">
				<table border='0' width='100%'>
					<form name="form1" method="post" action="equal_ans_up.jsp">
					<tr height="20">  
					
					<input type = "hidden" name = "id_exam" value = "<%=id_exam%>"> 
					<input type = "hidden" name = "id_q" value = "<%=id_q%>"> 
					<input type = "hidden" name = "userid" value = "<%=userid%>"> 
						<td align='left'>&nbsp;&nbsp;<B>�������Է�</B></td>  			
					</tr>		
					<tr>
						<td align='left' colspan="2">&nbsp;<select name="equal_ans_list" multiple size="4" onClick="del_sel(this.value)"></select>&nbsp;<textarea cols=25 rows=4 name=equal_reason></textarea></td>
					</tr>
					<tr>
						<td align="left" colspan="2"><div style="float: left;">&nbsp;<input type=text name=ans_score size=3> ��&nbsp;&nbsp;&nbsp;</div><div style="float: left; padding-top: 1px;"><img src="../images/bt3_mark.gif" style="cursor: pointer;" onClick="chk_send()"></div></td>
					</form>
					</tr>
				</table>
				
			</td>
		</tr>
	</table>


</body>
</html>
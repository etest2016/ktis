<!--#include file="../common/ADO.asp" -->
<!--#include file="../common/function.asp" -->
<%
	Response.CacheControl = "no-cache" 
	Response.AddHeader "pragma", "no-cache" 
	Response.Expires = -1
	Response.Charset = "EUC-KR"

	id_exam = Request("id_exam")
	id_q = Request("id_q")
	allot = Request("allot")
	allot = CInt(allot)
	answer = Replace(Replace(Replace(Request("answer"), "<", "&lt;"), ">", "&gt;"), "'", "''")

%>

<html>
<head>
<title>�ܴ��� ���� ä��</title>
<meta http-equiv="Content-Type" content="text/html; CHARSET=EUC-KR">
<link rel="stylesheet" href="../css/style_admin.css" type="text/css">
<link rel="stylesheet" href="../css/table_admin.css" type="text/css">

<script language="javascript">
	function checks(bigo) {
		var frm = document.form1;
						
		if (bigo == "0")
		{
			frm.scores.value = 0;			
		} else if(bigo == "1") {
			frm.scores.value = <%=allot%>;			
		} else {
			if(frm.scores.value == "") {
				alert("������ �Է��ϼ���.");
				frm.scores.focus();				
			} else if(frm.scores.value > <%=allot%>)  {
				alert("�κ������� �������� ���� �ԷµǾ����ϴ�.");
				frm.scores.value = "";
				frm.scores.focus();
			} else if(frm.scores.value < 0)  {
				alert("�κ������� 0������ ���� �Է��ؾ� �մϴ�..");
				frm.scores.value = "";
				frm.scores.focus();
			} else {
				frm.submit();
			}
		}
	}
</script>

</head>

<body style="margin: 15px 20px 30px 20px" oncontextmenu="javascript:return false;" ondragstart="javascript:return false;" onselectstart="javascript:return false;">

<form name="form1" method="post" action="score_U_result2.asp">
<input type="hidden" name="id_exam" value="<%=id_exam%>">
<input type="hidden" name="id_q" value="<%=id_q%>">
<input type="hidden" name="answer" value="<%=answer%>">

<img src="../images/sub2_webscore4.gif">

<table border='0' cellspacing='0' cellpadding='0' class="Btype">
  <tr class="title">    
    <td>����</td>      
    <td>�����Է�</td> 		
  </tr>
  <tr height="50">    
    <td><%=allot%> ��</td>      
    <td><img type="button" value="����" onClick="checks('1');" style="cursor: pointer;" src="../images/bt3_true.gif">&nbsp;&nbsp;<img type="button" value="Ʋ��" onClick="checks('0');" style="cursor: pointer;" src="../images/bt3_false.gif">&nbsp;&nbsp;<input type=text name="scores" size=3> ��</td> 		
  </tr>
</table>
<div class="button" align="center">
	<img type="button" value="ä���ϱ�" onClick="checks();" style="cursor: pointer;" src="../images/bt3_mark2.gif">
</div>
</form>

</body>
</html>

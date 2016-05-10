<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, etest.*, etest.webscore.*" %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");
%>
<%
	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam = ""; } else { id_exam = id_exam.trim(); }

	if (id_exam.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

		if(true) return;
	}

	String userids = "";

	// from exam_ans table
	User_AnswerMarkBean[] users = null;
	try {
	  users = User_AnswerMark.getBeans(id_exam);
	}
	catch (Exception ex) {
	  out.println(ComLib.getExceptionMsg(ex, "back"));

  	  if(true) return;
	}

	if (users == null) {
%>
		<script language="javascript">
			alert("���� ����ڰ� �����ϴ�.");
			window.close();
		</script>
<%
		if(true) return;
	}

	String[] mark = new String[users.length];

	for (int i = 0; i < users.length; i++)
	{
	  String yn_mark = users[i].getYn_mark();
	  if (yn_mark.equalsIgnoreCase("Y")) mark[i] = "��&nbsp;&nbsp;��";
	  else if (yn_mark.equalsIgnoreCase("N")) mark[i] = "�̿Ϸ�";
	  else mark[i] = "������"; // yn_mark = "";
	}
%>

<html>
<head>
<title> :: ������ ��� :: </title>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<meta http-equiv="Pragma" content="no-cache">
<meta name="AUTHOR" content="CheongJH">
<link rel="StyleSheet" href="../../css/style.css" type="text/css">

<script language="javascript">

var count = <%= users.length %>;
var index = -1;

function SetBgColor(ndx)
{
  if (index >= 0) // -1 : ä������ ���ڵ尡 ���� = �ʱ���� (onload ��)
  {
    // ���� ä������ ���ڵ��� ������ ������� ȯ��
    if (count > 1) {
      trData[index].bgColor = "#FFFFFF";
    } else {
      trData.bgColor = "#FFFFFF";
    }
  }

  // ���� ä���� ���ڵ��� ������ ���� ��� ����
  if (count > 1) {
    trData[ndx].bgColor = "#e4f5fc";
  } else {
    trData.bgColor = "#e4f5fc";
  }

  // ���� ä���� �ε����� ����
  index = ndx;
}

function GoMark(userid)
{
  parent.fraMain.location.href = "m_mark.jsp?id_exam=<%= id_exam %>&userid=" + userid;
}

</script>
</head>

<BODY style="margin: 0px 5px 5px 5px;" id="tman">

	<form name="frmData">
		<input type="hidden" name="index" value="-1">
	</form>

	<img src="../../images/sub2_webscore5.gif"><br>

	<table border="0" cellpadding="0" cellspacing="0" id="tableD">
		<tr id="tr" align="center">
			<td width="120">���̵�</td>
			<td width="110">ä��</td>
		</tr>
	</table>
	<div style="overflow-y: scroll; height: 88%; width: 100%; ">
		<table border="0" cellpadding="0" cellspacing="0">
			<% 
				for (int i = 0; i < users.length; i++) {
			%>
			<tr id="trData" align="center" height="22">
				<td style="border-bottom: 1px solid #c2c9d9;" width="120">
					<% if(users[i].getOxs().equals("") || users[i].getOxs() == null) { %><a href="javascript:alert('������ ä���� ������� �ʾҽ��ϴ�.\n\n����ä���� �Ͻñ����� �������������\n\n�ϰ�ä�� Ŭ���Ͻ��� ������ �����ڸ� ä��\n\n�Ǵ� ��� ������ ä���� �����ϼž߸�\n\n����ä���� �����Ͻ� �� �ֽ��ϴ�.')"><% } else { %><a href="javascript: SetBgColor(<%= i %>); GoMark('<%= users[i].getUserid() %>');"><% } %><u><%= users[i].getUserid() %></u>(<%= users[i].getNames() %>)</a>
				</td>
				<td id="tdMark" style="border-bottom: 1px solid #c2c9d9;" width="110"><%= mark[i] %></td>
			</tr>
			<% } %>
		</table>
	</div>

</body>
</html>

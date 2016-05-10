<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="qmtm.ComLib" %>
<%
	String userid = "";

	userid = (String)session.getAttribute("current_userid");
	if (userid == null) { userid= ""; } else { userid = userid.trim(); }

	if(userid.length() == 0 ) {
	    out.println(ComLib.getParameterChk("close"));

	    if(true) return;
	}	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Guide</title>
<link href="../css/bootstrap.css" rel="stylesheet" media="screen">
<link rel="stylesheet" type="text/css" href="../css/top.css" />
</head>
<body>

	<a name="top"></a>
	
	<jsp:include page="../include/include_top.jsp" flush="false">
		<jsp:param name="active_menu_item" value="guide" />
    </jsp:include>

	<div class="container">

		<h4>�� ���ù��</h4>

		<div class='text'>
			�Ʒ��� ���� ������ �򰡿� �����Ͻø� �˴ϴ�.<br><br>
			
			�� �α��� (<strong><u>���̵�: ���</u></strong>)
			<br>
			<b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;��</b><br>
			�� �̿� �ȳ� Ȯ�� (�������� �� ���ǻ��� ��)
			<br>
			<b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;��</b><br>
			�� ������ ('������' �޴� Ŭ�� �� �ش� ���� �����Ͽ� ����)<br>
		</div>


		<h4>���õ��� ������ �߻������� ��ó ���</h4>
		<div class='text'>
			�� <strong>���� ��ǻ�Ͱ� �ٿ� ���� ���</strong><br><br>
			&nbsp;&nbsp;&nbsp;��ǻ�͸� ������ϰų� �ٸ�PC�� �̿��Ͽ� �ٽ� �����Ͽ� �ֽʽÿ�. <br>
			&nbsp;&nbsp;&nbsp;�̶� �̹� �ۼ��Ͻ� ����� ����Ǿ� �����Ƿ� �� Ǭ �������� �̾ Ǫ�� ���� �ֽ��ϴ�.<br>
			<br>
			�� <strong>����ȭ���� ��Ÿ���� ���� ���</strong><br><br>
			&nbsp;&nbsp;&nbsp;��Ʈ��ũ ���°� �������� �ʾ� ���������� ������ ����� ���� ���� ��� �Դϴ�.<br>
			&nbsp;&nbsp;&nbsp;ȭ�� ��� �������� '���ΰ�ħ' ��ư�� Ŭ���Ͽ� ȭ���� �ٽ� �ҷ����ʽÿ�. <br>
			<br>
			�� <strong>���� ���� �̵��̳� ����� ������ �� �Ǵ� ���</strong><br><br>
			&nbsp;&nbsp;&nbsp;��Ʈ��ũ ���°� ��Ȱ���� �ʾ� ������ �ȵǴ� ����� Ȯ���� �����ϴ�.<br>
			&nbsp;&nbsp;&nbsp;Help-Desk�� �����Ͽ� ��ġ�Ͻʽÿ�.
		</div>

		<h4>Online Test�� �����ϱ� ���� ���� PC���</h4>
		<div class='text'>
			<ul>
				<li> CPU : 1GMhz �̻� </li>
				<li> RAM : �ּ� 256�ް� �̻� </li>
				<li> �ϵ��ũ : 10G �̻� </li>
				<li> ȭ��ũ�� : 1024*768 �̻�</li>
				<li> PC�ü�� : Windows XP �̻�</li>
				<li> ���ͳ� ������ :<font class='point'> Internet-explorer 8</font> �̻� (�ʼ� ����) </li>
				<li> �������� ��� : ������ �̵���÷��̾� 6.0 �̻� (�ʼ� ����)</li>
			</ul>
		</div>	
		<div align='right'><a href='#top'><img src='../images/bt_top.gif'></a></div>


	</div>

	<div class="container_bottom"><!--�ٴ� �κ� ���̾ƿ�--></div>


</body>
</html>

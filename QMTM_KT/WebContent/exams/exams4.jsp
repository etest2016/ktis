<%
//******************************************************************************
//   ���α׷� : exams3.jsp
//   �� �� �� : ��������
//   ��    �� : �������� > ��������
//   �� �� �� : q
//   �ڹ����� : 
//   �� �� �� : 2008-12-05
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.qman.*, qmtm.qman.question.*, java.sql.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");


%>

<HTML>
 <HEAD>
  <TITLE> �������� </TITLE>
  <link rel="StyleSheet" href="../../css/style.css" type="text/css">
  <SCRIPT LANGUAGE="JavaScript">
  <!--
		function SaveQ(){
			
			window.open('exams5.jsp','exams5','width=700,height=500');
		}
  //-->
  </SCRIPT>
 </HEAD>

 <BODY>
 
	<div id="main">	
	
			<div id="mainTop">
				<div class="title">�������� <span>���蹮���� ����ڰ� �����Ͽ� �����մϴ�</span></div>
				<div class="location">Question Manager > <span>��������</span></div>
			</div>

			
			��  ����� �������� ���İ� �ɼ��� ���� �� [������ ����]��ư�� Ŭ�� �Ͻʽÿ�.

			<TABLE width="100%">
				<TR>
					<TD>������ ���� ����</TD>
					<TD align="right"><a href="exams1.jsp" target="fraMain">����,</a> <a href="javascript: SaveQ();">������ ����</a>, ���Ϸ� ����</TD>
				</TR>
			</TABLE>
			<div class="box">
				<TABLE>
					<TR>
						<TD align="center">
							<INPUT TYPE="radio" NAME="">����2��<br>
							<img src="../images/layoutA.gif"><br>
							<img src="../images/bt3_zoomin.gif">
						</TD>
						<TD align="center">
							<INPUT TYPE="radio" NAME="">����1��(TypeA)<br>
							<img src="../images/layoutB.gif"><br>
							<img src="../images/bt3_zoomin.gif">
						</TD>
						<TD align="center">
							<INPUT TYPE="radio" NAME="">����1��(TypeB)<br>
							<img src="../images/layoutC.gif"><br>
							<img src="../images/bt3_zoomin.gif">
						</TD>
					</TR>
				</TABLE>
			</div>

			<TABLE width="100%">
				<TR>
					<TD>������ �ɼ� ����</TD>
					<TD align="right">
						�������� : 
						<SELECT NAME="">
							<OPTION VALUE="" SELECTED>�����
							<OPTION VALUE="">����
						</SELECT>
					</TD>
				</TR>
			</TABLE>

			<table border="0" cellpadding ="0" cellspacing="0" id="tableD" width="100%">
				<tr>
					<td id="left" width="20%">�г�</td>
					<td>
						<SELECT NAME="">
							<OPTION VALUE="" SELECTED>�г� ����
							<OPTION VALUE="">
						</SELECT>
						*�ʼ�����
					</td>
				</tr>
				<tr>
					<td id="left">�����</td>
					<td>
						<INPUT TYPE="text" NAME="">
						*�ʼ�����(�ѱ�/���� ���� �ִ� 10�� ���� �Է� ����)
					</td>
				</tr>
				<tr>
					<td id="left">�ܿ���</td>
					<td>
						<INPUT TYPE="text" NAME="">
						���û���(�ѱ�/���� ���� �ִ� 30�� ���� �Է� ����)
					</td>
				</tr>
				<tr>
					<td id="left">������/���ǻ�</td>
					<td>
						<INPUT TYPE="text" NAME="">
						���û���(�ѱ�/���� ���� �ִ� 10�� ���� �Է� ����)
					</td>
				</tr>
				<tr>
					<td id="left">�ΰ�</td>
					<td>
						<SELECT NAME="">
							<OPTION VALUE="" SELECTED>High Mentor�ΰ�
							<OPTION VALUE="">
						</SELECT>
						*�ʼ�����
					</td>
				</tr>
				<tr>
					<td id="left">������</td>
					<td>
						<INPUT TYPE="text" NAME=""> [����������]
						*�ʼ�����
					</td>
				</tr>
				<tr>
					<td id="left">�����</td>
					<td>
						<INPUT TYPE="text" NAME="">
						*�ʼ�����(�ѱ�/���� ���� �ִ� 20�� ���� �Է� ����)
					</td>
				</tr>
				<tr>
					<td id="left">�����ǵ�</td>
					<td>
						<INPUT TYPE="text" NAME="">
						���û���
					</td>
				</tr>
				<tr>
					<td id="left">��Ÿ�ɼ�</td>
					<td>
						������� ����
						<SELECT NAME="">
							<OPTION VALUE="" SELECTED> 3��
							<OPTION VALUE="">2��
							<OPTION VALUE="">1��
						</SELECT>
						<br>
						<INPUT TYPE="checkbox" NAME=""> ���� ������ �ؼ� ǥ��<br>
						<INPUT TYPE="checkbox" NAME=""> ���� ������ ���� ǥ��
					</td>
				</tr>
			</table>

			
	<jsp:include page="../copyright.jsp"/>

</BODY>
</HTML>
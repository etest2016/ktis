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

	String userid = CommonUtil.get_Cookie(request, "userid");
	if (userid == null) { userid= ""; } else { userid = userid.trim(); }

	if (userid.length() == 0) {
		response.sendRedirect("/error/page_error.jsp");
	
		if(true) return ;
	}

    // �ű� ��� ���� ��������
	QListBean[] rst = null; 

	try {
		rst = QListUtil.getNewQ(userid);
	} catch(Exception ex) {
		response.sendRedirect("/error/db_error.jsp?err_msg="+ex.getMessage());

		if(true) return;
	}
%>

<HTML>
 <HEAD>
  <TITLE> �������� </TITLE>
  <link rel="StyleSheet" href="../../css/style.css" type="text/css">
 </HEAD>

 <BODY>
 
	<div id="main">	
	
			<div id="mainTop">
				<div class="title">�������� <span>���蹮���� ����ڰ� �����Ͽ� �����մϴ�</span></div>
				<div class="location">Question Manager > <span>��������</span></div>
			</div>

			
			��  ���� ���� �� �迭������ ���� �� [����] ��ư�� Ŭ�� �Ͻʽÿ�.

			<TABLE width="100%">
				<TR>
					<TD>���õ� ���� ��: (<B>30</B>)����</TD>
					<TD align="right">
						<a href="exams1.jsp" target="fraMain">����,</a> 
						*�迭���� 
						<SELECT NAME="">
							<OPTION VALUE="" SELECTED>����1
							<OPTION VALUE="">
						</SELECT>
						<SELECT NAME="">
							<OPTION VALUE="" SELECTED>����2
							<OPTION VALUE="">
						</SELECT>
						<SELECT NAME="">
							<OPTION VALUE="" SELECTED>����3
							<OPTION VALUE="">
						</SELECT>
						, ..�ϱ�, <a href="exams4.jsp" target="fraMain">����</a>
					</TD>
				</TR>
			</TABLE>

			<% 
				if(rst != null){ 
					for(int i = 0; i < rst.length; i++){
			%>

			<div class="box">
				[�����ڵ�: <%=rst[i].getId_q()%>]&nbsp;&nbsp;[�ܿ�: <%=rst[i].getQ_subject()%>]&nbsp;&nbsp;[��������: <%=rst[i].getQtype()%><!--1:ox��, 2:������, 3:���������, 4:�ܴ���, 5:������-->]&nbsp;&nbsp;[��������: <%=rst[i].getRefs()%>]&nbsp;&nbsp;[���̵�: ]&nbsp;&nbsp;[�뵵: ]&nbsp;&nbsp;[�˻���: ]
			</div>

			<TABLE width="97%" align="center" cellpadding="2" cellspacing="0">
				<TR>
					<TD rowspan="3" style="vertical-align: top;" width="20"><INPUT TYPE="checkbox" NAME=""></TD>
					<TD><%=rst[i].getQ()%></TD>
				</TR>
				<!--����-->
				<TR>
					<TD>(����)</TD>
				</TR>
				<!--�ؼ�-->
				<TR>
					<TD>(�ؼ�)</TD>
				</TR>				
			</TABLE>

			<% }} %>

			
	<jsp:include page="../copyright.jsp"/>

</BODY>
</HTML>
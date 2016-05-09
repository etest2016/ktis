<%
//******************************************************************************
//   ���α׷� : exams1.jsp
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

	String userid = (String)session.getAttribute("userid");
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
  <SCRIPT LANGUAGE="JavaScript">
  <!--
		
		function errorQ(id_q){
		
			window.open('exams2.jsp','exams2','width=640,height=500');
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

			
			<div class="box" style="margin-bottom: 10px;">
				<TABLE width="100%">
					<TR>
						<TD valign="top"><img src="../images/img_exams1.gif"></TD>
						<TD>
							<TABLE border="0" cellpadding="1" cellspacing="0">
								<TR>
									<TD><INPUT TYPE="checkbox" NAME="">��������</TD>
									<TD>
										&nbsp;&nbsp;&nbsp;
										<SELECT NAME="">
											<OPTION VALUE="" SELECTED>��������
											<OPTION VALUE="">
										</SELECT>
									</TD>
									<TD width="50"></TD>
									<TD><INPUT TYPE="checkbox" NAME="">���̵�</TD>
									<TD>
										&nbsp;&nbsp;&nbsp;
										<SELECT NAME="">
											<OPTION VALUE="" SELECTED>���̵�����
											<OPTION VALUE="">
										</SELECT>
									</TD>
								</TR>
								<TR>
									<TD colspan="5" align="right"><img src="../images/bt3_search_d.gif"></TD>
								</TR>
							</TABLE>
							<hr>
							<TABLE border="0" cellpadding="0" cellspacing="0">
								<TR>
									<TD><INPUT TYPE="checkbox" NAME="">��ó</TD>
									<TD>
										<SELECT NAME="">
											<OPTION VALUE="" SELECTED>����
											<OPTION VALUE="">
										</SELECT>

										<SELECT NAME="">
											<OPTION VALUE="" SELECTED>
											<OPTION VALUE="">
										</SELECT>
									</TD>
									<TD width="50"></TD>
									<TD><INPUT TYPE="checkbox" NAME="">���� �ܿ� ���� ����</TD>
								</TR>
								<TR>
									<TD><INPUT TYPE="checkbox" NAME="">�뵵</TD>
									<TD>
										<SELECT NAME="">
											<OPTION VALUE="" SELECTED>����
											<OPTION VALUE="">
										</SELECT>
									</TD>
									<TD></TD>
									<TD><INPUT TYPE="checkbox" NAME="">�ؼ��� �ִ� ���׸� ����</TD>
								</TR>
								<TR>
									<TD><INPUT TYPE="checkbox" NAME="">�˻���</TD>
									<TD>
										<SELECT NAME="">
											<OPTION VALUE="" SELECTED>����
											<OPTION VALUE="">
										</SELECT>
									</TD>
									<TD></TD>
									<TD><INPUT TYPE="checkbox" NAME="">�׷������� �ִ� ���׸� ����</TD>
								</TR>
							</TABLE>

						</TD>
						<TD align="right" valign="top"><img src="../images/bt5_qI_4.gif"></TD>
					</TR>
				</TABLE>

				
				

			</div>
			

			<div class="box2">
			<span class="subtitle">�˻��� ����</span>
			<TABLE width="100%">
				<TR>
					<TD>�˻��� ���� ��: (<B>30</B>)����</TD>
					<TD align="right"><img src="../images/bt1_a.gif">&nbsp;<img src="../images/bt1_b.gif"> <a href="exams3.jsp" target="fraMain">����</a></TD>
				</TR>
			</TABLE>



			<% 
				if(rst != null){ 
					for(int i = 0; i < rst.length; i++){
			%>

			<div class="box3">
				[�����ڵ�: <%=rst[i].getId_q()%>]&nbsp;&nbsp;[�ܿ�: <%=rst[i].getQ_subject()%>]&nbsp;&nbsp;[��������: <%=rst[i].getQtype()%><!--1:ox��, 2:������, 3:���������, 4:�ܴ���, 5:�����-->]&nbsp;&nbsp;[��������: <%=rst[i].getRefs()%>]&nbsp;&nbsp;[���̵�: ]&nbsp;&nbsp;[�뵵: ]&nbsp;&nbsp;[�˻���: ]
			</div>

			<TABLE width="97%" align="center" cellpadding="2" cellspacing="0">
				<TR>
					<TD rowspan="4" style="vertical-align: top;" width="20"><INPUT TYPE="checkbox" NAME=""></TD>
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
				<!--����Ű�-->
				<TR>
					<TD align="right"><a href="Javascript:errorQ('<%=rst[i].getId_q()%>');">�������׽Ű�</a></TD>
				</TR>
			</TABLE>

			<% }} %>


			</div>



			
	<jsp:include page="../copyright.jsp"/>

</BODY>
</HTML>
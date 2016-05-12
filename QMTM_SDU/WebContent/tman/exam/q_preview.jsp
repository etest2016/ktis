<%
//******************************************************************************
//   ���α׷� : q_preview.jsp
//   �� �� �� : ���� �̸�����
//   ��    �� : ���� �̸�����
//   �� �� �� : q
//   �ڹ����� : qmtm.*, qmtm.qman.question.*
//   �� �� �� : 2008-07-08
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************

%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.tman.exam.*, qmtm.common.* " %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_qs = request.getParameter("id_qs");
	if (id_qs == null) { id_qs = ""; } else { id_qs = id_qs.trim(); }	
	
	if (id_qs.length() == 0) {
		response.sendRedirect("/error/page_error.jsp");
	
		if(true) return ;
	}

	String[] arrQ = id_qs.split(",");

	int qcount = arrQ.length;

	String exlabel = "��,��,��,��,��,��,��,��,";

	String[][] arrEx = new String[qcount][8];  // ����� + ���⳻��
	
	String[] arrExlabel = exlabel.split(",");

	QunitBean[] qs = null;

	try {
		qs = Qunit.getBeans(id_qs);
	} catch(Exception ex) {
		response.sendRedirect("/error/db_error.jsp?err_msg="+ex.getMessage());

		if(true) return;
	}

	long[] arrId_q = new long[qcount];
	boolean[] arrHasRef = new boolean[qcount]; // ��������
	String[] arrRefTitle = new String[qcount]; // �������� �� �ش繮����ȣ
	String[] arrRefBody = new String[qcount];  // ��������
	String[] arrId_ref = new String[qcount];  // ��������

	String[] arrQuestion = new String[qcount]; // ��������

	int[] arrId_qtype = new int[qcount];        // ���� ����
	boolean[] arrHasEx = new boolean[qcount];  // ��������
	int[] arrExcount = new int[qcount];        // ���� ����

	String[] arrCA = new String[qcount];       // ����ǥ��
	boolean[] arrHasExplain = new boolean[qcount]; // �ؼ�����
	String[] arrExplain = new String[qcount];      // �ؼ�

	String[] arrHint = new String[qcount];      // ��Ʈ

	String[] arrQtype = new String[qcount]; // ��������

	String[] arrEx1 = new String[qcount];
	String[] arrEx2 = new String[qcount];
	String[] arrEx3 = new String[qcount];
	String[] arrEx4 = new String[qcount];
	String[] arrEx5 = new String[qcount];
	String[] arrEx6 = new String[qcount];
	String[] arrEx7 = new String[qcount];
	String[] arrEx8 = new String[qcount];

	// �ʱ�ȭ
	String id_ref = "";     // ����ID
	
	for(int i=0; i<qs.length; i++) {

		arrId_qtype[i] = qs[i].getId_qtype();
	    int id_valid_type = qs[i].getId_valid_type();
	    int cacount = qs[i].getCacount();
		int[] arrEx_order = qs[i].getArrEx_order();
		arrCA[i] = QmTm.getNullChk(qs[i].getCa());

		arrEx1[i] = QmTm.delTag2(qs[i].getEx1());
		arrEx2[i] = QmTm.delTag2(qs[i].getEx2());
		arrEx3[i] = QmTm.delTag2(qs[i].getEx3());
		arrEx4[i] = QmTm.delTag2(qs[i].getEx4());
		arrEx5[i] = QmTm.delTag2(qs[i].getEx5());
		arrEx6[i] = QmTm.delTag2(qs[i].getEx6());
		arrEx7[i] = QmTm.delTag2(qs[i].getEx7());
		arrEx8[i] = QmTm.delTag2(qs[i].getEx8());

		arrQuestion[i] = qs[i].getQ();

		arrId_q[i] = qs[i].getId_q();
		
		if(qs[i].getId_ref().equals("0")) {
			arrHasRef[i] = false;
		} else {
			arrHasRef[i] = true;
			arrRefTitle[i] = qs[i].getReftitle();
			arrRefBody[i] = qs[i].getRefbody();
			arrId_ref[i] = qs[i].getId_ref();
		}

		if (arrId_qtype[i] <= 3) {
			arrHasEx[i] = true;
		} else {
			arrHasEx[i] = false;
   	    }
	  
		arrExcount[i] = qs[i].getExcount();

		for (int j = 0; j < arrExcount[i]; j++) {
			arrEx[i][j] = arrExlabel[j];
		}
	}
%>

<html>
<head>
	<title> :: ���� �̸����� :: </title>
	<style>
		
		Body { margin: 20px 20px 100px 20px; font: normal 12px gulim; }
		table, tr, td, div { font: normal 12px gulim; }
		img { border: 0px; }
		
		#ref { margin-top: 25px; line-height: 150%; }
		#q { margin-top: 25px; line-height: 120%; }
		#ex { margin-top: 15px; line-height: 150%; padding-left: 8px; }
		#ans { margin-top: 10px; color: red; }

	</style>
</head>

<BODY>
	
	<% for (int i = 0; i < qcount; i++) { /* �������� loop �� �����鼭 */ %>

	<!--------------------------------------- ���� --------------------------------------->
	<Div id="ref">
		<% if (arrHasRef[i]) { %>
		<b>�����ڵ�:<%= arrId_ref[i] %></b><br>
		<%= arrRefTitle[i] %>
		<%= arrRefBody[i] %>
		<% } %>
	</Div>
	

	<!--------------------------------------- ���� --------------------------------------->
	<Div id="q">
		<b>�����ڵ�:<%= arrId_q[i] %></b><br>
		<font color="#0000CC"><%= arrQuestion[i] %></font>
	</Div>


	<!--------------------------------------- ���� --------------------------------------->
	<Div id="ex">
		<% if (arrHasEx[i]) { %>
			<% if(arrExcount[i] == 2) { %>
				<%=arrExlabel[0]%>&nbsp;&nbsp;<%= arrEx1[i] %><br>
				<%=arrExlabel[1]%>&nbsp;&nbsp;<%= arrEx2[i] %>
			<% } else if(arrExcount[i] == 3) { %>
				<%=arrExlabel[0]%>&nbsp;&nbsp;<%= arrEx1[i] %><br>
				<%=arrExlabel[1]%>&nbsp;&nbsp;<%= arrEx2[i] %><br>
				<%=arrExlabel[2]%>&nbsp;&nbsp;<%= arrEx3[i] %>
			<% } else if(arrExcount[i] == 4) { %>
				<%=arrExlabel[0]%>&nbsp;&nbsp;<%= arrEx1[i] %><br>
				<%=arrExlabel[1]%>&nbsp;&nbsp;<%= arrEx2[i] %><br>
				<%=arrExlabel[2]%>&nbsp;&nbsp;<%= arrEx3[i] %><br>
				<%=arrExlabel[3]%>&nbsp;&nbsp;<%= arrEx4[i] %>
			<% } else if(arrExcount[i] == 5) { %>
				<%=arrExlabel[0]%>&nbsp;&nbsp;<%= arrEx1[i] %><br>
				<%=arrExlabel[1]%>&nbsp;&nbsp;<%= arrEx2[i] %><br>
				<%=arrExlabel[2]%>&nbsp;&nbsp;<%= arrEx3[i] %><br>
				<%=arrExlabel[3]%>&nbsp;&nbsp;<%= arrEx4[i] %><br>
				<%=arrExlabel[4]%>&nbsp;&nbsp;<%= arrEx5[i] %>
			<% } else if(arrExcount[i] == 6) { %>
				<%=arrExlabel[0]%>&nbsp;&nbsp;<%= arrEx1[i] %><br>
				<%=arrExlabel[1]%>&nbsp;&nbsp;<%= arrEx2[i] %><br>
				<%=arrExlabel[2]%>&nbsp;&nbsp;<%= arrEx3[i] %><br>
				<%=arrExlabel[3]%>&nbsp;&nbsp;<%= arrEx4[i] %><br>
				<%=arrExlabel[4]%>&nbsp;&nbsp;<%= arrEx5[i] %><br>
				<%=arrExlabel[5]%>&nbsp;&nbsp;<%= arrEx6[i] %>
			<% } else if(arrExcount[i] == 7) { %>
				<%=arrExlabel[0]%>&nbsp;&nbsp;<%= arrEx1[i] %><br>
				<%=arrExlabel[1]%>&nbsp;&nbsp;<%= arrEx2[i] %><br>
				<%=arrExlabel[2]%>&nbsp;&nbsp;<%= arrEx3[i] %><br>
				<%=arrExlabel[3]%>&nbsp;&nbsp;<%= arrEx4[i] %><br>
				<%=arrExlabel[4]%>&nbsp;&nbsp;<%= arrEx5[i] %><br>
				<%=arrExlabel[5]%>&nbsp;&nbsp;<%= arrEx6[i] %><br>
				<%=arrExlabel[6]%>&nbsp;&nbsp;<%= arrEx7[i] %>
			<% } else if(arrExcount[i] == 8) { %>
				<%=arrExlabel[0]%>&nbsp;&nbsp;<%= arrEx1[i] %><br>
				<%=arrExlabel[1]%>&nbsp;&nbsp;<%= arrEx2[i] %><br>
				<%=arrExlabel[2]%>&nbsp;&nbsp;<%= arrEx3[i] %><br>
				<%=arrExlabel[3]%>&nbsp;&nbsp;<%= arrEx4[i] %><br>
				<%=arrExlabel[4]%>&nbsp;&nbsp;<%= arrEx5[i] %><br>
				<%=arrExlabel[5]%>&nbsp;&nbsp;<%= arrEx6[i] %><br>
				<%=arrExlabel[6]%>&nbsp;&nbsp;<%= arrEx7[i] %><br>
				<%=arrExlabel[7]%>&nbsp;&nbsp;<%= arrEx8[i] %>
			<% } %>
		<% } %>

	</Div> 
	
	<Div id="ans">
		<% if(arrId_qtype[i] == 3 || arrId_qtype[i] == 4) { %>
			����: <%=arrCA[i].replace("{|}",", ").replace("{^}"," �Ǵ� ")%>
		<% } else { %>
			����: <%=arrCA[i] %>
		<% } %>
	</Div>
		
	<% } %>

</body>
</html>
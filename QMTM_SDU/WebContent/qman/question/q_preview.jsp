<%
//******************************************************************************
//   ���α׷� : q_preview.jsp
//   �� �� �� : ���� �̸�����
//   ��    �� : ���� �̸�����
//   �� �� �� : q
//   �ڹ����� : qmtm.ComLib, qmtm.QmTm, qmtm.tman.exam.QunitBean, qmtm.tman.exam.Qunit
//   �� �� �� : 2013-02-08
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************

%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.QmTm, qmtm.tman.exam.QunitBean, qmtm.tman.exam.Qunit " %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_qs = request.getParameter("id_qs");
	if (id_qs == null) { id_qs = ""; } else { id_qs = id_qs.trim(); }	
	
	if (id_qs.length() == 0) {
%>
	<script type="text/javascript">
		alert("�̸����� �� ������ �����ϴ�.");
		window.close();
	</script>
<%	
	}
	
	String id_subject = request.getParameter("id_subject");
	if (id_subject == null) { id_subject = "-1"; } else { id_subject = id_subject.trim(); }

	String id_chapter = request.getParameter("id_chapter");
	if (id_chapter == null) { id_chapter = "-1"; } else { id_chapter = id_chapter.trim(); }

	String[] arrQ = id_qs.split(",");

	int qcount = arrQ.length;

	String exlabel = "��,��,��,��,��,";

	String[][] arrEx = new String[qcount][8];  // ����� + ���⳻��
	
	String[] arrExlabel = exlabel.split(",");

	QunitBean[] qs = null;

	try {
		qs = Qunit.getBeans2(id_qs, id_subject, id_chapter);
	} catch(Exception ex) {
		out.println(ex.getMessage());
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
	<link rel="StyleSheet" href="../../css/style.css" type="text/css">
</head>

<BODY id="popup2">
	
	<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">�����̸����� </div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>

	<div id="contents">
	
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

	</div>

	<div id="button">
		<input type="button" value="â�ݱ�" class="form" onClick="window.close();">
	</div>

</body>
</html>
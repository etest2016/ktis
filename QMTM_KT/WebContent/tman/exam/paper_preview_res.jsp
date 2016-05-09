<%
//******************************************************************************
//   ���α׷� : paper_preview_res.jsp
//   �� �� �� : ������ �̸�����
//   ��    �� : ������ �̸�����
//   �� �� �� : 
//   �ڹ����� : 
//   �� �� �� : 2008-05-16
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.common.*, java.sql.*" %>

<%
    response.setDateHeader("Expires", 0);
    request.setCharacterEncoding("EUC-KR");

	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }

	String nr_set = request.getParameter("nr_set");
	if (nr_set == null) { nr_set= "1"; } else { nr_set = nr_set.trim(); }
	
	String answer_view = request.getParameter("answer"); // ��������
	if (answer_view == null) { answer_view= "N"; } else { answer_view = answer_view.trim(); }

	String explain_view = request.getParameter("explain"); // �ؼ�����
	if (explain_view == null) { explain_view = "N"; } else { explain_view = explain_view.trim(); }

	String hint_view = request.getParameter("hint"); // ��Ʈ����
	if (hint_view == null) { hint_view= "N"; } else { hint_view = hint_view.trim(); }

	String diff_view = request.getParameter("diff"); // ���̵�����
	if (diff_view == null) { diff_view= "N"; } else { diff_view = diff_view.trim(); }

	String allott_view = request.getParameter("allott"); // ��������
	if (allott_view == null) { allott_view= "N"; } else { allott_view = allott_view.trim(); }

	String id_q_view = request.getParameter("id_q"); // �����ڵ�����
	if (id_q_view == null) { id_q_view= "N"; } else { id_q_view = id_q_view.trim(); }
	
	if (id_exam.length() == 0) {
%>
	<script language="javascript">
		alert("�ش� ȭ�鿡 ���� ������ �����ϴ�.");
		window.close();
	</script>
<%	
	}

	ExamInfoBean info = null;
	
	try {
		info = ExamInfo.getBean(id_exam);
	}
    catch (Exception ex) {
        out.println(ex.getMessage());
	}

	String title = info.getTitle();
	double totalAllot = info.getAllotting();
	int qcount = info.getQcount();

	ExamPaperBean[] qs = null;

	try {
		qs = ExamPaper.getBeans(id_exam, Integer.parseInt(nr_set));
	} catch (Exception ex) {
		out.println(ex.getMessage());
	}

	if (qs == null) {
%>
	<script language="JavaScript">
		alert("�ش��ϴ� ���������� �����ϴ�");
	</script>
<%
	}
	if (qs.length != qcount) {
%>
	<script language="JavaScript">
		alert("���������� �������� �������� �������� �ٸ��ϴ�");
	</script>
<%
	}

	String[] arrExlabel = info.getExlabel().split(",");
%>

<%
	// ������ ǥ�ø� ���� ������

	long[] arrId_q = new long[qcount];
	String[] arrDifficulty1 = new String[qcount];

	boolean[] arrHasRef = new boolean[qcount]; // ��������
	String[] arrRefTitle = new String[qcount]; // �������� �� �ش繮����ȣ
	String[] arrRefBody = new String[qcount];  // ��������

	int[] arrQuestionNo = new int[qcount];     // ������ȣ
	String[] arrQuestion = new String[qcount]; // ��������
	String[] arrOPX_img = new String[qcount];  // ������ȣ�� ����̹��� (OX ����)

	boolean[] arrHasEx = new boolean[qcount];  // ��������
	int[] arrExcount = new int[qcount];        // ���� ����
	String[][] arrEx = new String[qcount][8];  // ����� + ���⳻��

	double[] arrAllot = new double[qcount];    // ����
	String[] arrCA = new String[qcount];       // ����ǥ��
	
	boolean[] arrHasExplain = new boolean[qcount]; // �ؼ�����
	String[] arrExplain = new String[qcount];      // �ؼ�

	String[] arrHint = new String[qcount];      // ��Ʈ

	String[] arrQtype = new String[qcount]; // ��������

	// �ʱ�ȭ
	String id_ref = "";     // ����ID

	// looping

	for (int i = 0; i < qcount; i++)
	{
		int id_qtype = qs[i].getId_qtype();
	    int id_valid_type = qs[i].getId_valid_type();
	    int cacount = qs[i].getCacount();
		int[] arrEx_order = qs[i].getArrEx_order();
		String correctAnswer = qs[i].getCa().trim();

		arrId_q[i] = qs[i].getId_q();
		arrHint[i] = qs[i].getHint();

		if (qs[i].getId_difficulty1() == 0) {
			arrDifficulty1[i] = "����";
		} else if (qs[i].getId_difficulty1() == 1) {
			arrDifficulty1[i] = "�ֻ�";
		} else if (qs[i].getId_difficulty1() == 2) {
			arrDifficulty1[i] = "��";
		} else if (qs[i].getId_difficulty1() == 3) {
			arrDifficulty1[i] = "��";
		} else if (qs[i].getId_difficulty1() == 4) {
			arrDifficulty1[i] = "��";
		} else if (qs[i].getId_difficulty1() == 5) {
			arrDifficulty1[i] = "����";
		}

		// ����ǥ��
		if (id_ref.equalsIgnoreCase(qs[i].getId_ref())) {     // id_ref ������
		    arrHasRef[i] = false;
		} else if (qs[i].getId_ref().equalsIgnoreCase("0")) { // id_ref = 0 : ������
		    arrHasRef[i] = false;
		} else {                                              // id_ref �� ���� �Ǿ��� ������
		    arrHasRef[i] = true;

			id_ref = qs[i].getId_ref();
		    arrRefTitle[i] = "�� " + qs[i].getReftitle() + "[" + qs[i].getQ_no1() + "]" ;

			if (qs[i].getQ_no1() != qs[i].getQ_no2()) { // ���������� ����
		      arrRefTitle[i] += " ~ [" + qs[i].getQ_no2() + "]";
		    }

			arrRefBody[i] = qs[i].getRefbody();
		}

		arrCA[i] = ExamPaper.getAnswerDisplay(id_valid_type, id_qtype, cacount, arrEx_order, correctAnswer, arrExlabel);

		if (id_qtype == 5) {
			arrCA[i] = "N/A";
		}

	  // ����ǥ��
	  arrQuestionNo[i] = qs[i].getNr_q();
	  arrQuestion[i] = qs[i].getQ();

	  // ����ǥ��
	  if (id_qtype <= 3) {
		arrHasEx[i] = true;
	  } else {
		arrHasEx[i] = false;
	  }
	  arrExcount[i] = qs[i].getExcount();
	  for (int j = 0; j < arrExcount[i]; j++) {
		arrEx[i][j] = arrExlabel[j] + " " + QmTm.delTag(qs[i].getArrEx()[j]);
	  }

	  // ����
	  arrAllot[i] = qs[i].getAllotting();

	  // �ؼ�����
	  if (qs[i].getExplain().length() > 0) {
		arrHasExplain[i] = true; arrExplain[i] = qs[i].getExplain();
	  } else {
		arrHasExplain[i] = false;
	  }
	}
%>
<HTML>
<HEAD>
<TITLE> :: ������ �̸����� :: </TITLE>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8">
<style>
	
	Body { margin: 0px 20px 100px 20px; font: normal 12px gulim; line-height: 140%; }
	table, tr, td, div { font: normal 12px gulim; line-height: 140%; }
	img { border: 0px; }
	
	#exam_info { line-height: 150%; border: 0px solid #CCC; padding: 0px 0px 20px 0px; margin-top: 5px; font: normal 13px gulim; 
		border-bottom: 1px dotted #999;
	}
	#ref { margin-top: 25px; }
	#q { margin-top: 25px; line-height: 120%; }
	#ex { margin-top: 15px; padding-left: 8px; }
	#ans { margin-top: 10px; color: red; }


</style>
<script language="JavaScript">
	
	function inits() {
		window.resizeTo('1000','700');
	}

	function paper_html() {
		window.open("paper_preview_html.jsp?id_exam=<%=id_exam%>&nr_set=<%=nr_set%>&answer=<%=answer_view%>&explain=<%=explain_view%>&hint=<%=hint_view%>&id_q=<%=id_q_view%>&diff=<%=diff_view%>&allott=<%=allott_view%>","paper_preview","width=1, height=1, scrollbars=no");
	}

</script>


<body onLoad="inits();">


	<Div align="right">
		<img src="../../images/bt2_html.gif" onclick="javascript:paper_html();" style="cursor: hand;" onfocus="this.blur();">
	</Div>


	<Div id="exam_info">
		<li>����� : <%=title%></li>
		<li>������ ��ȣ : <%=nr_set%></li>
		<li>������ : <%=qcount%></li>
		<li>���� : <%=totalAllot%></li>
	</Div>


	<% for(int i = 0; i < qcount; i++) { %>

	<!--------------------------------------- ���� --------------------------------------->
	<Div id="q">
		<font color="#0000CC"><%=arrQuestionNo[i]%>.&nbsp;<%=arrQuestion[i]%></font>
	</Div>
	
	<!--------------------------------------- ���� --------------------------------------->
	<Div id="ex">
		<% if (arrHasEx[i]) { %>
			<% for (int j = 0; j < arrExcount[i]; j++) { %>
				<%= arrEx[i][j] %>
			<% } %>
		<% } %>
	</Div>

	<!--------------------------------------- ��Ÿ --------------------------------------->
	<Div id="ans">

		<% if(id_q_view.equals("Y")) { %>
			(�����ڵ�) <%= arrId_q[i] %><br>
		<% } %>

		<% if(answer_view.equals("Y")) { %>
			(����) <%= arrCA[i] %><Br>
		<% } %>
		
		<% if(allott_view.equals("Y")) { %>
			(����) <%=arrAllot[i]%><br>
		<% } %>
		
		<% if(diff_view.equals("Y")) { %>
			(���̵�) <%= arrDifficulty1[i] %><br>
		<% } %>
		
		<% if(explain_view.equals("Y")) { %>
			(�ؼ�) <%= arrExplain[i] %><br>
		<% } %>

		<% if(hint_view.equals("Y")) { %>
			(��Ʈ) <%=arrHint[i]%>
		<% } %>
	</Div>


	<% } %>
	
</body>
</html>
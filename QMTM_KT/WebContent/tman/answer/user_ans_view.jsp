<%
//******************************************************************************
//   ���α׷� : user_ans_view.jsp
//   �� �� �� : ����� ��ȸ
//   ��    �� : ����� ��ȸ
//   �� �� �� : 
//   �ڹ����� : qmtm.tman.answer.ExamUtil
//   �� �� �� : 2008-05-21
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="qmtm.*, qmtm.common.*, qmtm.tman.answer.*, java.sql.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("euc-kr");

	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }

	String userid = request.getParameter("userid");
	if (userid == null) { userid = ""; } else { userid = userid.trim(); }
	
	if (id_exam.length() == 0 || userid.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	ExamAnswerAddBean ans = null;

	try {
		ans = ExamAnswerAdd.getBean(userid, id_exam);
	} catch (Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

		if(true) return;
	}

	if(ans == null) {
%>
	<script language="javascript">
		alert("���迡 �������ϼ̽��ϴ�.\n\n���迡 �����Ͻ� �� ������� Ȯ���Ͻ� �� �ֽ��ϴ�.");
		window.close();
	</script>
<%
		if(true) return;
	}
	
	int nr_set = ans.getNr_set();

	ExamInfoBean info = null;
	
	try {
		info = ExamInfo.getBean(id_exam);
	}
    catch (Exception ex) {
        out.println(ComLib.getExceptionMsg(ex, "back"));

		if(true) return;
	}

	String title = info.getTitle();
	double totalAllot = info.getAllotting();
	int qcount = info.getQcount();

	// ���������� �о�´�.
	ExamPaperBean[] qs = null;

	try {
		qs = ExamPaper.getBeans45(id_exam, nr_set, userid);
	} catch (Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

		if(true) return;
	}

	if (qs == null) {
%>
	<script language="JavaScript">
		alert("�ش��ϴ� ���������� �����ϴ�");
	</script>
<%
		if(true) return;
	}
	if (qs.length != qcount) {
%>
	<script language="JavaScript">
		alert("���������� �������� �������� �������� �ٸ��ϴ�");
	</script>
<%
		if(true) return;
	}

	String[] arrExlabel = info.getExlabel().split(",");

	String[] arrAnswer;
	String[] arrOX;
	String[] arrPoint;

	if (ans.getAnswers().length() >= qcount) {
	  arrAnswer = ans.getAnswers().split(QmTm.Q_GUBUN_re, -1);
	} else {
	  arrAnswer = new String[qcount];
	}

	if (ans.getOxs().length() >= qcount) {
	  arrOX = ans.getOxs().split(QmTm.Q_GUBUN_re, -1);
	} else {
	  arrOX = new String[qcount];
	}

	if (ans.getPoints().length() >= qcount) {
	  arrPoint = ans.getPoints().split(QmTm.Q_GUBUN_re, -1);
	} else {
	  arrPoint = new String[qcount];
	}

	if (arrAnswer.length != qs.length) {
%>
	<script language="JavaScript">
		alert("������� �������� ���� �������� Ʋ���ϴ�.);
	</script>
<%
		if(true) return;
	}

	// ������ ǥ�ø� ���� ������

	int[] arrId_qtype = new int[qcount];
	long[] arrId_q = new long[qcount];
	String[] arrDifficulty1 = new String[qcount];

	int[] arrQuestionNo = new int[qcount];     // ������ȣ
	String[] arrQuestion = new String[qcount]; // ��������
	String[] arrOPX_img = new String[qcount];  // ������ȣ�� ����̹��� (OX ����)

	boolean[] arrHasEx = new boolean[qcount];  // ��������
	int[] arrExcount = new int[qcount];        // ���� ����
	String[][] arrEx = new String[qcount][5];  // ����� + ���⳻��

	double[] arrAllot = new double[qcount];    // ����
	String[] arrCA = new String[qcount];       // ����ǥ��

	String[] arrUserCA = new String[qcount];       // ���� ���

	String[] arrUA = new String[qcount];       // ������ǥ��

	String[] arrOXP = new String[qcount];       // OXP ǥ��
	
	String[] arrExplain = new String[qcount];      // �ؼ�

	String[] arrQtype = new String[qcount]; // ��������

	String[] ex_order = new String[qcount];

	int[] arrCacount = new int[qcount]; // ���� ����

	String[] arrYn_caorder = new String[qcount];
	String[] arrYn_case = new String[qcount];
	String[] arrYn_blank = new String[qcount];

	int[] arrId_valid_type = new int[qcount];

	// �ʱ�ȭ
	String strChk = "";

	// looping

	for (int i = 0; i < qcount; i++)
	{
		if (arrAnswer[i] == null) { arrAnswer[i] = ""; }
		if (arrOX[i] == null) { arrOX[i] = ""; }
		if (arrPoint[i] == null) { arrPoint[i] = ""; }

		arrId_qtype[i] = qs[i].getId_qtype();
	    arrId_valid_type[i] = qs[i].getId_valid_type();
	    arrCacount[i] = qs[i].getCacount();
		int[] arrEx_order = qs[i].getArrEx_order();
		String correctAnswer = qs[i].getCa();

		arrYn_caorder[i] = qs[i].getYn_caorder();
		arrYn_case[i] = qs[i].getYn_case();
		arrYn_blank[i] = qs[i].getYn_blank();

		arrId_q[i] = qs[i].getId_q();
		ex_order[i] = qs[i].getEx_order();

		if(arrId_qtype[i] == 1) {
			arrQtype[i] = "OX��";
		} else if(arrId_qtype[i] == 2) {
			arrQtype[i] = "������";
		} else if(arrId_qtype[i] == 3) {
			arrQtype[i] = "���� �����";
		} else if(arrId_qtype[i] == 4) {
			arrQtype[i] = "�ܴ���";
		} else if(arrId_qtype[i] == 5) {
			arrQtype[i] = "�����";
		}
		
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

		arrCA[i] = ExamPaper.getAnswerDisplay(arrId_valid_type[i], arrId_qtype[i], arrCacount[i], arrEx_order, correctAnswer, arrExlabel);

		//arrUserCA[i] = ExamPaper.getAnswerDisplay(id_valid_type, arrId_qtype[i], arrCacount[i], arrEx_order, arrAnswer[i], arrExlabel);

		if (arrId_qtype[i] == 5) {
			arrCA[i] = "";
		}

		if (arrId_qtype[i] == 5) { arrAnswer[i] = qs[i].getUserans(); }
		    arrUA[i] = QA.getAnswerDisplay(9, arrId_qtype[i], arrCacount[i], arrEx_order, arrAnswer[i], arrExlabel);
		
		// ����ǥ��
	    arrQuestionNo[i] = qs[i].getNr_q();
	    arrQuestion[i] = qs[i].getQ();

	    // ����ǥ��
	    if (arrId_qtype[i] <= 3) {
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
		  arrExplain[i] = qs[i].getExplain();
	    } else {
		  arrExplain[i] = "";
	    }

	    // ä��ǥ�� ����
	    if (arrOX[i].equalsIgnoreCase("O")) { // ����
		  arrOXP[i] = arrOX[i].toUpperCase();
		  arrPoint[i] = String.valueOf(arrAllot[i]);
	    } else if (arrOX[i].equalsIgnoreCase("X")) { // ����
		  arrOXP[i] = arrOX[i].toUpperCase();
		  arrPoint[i] = "0";	
	    } else if (arrOX[i].equalsIgnoreCase("P")) { // �κ�����
		  arrOXP[i] = "��";
		  arrPoint[i] = arrPoint[i];
	    } else {
		  arrOXP[i] = "";
		  arrPoint[i] = "";
	    }

	    if (arrPoint[i].length() == 0) arrPoint[i] = "";
 }
%>

<title>����� ����</title>

<link rel="StyleSheet" href="../../css/style.css" type="text/css">

<body>

	<table width="90%" cellpadding="0" cellspacing="0" border="0" align="center">
	
		<tr>
			<td>
				<br>
				<table border="0" cellpadding="0" cellspacing="0" id="tableD" WIDTH="100%">
					<tr>
						<td id="left" width="50%" colspan="2"><li>����� : </li><font color=green><b><%=title%></b></font></td>
						<td id="left" width="50%" colspan="2"><li>������⿩�� : </li><font color=green><b><%if(ans.getYn_end().equals("Y")) { %>������� �Ϸ�<% } else { %>������� �̿Ϸ�<% } %></b></font></td>
					</tr>
					<tr>
						<td width="25%" id="left"><li>������ ��ȣ : </li><font color=green><b><%=nr_set%></b></font></td>
						<td width="25%" id="left" ><li>������ : </li><font color=green><b><%=qcount%></b></font> ����</td>
						<td width="25%" id="left"><li>���� : </li><font color=green><b><%=totalAllot%></b></font> ��</td>
						<td width="25%" id="left"><li>������ : </li><font color=green><b><%=userid%></b></font></td>
					</tr>					
				</table>
				<table border="0" cellpadding="0" cellspacing="0" id="tableD" WIDTH="100%">					
					<tr>
						<td width="35%" id="left"><li>������۽ð� : </li><font color=green><b><%=ans.getStart_time().toString()%></b></font></td>
						<td width="35%" id="left" ><li>�������ð� : </li><font color=green><b><%=ans.getEnd_time().toString()%></b></font></td>
						<td width="30%" id="left"><li>����IP : </li><font color=green><b><%=ans.getUser_ip()%></b></font></td>
					</tr>					
				</table>
				<BR>
			</td>
		</tr>
		<tr>
			<td>
								
				<table border="0" width='100%'>
					<tr>
						<td>

							<% for(int i = 0; i < qcount; i++) { %>
							<table border="0" width="100%" >
								<tr>
									<td colspan="2" align="left" valign="top"><font color="#ooo"><b>&nbsp;<%=arrQuestionNo[i]%>.</b></font></td>
								</tr>								
								
								<tr>
									<td width="7%" valign="top">&nbsp;&nbsp;(����)</td>
									<td><font color="#B70000"><%= arrAllot[i] %></font></td>
								</tr>
								<tr>
									<td width="7%" valign="top">&nbsp;&nbsp;(���)</td>
									<td><font color="#B70000">
									<% 
										if(arrId_qtype[i] == 5) { 
											if(arrUA[i].trim().length() > 0) {
									%>
									�� ����
									<%
											} else {
									%>	
									�� ����
									<%
											}
										} else {
									%>										
										<%= arrUA[i] %>
									<% 
										} 
									%>
									</font></td>
								</tr>	
								
								<tr>
									<td colspan="2" height="5">&nbsp;</td>
								</tr>							
							</table>

							<% } %>

						</td>
					</tr>
				</table>
				<p>&nbsp;</p>
				<p>&nbsp;</p>
			</td>
		</tr>
	</table>
	
</body>
</html>
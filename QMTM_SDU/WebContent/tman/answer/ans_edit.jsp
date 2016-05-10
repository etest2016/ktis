<%
//******************************************************************************
//   ���α׷� : ans_edit.jsp
//   �� �� �� : ����� ����
//   ��    �� : ����� ����
//   �� �� �� : 
//   �ڹ����� : , qmtm.tman.answer.ExamAnswer
//   �� �� �� : 2008-05-21
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.common.*, qmtm.tman.answer.*, java.sql.*" %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");
		
	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }

	String userid = request.getParameter("userid");
	if (userid == null) { userid= ""; } else { userid = userid.trim(); }
	
	if (id_exam.length() == 0 || userid.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	ExamAnswerBean ans = null;

	try {
		ans = ExamAnswer.getBean(userid, id_exam);
	} catch (Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

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

	String[] arrYn_practice = new String[qcount];

	// �ʱ�ȭ
	String strChk = "";

	// looping

	for (int i = 0; i < qcount; i++)
	{
		if (arrAnswer[i] == null) { arrAnswer[i] = ""; }
		if (arrOX[i] == null) { arrOX[i] = ""; }
		if (arrPoint[i] == null) { arrPoint[i] = ""; }

		arrId_qtype[i] = qs[i].getId_qtype();
	    int id_valid_type = qs[i].getId_valid_type();
	    arrCacount[i] = qs[i].getCacount();
		int[] arrEx_order = qs[i].getArrEx_order();
		String correctAnswer = qs[i].getCa().trim();

		arrYn_caorder[i] = qs[i].getYn_caorder();
		arrYn_case[i] = qs[i].getYn_case();
		arrYn_blank[i] = qs[i].getYn_blank();

		arrYn_practice[i] = qs[i].getYn_practice();

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
			if(arrYn_practice[i].equals("Y")) {
				arrQtype[i] = "�Ǳ���";
			} else {
				arrQtype[i] = "�����";
			}
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

		arrCA[i] = ExamPaper.getAnswerDisplay(id_valid_type, arrId_qtype[i], arrCacount[i], arrEx_order, correctAnswer, arrExlabel);

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
	    } else if (arrOX[i].equalsIgnoreCase("X")) { // ����
		  arrOXP[i] = arrOX[i].toUpperCase();
	    } else if (arrOX[i].equalsIgnoreCase("P")) { // �κ�����
		  arrOXP[i] = "��";
	    } else {
		  arrOXP[i] = "";
	    }

	    if (arrPoint[i].length() == 0) arrPoint[i] = "";
 }
%>

<script language="JavaScript" type="text/javascript">
    <!--
    function SetScrollPos_Sample(tagDIV)
    {
        var positionTop = 0;
        if (tagDIV != null)
        {
            positionTop = parseInt(tagDIV.scrollTop, 10);
            document.getElementById("SAMPLE_TABLE").style.top = positionTop;
        }
    }

	// �޴����� ������ �����ֱ�..
	function movieLayout(obj) {
		if(obj == "answers") {
			document.all.id_answers_html.style.display = "block";
			document.all.id_papers_html.style.display = "none";
			document.all.id_answers.style.display = "block";
			document.all.id_papers.style.display = "none";
		} else if(obj == "papers") {
			document.all.id_answers_html.style.display = "none";
			document.all.id_papers_html.style.display = "block";
			document.all.id_answers.style.display = "none";
			document.all.id_papers.style.display = "block";
		}
	}

	function answers_html() {
		$.posterPopup("answers_type_html.jsp?id_exam=<%=id_exam%>&userid=<%=userid%>&nr_set=<%=nr_set%>","answers_preview","width=1, height=1, scrollbars=no");
	}

	function papers_html() {
		$.posterPopup("papers_type_html.jsp?id_exam=<%=id_exam%>&userid=<%=userid%>&nr_set=<%=nr_set%>","papers_preview","width=1, height=1, scrollbars=no");
	}

	function q_preview(id_q) {
		$.posterPopup("../../qman/question/q_preview.jsp?id_qs="+id_q,"preview_q","top=0, left=0, width=500, height=350, scrollbars=yes");
	}
	
    //-->
</script>
  <script type="text/javascript" src="../../js/jquery.js"></script>
  <script type="text/javascript" src="../../js/jquery.etest.poster.js"></script>
<link rel="StyleSheet" href="../../css/style.css" type="text/css">

<body id="popup">
 <TABLE width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
		<TR id="top">
			<TD id="left"></TD>
			<TD id="right"></TD>
		</TR>
		<TR id="main">
			<td id="left">

<form name="form1" method="post" action="ans_edit_ok.jsp">
<input type="hidden" name="id_exam" value="<%=id_exam%>">
<input type="hidden" name="userid" value="<%=userid%>">
<input type="hidden" name="nr_set" value="<%=nr_set%>">
<input type="hidden" name="qcount" value="<%=qcount%>">

<table border="0" width="95%" style="display:block;" id="id_answers_html">
	<tr height="30">
		<td align="left">&nbsp;<!--input type="button" value="HTML ����" onClick="javascript:answers_html();"--><a href="javascript:answers_html();"><img src="../../images/bt_paper_html_yj1.gif"></a>&nbsp;<input type="image" value="��� ����" name="submit" src="../../images/bt_ans_weiw_anssaveyj1.gif">&nbsp;&nbsp;<!--input type="button" value="������" onClick="window.close();"--><a href="javascript:window.close();"><img src="../../images/bt_ans_weiw_closeyj1.gif"></a></td>
	</tr>
</table>

<table border="0" width="95%" style="display:none;" id="id_papers_html">
	<tr height="30">
		<td align="left">&nbsp;<!--input type="button" value="HTML ����" onClick="javascript:papers_html();"--><a href="javascript:papers_html();"><img src="../../images/bt_paper_html_yj1.gif"></a>&nbsp;<!--input type="button" value="������" onClick="window.close();"--><a href="javascript:window.close();"><img src="../../images/bt_ans_weiw_closeyj1.gif"></a></td>
	</tr>
</table>

<table border="0" width="95%">
	<tr height="30">
		<td align="left">&nbsp;<!--input type="button" value="������ ���" onClick="movieLayout('answers')"--><a href="javascript:movieLayout('answers');"><img src="../../images/bt_asn_weiw_answersyj1.gif"></a>&nbsp;<!--input type="button" value="������ ������" onClick="movieLayout('papers')"--><a href="javascript:movieLayout('papers');"><img src="../../images/bt_asn_weiw_papersyj1.gif"></a></td>
	</tr>
</table>

<table border="0" width="95%" >
	<tr height="20">
		<td align="left"><font color="#ooo"><b>&nbsp;* ����� : <%=title%></b></font></td>
	</tr>
	<tr height="20">
		<td align="left">&nbsp;* ������ ��ȣ : <%=nr_set%></td>
	</tr>
	<tr height="20">
		<td align="left">&nbsp;* ������ : <%=qcount%> ����</td>
	</tr>
	<tr height="20">
		<td align="left">&nbsp;* ���� : <%=totalAllot%> ��</td>
	</tr>
	<tr height="20">
		<td align="left">&nbsp;* ������ : <%=userid%></td>
	</tr>
</table>
<br>
<table cellpadding="1" cellspacing="1" bgcolor="#CCCCCC" border=0 width='95%' style="display:block;" id="id_answers">
	<tr bgcolor="#DBDBDB" height="30" style="height: 29px; text-align: center; background-image: url(../../images/tablea_top3_exmake_yj1.gif);">
		<td align="center" width="5%">��ȣ</td>
		<td align="center" width="15%">����</td>
		<td align="center" width="32%">���</td>
		<td align="center" width="5%">OX</td>
		<td align="center" width="5%">����</td>
		<td align="center" width="5%">����</td>
		<td align="center" width="10%">��������</td>
		<!--<td align="center" width="8%">���̵�</td>-->
		<td align="center" width="8%">�����ڵ�</td>
		<td align="center" width="10%">����迭</td>
		<td align="center" width="5%">����</td>
	</tr>

	<% for(int i = 0; i < qcount; i++) { %>
	<tr bgcolor="#FFFFFF">
		<td align="center"><font color="#ooo"><%=arrQuestionNo[i]%></font></td>
		<td valign="top"><b>
		<% 
			if(arrId_qtype[i] <= 3) {
				for (int j = 0; j < arrExcount[i]; j++) {
					if(arrCacount[i] > 1) {
						for(int k = 0; k < arrCacount[i]; k++) {
							if(arrCA[i].substring(k,k+1).equals(arrExlabel[j])) {
								strChk = "checked";
							}
						}
		%>
			<input type="checkbox" <%=strChk%> disabled>
		<%
					strChk = "";
					} else {
		%>
			<input type="radio" <% if(arrCA[i].equals(arrExlabel[j])) { %> checked <% } %> disabled >
		<%
					}
				}
			} else if(arrId_qtype[i] == 4) {
		%>
			<%= arrCA[i] %><br><br><%if(arrCacount[i] > 1) {%>* ������� ���� : <%=arrYn_caorder[i]%><br><% } %>* ��ҹ��� ���� : <%=arrYn_case[i]%><br>* ��ĭ üũ : <%=arrYn_blank[i]%><br>
		<%
			} else if(arrId_qtype[i] == 5) {
				if(arrYn_practice[i].equals("Y")) {
		%>
					�Ǳ���
		<%
				} else {
		%>
					�����	
		<%
				}
			} 
		%>
		</b></td>
		<td valign="top">
		<% 
			if(arrId_qtype[i] <= 3) {
				for (int j = 0; j < arrExcount[i]; j++) {
					if(arrCacount[i] > 1) {
						strChk = "";
						String ans_imp = arrAnswer[i].replace(QmTm.OR_GUBUN,",");

						if(ans_imp.length() == 0) {
						} else {
							String[] arrAnswers = ans_imp.split(",",-1);

							for(int k = 0; k < arrAnswers.length; k++) {
								if(arrUA[i].substring(k,k+1).equals(arrExlabel[j])) {
									strChk = "checked";
								}
							}
						}
		%>
			<input type="checkbox" <%=strChk%> name="ans<%=i%>" value="<%=j+1%>">
		<%
					strChk = "";
					} else {
		%>
			<input type="radio" <% if(arrUA[i].equals(arrExlabel[j])) { %> checked <% } %> name="ans<%=i%>" value="<%=j+1%>">
		<%
					}
				}
			} else if(arrId_qtype[i] == 4) {
				String answer = "";
				if(arrCacount[i] == 1) {
		%>
			<input type="text" value="<%= arrUA[i] %>" name="ans<%=i%>">
		<%
				
				} else {
					answer = arrUA[i].replace("��","");
					String[] arrCas = answer.split("<br>", -1);

					for(int k = 0; k < arrCas.length-1; k++) {
		%>
			<input type="text" value="<%= arrCas[k] %>" name="ans<%=i%>"><br>
		<%
					}
				}
			} else if(arrId_qtype[i] == 5) {
		%>
			<textarea name="ans<%=i%>" cols="55" rows="15"><%= arrAnswer[i]%></textarea>
		<%
			} 
		%>
		</td>
		<td><%=arrOXP[i]%></td>
		<td><%=arrPoint[i]%></td>
		<td align="center"><a href="javascript:q_preview('<%=arrId_q[i]%>')">����</a></td>
		<td><%=arrQtype[i]%></td>
		<!--<td><%=arrDifficulty1[i]%></td>-->
		<td><%=arrId_q[i]%></td>
		<td><%=ex_order[i]%></td>
		<td><%=arrAllot[i]%></td>
	</tr>
	<% } %>
</table>

</form>

<table border=0 width='95%' style="display:none;" id="id_papers">
	<tr>
		<td>

<% for(int i = 0; i < qcount; i++) { %>
<table border="0" width="100%" >
	<tr>
		<td colspan="2" align="left" valign="top"><font color="#ooo"><b>&nbsp;<%=arrQuestionNo[i]%></b></font>&nbsp;&nbsp;&nbsp;<%=ComLib.htmlDel(arrQuestion[i])%></td>
	</tr>
	<tr>
		<td colspan="2" height="1">&nbsp;</td>
	</tr>
	<!-- ���� -->
    <% if (arrHasEx[i]) { %>
	    <% for (int j = 0; j < arrExcount[i]; j++) { %>
        <tr>
            <td colspan="2" valign="top">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%= arrEx[i][j] %></td>
        </tr>
		<% } %>
    <% } %>
	<tr>
		<td colspan="2" height="5">&nbsp;</td>
	</tr>
	<tr>
		<td width="10%" valign="top">&nbsp;&nbsp;(�����ڵ�)</td>
		<td><font color="#B70000"><%= arrId_q[i] %></font></td>
	</tr>
	<tr>
		<td width="10%" valign="top">&nbsp;&nbsp;(����)</td>		
		<td><font color="#B70000"><%= arrCA[i] %>
		<% 
			if(arrId_qtype[i] == 4) { 
		%>
		<br><br>
		<%
				if(arrCacount[i] > 1) {
		%>
		* ������� ���� : <%=arrYn_caorder[i]%><br>
		<% 
				} 
		%>
		* ��ҹ��� ���� : <%=arrYn_case[i]%><br>
		* ��ĭ üũ : <%=arrYn_blank[i]%>
		<%
			}
		%>
		</font></td>
	</tr>

	<tr>
		<td width="10%" valign="top">&nbsp;&nbsp;(����)</td>
		<td><font color="#B70000"><%= arrAllot[i] %></font></td>
	</tr>
	<tr>
		<td width="10%" valign="top">&nbsp;&nbsp;(���̵�)</td>
		<td><font color="#B70000"><%= arrDifficulty1[i] %></font></td>
	</tr>
	<tr>
		<td width="10%" valign="top">&nbsp;&nbsp;(���)</td>
		<td><font color="#B70000"><%= arrUA[i] %></font></td>
	</tr>
</table>
<br><br><br>

<% } %>

	</td>
	</tr>
</table>
</TD>
	<TD id="right"><a href="javascript:window.close();"><img src="../../images/bt_popup_close.gif"></a></TD>
		</TR>
	</TABLE>

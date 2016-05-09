<%
//******************************************************************************
//   ���α׷� : ans_view.jsp
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
		String correctAnswer = qs[i].getCa().trim();

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

	function movieLayout2(obj) {
		if(obj == "qs") {
			alert(obj);
			document.all.id_qs_code.style.display = "block";
		} else {
			document.all.id_qs_code.style.display = "none";
		}
	}

	function answers_html() {
		location.href="answers_type_html.jsp?id_exam=<%=id_exam%>&userid=<%=userid%>&nr_set=<%=nr_set%>";
	}

	function papers_html() {
		location.href="papers_type_html.jsp?id_exam=<%=id_exam%>&userid=<%=userid%>";
	}

	function q_preview(id_q) {
		window.open("../../qman/question/q_preview.jsp?id_qs="+id_q,"preview_q","top=0, left=0, width=400, height=250, scrollbars=yes");
	}

    //-->
</script>

<link rel="StyleSheet" href="../../css/style.css" type="text/css">

<body>

	<table width="90%" cellpadding="0" cellspacing="0" border="0" align="center">
	
		<tr ID="id_answers_html">
			<td align="right" height="40px;" valign="top">
				<img src="../../images/bt2_html.gif" onclick="javascript:answers_html();" style="cursor: hand;" onfocus="this.blur();">&nbsp;<a href="javascript:window.close();"><img src="../../images/bt2_close.gif"></a>
			</td>
		</tr>
		<tr id="id_papers_html" STYLE="display: none;">
			<td align="right" height="40px;" valign="top">
				<img src="../../images/bt2_html.gif" onclick="javascript:papers_html();" style="cursor: hand;" onfocus="this.blur();">&nbsp;<a href="javascript:window.close();"><img src="../../images/bt2_close.gif"></a>
			</td>
		</tr>
		<tr>
			<td>
				<a href="javascript:movieLayout('answers');"><img src="../../images/bt_asn_weiw_answersyj1.gif"></a>&nbsp;<a href="javascript:movieLayout('papers');"><img src="../../images/bt_asn_weiw_papersyj1.gif"></a>
			</td>
		</tr>
		<tr>
			<td>
				<br>
				<table border="0" cellpadding="0" cellspacing="0" id="tableD" WIDTH="100%">
					<tr>
						<td id="left" width="12%"><li>�����</td>
						<td colspan="7" width="88%"><%=title%></td>
					</tr>
					<tr>
						<td width="12%" id="left"><li>������ ��ȣ</td>
						<td width="12%"><%=nr_set%></td>
						<td width="12%" id="left"><li>������</td>
						<td width="12%"><%=qcount%> ����</td>
						<td width="12%" id="left"><li>����</td>
						<td width="14%"><%=totalAllot%> ��</td>
						<td width="12%" id="left">������</td>
						<td width="14%"><%=userid%></td>
					</tr>
				</table>
				<BR>
			</td>
		</tr>
		<tr>
			<td>
				
				<DIV ID="id_answers">
				<table border="0" cellpadding="0" cellspacing="0" id="tableA" >
					<tr id="tr">
						<td width="5%">��ȣ</td>
						<td width="15%">����</td>
						<td width="32%">���</td>
						<td width="5%">OX</td>
						<td width="5%">����</td>
						<td width="5%">����</td>
						<td width="10%">��������</td>
						<!--<td width="8%">���̵�</td>-->
						<td width="8%">�����ڵ�</td>
						<td width="10%">����迭</td>
						<td width="5%">����</td>
					</tr>

					<% for(int i = 0; i < qcount; i++) { %>
					<tr id="td2" align="center" <%if(i%2==1){%>bgcolor="#fafafa"<%}%>>
						<td><font color="#000"><%=arrQuestionNo[i]%></font></td>
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
						%>
							�����
						<%
							} 
						%>
						<br><b><font color="red"><%if(arrId_valid_type[i] == 1) { %>(���������� ó��)<% } else if(arrId_valid_type[i] == 2) { %>(������� ó��)<% } %></font></b></td>
						<td valign="top">
						<% 
							if(arrId_qtype[i] <= 3) {
								for (int j = 0; j < arrExcount[i]; j++) {
									if(arrCacount[i] > 1) {
										String ans_imp = arrAnswer[i].replace(QmTm.OR_GUBUN,",");

										if(ans_imp.length() == 0) {
											strChk = "";
										} else {
											String[] arrAnswers = ans_imp.split(",",-1);

											for(int k = 0; k < arrAnswers.length; k++) {
												if(arrUA[i].substring(k,k+1).equals(arrExlabel[j])) {
													strChk = "checked";
												}
											}
										}
						%>
							<input type="checkbox" <%=strChk%> name="ans<%=i%>" value="<%=j+1%>" disabled>
						<%
									strChk = "";
									} else {
						%>
							<input type="radio" <% if(arrUA[i].equals(arrExlabel[j])) { %> checked <% } %> name="ans<%=i%>" value="<%=j+1%>" disabled>
						<%
									}
								}
							} else if(arrId_qtype[i] == 4) {
								String answer = "";
								if(arrCacount[i] == 1) {
						%>
							<input type="text" class="input" value="<%= arrUA[i] %>" name="ans<%=i%>" disabled>
						<%
								
								} else {
									answer = arrUA[i].replace("��","");
									String[] arrCas = answer.split("<br>", -1);

									for(int k = 0; k < arrCas.length-1; k++) {
						%>
							<input type="text" class="input" value="<%= arrCas[k] %>" name="ans<%=i%>"><br>
						<%
									}
								}
							} else if(arrId_qtype[i] == 5) {
						%>
							<textarea name="ans<%=i%>" cols="55" rows="15"><%=arrAnswer[i]%></textarea>
						<%
							} 
						%>
						</td>
						<td>&nbsp;<%=arrOXP[i]%></td>
						<td>&nbsp;<%=arrPoint[i]%></td>
						<td align="center"><a href="javascript:q_preview('<%=arrId_q[i]%>')">����</a></td>
						<td><%=arrQtype[i]%></td>
						<!--<td><%=arrDifficulty1[i]%></td>-->
						<td><%=arrId_q[i]%></td>
						<td>&nbsp;<%=ex_order[i]%></td>
						<td><%=arrAllot[i]%></td>
					</tr>

					<% } %>
				</table>
				</DIV>

				<table border="0" width='100%' style="display:none;" id="id_papers">
					<tr>
						<td>

							<% for(int i = 0; i < qcount; i++) { %>
							<table border="0" width="100%" >
								<tr>
									<td colspan="2" align="left" valign="top"><font color="#ooo"><b>&nbsp;<%=arrQuestionNo[i]%></b></font>&nbsp;&nbsp;&nbsp;<%=arrQuestion[i]%></td>
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
								<tr>
									<td width="10%" valign="top">&nbsp;&nbsp;(����)</td>
									<td><font color="#B70000"><%= arrPoint[i] %></font></td>
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
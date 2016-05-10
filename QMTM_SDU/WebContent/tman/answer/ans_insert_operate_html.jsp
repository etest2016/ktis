<%
//******************************************************************************
//   ���α׷� : ans_insert_operate_html.jsp
//   �� �� �� : ����� �߰� HTML ����
//   ��    �� : ����� �߰� HTML ����
//   �� �� �� : 
//   �ڹ����� : qmtm.tman.answer.ExamUtil
//   �� �� �� : 2008-06-19
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.common.*, java.sql.*" %>
<%@ include file = "/common/login_chk.jsp" %>
<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");
	
	response.setHeader("Content-Disposition", "attachment; filename=ExamPaperAdd.htm"); 
    response.setHeader("Content-Description", "JSP Generated Data");

	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }

	String userid = request.getParameter("userid");
	if (userid == null) { userid = ""; } else { userid = userid.trim(); }

	String yn_end = request.getParameter("yn_end");
	if (yn_end == null) { yn_end = ""; } else { yn_end = yn_end.trim(); }
	
	if (id_exam.length() == 0 || userid.length() == 0 || yn_end.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}

	String nr_set = request.getParameter("nr_set");
	if (nr_set == null) { nr_set= "1"; } else { nr_set = nr_set.trim(); }

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
		qs = ExamPaper.getBeans(id_exam, Integer.parseInt(nr_set));
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
%>

<%
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
	
	String[] arrExplain = new String[qcount];      // �ؼ�

	String[] arrQtype = new String[qcount]; // ��������

	String[] ex_order = new String[qcount];

	int[] arrCacount = new int[qcount]; // ���� ����

	String[] arrYn_caorder = new String[qcount];
	String[] arrYn_case = new String[qcount];
	String[] arrYn_blank = new String[qcount];

	// �ʱ�ȭ
	String strChk = "";

	// looping

	for (int i = 0; i < qcount; i++)
	{
		arrId_qtype[i] = qs[i].getId_qtype();
	    int id_valid_type = qs[i].getId_valid_type();
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

		arrCA[i] = ExamPaper.getAnswerDisplay(id_valid_type, arrId_qtype[i], arrCacount[i], arrEx_order, correctAnswer, arrExlabel);

		if (arrId_qtype[i] == 5) {
			arrCA[i] = "";
		}

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
	}
%>

<html>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">

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
	
    //-->
</script>

<link rel="StyleSheet" href="../../css/style.css" type="text/css">

<BODY id="tman">


<table border="0" width="950" >
	<tr height="20">
		<td align="left">&nbsp;* ����� : <%=title%></td>
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
</table>

<div id="SAMPLE_DIV" style="width: 950px; height: 500px; overflow-y: auto;" onScroll="SetScrollPos_Sample(this);">

<table cellpadding="1" cellspacing="1" bgcolor="#CCCCCC" id="SAMPLE_TABLE" border=0 style="position: absolute; left: 0px; top: 0px; z-index: 0;" width='950'>
	<tr bgcolor="#DBDBDB" height="30">
		<td align="center" width="5%">��ȣ</td>
		<td align="center" width="23%">����</td>
		<td align="center" width="26%">���</td>
		<td align="center" width="5%">����</td>
		<td align="center" width="10%">��������</td>
		<td align="center" width="8%">���̵�</td>
		<td align="center" width="8%">�����ڵ�</td>
		<td align="center" width="10%">����迭</td>
		<td align="center" width="5%">����</td>
	</tr>
</table>

<table cellpadding="1" cellspacing="1" bgcolor="#CCCCCC" border=0 width='950'>
	<tr bgcolor="#DBDBDB" height="30">
		<td align="center" width="5%">��ȣ</td>
		<td align="center" width="23%">����</td>
		<td align="center" width="26%">���</td>
		<td align="center" width="5%">����</td>
		<td align="center" width="10%">��������</td>
		<td align="center" width="8%">���̵�</td>
		<td align="center" width="8%">�����ڵ�</td>
		<td align="center" width="10%">����迭</td>
		<td align="center" width="5%">����</td>
	</tr>

	<% for(int i = 0; i < qcount; i++) { %>
	<tr bgcolor="#FFFFFF">
		<td align="center"><%=arrQuestionNo[i]%></td>
		<td valign="top">
		<%
			strChk = "";
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
		</td>
		<td valign="top">
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
			<input type="checkbox" <%=strChk%> name="ans<%=i%>" value="<%=j+1%>">
		<%
					strChk = "";
					} else {
		%>
			<input type="radio" <% if(arrCA[i].equals(arrExlabel[j])) { %> checked <% } %> name="ans<%=i%>" value="<%=j+1%>">
		<%
					}
				}
			} else if(arrId_qtype[i] == 4) {
				String answer = "";
				if(arrCacount[i] == 1) {
		%>
			<input type="text" class="input" value="<%= arrCA[i] %>" name="ans<%=i%>">
		<%
				
				} else {
					answer = arrCA[i].replace("��","");
					String[] arrCas = answer.split("<br>", -1);

					for(int k = 0; k < arrCas.length-1; k++) {
		%>
			<input type="text" class="input" value="<%= arrCas[k] %>" name="ans<%=i%>"><br>
		<%
					}
				}
			} else if(arrId_qtype[i] == 5) {
		%>
			<textarea name="ans<%=i%>" cols="10" rows="10"></textarea>
		<%
			} 
		%>
		</td>
		<td>����</td>
		<td><%=arrQtype[i]%></td>
		<td><%=arrDifficulty1[i]%></td>
		<td><%=arrId_q[i]%></td>
		<td><%=ex_order[i]%></td>
		<td><%=arrAllot[i]%></td>
	</tr>
	<% } %>
</table>
<p>

</form>

</body>

</html>
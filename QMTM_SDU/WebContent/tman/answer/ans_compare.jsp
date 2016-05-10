<%
//******************************************************************************
//   ���α׷� : ans_all_score.jsp
//   �� �� �� : ��� ������ ���ä��
//   ��    �� : ��� ������ ���ä��
//   �� �� �� : 
//   �ڹ����� : qmtm.tman.answer.ExamAnswer, qmtm.tman.answer.ExamAnswerNon
//   �� �� �� : 2008-05-27
//   �� �� �� : ���׽�Ʈ ����ȣ
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.common.*, qmtm.tman.answer.*, java.sql.*, java.util.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");
	
	int nr_count = Integer.parseInt(request.getParameter("nr_count"));
	String id_exam = request.getParameter("id_exam");
	if (id_exam == null) { id_exam= ""; } else { id_exam = id_exam.trim(); }

	if (id_exam.length() == 0) {
		out.println(ComLib.getParameterChk("back"));

	    if(true) return;
	}
	
	ExamAnswerBean[] rst = null;

	try {
		rst = ExamAnswer.getBeans(id_exam, "Y");
	} catch(Exception ex) {
		out.println(ComLib.getExceptionMsg(ex, "back"));

		if(true) return;
	}
	
	
		
%>

<%!
public static double setScoreOxs(ExamAnswerBean bean, int nr_set) throws QmTmException {
	if (bean.getAnswers() == null || bean.getAnswers().length() == 0) { // ��繮���� ������� ��츦 ����Ѵ�
		ExamInfoBean info = ExamInfo.getBean(bean.getId_exam());
		String[] arrAnswer = new String[info.getQcount()]; // ������ ��������ŭ �迭����
		for (int i = 0; i < arrAnswer.length; i++) {
			arrAnswer[i] = "";
		}
		String answers = QmTm.join(arrAnswer, QmTm.Q_GUBUN); // �� ���� ��� �����ϱ� ���ؼ� ������Ȼ��̿� ������ �߰�
		bean.setAnswers(answers);
	}

	Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; 
	StringBuffer sql = new StringBuffer();

	sql.append("SELECT p.nr_q, p.allotting, ");
	sql.append("       q.id_qtype, q.ca, q.yn_caorder, q.yn_case, q.yn_blank, q.id_valid_type ");
	sql.append("  FROM exam_paper2 p, q ");
	sql.append("WHERE p.id_exam = ? AND p.nr_set = ? AND p.id_q = q.id_q ");

	try {
		// �������

		String[] arrAnswer = bean.getAnswers().split(QmTm.Q_GUBUN_re, -1);
		int qcount = arrAnswer.length;
		String[] arrOX = new String[qcount];
		String[] arrPoint = new String[qcount];

		if (bean.getOxs().length() > 0) {
            arrOX = bean.getOxs().split(QmTm.Q_GUBUN_re, -1);
        } else {
            for (int i = 0; i < qcount; i++) {
                arrOX[i] = "";
            }
        }

		if (bean.getPoints().length() > 0) {                
            arrPoint = bean.getPoints().split(QmTm.Q_GUBUN_re, -1);
        } else {
            for (int i = 0; i < qcount; i++) {
                arrPoint[i] = "";
            }
        }

		double score = 0; //�ش� ���迡 ���ؼ� ȹ���� ����

		cnn = DBPool.getConnection();
		stm = cnn.prepareStatement(sql.toString());
		stm.setString(1, bean.getId_exam());
		stm.setInt(2, nr_set);
		rst = stm.executeQuery();

		while (rst.next()) // ������
		{
			// �ʱ�ȭ
			double pointRate = -1; // 0 = Ʋ������, 1 = ��������, 0.01~0.99 = �κ������� �������� (ynPart = Y, Qtype = 3)
			double point = 0; // ����
			String OX = ""; // X = Ʋ������, O = ��������, P = �κ������� ��������

			// from DB

			int nr_q = rst.getInt("nr_q");
			int ndx = nr_q - 1;
			double allot = rst.getDouble("allotting");
			int id_qtype = rst.getInt("id_qtype");
			int id_valid_type = rst.getInt("id_valid_type");
			String yn_caorder = rst.getString("yn_caorder");
			String yn_case = rst.getString("yn_case");
			String yn_blank = rst.getString("yn_blank");

			String ca = rst.getString("ca");
			if (ca == null) {
				ca = "";
			} else {
				ca = ca.trim();
			}

			// ä��

			String userAnswer = arrAnswer[ndx].trim(); // ������

			if (id_valid_type == 2) // 2 : ��� ���� ó��
			{
				pointRate = 1;
			} else // 0 : ������, 1 : �ٸ����⵵ ���� (�Ѵ� ����ó��)
			{
				if (arrAnswer[ndx].length() > 0) // ���� ������
				{
					if (id_qtype == 1) // OX��
					{
						if (userAnswer.equals(ca)) {
							pointRate = 1;
						} else {
							pointRate = 0;
						}
					} else if (id_qtype == 2) // ������
					{
						if (id_valid_type == 0) // ������
						{
							if (userAnswer.equals(ca)) {
								pointRate = 1;
							} else {
								pointRate = 0;
							}
						} else // 1 : �Ѵ� ����
						{
							if (ca.indexOf(userAnswer) >= 0) {
								pointRate = 1;
							} else {
								pointRate = 0;
							}
						}
					} else if (id_qtype == 3) // ��������
					{
						pointRate = scoringType3(ca, userAnswer);

						if (DBPool.PART_POINT == false) // �κ����� ���� ����
						{
							if (pointRate < 1) {
								pointRate = 0;
							}
						}
					} else if (id_qtype == 4) // �ܴ���
					{
						/*
						 ����� �κ����� ������� ����.(����ä������ �κ������� �� �� ����)
						 ����ä���� ��ä���ϸ� ����ä���� ���õǹǷ� ��Ȳ�� ����
						 ��ä���� ��󿡼� ����(��ü or Ư������) �� �� �ִ� ���� ���鵵�� ...
						*/
                        if(arrPoint[ndx].length() > 0) {
						   pointRate = -1;
					    } else {					   
                           if (scoringAns2(ca, userAnswer, yn_caorder, yn_blank, yn_case)) {
	                           pointRate = 1;
		                   } else {
			                   pointRate = 0;
				           }
					    }

					} else // 5 : �����
					{
						pointRate = -1;
					}

				} else // ���� ������ (����� or Ǯ�� ���� ���)
				{
					if (id_qtype == 5) { // �����
						pointRate = -1;
					} else { // ������� �ƴϸ�
						pointRate = 0;
					}
				}

			} // end of id_valid_type = 0 and 1

			if (pointRate < 0) // ä����󿡼� ���ܵǴ� ���� : �����, ����ä������� �����ϴ� Ư���� ������ ���� ��
			{
				if (arrPoint[ndx].length() > 0) {
					point = Double.parseDouble(arrPoint[ndx]);
				} // ��������
				else {
					point = 0;
				}
				if (arrOX[ndx].length() > 0) {
					OX = arrOX[ndx];
				} // ���� OX
				else {
					OX = "X";
				}
			} else // pointRate : 0 ~ 1
			{
				point = Math.round(allot * pointRate * 10) / 10.0D; // �Ҽ��� �Ʒ� ���ڸ���					
				
				if (pointRate == 1) {
					OX = "O";
				} else if (pointRate == 0) {
					OX = "X";
				} else {
					OX = "P";
				}
				arrOX[ndx] = OX;
				
			}
					
			score += point; // ��������
			
		} // end of while rst.next()
		
		return score;
					
	} catch (SQLException ex) {
		throw new QmTmException("������ ����� ä���� �����ϴ� �� ������ �߻��Ǿ����ϴ�. [ExamAnswer.setScoreOxs] " + ex.getMessage());
	} finally {
		if (rst != null) try { rst.close(); } catch (SQLException ex) { }
		if (stm != null)	try {	stm.close();	} catch (SQLException ex) {}
		if (cnn != null)	try {	cnn.close();	} catch (SQLException ex) {}
	}
}

private static double scoringType3(String correctAnswer, String userAnswer) {
	/*
	 �κ������� ����� ������������ ä�� (id_qtype == 3)
	 ���ϰ� : 0 = Ʋ��(O), 1 = ����(X), 0.0001 ~ 0.9999 = �κ������� ����(P)
	 */

	if (correctAnswer.trim().length() == 0) // ������ �־����� ����
	{
		return 1.0;
	}
	if (userAnswer.trim().length() == 0) // ����� �������� ����
	{
		return 0.0;
	}
	String[] arrCA = correctAnswer.split(QmTm.OR_GUBUN_re, -1);
	String[] arrUA = userAnswer.split(QmTm.OR_GUBUN_re, -1);

	if (arrCA.length < arrUA.length) // ������� �ʰ��Ͽ� ���� ������ ��� 0 �� ó��
	{
		return 0.0;
	}

	int cnt = 0; // ���������

	for (int i = 0; i < arrCA.length; i++) {
		String ca = arrCA[i];

		for (int j = 0; j < arrUA.length; j++) {
			String ua = arrUA[j];
			if (ca.equals(ua)) {
				cnt++;
				break;
			}
		}
	}

	int caCnt = arrCA.length; // �����
	double pointRate = 1.0D * cnt / caCnt;
	return pointRate;
}

private static boolean scoringAns2(String correctAnswer, String userAnswer,
		String yn_caorder, String yn_blank, String yn_case) {
	// �ܴ����� ä�� (id_qtype == 4) : �κ����� ��� ����

	if (correctAnswer.trim().length() == 0) // ������ �־����� ����
	{
		return true;
	}
	if (userAnswer.trim().length() == 0) // ����� �������� ����
	{
		return false;
	}

	if (yn_blank.equalsIgnoreCase("N")) { // ���鹫�� --> ��������
		correctAnswer = correctAnswer.replaceAll(" ", "");
		userAnswer = userAnswer.replaceAll(" ", "");
	}
	if (yn_case.equalsIgnoreCase("N")) { // ��ҹ��� �������� --> �ҹ��ڷ�
		correctAnswer = correctAnswer.toLowerCase();
		userAnswer = userAnswer.toLowerCase();
	}

	String[] arrCA = correctAnswer.split(QmTm.OR_GUBUN_re, -1);
	String[] arrUA = userAnswer.split(QmTm.OR_GUBUN_re, -1);
	boolean[] arrCheck = new boolean[arrCA.length];

	if (arrCA.length != arrUA.length) { // ������� �������� Ʋ����
		return false;
	}

	if (yn_caorder.equalsIgnoreCase("Y")) // ���� ������ ��ġ�ؾ� �ϴ� ���
	{
		for (int i = 0; i < arrCA.length; i++) {
			arrCheck[i] = false;
			String[] arrSubCA = arrCA[i].split(QmTm.LIKE_GUBUN_re, -1);

			for (int j = 0; j < arrSubCA.length; j++) {
				if (arrUA[i].equals(arrSubCA[j])) {
					arrCheck[i] = true;
					break;
				}
			}
		}

		boolean retval = true;
		for (int i = 0; i < arrCheck.length; i++) {
			if (arrCheck[i] == false) {
				retval = false;
				break;
			}
		}
		return retval;
	} else { // ���� ������ �����ϴ� ���
		return compareAns2(arrCA, arrUA);
	}
}

private static boolean compareAns2(String[] arrCorrectAnswer,
		String[] arrUserAnswer) {
	/*
	 Dim m, n, t
	 Dim iSize
	 Dim iResult
	 Dim sTempCA
	 Dim iSum1, iSum2
	 */

	int size = arrCorrectAnswer.length;
	int[][] result = new int[size][size];

	// Initialize values with -1
	for (int i = 0; i < size; i++) {
		for (int j = 0; j < size; j++) {
			result[i][j] = -1;
		}
	}

	for (int i = 0; i < size; i++) {
		for (int j = 0; j < size; j++) {
			String[] arrTempCA = arrCorrectAnswer[j]
					.split(QmTm.LIKE_GUBUN_re);
			for (int k = 0; k < arrTempCA.length; k++) {
				if (arrUserAnswer[i].equals(arrTempCA[k])) {
					result[i][j] = j; // ����� �߰ߵ� ��ġ�� ����
					break;
				}
			}
		}
	}

	/*
	 A^B A^B C^D
	 -------------------
	 A  0   1  -1   (01)
	 C -1  -1   2   (2)
	 D -1  -1   2   (2)
	 -------------------
	 */

	for (int i = 0; i < size; i++) {
		int sum1 = 0;
		int sum2 = 0;

		for (int j = 0; j < size; j++) {
			sum1 += result[i][j];
			sum2 += result[j][i];
		}

		if (sum1 == -(size + 1) || sum2 == -(size + 1)) {
			return false;
		}
	}

	/*
	 A^B A^B C^D
	 -------------------
	 A  0   1  -1   (01)
	 C -1  -1   2   (2)
	 D -1  -1   2   (2)
	 -------------------
	 */

	String[] arrPosUA = new String[size];

	for (int i = 0; i < size; i++) {
		String tmp = "";

		for (int j = 0; j < size; j++) {
			if (result[i][j] != -1) {
				tmp += result[i][j]; // (01), (2), (2)�� ����
			}
		}
		arrPosUA[i] = tmp;
	}

	for (int i = 0; i < size; i++) {
		for (int j = 0; j < size; j++) {
			if (arrPosUA[j].length() == 1) {
				for (int k = 0; k < size; k++) {
					if (k != j) {
						arrPosUA[k] = arrPosUA[k].replaceAll(arrPosUA[j],"");
						if (arrPosUA[k].equals("")) {
							return false;
						}
					}
				}
			} else if (arrPosUA[j].length() == 0) {
				return false;
			}
		}
	}
	return true;
}
	
%>

<html>

<head>

<title>��� ������ ä������</title>

</head>
<!-- ��������ٰ� ��ġ�� HTMl�ҽ� -->

<BODY id="tman">
<table border=1>
<%	
	double user_score = 0;
	double max_score = -1;
	int max_nr_set = -1;
	List<String> list_str_update = new ArrayList();

	for(int i=0; i<rst.length; i++) {		
		max_score = -1;
		max_nr_set = -1;
%>
				<tr>
					<td colspan="2" bgcolor="#CCCCCC"><%=rst[i].getUserid()%></td>
				</tr>
<%
		for(int j=1; j < nr_count+1; j++) {
		
			try {
				user_score = setScoreOxs(rst[i], j);

			} catch(Exception ex) {
				out.println(ComLib.getExceptionMsg(ex, "back"));
		
				if(true) return;
			}
			
			if (user_score > max_score) {
				max_score = user_score;
				max_nr_set = j;
			}
%>										
				<tr>
					<td><%=j%>������������</td><td><%=user_score%></td>					
				</tr>
						
<%			
		}
%>
	<tr style="background-color:#ccffff;">
		<td>���̵� -- �ְ����� �� ������������ȣ <br>(��������� - ������� ��������ȣ) </td>
		<td><%=rst[i].getUserid()%> <%= max_score %> <%=max_nr_set %> <br>(<%=rst[i].getScore() %> - <%=rst[i].getNr_set() %>)</td>
	</tr>
<% 	
	String temp_update_str = "update exam_ans set nr_set = '" + max_nr_set + "' where id_exam='" + id_exam + "' and userid = '" + rst[i].getUserid() + "'";
	list_str_update.add(temp_update_str);
	}
%>

</table>
</body>
</html>
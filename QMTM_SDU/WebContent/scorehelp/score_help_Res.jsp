<%
//******************************************************************************
//   ���α׷� : score_help_Res.jsp
//   �� �� �� : ����� ä�������
//   ��    �� : ����� ���� ä�� ������
//   �� �� �� : 
//   �ڹ����� : 
//   �� �� �� : 2009-01-23
//   �� �� �� : ���׽�Ʈ ������
//   �� �� �� : 
//   �� �� �� : 
//	 �������� : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.common.*, etest.scorehelp.*, java.sql.*, java.util.*, java.util.regex.* " %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");
%>

<%!
	private String ClearRepeat(String str) {
		
		String sResult = "";
		
		str = str.toLowerCase();

		TreeSet tset = new TreeSet();
	    String[] tokens = str.split(" ");
		for(int i = 0; i < tokens.length; i++) {
           tset.add(tokens[i]);
		}
  
		Iterator itor = tset.iterator();

		while(itor.hasNext()) {
		   sResult = sResult + " " + itor.next();
		}

		return sResult;
	}
%>

<%
	/*
	Function ClearRepeat(ByVal str)
		Dim sResult
		Dim sSource : sSource = str
		Dim sAdd()
		Dim i, j, iPos, bIsInDic
		Dim gubun_word
		ReDim sAdd(0)

		sSource = LCase(sSource)

		arrUserans = Split(sSource, " ")
		
		For i = 0 To UBound(arrUserans)
			'If Len(arrUserans(i)) > 2 then
				iPos = InStr(sSource, arrUserans(i))
			If iPos Then
				For j = 0 To UBound(sAdd)
					If arrUserans(i) = sAdd(j) Then
						bIsInDic = True
						Exit For
					End If
				Next
				If Not bIsInDic Then
					ReDim Preserve sAdd(i)
					sAdd(i) = arrUserans(i)
				End If
				bIsInDic = False
			Else
				ReDim Preserve sAdd(i)
				sAdd(i) = arrUserans(i)
			'End If
			End if
		Next

		sResult = ""

		For i = 0 To UBound(sAdd)
			sResult = sResult + " " + sAdd(i)
		Next

		ClearRepeat = sResult
	End Function
  
  Function RegExpExec(Patrn, TestStr)
  
    Dim ObjRegExp

    On Error Resume Next    
    
    Set ObjRegExp = New RegExp
    
    ObjRegExp.Pattern = Patrn               '** ���� ǥ���� ����
    ObjRegExp.Global = True                 '** ���ڿ� ��ü�� �˻���
    ObjRegExp.IgnoreCase = True             '** ��.�ҹ��� ���� ����
    
    Set RegExpExec = ObjRegExp.Execute(TestStr)
    
    Set ObjRegExp = Nothing
    
  End Function

  Public Function Clearblank(ByVal ans)
	  ans_results = ""
	  For x = 0 To UBound(ans)			
		If Len(ans(x)) <> 0 Then			
			ans_results = ans_results +" "+Trim(ans(x)) 					
		End if
	  Next
	  Clearblank = ans_results
	End Function
  */
%>


<%	
	String adm_userid = (String)session.getAttribute("userid"); // ����� ���̵�
	//������
	if(adm_userid==null){
		adm_userid = "qmtm";
	}
	String id_exam = request.getParameter("id_exam");
	String id_q = request.getParameter("id_q");
	
	// Ű�ֵ� ���ý� : 1
	// ������ ���ý� : 2

	// Ű���� �Ǵ� ������, �Ѵ� �������� ��� "Ű�ֵ�"�� �˻�
	String cb = request.getParameter("compare_bigo");
	
	int comp_bigo = 0;
	String search_string = "";

	// ��� �� ���� üũ
    if (cb.equals("1")){
		comp_bigo = 1;
		search_string = request.getParameter("search_ans_result");
		//�˻�� 2�� �̻��϶� �����̽��� �����Ѵ�
		search_string = search_string.replace("\r\n", " ");
		//search_string = replace(search_string, chr(13)&chr(10), " ");
	} else if (cb.equals("2")){
		comp_bigo = 2;
		search_string = request.getParameter("basic_ans");
	}

	search_string = search_string.replace("\"","");
	
	try {
		Score_AnsNon.DelBasicans(id_exam, id_q, comp_bigo);
	} catch(Exception ex) {
		//response.sendRedirect("/error/db_error.jsp?err_msg="+ex.getMessage());
		out.println(ex.getMessage());
		if(true) return;
	}

	try {
		Score_AnsNon.InsBasicans(id_exam, id_q, comp_bigo, search_string, adm_userid);
	} catch(Exception ex) {
		//response.sendRedirect("/error/db_error.jsp?err_msg="+ex.getMessage());
		out.println(ex.getMessage());
		if(true) return;
	}
	
			
	String userans_Res = "";

	search_string = search_string.replace(")","");
	search_string = search_string.replace("&lt","<");
	search_string = search_string.replace("&gt",">");
	search_string = search_string.replace("(","");
	search_string = search_string.replace(",","");
	search_string = search_string.replace(".","");
	search_string = search_string.replace("*","");
	search_string = search_string.replace("[","");
	search_string = search_string.replace("\"","");
	
	search_string = search_string.trim();

	//�˻�� �����̽����� �˻� �ϵ��� �迭�� �����
	String[] arrSearch;
	arrSearch = search_string.split(" ");

	Score_AnsNonBean[] rst = null;

	try {
		rst = Score_AnsNon.getAnswers(id_exam, id_q);
	} catch(Exception ex) {
		out.println(ex.getMessage());
		//response.sendRedirect("/error/db_error.jsp?err_msg="+ex.getMessage());
		if(true) return;
	}

	//������
	for (int i=0; i<rst.length; i++){
		String userans_Res2 = "";
		String userans2 = rst[i].getUserans1().trim() + rst[i].getUserans2().trim() + rst[i].getUserans3().trim();

		userans2 = userans2.replace(")"," ");
		userans2 = userans2.replace("&lt","<");
		userans2 = userans2.replace("&gt",">");
		userans2 = userans2.replace(","," ");
		userans2 = userans2.replace("."," ");
		userans2 = userans2.replace("*"," ");
		userans2 = userans2.replace("["," ");
		userans2 = userans2.replace("\"","");
		
		String[] arrUserans2 = userans2.split(" ");

		for (int j=0; j<arrUserans2.length; j++){
			userans_Res2 = userans_Res2 + arrUserans2[j].trim() + " ";
		}

		String[] u_counts = userans_Res2.split(" ");

		String[] arr_Res_view = new String[u_counts.length];

		for(int x = 0; x < u_counts.length; x++) {
			arr_Res_view[x] = u_counts[x];
		}
		
		String[] arrUserans_Res2 = userans_Res2.split(" ");

		//out.println(userans2);
		//out.println("<BR><BR>");

		Pattern pt = null;
		Matcher mt = null;
	
		int equal_cnt = 0;
		String results = "";

		for (int p=0; p<arrSearch.length; p++) {
            pt = Pattern.compile(arrSearch[p]);

            for(int q=0; q < arr_Res_view.length; q++) {

				mt = pt.matcher(arr_Res_view[q]);

                if(mt.find()) {
					results = results + arrSearch[p] + " ";
					equal_cnt = equal_cnt + 1;	
					break;
                }
            }
		}

		/*
		out.println("��� : " + results);
		out.println("<BR>");
		out.println("<BR>");
		out.println("���� : " + equal_cnt);
		out.println("<BR>");
		out.println("<BR>");
		*/

		String[] counts = search_string.split(" ");
		String[] counts2 = userans_Res2.split(" ");

		/*
		out.println("�˻��� : " + search_string);
		out.println("<BR>");
		out.println("<BR>");
		out.println("�˻��� ���� : " + counts.length);
		out.println("<BR>");
		out.println("<BR>");
		out.println("��� ���� : " + counts2.length);
		out.println("<BR>");
		out.println("<BR>");
		*/

		double res1 = ((double)equal_cnt / (double)counts.length) * 100.0;
	
		if(res1 > 100.0) {
			res1 = 100.0;
		}
		
		if(res1 < 0.0) {
			res1 = 0.0;
		}
						
		double res2 = ((double)equal_cnt / (double)counts2.length) * 100.0;

		if(res2 > 100.0) {
			res2 = 100.0;
		}
		
		if(res2 < 0.0) {
			res2 = 0.0;
		}

		//out.println(ComLib.numToStr(res1));
		//out.println("<BR>");
		//out.println(ComLib.numToStr(res2));
		//out.println("<BR>");
		//out.println("<BR>");

	
		//�˻���: counts
		//������ ���: counts2
		//�˻���� ��ġ�ϴ� �ܾ� ��: equal_cnt
		//Ű���� ������: search_result_rate
		//������ ������: ans_result_rate
		//������ ��ȱ���: userid_ans_len Len
		
		String userid = rst[i].getUserid();

		int cnt_yn = 0;

		try {
			cnt_yn = Score_AnsNon.getRcnt(id_exam, id_q, userid);
		} catch(Exception ex) {
			out.println(ex.getMessage());
			//response.sendRedirect("/error/db_error.jsp?err_msg="+ex.getMessage());
			if(true) return;
		}

		//Thread.sleep(1000);
		
		//out.println(cnt_yn);
		//out.println("<br>");
		//out.println(comp_bigo);
		//out.println("<br>");
		//out.println("<br>");

		int basic_ans_len = 0;
		int userid_ans_len = 0;

		//out.println("Step2." + Integer.toString(cnt_yn));
		
		if(cnt_yn==0){
			if (comp_bigo==1){
				
				
				results = ClearRepeat(results);
				String results2 = "";
				String[] result_cnt = (results.trim()).split(" ");
				
				for (int zz=0; zz<result_cnt.length; zz++){
					if (result_cnt[zz].length()!=0){
						results2 = results2 + result_cnt[zz].trim() + " ";
					}
				}
				
				String[] result_cnts = results2.split(" ");
				int result_cnts2 = 0;

				if (equal_cnt != 0){
					result_cnts2 = result_cnts.length;
				}
				
				String[] counts_1 = search_string.split(" ");

				double search_cnt = ((double)result_cnts2 / (double)counts_1.length) * 100.0;
				
				try {
					Score_AnsNon.InsSresult(userid, id_exam, id_q, search_cnt, result_cnts2);
				} catch(Exception ex) {
					//response.sendRedirect("/error/db_error.jsp?err_msg="+ex.getMessage());
					out.println(ex.getMessage());
					if(true) return;
				}
				
				

			}else{
				
				basic_ans_len = search_string.length();
				userid_ans_len = userans_Res2.trim().length();				

				try {
					Score_AnsNon.InsAresult(userid, id_exam, id_q, res1, res2, basic_ans_len, userid_ans_len);
				} catch(Exception ex) {
					//response.sendRedirect("/error/db_error.jsp?err_msg="+ex.getMessage());
					//out.println(ex.getMessage());
					out.println(ex.getMessage());
					if(true) return;
				}
				
			}
		}else {
		
			if (comp_bigo==1){
				
				results = ClearRepeat(results);

				String results2 = "";
				String[] result_cnt = (results.trim()).split(" ");
				
				for (int xx=0; xx<result_cnt.length; xx++){
					if (result_cnt[xx].length()!=0){
						results2 = results2 + result_cnt[xx].trim() + " ";
					}
				}

				String[] result_cnts = results2.split(" ");
				int result_cnts2 = 0;

				if (equal_cnt != 0){
					result_cnts2 = result_cnts.length;
				}
				
				String[] counts_1 = search_string.split(" ");

				double search_cnt = ((double)result_cnts2 / (double)counts_1.length) * 100.0;
				
				try {
					Score_AnsNon.UpSresult(userid, id_exam, id_q, search_cnt, result_cnts2);
				} catch(Exception ex) {
					//response.sendRedirect("/error/db_error.jsp?err_msg="+ex.getMessage());
					out.println(ex.getMessage());
					if(true) return;
				}

			}else{

				basic_ans_len = search_string.length();
				userid_ans_len = (userans_Res2.trim()).length();

				try {
					Score_AnsNon.UpAresult(userid, id_exam, id_q, res1, res2, basic_ans_len, userid_ans_len);
				} catch(Exception ex) {
					//response.sendRedirect("/error/db_error.jsp?err_msg="+ex.getMessage());
					out.println(ex.getMessage());
					if(true) return;
				}
			}
		}
	}
%>

<script language="javascript">
	//alert("����� ä������� ���۾��� �Ϸ�Ǿ����ϴ�.");
	location.href="ans_non_score.jsp?id_exam=<%=id_exam%>&id_q=<%=id_q%>";
</script>

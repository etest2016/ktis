<%
//******************************************************************************
//   프로그램 : score_help_Res.jsp
//   모 듈 명 : 논술형 채점도우미
//   설    명 : 논술형 문제 채점 페이지
//   테 이 블 : 
//   자바파일 : 
//   작 성 일 : 2009-01-23
//   작 성 자 : 이테스트 강진아
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
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
    
    ObjRegExp.Pattern = Patrn               '** 정규 표현식 패턴
    ObjRegExp.Global = True                 '** 문자열 전체를 검색함
    ObjRegExp.IgnoreCase = True             '** 대.소문자 구분 안함
    
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
	String adm_userid = (String)session.getAttribute("userid"); // 사용자 아이디
	//강진아
	if(adm_userid==null){
		adm_userid = "qmtm";
	}
	String id_exam = request.getParameter("id_exam");
	String id_q = request.getParameter("id_q");
	
	// 키둬드 선택시 : 1
	// 모범답안 선택시 : 2

	// 키워드 또는 모범답안, 둘다 선택했을 경우 "키둬드"로 검색
	String cb = request.getParameter("compare_bigo");
	
	int comp_bigo = 0;
	String search_string = "";

	// 답안 비교 유무 체크
    if (cb.equals("1")){
		comp_bigo = 1;
		search_string = request.getParameter("search_ans_result");
		//검색어가 2개 이상일때 스페이스로 구분한다
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

	//검색어를 스페이스별로 검색 하도록 배열을 만든다
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

	//강진아
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
		out.println("결과 : " + results);
		out.println("<BR>");
		out.println("<BR>");
		out.println("갯수 : " + equal_cnt);
		out.println("<BR>");
		out.println("<BR>");
		*/

		String[] counts = search_string.split(" ");
		String[] counts2 = userans_Res2.split(" ");

		/*
		out.println("검색어 : " + search_string);
		out.println("<BR>");
		out.println("<BR>");
		out.println("검색어 갯수 : " + counts.length);
		out.println("<BR>");
		out.println("<BR>");
		out.println("답안 갯수 : " + counts2.length);
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

	
		//검색어: counts
		//응시자 답안: counts2
		//검색어와 일치하는 단어 수: equal_cnt
		//키워드 유사율: search_result_rate
		//모범답안 유사율: ans_result_rate
		//응시자 답안길이: userid_ans_len Len
		
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
	//alert("논술형 채점도우미 비교작업이 완료되었습니다.");
	location.href="ans_non_score.jsp?id_exam=<%=id_exam%>&id_q=<%=id_q%>";
</script>

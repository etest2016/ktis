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
<%@ page import="qmtm.*, qmtm.common.*, etest.scorehelp.*, java.sql.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");
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
		//search_string = replace(search_string, chr(13)&chr(10), " ");
	} else if (cb.equals("2")){
		comp_bigo = 2;
		search_string = request.getParameter("basic_ans");
	}

	search_string = search_string.replace("\"","");
	
	try {
		Score_AnsNon.DelBasicans(id_exam, id_q, comp_bigo);
	} catch(Exception ex) {
		response.sendRedirect("/error/db_error.jsp?err_msg="+ex.getMessage());
		//out.println(ex.getMessage());
		if(true) return;
	}


	
	try {
		Score_AnsNon.InsBasicans(id_exam, id_q, comp_bigo, search_string, adm_userid);
	} catch(Exception ex) {
		response.sendRedirect("/error/db_error.jsp?err_msg="+ex.getMessage());
		//out.println(ex.getMessage());
		if(true) return;
	}
	
			
	String userans_Res = "";

	search_string = search_string.replace(")"," ");
	search_string = search_string.replace("("," ");
	search_string = search_string.replace(","," ");
	search_string = search_string.replace("."," ");
	search_string = search_string.replace("*"," ");
	search_string = search_string.replace("["," ");
	
	search_string = search_string.trim();

	String[] arrUserans = new String[2];
	arrUserans = search_string.split(" ");
	
	
	for (int i=0; i<arrUserans.length; i++){
		userans_Res = userans_Res + arrUserans[i].trim() + " ";
	}
	
	search_string = userans_Res;
	
	String userans3 = search_string.replace(" ", "|");
	
	Score_AnsNonBean[] rst = null;

	try {
		rst = Score_AnsNon.getAnswers(id_exam, id_q);
	} catch(Exception ex) {
		response.sendRedirect("/error/db_error.jsp?err_msg="+ex.getMessage());
		if(true) return;
	}
	
	
	for (int i=0; i<rst.length; i++){

		String userans_Res2 = "";
		String userans2 = rst[i].getUserans1() + rst[i].getUserans2() + rst[i].getUserans3();
		if (userans2.equals("")){
			userans2 = userans2.trim();
		}
		userans2 = userans2.replace(")"," ");
		userans2 = userans2.replace("("," ");
		userans2 = userans2.replace(","," ");
		userans2 = userans2.replace("."," ");
		userans2 = userans2.replace("*"," ");
		userans2 = userans2.replace("["," ");
		userans2 = userans2.replace("\"","");

		
		String[] arrUserans2 = new String[2];
		arrUserans2 = userans2.split(" ");

		for (int j=0; j<arrUserans2.length; j++){
			userans_Res2 = userans_Res2 + arrUserans2[j].trim() + " ";
		}

	
		String[] u_counts = userans_Res2.split(" ");
	
	
	/*

		ReDim arr_Res_view(UBound(u_counts))

		For x = 0 To UBound(u_counts)
			arr_Res_view(x) = u_counts(x)
		Next

		equal_cnt = 0
		results = ""

		Set Result_Matches_Collection = RegExpExec("("&userans3&")", userans_Res2)

		//** 루프를 돌면서 정보를 출력한다.  
		For Each Result_Match In Result_Matches_Collection
	       
			For y = 0 To UBound(arr_Res_view)		
				If arr_Res_view(y) = Result_Match.Value Then
					arr_Res_view(y) = "<font color=red>"&Result_Match.Value&"</font>"
					results = results & Result_Match.Value & " "
					equal_cnt = equal_cnt + 1
					Exit for				
				End if
			Next	
		Next
							
		counts = Split(search_string, " ")
		counts2 = Split(userans_Res2, " ")

		res1 = (equal_cnt / UBound(counts)) * 100
	
		If res1 > 100 Then
			res1 = 100
		End If
		
		If res1 < 0 Then
			res1 = 0
		End if
						
		res2 = (equal_cnt / UBound(counts2)) * 100
		
		SQL = ""
		SQL = SQL & "Select count(*) as cnt "
		SQL = SQL & "From equal_test_result2 "
		SQL = SQL & "Where id_exam = '" & id_exam & "' and id_q = '" & id_q & "' and userid = '"& Rst("userid") &"' "
				
		Set rs = Cnn.Execute(SQL)
		
		cnt_yn = Rs("cnt")

		rs.Close
		Set rs = Nothing
		
		If cnt_yn = "0" then
		If comp_bigo = "1" then
			
			results = ClearRepeat(results)	
			
			result_cnt = Split(RTrim(results), " ")
			
			results2 = ""

			For y = 0 To UBound(result_cnt)			
					
			If Len(result_cnt(y)) <> 0 Then			
				results2 = results2 & Trim(result_cnt(y)) & " "					
			End if
			Next

			result_cnts = Split(results2, " ")
						
			If equal_cnt = 0 Then
				result_cnts2 = 0
			Else
				result_cnts2 = UBound(result_cnts)
			End If

			counts_1 = Split(search_string, " ")
			
			search_cnt = (result_cnts2 / UBound(counts_1)) * 100

			SQL = ""
			SQL = SQL & " Insert into EQUAL_TEST_RESULT2(userid, id_exam, id_q, search_bigo, search_result_rate, search_result_rate2) "
			SQL = SQL & " Values('"&Rst("userid")&"', '"&id_exam&"', "&id_q&", 1, "
			SQL = SQL & "        "&search_cnt&", "&result_cnts2&") "		
	    Else			
			SQL = ""
			SQL = SQL & " Insert into EQUAL_TEST_RESULT2(userid, id_exam, id_q, search_bigo, ans_result_rate, " 
			SQL = SQL & "                                ans_result_rate2, basic_ans_len, userid_ans_len) "
			SQL = SQL & " Values('"&Rst("userid")&"', '"&id_exam&"', "&id_q&", 2, "
			SQL = SQL & "        '"&FormatNumber(res1,2)&"', '"&FormatNumber(res2,2)&"', "	
			SQL = SQL & "        "&Len(LTrim(rtrim(userans_Res)))&", "&Len(LTrim(rtrim(userans_Res2)))&") "	
	    End If
	    
		Else

		If comp_bigo = "1" then
			
			results = ClearRepeat(results)	
			
			result_cnt = Split(RTrim(results), " ")
			
			results2 = ""

			For y = 0 To UBound(result_cnt)			
					
			If Len(result_cnt(y)) <> 0 Then			
				results2 = results2 & Trim(result_cnt(y)) & " "					
			End if
			Next

			result_cnts = Split(results2, " ")
						
			If equal_cnt = 0 Then
				result_cnts2 = 0
			Else
				result_cnts2 = UBound(result_cnts)
			End If
			
			counts_1 = Split(search_string, " ")
			
			search_cnt = (result_cnts2 / UBound(counts_1)) * 100

			SQL = ""
			SQL = SQL & "Update EQUAL_TEST_RESULT2 "
			SQL = SQL & "       set search_result_rate = "&search_cnt&", search_result_rate2 = "&result_cnts2&" "
			SQL = SQL & "Where id_exam = '" & id_exam & "' and id_q = '" & id_q & "' and userid = '"& Rst("userid") &"' "
	    Else			
			SQL = ""
			SQL = SQL & "Update EQUAL_TEST_RESULT2 "
			SQL = SQL & "       set ans_result_rate = '"&FormatNumber(res1,2)&"', ans_result_rate2 = '"&FormatNumber(res2,2)&"', "
			SQL = SQL & "           basic_ans_len = "& Len(userans_Res) &", userid_ans_len = "& Len(userans_Res2) &" " 
			SQL = SQL & "Where id_exam = '" & id_exam & "' and id_q = '" & id_q & "' and userid = '"& Rst("userid") &"' "
	    End If
			
	    End if
				
		On Error Resume Next
	
		Cnn.Execute SQL
				
		' 테이블 저장중 Error 가 발생했을 경우.
		if Err.Number <> 0 Then	
					
			SQL = ""
			SQL = SQL & "Delete EQUAL_TEST_RESULT2 "
			SQL = SQL & " Where id_exam='"& id_exam &"' and id_q='"& id_q &"' "
						
			Cnn.Execute SQL
				
			'Response.End
			Call AlertWindow("논술형 채점도우미 결과 저장중 오류가 발생했습니다.\n\n잠시 후 다시 시도해 주십시요.")
		End If
	
	*/
	}
%>

<script language="javascript">
	//alert("논술형 채점도우미 비교작업이 완료되었습니다.");
	location.href="ans_non_score.jsp?id_exam=<%=id_exam%>&id_q=<%=id_q%>"
</script>
<%
//******************************************************************************
//   프로그램 : q_preview.jsp
//   모 듈 명 : 문제 미리보기
//   설    명 : 문제 미리보기
//   테 이 블 : q
//   자바파일 : qmtm.*, qmtm.qman.question.*
//   작 성 일 : 2008-07-08
//   작 성 자 : 이테스트 석준호
//   수 정 일 : 
//   수 정 자 : 
//	 수정사항 : 
//******************************************************************************

%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.tman.exam.*, qmtm.common.* " %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	String id_qs = request.getParameter("id_qs");
	if (id_qs == null) { id_qs = ""; } else { id_qs = id_qs.trim(); }	
	
	if (id_qs.length() == 0) {
%>
	<script language="javascript">
		alert("미리보기 할 문항이 없습니다.");
		window.close();
	</script>
<%	
	}

	String[] arrQ = id_qs.split(",");

	int qcount = arrQ.length;

	String exlabel = "①,②,③,④,⑤,⑥,⑦,⑧,";

	String[][] arrEx = new String[qcount][8];  // 보기라벨 + 보기내용
	
	String[] arrExlabel = exlabel.split(",");

	QunitBean[] qs = null;

	try {
		qs = Qunit.getBeans(id_qs);
	} catch(Exception ex) {
		out.println(ex.getMessage());
	}

	long[] arrId_q = new long[qcount];
	boolean[] arrHasRef = new boolean[qcount]; // 지문여부
	String[] arrRefTitle = new String[qcount]; // 지문제목 및 해당문제번호
	String[] arrRefBody = new String[qcount];  // 지문내용
	String[] arrId_ref = new String[qcount];  // 지문내용

	String[] arrQuestion = new String[qcount]; // 문제내용

	int[] arrId_qtype = new int[qcount];        // 보기 유형
	boolean[] arrHasEx = new boolean[qcount];  // 보기유무
	int[] arrExcount = new int[qcount];        // 보기 개수

	String[] arrCA = new String[qcount];       // 정답표시
	boolean[] arrHasExplain = new boolean[qcount]; // 해설유무
	String[] arrExplain = new String[qcount];      // 해설

	String[] arrHint = new String[qcount];      // 힌트

	String[] arrQtype = new String[qcount]; // 문제유형

	String[] arrEx1 = new String[qcount];
	String[] arrEx2 = new String[qcount];
	String[] arrEx3 = new String[qcount];
	String[] arrEx4 = new String[qcount];
	String[] arrEx5 = new String[qcount];
	String[] arrEx6 = new String[qcount];
	String[] arrEx7 = new String[qcount];
	String[] arrEx8 = new String[qcount];

	// 초기화
	String id_ref = "";     // 지문ID
	
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
		arrEx6[i] = QmTm.delTag2(qs[i].getEx6());
		arrEx7[i] = QmTm.delTag2(qs[i].getEx7());
		arrEx8[i] = QmTm.delTag2(qs[i].getEx8());

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
	<title> :: 문제 미리보기 :: </title>
	<style>
		
		Body { margin: 20px 20px 100px 20px; font: normal 12px gulim; }
		table, tr, td, div { font: normal 12px gulim; }
		img { border: 0px; }
		
		#ref { margin-top: 25px; line-height: 150%; }
		#q { margin-top: 25px; line-height: 120%; }
		#ex { margin-top: 15px; line-height: 150%; padding-left: 8px; }
		#ans { margin-top: 10px; color: red; }

	</style>
</head>

<BODY>
	
	<% for (int i = 0; i < qcount; i++) { /* 문제별로 loop 를 돌리면서 */ %>

	<!--------------------------------------- 지문 --------------------------------------->
	<Div id="ref">
		<% if (arrHasRef[i]) { %>
		<b>지문코드:<%= arrId_ref[i] %></b><br>
		<%= arrRefTitle[i] %>
		<%= arrRefBody[i] %>
		<% } %>
	</Div>
	

	<!--------------------------------------- 문제 --------------------------------------->
	<Div id="q">
		<b>문제코드:<%= arrId_q[i] %></b><br>
		<font color="#0000CC"><%= arrQuestion[i] %></font>
	</Div>


	<!--------------------------------------- 보기 --------------------------------------->
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
			<% } else if(arrExcount[i] == 6) { %>
				<%=arrExlabel[0]%>&nbsp;&nbsp;<%= arrEx1[i] %><br>
				<%=arrExlabel[1]%>&nbsp;&nbsp;<%= arrEx2[i] %><br>
				<%=arrExlabel[2]%>&nbsp;&nbsp;<%= arrEx3[i] %><br>
				<%=arrExlabel[3]%>&nbsp;&nbsp;<%= arrEx4[i] %><br>
				<%=arrExlabel[4]%>&nbsp;&nbsp;<%= arrEx5[i] %><br>
				<%=arrExlabel[5]%>&nbsp;&nbsp;<%= arrEx6[i] %>
			<% } else if(arrExcount[i] == 7) { %>
				<%=arrExlabel[0]%>&nbsp;&nbsp;<%= arrEx1[i] %><br>
				<%=arrExlabel[1]%>&nbsp;&nbsp;<%= arrEx2[i] %><br>
				<%=arrExlabel[2]%>&nbsp;&nbsp;<%= arrEx3[i] %><br>
				<%=arrExlabel[3]%>&nbsp;&nbsp;<%= arrEx4[i] %><br>
				<%=arrExlabel[4]%>&nbsp;&nbsp;<%= arrEx5[i] %><br>
				<%=arrExlabel[5]%>&nbsp;&nbsp;<%= arrEx6[i] %><br>
				<%=arrExlabel[6]%>&nbsp;&nbsp;<%= arrEx7[i] %>
			<% } else if(arrExcount[i] == 8) { %>
				<%=arrExlabel[0]%>&nbsp;&nbsp;<%= arrEx1[i] %><br>
				<%=arrExlabel[1]%>&nbsp;&nbsp;<%= arrEx2[i] %><br>
				<%=arrExlabel[2]%>&nbsp;&nbsp;<%= arrEx3[i] %><br>
				<%=arrExlabel[3]%>&nbsp;&nbsp;<%= arrEx4[i] %><br>
				<%=arrExlabel[4]%>&nbsp;&nbsp;<%= arrEx5[i] %><br>
				<%=arrExlabel[5]%>&nbsp;&nbsp;<%= arrEx6[i] %><br>
				<%=arrExlabel[6]%>&nbsp;&nbsp;<%= arrEx7[i] %><br>
				<%=arrExlabel[7]%>&nbsp;&nbsp;<%= arrEx8[i] %>
			<% } %>
		<% } %>

	</Div>
	
	<Div id="ans">
		<% if(arrId_qtype[i] == 3 || arrId_qtype[i] == 4) { %>
			정답: <%=arrCA[i].replace("{|}",", ").replace("{^}"," 또는 ")%>
		<% } else { %>
			정답: <%=arrCA[i] %>
		<% } %>
	</Div>
		
	<% } %>

</body>
</html>
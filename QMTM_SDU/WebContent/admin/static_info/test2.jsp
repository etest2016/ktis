<%
//******************************************************************************
//   프로 그램 : exam_copy.jsp
//   모 듈  명 : 시험 복사
//   설     명 : 시험 복사
//   테 이  블 : exam_m
//   자바 파일 : qmtm.ComLib, qmtm.tman.ExamListBean, qmtm.tman.ExamList
//   작 성  일 : 2013-02-12
//   작 성  자 : 이테스트 석준호
//   수 정  일 : 
//   수 정  자 : 
//	 수정 사항 : 
//******************************************************************************
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.ComLib, qmtm.tman.exam.ExamListBean, qmtm.tman.exam.ExamList, qmtm.admin.tman.SubjectTmanBean, qmtm.admin.tman.SubjectTmanUtil, qmtm.tman.exam.ExamUtil, qmtm.tman.exam.ExamUtilBean" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	
%>

<HTML>
 <HEAD>
  <TITLE> :: 시험 복사 :: </TITLE>
  <link rel="StyleSheet" href="../../css/style.css" type="text/css">
 
  <script language="JavaScript">
	
	function exam_copy() {

		var frmx = document.form2;
			
		var selectId = "";
		var k = 0;

		if(frmx.id_exam.length == undefined) {
			 if(frmx.id_exam.checked == true) {
				 k = k + 1;
			 }
		} else if(frmx.id_exam.length != undefined) {
			 for (i=0; i<=frmx.id_exam.length -1; i++) {
				 if (frmx.id_exam[i].checked == true) {
					k = k + 1;
				 }
			 }
		}

		if(k == 0) {
			alert("복사할 시험을 선택해주세요.");
		} else {
			
			var str = confirm("체크한 시험에 대해서 일괄복사 작업을 진행하시겠습니까?");

			if(str == true) {
				document.form2.submit();
			}
		}
    }

	// 단원 1정보 가지고오기
	function get_cpt1_list(id_course, id_subject) {

		var frm = document.form1;
		
		cpt1 = new ActiveXObject("Microsoft.XMLHTTP");
		cpt1.onreadystatechange = get_cpt1_list_callback;
		cpt1.open("GET", "lecture.jsp?id_course="+id_course+"&id_subject="+id_subject, true);
		cpt1.send();
	}

	function get_cpt1_list_callback() {

		if(cpt1.readyState == 4) {
			if(cpt1.status == 200) {
				if(typeof(document.all.div_cpt1) == "object") {
					document.all.div_cpt1.innerHTML = cpt1.responseText;
				}
			}
		}
	}

	function cat_select(sel) {

		var frm = document.form1;

		frm.submit();
		
	}

 </script>

</HEAD>

<BODY id="popup2" >


	<div id="top">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<Td id="left"></td>
				<Td id="mid"><div class="title">재응시 권한설정<span>검색된 교수자에게 재응시 권한을 설정합니다.</span></div></td>
				<Td id="right"></td>
			</tr>
		</table>
	</div>

	<div id="contents">
		<table border="0" width="100%" cellpadding ="0" cellspacing="0" id="tableD">			
			<tr>
				<td id="left" width="20%"><li>교수자 검색</td>
				<td><select name="id_course" >
					<option>성명</option>
					</select>&nbsp;&nbsp;<input type="text" class="input" size="30">&nbsp;&nbsp;
					<input type="button" value="검색하기" class="form4">
				</td>
			</tr>			
			
		</table>		
	</div>	
	<BR>

		
		<table border="0" cellpadding ="0" cellspacing="0" id="tableA" width="100%" style="margin-bottom: 0px;">
			<tr id="tr">
				<td width="5%">선택</td>
				<td width="25%">학과</td>
				<td width="20%">구분</td>
				<td width="25%">사번</td>
				<td width="25%">성명</td>
			</tr>
		</table>
		
		
			<table border="0" cellpadding ="0" cellspacing="0" id="tableA" width="100%">
				
				<tr id="td" align="center">
					<td width="5%"><input type="radio" name="id_exam" ></td>
					<td width="25%">테스트학과</td>
					<td width="20%">교수</td>
					<td width="25%">098765</td>
					<td width="25%">홍교수</td>
				</tr>
				<tr id="td" align="center">
					<td width="5%"><input type="radio" name="id_exam" ></td>
					<td width="25%">테스트학과</td>
					<td width="20%">교수</td>
					<td width="25%">098765</td>
					<td width="25%">홍교수</td>
				</tr>
				<tr id="td" align="center">
					<td width="5%"><input type="radio" name="id_exam" ></td>
					<td width="25%">테스트학과</td>
					<td width="20%">교수</td>
					<td width="25%">098765</td>
					<td width="25%">홍교수</td>
				</tr>
				<tr id="td" align="center">
					<td width="5%"><input type="radio" name="id_exam" ></td>
					<td width="25%">테스트학과</td>
					<td width="20%">교수</td>
					<td width="25%">098765</td>
					<td width="25%">홍교수</td>
				</tr>
				
			</table>


	</div>
	<div id="button">
	<input type="button" value="권한등록하기" class="form" onClick="Sends();">&nbsp;&nbsp;<input type="button" value="창닫기" class="form" onClick="window.close();">
	</div>


 </BODY>
</HTML>
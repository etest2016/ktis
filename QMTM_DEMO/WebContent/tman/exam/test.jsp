<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="qmtm.*, qmtm.tman.exam.*, qmtm.tman.paper.*, java.sql.*, java.util.*" %>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("EUC-KR");

	Random random = new Random( );

	ExamPaperUtil rst = null;
	
	// 출제대상 문항을 가지고온다.
	try {
		ExamPaperUtil.getQList(id_exam);
	} catch(Exception ex) {
		out.println(ex.getMessage());
	}

	String qs_lists = "111,222,3333,4,55,6666,7,88888,99999";

	String[] Arr_qs;

	Arr_qs = qs_lists.split(",");

	int randomValue = 0;

	Vector vector = new Vector();

	// 벡터에 Integer 형 데이터 삽입
	for( int i = 0; i < Arr_qs.length; i++ ) vector.addElement( new Integer(Arr_qs[i]) );

	for( int i = 0; i < Arr_qs.length; i++ )
	{
		randomValue = random.nextInt( vector.size() );

		out.println( vector.elementAt( randomValue ) + "" );

		vector.remove( randomValue );
	}
%>
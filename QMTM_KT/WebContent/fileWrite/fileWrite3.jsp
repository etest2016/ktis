<%@ page contentType="text/html; charset=euc-kr" %>
<%@page import="qmtm.ComLib, qmtm.FileSecurity, qmtm.ZipUtils, qmtm.SET, qmtm.QmTm, qmtm.common.*, java.io.*, java.util.* "%>

<%
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("euc-kr");

	String strCurPath = "C:/QMTMADMIN";

	String strCmd =strCurPath + "/fileWrite/EsSeedCuiTest/tool/EsCryptCui";
	String strCryptKey = "etest";

	String strSrcPath = "";
	String strDestPath = "";

	String dirName = "C:/QMTMADMIN/paper_file";
	String fileName = "E140901113500US_2.zip";

	// 파일을 암호화 시키는 부분 시작
	strSrcPath = dirName + "/" + fileName;
	strDestPath = strSrcPath + ".enc";

	String cmdarray[] = {strCmd, strCryptKey, strSrcPath, strDestPath};

	String s;
				
	try {
		ProcessBuilder pb = new ProcessBuilder(	strCmd,
												"ef",
												strCryptKey,
												strSrcPath,
												strDestPath);
				
		Process process = pb.start();	
	
	} catch(Exception e) {
		throw new Exception(e.getMessage());
	} 
	// 파일을 암호화 시키는 부분 종료

%>


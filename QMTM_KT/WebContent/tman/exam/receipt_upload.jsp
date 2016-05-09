<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="org.apache.poi.poifs.filesystem.POIFSFileSystem, org.apache.poi.hssf.record.*, org.apache.poi.hssf.model.*, org.apache.poi.hssf.usermodel.*, org.apache.poi.hssf.util.*, qmtm.tman.exam.ReceiptUtil, qmtm.tman.exam.ReceiptBean, qmtm.*" %>

<head>
<title>시험 접수</title>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8">
</head>

<body>
<%
	String realFolder = "";

	String saveFolder = "upload";
	String encType = "euc-kr";

	String id_exam = "";
	String filename = "";
	String excelfile = "";

	int maxSize = 1024*1024*100;

	ServletContext context = getServletContext();

	realFolder = context.getRealPath(saveFolder);

	try {
	 
		 MultipartRequest multi = null;
		 
		 multi = new MultipartRequest(request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());

		 id_exam = multi.getParameter("id_exam");
		 
		 Enumeration files = multi.getFileNames();
		 
		 while(files.hasMoreElements()) {
		  
			  String name = (String)files.nextElement();
			  filename = multi.getFilesystemName(name);
			  String original = multi.getOriginalFileName(name);
			  String type = multi.getContentType(name);
			  
			  File file = multi.getFile(name);
			  
			  excelfile = realFolder+"/"+filename; 
	      } 
	 
	}catch(IOException e){
		out.println(e);
		if(true) return;
	}catch(Exception ex){
		out.println(ex);
		if(true) return;
	}

	ReceiptBean bean = new ReceiptBean();
	
	try {
       POIFSFileSystem fs = new POIFSFileSystem(new FileInputStream(excelfile)); 

       //워크북을 생성!                
       HSSFWorkbook workbook = new HSSFWorkbook(fs);

       int sheetNum = workbook.getNumberOfSheets();

       for (int k = 0; k < sheetNum; k++) {

            //시트 이름과 시트번호를 추출
            HSSFSheet sheet = workbook.getSheetAt(k);
            int rows = sheet.getPhysicalNumberOfRows();

            for (int r = 1; r < rows; r++) { 

                // 시트에 대한 행을 하나씩 추출
                HSSFRow row   = sheet.getRow(r);
                if (row != null) { 
                     int cells = row.getPhysicalNumberOfCells();

					 String userid = "";
				
                     for (short c = 0; c < cells; c++) {

                         // 행에대한 셀을 하나씩 추출하여 셀 타입에 따라 처리
                         HSSFCell cell  = row.getCell(c);
                         if (cell != null || cell.equals("")) { 

                              String value = "";	
							  
							  cell.setCellType(HSSFCell.CELL_TYPE_STRING);

                              switch (cell.getCellType()) {

                                   case HSSFCell.CELL_TYPE_FORMULA :
                                       value = String.valueOf(cell.getCellFormula());
                                        break;
                                   case HSSFCell.CELL_TYPE_NUMERIC :
                                       value = String.valueOf(cell.getNumericCellValue()); //double
                                       break;
                                  case HSSFCell.CELL_TYPE_STRING :
                                       value = cell.getStringCellValue(); //String
                                       break;
                                  case HSSFCell.CELL_TYPE_BLANK :
                                      value = "";
                                     break;
                                 case HSSFCell.CELL_TYPE_BOOLEAN :
                                     value = String.valueOf(cell.getBooleanCellValue()); //boolean
                                    break;
                                case HSSFCell.CELL_TYPE_ERROR :
                                     value = String.valueOf(cell.getErrorCellValue()); // byte
                                     break;
                                default :
                             }						
							
							if(cell.getCellNum() == 0) {
								userid = value;	
								bean.setUserid(userid);							
							}

                        } 					

                    }

					if(!(userid == null || userid.equals(""))) {

					try {
						ReceiptUtil.getECnt(id_exam, userid);
					} catch(Exception ex) {
						out.println(ComLib.getExceptionMsg(ex, "back"));

					    if(true) return;
					}

					}
					
                }
            }
       }
   } catch (Exception e) {
%>
       Error occurred:  <%= e.getMessage() %>
<%   
       e.printStackTrace();

		if(true) return;
    }

%>

<Script language="javascript">
	alert("대상자가 등록되었습니다.");
	location.href="receipt_inwons.jsp?id_exam=<%=id_exam%>";
</Script>

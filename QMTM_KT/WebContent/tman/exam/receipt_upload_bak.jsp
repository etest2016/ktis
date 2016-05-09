<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="org.apache.poi.poifs.filesystem.POIFSFileSystem, org.apache.poi.hssf.record.*, org.apache.poi.hssf.model.*, org.apache.poi.hssf.usermodel.*, org.apache.poi.hssf.util.*, qmtm.tman.exam.ReceiptUtil, qmtm.tman.exam.ReceiptBean, qmtm.*" %>

<html>

<head>

<title>대상자 접수</title>
<link rel="StyleSheet" href="../../css/style.css" type="text/css">

<script>
	function go(id_exam){

		Show_LayerProgressBar(false);

		alert("접수자가 등록되었습니다.");
		location.href="receipt_inwons.jsp?id_exam="+id_exam;
	}
	
	HTML_P = '<DIV id="ProgressBar" class="progress_img_all_cover">' 
		   + '<img src="../../images/loading.gif" style="position:absolute; top:35%; left:35%;"/>' 
		   + '</DIV>'; 
	  
	document.write(HTML_P); 
		  
	function Show_LayerProgressBar(isView) { 
				
		var obj = document.getElementById("ProgressBar"); 
		if (isView) { 
			obj.style.display = "block"; 
		}else{ 
			obj.style.display = "none"; 
		} 
	} 
		
</script>

</head>
<!-- 상태진행바가 위치할 HTMl소스 -->

<BODY onLoad = "Show_LayerProgressBar(true);">

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

						 String value = "";

                         if (cell != null) {                               					
							  
							  cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				
                              switch (cell.getCellType()) {
                                   case HSSFCell.CELL_TYPE_FORMULA :									   
                                       value = String.valueOf(cell.getCellFormula());					   	
                                       break;
                                   case HSSFCell.CELL_TYPE_NUMERIC :
                                       value = String.valueOf(cell.getNumericCellValue()); //double
                                       break;
                                   case HSSFCell.CELL_TYPE_STRING :
                                       value = String.valueOf(cell.getStringCellValue()); //String
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

					if(userid == null || userid.equals("")) {
						continue;
					}

					try {
						ReceiptUtil.getECnt(id_exam, userid);
					} catch(Exception ex) {
						//out.println(ComLib.getExceptionMsg(ex, "back"));
						out.println(ex.getMessage());

					    if(true) return;
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
	
	out.println("<script>go('"+id_exam+"')</script>");
%>
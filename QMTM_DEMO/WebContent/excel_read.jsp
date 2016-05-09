<%@ page language="java" contentType="text/html;charset=euc-kr" import="java.io.*, org.apache.poi.poifs.filesystem.POIFSFileSystem, org.apache.poi.hssf.record.*, org.apache.poi.hssf.model.*, org.apache.poi.hssf.usermodel.*, org.apache.poi.hssf.util.*" %>

<html>
<head><title>Read example</title></head>
<body>

<%
  String excelfile = "D:\\gnu_dev\\ROOT\\upload\\���������.xls";

  try {
       POIFSFileSystem fs = new POIFSFileSystem(new FileInputStream(excelfile)); 

       //��ũ���� ����!                
       HSSFWorkbook workbook = new HSSFWorkbook(fs);

       int sheetNum = workbook.getNumberOfSheets();

       for (int k = 0; k < sheetNum; k++) {

            //��Ʈ �̸��� ��Ʈ��ȣ�� ����
%>
            <br><br>
            Sheet Number <%= k %> <br>
            Sheet Name <%= workbook.getSheetName(k) %><br>
<%
            HSSFSheet sheet = workbook.getSheetAt(k);
            int rows = sheet.getPhysicalNumberOfRows();

            for (int r = 0; r < rows; r++) { 

                // ��Ʈ�� ���� ���� �ϳ��� ����
                HSSFRow row   = sheet.getRow(r);
                if (row != null) { 
                     int cells = row.getPhysicalNumberOfCells();
%>
                     ROW  <%= row.getRowNum() %> <%=cells%></b><br>
<%
                     for (short c = 0; c < cells; c++) {

                         // �࿡���� ���� �ϳ��� �����Ͽ� �� Ÿ�Կ� ���� ó��
                         HSSFCell cell  = row.getCell(c);
                         if (cell != null) { 
                              String value = null;

                              switch (cell.getCellType()) {

                                   case HSSFCell.CELL_TYPE_FORMULA :
                                       value = "FORMULA value=" + cell.getCellFormula();
                                        break;
                                   case HSSFCell.CELL_TYPE_NUMERIC :
                                       value = "NUMERIC value=" + cell.getNumericCellValue(); //double
                                       break;
                                  case HSSFCell.CELL_TYPE_STRING :
                                       value = "STRING value=" + cell.getStringCellValue(); //String
                                       break;
                                  case HSSFCell.CELL_TYPE_BLANK :
                                      value = null;
                                     break;
                                 case HSSFCell.CELL_TYPE_BOOLEAN :
                                     value = "BOOLEAN value=" + cell.getBooleanCellValue(); //boolean
                                    break;
                                case HSSFCell.CELL_TYPE_ERROR :
                                     value = "ERROR value=" + cell.getErrorCellValue(); // byte
                                     break;
                                default :
                             }
%>         
                          <%= "CELL col=" + cell.getCellNum() + " VALUE=" + value %> <br>
<%
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
    }

%>

</body>
</html>
import java.awt.*;
import javax.swing.*;

public class Inwons extends JApplet {
 private JScrollPane panel;
 private JTable table;
 private JSplitPane spane;
 private String [] columnName = {"문제코드","문제유형","지문유무","문제","정답","보기수","정답수","등록일자"};//컬럼명 배열
 private  Object[][] array = {{"1","테스트","1","2008-05-30 11:21:24","2008-05-30 11:21:24","80","",""},//입력값들 배열
        {"111111111111","테스트","1","2008-05-30 11:21:24","2008-05-30 11:21:24","80","",""},
        {"111111111111","테스트","1","2008-05-30 11:21:24","2008-05-30 11:21:24","80","",""},
        {"111111111111","테스트","1","2008-05-30 11:21:24","2008-05-30 11:21:24","80","",""},
        {"111111111111","테스트","1","2008-05-30 11:21:24","2008-05-30 11:21:24","80","",""},
        {"111111111111","테스트","1","2008-05-30 11:21:24","2008-05-30 11:21:24","80","",""},
        {"111111111111","테스트","1","2008-05-30 11:21:24","2008-05-30 11:21:24","80","",""},
        {"111111111111","테스트","1","2008-05-30 11:21:24","2008-05-30 11:21:24","80","",""},
        {"111111111111","테스트","1","2008-05-30 11:21:24","2008-05-30 11:21:24","80","",""}};
  
 public void init() {
   table = new JTable(array, columnName);   //테이블선언
   table.setPreferredScrollableViewportSize(new Dimension(250,80)); //테이블사이즈선언
   panel = new JScrollPane(table);   //테이블을 넣기위한 JScrollPane선언
   add(panel);   //scrollpane을 frame에 add
      setSize(1000,500);
   setVisible(true);
  }
}
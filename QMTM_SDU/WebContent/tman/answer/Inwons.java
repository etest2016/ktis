import java.awt.*;
import javax.swing.*;


public class Inwons extends JApplet  {
 private JScrollPane panel;
 private JTable table;
 private JSplitPane spane;
 private String [] columnName = {"���̵�","����","������","������۽ð�","�������ð�","����","������","��������","������ IP"};//�÷��� �迭
 private  Object[][] array = {{"111111111111","�׽�Ʈ","1","2008-05-30 11:21:24","2008-05-30 11:21:24","80","","","111.222.333.444"},//�Է°��� �迭
        {"111111111111","�׽�Ʈ","1","2008-05-30 11:21:24","2008-05-30 11:21:24","80","","","111.222.333.444"},
        {"111111111111","�׽�Ʈ","1","2008-05-30 11:21:24","2008-05-30 11:21:24","80","","","111.222.333.444"},
        {"111111111111","�׽�Ʈ","1","2008-05-30 11:21:24","2008-05-30 11:21:24","80","","","111.222.333.444"},
        {"111111111111","�׽�Ʈ","1","2008-05-30 11:21:24","2008-05-30 11:21:24","80","","","111.222.333.444"},
        {"111111111111","�׽�Ʈ","1","2008-05-30 11:21:24","2008-05-30 11:21:24","80","","","111.222.333.444"},
        {"111111111111","�׽�Ʈ","1","2008-05-30 11:21:24","2008-05-30 11:21:24","80","","","111.222.333.444"},
        {"111111111111","�׽�Ʈ","1","2008-05-30 11:21:24","2008-05-30 11:21:24","80","","","111.222.333.444"},
        {"111111111111","�׽�Ʈ","1","2008-05-30 11:21:24","2008-05-30 11:21:24","80","","","111.222.333.444"}};
  
 public void init() {
   table = new JTable(array, columnName);   //���̺�����
   table.setPreferredScrollableViewportSize(new Dimension(250,80)); //���̺��������
   panel = new JScrollPane(table);   //���̺��� �ֱ����� JScrollPane����
   add(panel);   //scrollpane�� frame�� add
   setSize(1400,500);
   setVisible(true);
  }
}
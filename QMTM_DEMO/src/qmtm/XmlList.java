package qmtm;

// Java API Import
import java.io.FileWriter;
import java.io.File;

public class XmlList
{
    public XmlList() {
    }

    public static void saveXML(String text, String fileName, boolean append) throws QmTmException
    {
        String fullPathFileName = DBPool.XML_PATH + "/" + fileName;

		File dir = new File(fullPathFileName);
        
		try {
            dir.delete();            
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }

		try {
            FileWriter output = new FileWriter(fullPathFileName, append);
            output.write(text, 0, text.length());
            output.flush();
            output.close();
        } catch (Exception ex) {
            System.out.println("XML 파일 생성중에 인터넷 연결상태가 좋지 않습니다. [XmlList.saveXML()]");
        }        
    }
		
}

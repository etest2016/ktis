package qmtm;

// Package Import
// Java API Import
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;

import qmtm.admin.qman.ChapterQmanBean;

public class LoginUtil
{
    public LoginUtil() {
    }
	
	public static ChapterQmanBean[] getBeans(String id_q_subject) throws QmTmException
    {
        Connection cnn = null; PreparedStatement stm = null; ResultSet rst = null; String sql = "";
		
		sql = "Select id_q_subject, id_q_chapter, chapter, to_char(regdate, 'yyyy-mm-dd hh24:mi') regdate "
		    + "From q_chapter "
			+ "Where id_q_subject = ? "
			+ "Order by regdate desc ";

        try
        {
            Collection beans = new ArrayList();
            cnn = DBPool.getConnection();
            stm = cnn.prepareStatement(sql);
			stm.setString(1, id_q_subject);
            rst = stm.executeQuery();
            ChapterQmanBean bean = null;
            while (rst.next()) {
                bean = makeBeans(rst);
                beans.add(bean);
            }
            if (bean == null) {
                return null;
            } else {
                return (ChapterQmanBean[]) beans.toArray(new ChapterQmanBean[0]);
            }
        }
        catch (SQLException ex) {
            throw new QmTmException("[ChapterQmanUtil.getBeans]" + ex.getMessage());
        }
        finally {
            if (rst != null) try { rst.close(); } catch (SQLException ex) {}
            if (stm != null) try { stm.close(); } catch (SQLException ex) {}
            if (cnn != null) try { cnn.close(); } catch (SQLException ex) {}
        }
    }
	
    private static ChapterQmanBean makeBeans (ResultSet rst) throws QmTmException
    {
		
		try {
            ChapterQmanBean bean = new ChapterQmanBean();
            bean.setId_q_subject(rst.getString(1));
			bean.setId_q_chapter(rst.getString(2));
            bean.setChapter(rst.getString(3));
            bean.setRegdate(rst.getString(4));
            return bean;
        } catch (SQLException ex) {
            throw new QmTmException("[ChapterQmanUtil.makeBeans]" + ex.getMessage());
        }
    }

	
}